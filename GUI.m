function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% txt the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 22-Sep-2020 18:42:32

% Begin initialization code - DO NOT TXT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT TXT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton.
function pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

c = 10; %speed of EM wave
lambda = 1; %wave length
z = 0; %z=0 mesure from a point with time
T = lambda/c; % c = Lambda/T -> T = Lambda/c
t = 0:T/100:5*T;% let time flow
%Amplitudes
Ex = 1;
Ey = 1;
% px - py = phase difference
px = 0;
py = 0;

omega = 2*pi*c/lambda; %2pi/T
k = 2*pi/lambda;

ex = real(Ex*exp( 1i*( omega*t - k*z + px ) ));
ey = real(Ey*exp( 1i*( omega*t - k*z + py ) ));

plot3(t,ex,t*0,'r',t,t*0,ey,'b',t,ex,ey,'g'),grid on,view(45,45),hold on;

%Jones vector
J1 = Ex*exp(1i*omega*px);
J2 = Ey*exp(1i*omega*py);

J = [ J1
      J2 ];

%normalized
%factor = (abs(J1)^2 + abs(J2)^2)^(0.5);

p_theta = get(hObject,'Value');
set(handles.txt, 'String', num2str(p_theta));

p_rad = pi*p_theta/180;

polarizer = [ cos(p_rad)^2          sin(p_rad)*cos(p_rad)
              sin(p_rad)*cos(p_rad) sin(p_rad)^2          ];

output = polarizer*J;

ex_o = real(exp( 1i*(omega*t - k*z ))*output(1));
ey_o = real(exp( 1i*(omega*t - k*z ))*output(2));

t = 0:T/100:5*T;
plot3(t,ex,t*0,'r',t,t*0,ey,'b',t,ex,ey,'g'),grid on,view(45,45),hold on;
t = 6*T:T/100:11*T;
plot3(t,ex_o,t*0,'r',t,t*0,ey_o,'b',t,ex_o,ey_o,'g'),grid on,view(45,45),hold off;




% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function txt_Callback(hObject, eventdata, handles)
% hObject    handle to txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt as text
%        str2double(get(hObject,'String')) returns contents of txt as a double


% --- Executes during object creation, after setting all properties.
function txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: txt controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
