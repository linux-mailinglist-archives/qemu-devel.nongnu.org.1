Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E364819134
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 21:07:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFgMH-0003EM-B2; Tue, 19 Dec 2023 15:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smarkusg@gmail.com>)
 id 1rFgMB-0003BV-Ku
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 15:06:25 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smarkusg@gmail.com>)
 id 1rFgM9-0002zq-QB
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 15:06:23 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a2371eae8f1so162634166b.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 12:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703016380; x=1703621180; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=13hGPiDpsUilD26ubkFv4qjqbMJDAWgWcTjx61ISfFw=;
 b=LuuIQa2f7Z6BmWhwKjENew5umQvP7/R17aomcSnbK5W9iQAZ8IBs1yyPT/NZ/mUv88
 ffyQGD54CZS7e+nbpplYMOPRuGjeNMNtr7Plte5NKaTLwm7TRI6w/g/QZPE7oQ+Sr75z
 TNnv52v+Q/fjUqIC6E02A8svrYV0Psu0bVVYZ+zDVzX1iSzBVJ79FJ7q7AXZfZSHGEDD
 bLrAVu6BXZLIMpAXFuoX64BtsVLODcP34vEvmAQn9RRTwFzzBORhlWJJR9roduzrmCkg
 P5Uw2Jy9dfYG2eLyVzwfJQunA3F0DAi5Nla9Rw67oW8et8hz309+41iW1vFWmVF6uU8Q
 w5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703016380; x=1703621180;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=13hGPiDpsUilD26ubkFv4qjqbMJDAWgWcTjx61ISfFw=;
 b=xCHtr1EAJmTNYXAWfraw5XBOrPj8fojOD708Xn4B9tT+q6Ct0VDnesp3pJzkWc037j
 ccX4Rbs6uqmlwQE4RcN8HKYEsWaTIIbF5JoUpZgzZaze6yucScg5RckxekPN7GFF+FhT
 iIV95jdQtoGQbtO4sc+fiGShnPaX4OESdqR5pQuVZyC1YiX5awEcxRpsKERtpe7Ofo/m
 8x5hzMAFQHqh+ZFjerXEWTEv1ercQJELheHixvb8EUPDvMaN447AUviOD4z4XZqt/sAp
 S5YGKFPr1gLHV1yQ4Z2udY+r/h+TlI5aLYaFmGFwmZCspHHe0YsFs3ycbhDe0M4hOU/w
 NcxQ==
X-Gm-Message-State: AOJu0YwozPTzRz2Qrvnjg5d5ibmBWfD5QNwIiWI8zUGDZVF9PElq0BBy
 6vvt+SfnZDssDZz88wa6n7k=
X-Google-Smtp-Source: AGHT+IGMGD7gTd+BhfQ+Ut3Rd/Q0+SuFf8KtnzHp7pRc5f/hp70fU7rpNAphvy+MDOUs78qpre41og==
X-Received: by 2002:a17:906:2d3:b0:a22:ef8b:76d0 with SMTP id
 19-20020a17090602d300b00a22ef8b76d0mr6133529ejk.45.1703016379872; 
 Tue, 19 Dec 2023 12:06:19 -0800 (PST)
Received: from smtpclient.apple ([178.252.34.151])
 by smtp.gmail.com with ESMTPSA id
 vv8-20020a170907a68800b00a1d2b0d4500sm15744412ejc.168.2023.12.19.12.06.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Dec 2023 12:06:19 -0800 (PST)
From: Marek Glogowski <smarkusg@gmail.com>
Message-Id: <DB8CB49B-092F-4620-B8AE-67ED92059544@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_033A615A-488E-4043-9DFF-BE8C312579EC"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
Date: Tue, 19 Dec 2023 21:06:17 +0100
In-Reply-To: <2a775be4-363a-4e85-ae32-97ceb5927e11@daynix.com>
Cc: Rene Engel <ReneEngel80@emailn.de>, peter.maydell@linaro.org,
 philmd@linaro.org, kraxel@redhat.com, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org
To: Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20231217-cocoa-v7-1-6af21ef75680@daynix.com>
 <ad45a3b3201a6c9b24138abf2174946b@mail.emailn.de>
 <d73b8c8e-fde3-49e6-88b8-8f9bfa248509@daynix.com>
 <71895f08af8ba9f01dd78da158005229@mail.emailn.de>
 <2a775be4-363a-4e85-ae32-97ceb5927e11@daynix.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=smarkusg@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


