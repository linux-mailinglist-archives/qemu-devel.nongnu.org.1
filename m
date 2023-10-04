Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A117B78D4
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 09:37:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwQs-0000PW-S5; Wed, 04 Oct 2023 03:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qnwQq-0000PH-8L
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:36:32 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qnwQn-0004lQ-Fr
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:36:31 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6beff322a97so1175280a34.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696404987; x=1697009787;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gcxx6dsVALTb+rscrLWDR1ktx6okwFHk9uAzWDT/pAs=;
 b=r2iBGnZFbbMmCIcJ+SNUvKholbFcKAFmcYlq6usnFBlrnOJEKf/evieCH7RS9Sv3zv
 1mc1MLvmvyf0uIGExaZKns6wvttede7OwjiG+w8MrOo387jAihKETN++StCzxnDUm22F
 6ggu66ao/Zvugz5duMc2ZK85gv9l/d/nXtET6ypHMnW96deELCB3C2/KFXLmqce6hzZf
 v6vvBNBBdqL3eb3PFDWV1ryB9qnOcDIlBKGCfJqIFxSLsfICBkLkHTGojPo680NeV1/k
 kRlCiQUF+X/WpDuFsM46fByRez4pOg0y4ivZZKTjusJUWy/zo5za4oeQUzEgPhwiOJwN
 RwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696404987; x=1697009787;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gcxx6dsVALTb+rscrLWDR1ktx6okwFHk9uAzWDT/pAs=;
 b=p7Jj4PMb0coc8rKkmpFev5nOc9/4+SkBDVMw1byMhVB3hQXmSJ9wrWeVnLoWmiCnGE
 r/RsV3xK0Eoz48BqVbXZNlo8pyAuHy5GDiFlXC71VWQVHQDHMXpaAynGBq1MdQCvH0NW
 MvSK9m1DBighE0mJBcIvpxm+wbZUbazjmFuORu6ErK61dZcYWQvwWLN7CRLvs3yd7fAP
 KGTRbIZRrKH/fOyIptMxugAu73ETWRQDYnaqtMkhnr1FNAl/TXoonKepWksAMyK0gxov
 iTpgvA8YATfBuKh5VudAP/NbspZarYhrizS9R56tjR/mbKQO0gDS6+1KP4VcaysTIw1c
 2zbQ==
X-Gm-Message-State: AOJu0YxtraENjjfgyaGBe4u+l0e7w6nLhxEyy8TO6ezFDGfanH31Zt28
 JX+AMyGUYVc192/xFGGc0rFbe/sF80eQKWx68tuwzQ==
X-Google-Smtp-Source: AGHT+IHNkJpyHPhAUz7MGxd2P/FBYoTvVO7vi3xbnnYwfITWpZe1/z3OaIeRGnumwxJSYP2a8nbYYYtKaVCB7HVPi2c=
X-Received: by 2002:a05:6870:3310:b0:1d5:cdf7:bd95 with SMTP id
 x16-20020a056870331000b001d5cdf7bd95mr1860975oae.16.1696404987540; Wed, 04
 Oct 2023 00:36:27 -0700 (PDT)
MIME-Version: 1.0
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Wed, 4 Oct 2023 09:36:16 +0200
Message-ID: <CAGNS4TbhS3XnCFAEi378+cSmJvGMdjN2oTv=tES36vbV4CaDuA@mail.gmail.com>
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
To: cz172638@gmail.com
Cc: bhelgaas@google.com, Jagannathan Raman <jag.raman@oracle.com>,
 kishon@kernel.org, 
 kvijayab@amd.com, kw@linux.com, levon@movementarian.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, mie@igel.co.jp, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, 
 robh@kernel.org, thanos.makatos@nutanix.com, vaishnav.a@ti.com, 
 william.henderson@nutanix.com
Content-Type: multipart/alternative; boundary="000000000000ad8d680606df1061"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=mnissler@rivosinc.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000ad8d680606df1061
Content-Type: text/plain; charset="UTF-8"

>
> hi shunsuke, all,
> what about vfio-user + qemu?
>

