Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDDC7E1A77
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 07:47:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztMo-0001kb-HR; Mon, 06 Nov 2023 01:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1qztMk-0001kQ-TC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:45:42 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1qztMj-0007jT-5r
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:45:42 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso8233474a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699253139; x=1699857939; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U+AqvDxTeRtd5HBrV0965pMk2bMFdHFuO6m8bfS4Juk=;
 b=bn0tPasQN7zX2+/UzxEiL6ryu9NqvJr5yEOOKH7pD9g5Tf4IGE5olBy8xF6h9IvJ6j
 Wly+RvUV9L0r7vfJHggztdNJ5nokb0hC94ztZ56Bzbli2Mx8LEoCnFtK/3T/ltGeOh0I
 mvgWffjGzCthsDjcbFcy7TD+vT9wP0V/MRCb1UY/OKmbxzkO+XudGUiNfBU3w1YI301F
 guVbOMuYrhnZvlwoi5STUvvUCwm7Gby4004edNSzXZbZlmWIFYufmCxyeK+1jGCnnA9Y
 4IJagmge4YT0Rmy1HXqAn6ODzMjMIjqBM77nidn4F1scbMXU/SElDeNOXNH81TFMR4aF
 tXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253139; x=1699857939;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U+AqvDxTeRtd5HBrV0965pMk2bMFdHFuO6m8bfS4Juk=;
 b=b53Ew8PJE/IHHP/N4YExHxSosDZ2xASLpk+9CdlOw5S9YpGAciWOtnhzFmWv0BjeT0
 1u6BNSZ9ZOPXi/IhXKqdMp6vqopydIZTk/e1+W0b6muhY4w6PgHLK8zcpsnvMef6cdVg
 XtVV+V4Xg15pMEX7E1aJTpKHkEo4CDN+Z3I0ct0wiGpWS0QkGD6dac2fPXzrMQ9WUAiE
 k5oKSk7RpLs4A7p7CLKgGK9Lh+0VEs38MV0qbj8wkwzzaNTLd9s853BzhO2ku0fjTUqa
 Nz1fx0rOd3EyH4rkJanuB60sVRw8lk15l9jrtSRUqvgzOjfNEmOKgsQUA9AtzLjRKLHA
 VjAg==
X-Gm-Message-State: AOJu0Yz6oj8xYUo1yPSEPKFnztBvIMm0mNTLkKchpVPQ+jS/TuwnRu5i
 aV+bUclHoQMj4WxVSlDXWs+YZJG91IBWIVHc92NTI8Vfb+c=
X-Google-Smtp-Source: AGHT+IEtJ+gf1vn+0KSPgw1vTiiThrKWCG4tMA3SLi6vyft1mv4GKEMqkHMrCBixIC+53zrOXJu50lL3TV2VJbyBwPA=
X-Received: by 2002:a50:d68c:0:b0:544:3cd4:5c50 with SMTP id
 r12-20020a50d68c000000b005443cd45c50mr6221640edi.14.1699253138695; Sun, 05
 Nov 2023 22:45:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1672868854.git.balaton@eik.bme.hu>
 <4162db13bd1da9c6ddd77f185cef738e44790467.1672868854.git.balaton@eik.bme.hu>
 <b821c773-a443-c70b-5d4c-787284028f8a@ilande.co.uk>
 <389d8398-2b77-a64e-7034-79123da6cb86@eik.bme.hu>
 <CABLmASHE7iiqHnOZxCfaqvz5zwUipG5vunHG_UK8krXu71HOgw@mail.gmail.com>
 <bd0e4431-c5ec-2ef5-d847-8c59aa8cc55c@eik.bme.hu>
 <ab9e33e5-70fc-0a76-c548-16ec787ea1af@ilande.co.uk>
 <ed8ee369-c9a8-7853-3b65-7361fefc3c63@eik.bme.hu>
 <ca5240e6-e00d-6213-22d6-f7b43d8bed18@ilande.co.uk>
 <CABLmASGc6fybw7mL5JHUCukwoB6KjGaaWHct5mi20A2vXZhtaA@mail.gmail.com>
In-Reply-To: <CABLmASGc6fybw7mL5JHUCukwoB6KjGaaWHct5mi20A2vXZhtaA@mail.gmail.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Mon, 6 Nov 2023 07:45:25 +0100
Message-ID: <CABLmASHL3etTk7b1Tbg6rcZD+qGZXcPBkAR0+tcJP+EJdXF63Q@mail.gmail.com>
Subject: Error detecting linker while compiling qemu-system-ppc on macOS
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000b729480609763305"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000b729480609763305
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm getting a error while compiling on macOS (Intel). It seems linker
detection is passed an unknown argument "--version", whereas "-v" works OK?
See log below.

Thanks for looking into this,
Howard

Build started at 2023-11-06T07:29:19.181487
Main binary: /Users/hsp/src/qemu-ppc/build/pyvenv/bin/python3.11
Build Options: -Db_pie=false -Ddocs=disabled -Dplugins=true '--native-file
config-meson.cross'
Python system: Darwin
The Meson build system
Version: 0.63.3
Source dir: /Users/hsp/src/qemu-ppc
Build dir: /Users/hsp/src/qemu-ppc/build
Build type: native build
Project name: qemu
Project version: 8.1.50
-----
Detecting compiler via: cc -m64 -mcx16 --version
compiler returned <Popen: returncode: 0 args: ['cc', '-m64', '-mcx16',
'--version']>
compiler stdout:
Apple clang version 15.0.0 (clang-1500.0.40.1)
Target: x86_64-apple-darwin22.6.0
Thread model: posix
InstalledDir: /Library/Developer/CommandLineTools/usr/bin