--Apple-Mail=_033A615A-488E-4043-9DFF-BE8C312579EC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi

For me, the problem does not occur if you use the maximum screen =
resolution available.
For me it is 1680x1050 - everything works fine.
When I change the screen preference to a smaller screen resolution than =
my maximum (1440x900,1024x768 ...) the mouse starts to malfunction. The =
mouse pointer works strenuously and with a delay.

Checked on the current version with git qemu-system-ppc AOS4 with V8 and =
V7 patch and the older version qemu-system-aarch64 Linux/Fedora

> Wiadomo=C5=9B=C4=87 napisana przez Akihiko Odaki =
<akihiko.odaki@daynix.com> w dniu 19.12.2023, o godz. 13:12:
>=20
> On 2023/12/19 0:07, Rene Engel wrote:
>> --- Urspr=C3=BCngliche Nachricht ---
>> Von: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Datum: 18.12.2023 08:59:41
>> An: Rene Engel <ReneEngel80@emailn.de>
>> Betreff: Re: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
>>> On 2023/12/17 18:46, Rene Engel wrote:
>>>>=20
>>>> --- Urspr=C3=BCngliche Nachricht ---
>>>> Von: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Datum: 17.12.2023 07:25:52
>>>> An: Peter Maydell <peter.maydell@linaro.org>,  Philippe =
Mathieu-Daud=C3=A9
>>> <philmd@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,  =
Marc-Andr=C3=A9
>>> Lureau <marcandre.lureau@redhat.com>,  Marek Glogowski =
<smarkusg@gmail.com>
>>>=20
>>>> Betreff: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
>>>>=20
>>>> Tested-by: Rene Engel <ReneEngel80@emailn.de>
>>>>=20
>>>> This patch now works with the "option zoom-to-fit=3Don/off"
>>> thank you very much.
>>>>=20
>>>> But there is severe mouse lag within Cocoa output in full screen. =
You
>>> can reproduce the problem by using the mouse very slowly inside the =
machine
>>> where the mouse pointer no longer moves (guest). This issue only =
occurs with
>>> Cocoa edition SDL/GTK works without mouse lag within the machine.
>>>=20
>>> I can't reproduce the issue. Is it a regression caused by this =
change or
>>>=20
>>> an existing bug?
>>>=20
>> I'm not sure how to reproduce it, but when I compile Qemu from master =
source, zoom-to-fit for cocoa output is always active without using your =
patch and cannot be enabled or disabled in full screen. Here the mouse =
speed is about the same as under the MacOs host system.
>> When using their latest patch series v8 for cocoa I can enable and =
disable zoom-to-fit with "-display cocoa,zoom-to-fit=3Don/off =
-full-screen" but the mouse speed then becomes slower. I'm not sure what =
changes there were from Qemu Master where part of their patch must be =
included, unless someone else has added something similar for Qemu =
Master.
>=20
> Can you tell me your whole command line and guest operating system?
>=20
> Regards,
> Akihiko Odaki


--Apple-Mail=_033A615A-488E-4043-9DFF-BE8C312579EC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D""><div class=3D""><font color=3D"#000000" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0);" class=3D"">Hi</span></font></div><div=
 class=3D""><font color=3D"#000000" class=3D""><span style=3D"caret-color:=
 rgb(0, 0, 0);" class=3D""><br class=3D""></span></font></div><div =