FWIW, I have had some good success using VFIO-user to bridge software
components to hardware designs. For the most part, I have been hooking up
software endpoint models to hardware design components speaking the PCIe
transaction layer protocol. The central piece you need is a way to
translate between the VFIO-user protocol and PCIe transaction layer
messages, basically converting ECAM accesses, memory accesses (DMA+MMIO),
and interrupts between the two worlds. I have some code which implements
the basics of that. It's certainly far from complete (TLP is a massive
protocol), but it works well enough for me. I believe we should be able to
open-source this if there's interest, let me know.

One thing to note is that there are currently some limits to bridging
VFIO-user / TLP that I haven't figured out and/or will need further work:
Advanced PCIe concepts like PASID, ATS/PRI, SR-IOV etc. may lack
equivalents on the VFIO-user side that would have to be filled in. The folk
behind libvfio-user[2] have been very approachable and open to improvements
in my experience though.

If I understand correctly, the specific goal here is testing PCIe endpoint
designs against a Linux host. What you'd need for that is a PCI host
controller for the Linux side to talk to and then hooking up endpoints on
the transaction layer. QEMU can simulate host controllers that work with
existing Linux drivers just fine. Then you can put a vfio-user-pci stub
device (I don't think this has landed in qemu yet, but you can find the
code at [1]) on the simulated PCI bus which will expose any software
interactions with the endpoint as VFIO-user protocol messages over unix
domain socket. The piece you need to bring is a VFIO-user server that
handles these messages. Its task is basically translating between VFIO-user
and TLP and then injecting TLP into your hardware design.

[1] https://github.com/oracle/qemu/tree/vfio-user-p3.1 - I believe that's
the latest version, Jagannathan Raman will know best
[2] https://github.com/nutanix/libvfio-user

--000000000000ad8d680606df1061
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">hi shuns=
uke, all,<br>what about vfio-user + qemu?<br></blockquote><div><br></div><d=
iv>FWIW, I have had some good success using VFIO-user to bridge software co=
mponents to hardware designs. For the most part, I have been hooking up sof=
tware endpoint models to hardware design components speaking the PCIe trans=
action layer protocol. The central piece you need is a way to translate bet=
ween the VFIO-user protocol and PCIe transaction layer messages, basically =
converting ECAM accesses, memory accesses (DMA+MMIO), and interrupts betwee=
n the two worlds. I have some code which implements the basics of that. It&=
#39;s certainly far from complete (TLP is a massive protocol), but it works=
 well enough for me. I believe we should be able to open-source this if the=
re&#39;s interest, let me know.<br></div><div><br></div><div>One thing to n=
ote is that there are currently some limits to bridging VFIO-user / TLP tha=
t I haven&#39;t figured out and/or will need further work: Advanced PCIe co=
ncepts like PASID, ATS/PRI, SR-IOV etc. may lack equivalents on the VFIO-us=
er side that would have to be filled in. The folk behind libvfio-user[2] ha=
ve been very approachable and open to improvements in my experience though.=
<br></div><div><br></div><div>If I understand correctly, the specific goal =
here is testing PCIe endpoint designs against a Linux host. What you&#39;d =
need for that is a PCI host controller for the Linux side to talk to and th=
en hooking up endpoints on the transaction layer. QEMU can simulate host co=
ntrollers that work with existing Linux drivers just fine. Then you can put=
 a vfio-user-pci stub device (I don&#39;t think this has landed in qemu yet=
, but you can find the code at [1]) on the simulated PCI bus which will exp=
ose any software interactions with the endpoint as VFIO-user protocol messa=
ges over unix domain socket. The piece you need to bring is a VFIO-user ser=
ver that handles these messages. Its task is basically translating between =
VFIO-user and TLP and then injecting TLP into your hardware design.<br></di=
v><div><br></div><div>[1] <a href=3D"https://github.com/oracle/qemu/tree/vf=
io-user-p3.1">https://github.com/oracle/qemu/tree/vfio-user-p3.1</a> - I be=
lieve that&#39;s the latest version,=C2=A0Jagannathan Raman will know best<=
/div><div>[2] <a href=3D"https://github.com/nutanix/libvfio-user">https://g=
ithub.com/nutanix/libvfio-user</a></div><br></div>

--000000000000ad8d680606df1061--