compiler stderr:

Running command: cc -m64 -mcx16 -E -dM -
-----
Detecting linker via: cc -m64 -mcx16 -Wl,--version
linker returned <Popen: returncode: 1 args: ['cc', '-m64', '-mcx16',
'-Wl,--version']>
linker stdout:

linker stderr:
ld: unknown options: --version
clang: error: linker command failed with exit code 1 (use -v to see
invocation)

-----
Detecting Apple linker via: cc -m64 -mcx16 -Wl,-v
linker stdout:

linker stderr:
@(#)PROGRAM:ld  PROJECT:dyld-1015.7
BUILD 18:48:43 Aug 22 2023
configured to support archs: armv6 armv7 armv7s arm64 arm64e arm64_32 i386
x86_64 x86_64h armv6m armv7k armv7m armv7em
will use ld-classic for: armv6 armv7 armv7s arm64_32 i386 armv6m armv7k
armv7m armv7em
LTO support using: LLVM version 15.0.0 (static support for 29, runtime is
29)
TAPI support using: Apple TAPI version 15.0.0 (tapi-1500.0.12.3)
Library search paths:
/usr/local/lib
Framework search paths:
ld: Undefined symbols:
  _main, referenced from:
      <initial-undefines>
clang: error: linker command failed with exit code 1 (use -v to see
invocation)


../meson.build:1:0: ERROR: Unable to detect linker for compiler `cc -m64
-mcx16 -Wl,--version`
stdout:
stderr: ld: unknown options: --version
clang: error: linker command failed with exit code 1 (use -v to see
invocation)

--000000000000b729480609763305
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all,</div><div><br></div><div>I&#39;m getting a er=
ror while compiling on macOS (Intel). It seems linker detection is passed a=
n unknown argument &quot;--version&quot;, whereas &quot;-v&quot; works OK?<=
/div><div>See log below.</div><div><br></div><div>Thanks for looking into t=
his,<br></div><div>Howard<br></div><div><br></div><div>Build started at 202=
3-11-06T07:29:19.181487<br>Main binary: /Users/hsp/src/qemu-ppc/build/pyven=
v/bin/python3.11<br>Build Options: -Db_pie=3Dfalse -Ddocs=3Ddisabled -Dplug=
ins=3Dtrue &#39;--native-file config-meson.cross&#39;<br>Python system: Dar=
win<br>The Meson build system<br>Version: 0.63.3<br>Source dir: /Users/hsp/=
src/qemu-ppc<br>Build dir: /Users/hsp/src/qemu-ppc/build<br>Build type: nat=
ive build<br>Project name: qemu<br>Project version: 8.1.50<br>-----<br>Dete=
cting compiler via: cc -m64 -mcx16 --version<br>compiler returned &lt;Popen=
: returncode: 0 args: [&#39;cc&#39;, &#39;-m64&#39;, &#39;-mcx16&#39;, &#39=
;--version&#39;]&gt;<br>compiler stdout:<br>Apple clang version 15.0.0 (cla=
ng-1500.0.40.1)<br>Target: x86_64-apple-darwin22.6.0<br>Thread model: posix=
<br>InstalledDir: /Library/Developer/CommandLineTools/usr/bin<br><br>compil=
er stderr:<br><br>Running command: cc -m64 -mcx16 -E -dM -<br>-----<br>Dete=
cting linker via: cc -m64 -mcx16 -Wl,--version<br>linker returned &lt;Popen=
: returncode: 1 args: [&#39;cc&#39;, &#39;-m64&#39;, &#39;-mcx16&#39;, &#39=
;-Wl,--version&#39;]&gt;<br>linker stdout:<br><br>linker stderr:<br>ld: unk=
nown options: --version <br>clang: error: linker command failed with exit c=
ode 1 (use -v to see invocation)<br><br>-----<br>Detecting Apple linker via=
: cc -m64 -mcx16 -Wl,-v<br>linker stdout:<br><br>linker stderr:<br>@(#)PROG=
RAM:ld =C2=A0PROJECT:dyld-1015.7<br>BUILD 18:48:43 Aug 22 2023<br>configure=
d to support archs: armv6 armv7 armv7s arm64 arm64e arm64_32 i386 x86_64 x8=
6_64h armv6m armv7k armv7m armv7em<br>will use ld-classic for: armv6 armv7 =
armv7s arm64_32 i386 armv6m armv7k armv7m armv7em<br>LTO support using: LLV=
M version 15.0.0 (static support for 29, runtime is 29)<br>TAPI support usi=
ng: Apple TAPI version 15.0.0 (tapi-1500.0.12.3)<br>Library search paths:<b=
r>	/usr/local/lib<br>Framework search paths:<br>ld: Undefined symbols:<br>=
=C2=A0 _main, referenced from:<br>=C2=A0 =C2=A0 =C2=A0 &lt;initial-undefine=
s&gt;<br>clang: error: linker command failed with exit code 1 (use -v to se=
e invocation)<br><br><br>../meson.build:1:0: ERROR: Unable to detect linker=
 for compiler `cc -m64 -mcx16 -Wl,--version`<br>stdout: <br>stderr: ld: unk=
nown options: --version <br>clang: error: linker command failed with exit c=
ode 1 (use -v to see invocation)<br><br><br></div></div>

--000000000000b729480609763305--