class=3D""><font color=3D"#000000" class=3D""><span style=3D"caret-color: =
rgb(0, 0, 0);" class=3D"">For me, the problem does not occur if you use =
the maximum screen resolution available.</span></font></div><div =
class=3D""><font color=3D"#000000" class=3D""><span style=3D"caret-color: =
rgb(0, 0, 0);" class=3D"">For me it is 1680x1050 - everything works =
fine.</span></font></div><div class=3D""><font color=3D"#000000" =
class=3D""><span style=3D"caret-color: rgb(0, 0, 0);" class=3D"">When I =
change the screen preference to a smaller screen resolution than my =
maximum (1440x900,1024x768 ...) the mouse starts to malfunction. The =
mouse pointer works strenuously and with a =
delay.</span></font></div><div class=3D""><font color=3D"#000000" =
class=3D""><span style=3D"caret-color: rgb(0, 0, 0);" class=3D""><br =
class=3D""></span></font></div><div class=3D""><font color=3D"#000000" =
class=3D""><span style=3D"caret-color: rgb(0, 0, 0);" class=3D"">Checked =
on the current version with git qemu-system-ppc AOS4 with V8 and V7 =
patch and the older version qemu-system-aarch64 =
Linux/Fedora</span></font></div></div><div><br class=3D""><blockquote =
type=3D"cite" class=3D""><div class=3D"">Wiadomo=C5=9B=C4=87 napisana =
przez Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" =
class=3D"">akihiko.odaki@daynix.com</a>&gt; w dniu 19.12.2023, o godz. =
13:12:</div><br class=3D"Apple-interchange-newline"><div class=3D""><meta =
charset=3D"UTF-8" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">On 2023/12/19 0:07, Rene Engel wrote:</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">--- =
Urspr=C3=BCngliche Nachricht ---<br class=3D"">Von: Akihiko Odaki &lt;<a =
href=3D"mailto:akihiko.odaki@daynix.com" =
class=3D"">akihiko.odaki@daynix.com</a>&gt;<br class=3D"">Datum: =
18.12.2023 08:59:41<br class=3D"">An: Rene Engel &lt;<a =
href=3D"mailto:ReneEngel80@emailn.de" =
class=3D"">ReneEngel80@emailn.de</a>&gt;<br class=3D"">Betreff: Re: =
[PATCH v7] ui/cocoa: Use NSWindow's ability to resize<br =
class=3D""><blockquote type=3D"cite" class=3D"">On 2023/12/17 18:46, =
Rene Engel wrote:<br class=3D""><blockquote type=3D"cite" class=3D""><br =
class=3D"">--- Urspr=C3=BCngliche Nachricht ---<br class=3D"">Von: =
Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" =
class=3D"">akihiko.odaki@daynix.com</a>&gt;<br class=3D"">Datum: =
17.12.2023 07:25:52<br class=3D"">An: Peter Maydell &lt;<a =
href=3D"mailto:peter.maydell@linaro.org" =
class=3D"">peter.maydell@linaro.org</a>&gt;, &nbsp;Philippe =
Mathieu-Daud=C3=A9<br class=3D""></blockquote>&lt;<a =
href=3D"mailto:philmd@linaro.org" class=3D"">philmd@linaro.org</a>&gt;, =
&nbsp;Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" =
class=3D"">kraxel@redhat.com</a>&gt;, &nbsp;Marc-Andr=C3=A9<br =
class=3D"">Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" =
class=3D"">marcandre.lureau@redhat.com</a>&gt;, &nbsp;Marek Glogowski =
&lt;<a href=3D"mailto:smarkusg@gmail.com" =
class=3D"">smarkusg@gmail.com</a>&gt;<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">Betreff: [PATCH v7] =
ui/cocoa: Use NSWindow's ability to resize<br class=3D""><br =
class=3D"">Tested-by: Rene Engel &lt;<a =
href=3D"mailto:ReneEngel80@emailn.de" =
class=3D"">ReneEngel80@emailn.de</a>&gt;<br class=3D""><br class=3D"">This=
 patch now works with the "option zoom-to-fit=3Don/off"<br =
class=3D""></blockquote>thank you very much.<br class=3D""><blockquote =
type=3D"cite" class=3D""><br class=3D"">But there is severe mouse lag =
within Cocoa output in full screen. You<br class=3D""></blockquote>can =
reproduce the problem by using the mouse very slowly inside the =
machine<br class=3D"">where the mouse pointer no longer moves (guest). =
This issue only occurs with<br class=3D"">Cocoa edition SDL/GTK works =
without mouse lag within the machine.<br class=3D""><br class=3D"">I =
can't reproduce the issue. Is it a regression caused by this change =
or<br class=3D""><br class=3D"">an existing bug?<br class=3D""><br =
class=3D""></blockquote>I'm not sure how to reproduce it, but when I =
compile Qemu from master source, zoom-to-fit for cocoa output is always =
active without using your patch and cannot be enabled or disabled in =
full screen. Here the mouse speed is about the same as under the MacOs =
host system.<br class=3D"">When using their latest patch series v8 for =
cocoa I can enable and disable zoom-to-fit with "-display =
cocoa,zoom-to-fit=3Don/off -full-screen" but the mouse speed then =
becomes slower. I'm not sure what changes there were from Qemu Master =
where part of their patch must be included, unless someone else has =
added something similar for Qemu Master.<br class=3D""></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">Can you tell me your whole =
command line and guest operating system?</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Regards,</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Akihiko Odaki</span></div></blockquote></div><br =
class=3D""></body></html>=

--Apple-Mail=_033A615A-488E-4043-9DFF-BE8C312579EC--

