Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DC97B99AD
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 03:33:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoDDi-0007A5-8I; Wed, 04 Oct 2023 21:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mie@igel.co.jp>) id 1qoDDe-0006z2-O6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 21:32:02 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mie@igel.co.jp>) id 1qoDDT-0001ZJ-63
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 21:31:56 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4545d8a95d9so194114137.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 18:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1696469508; x=1697074308;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sdttXZsYVKYNhVdFLS7zKGLp8vWLUS/hHtqctwej5Cw=;
 b=ymmgg3xIIDJENsLJ72JWi+4AKuGWIPXVaB1Yufegp7d2OvSXfyJu4v7lXHaYjE5Z14
 LPuJVYrBZ8xzw4jWMhtXJIbDxGkvqtOxsS6AlP8U574Z6qR2g/CPUsiRWjweR1E9LpHp
 QRUGgImoiR3w2IrgXqE+uqcZx/uhUC06kehekMExeBXABYJ88ssTHI0bI5r+ZDYQ2xrK
 AawPkRsYf2T0skQwBX2ut3sFvSZE4T99TJiTkuys+MfA6tDwtfAqvR8RjCISZO1OfMUU
 7KJnbT3dKn4dQBZjXan27JLdrq2kQadHCP/8c/x9s8V8GrhlhniFc1yYdJ98ZZHgOIUJ
 vmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696469508; x=1697074308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sdttXZsYVKYNhVdFLS7zKGLp8vWLUS/hHtqctwej5Cw=;
 b=JTbDvvHFZlnRNG+LUNnIDM302A+yf5BhHt97hCWArdFvBHY6NnrUwh/eIVW+SRusuM
 UCNysVs9lc1DGxjJTobDOH2v12zo9vZ1waA7xFbz3wdBuOuBOP40Z94/cuyboF0yYa6R
 a+mVwKaOqeKdd6Dh2QiFS+nhqSo2WsWmAQlvdRkCcaeQ9o76gseQYCRq4aopkYsSPFtL
 n/sLRSGXlVci1BNDlENvs+ox5APIaCJWyZPidEWtdoYCmAvoG7yC8+/T6Xg3UfTX2QpC
 qBaKp6Z8ptDC+APdDwa8EVgXVRJgiiTrOs0YRGr6fAsj2jlKNav47E/IrritghibLppz
 WAAA==
X-Gm-Message-State: AOJu0YxvJgtG72Ed7pRH8QArP+Ry0r5b8UDSNuTH+2b09u4mzhLjDETN
 1a8FmYJhsx9f0W0tw58f9MSfcCrsVedMAKATcAc7nw==
X-Google-Smtp-Source: AGHT+IFj7YUwQqklFB38MGhKothyz2wFVITqiXgxZGZ9Plrr6jOSVH3XMIhmgBymbK7jfHvR8+JNmYX29oL9NrCqf9Y=
X-Received: by 2002:a05:6102:215:b0:454:6d8b:3346 with SMTP id
 z21-20020a056102021500b004546d8b3346mr3196627vsp.12.1696469508194; Wed, 04
 Oct 2023 18:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNS4TbhS3XnCFAEi378+cSmJvGMdjN2oTv=tES36vbV4CaDuA@mail.gmail.com>
In-Reply-To: <CAGNS4TbhS3XnCFAEi378+cSmJvGMdjN2oTv=tES36vbV4CaDuA@mail.gmail.com>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Thu, 5 Oct 2023 10:31:37 +0900
Message-ID: <CANXvt5qKxfU3p1eSK4fkzRFRBXHSVvSkJrnQRLKPkQjhsMGNzQ@mail.gmail.com>
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: cz172638@gmail.com, bhelgaas@google.com, 
 Jagannathan Raman <jag.raman@oracle.com>, kishon@kernel.org, kvijayab@amd.com,
 kw@linux.com, levon@movementarian.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, lpieralisi@kernel.org, 
 manivannan.sadhasivam@linaro.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, robh@kernel.org, 
 thanos.makatos@nutanix.com, vaishnav.a@ti.com, william.henderson@nutanix.com
Content-Type: multipart/alternative; boundary="00000000000068a73c0606ee16da"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=mie@igel.co.jp; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--00000000000068a73c0606ee16da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri, Mattias and all.

2023=E5=B9=B410=E6=9C=884=E6=97=A5(=E6=B0=B4) 16:36 Mattias Nissler <mnissl=
er@rivosinc.com>:

> hi shunsuke, all,
>> what about vfio-user + qemu?
>
> Thank you for the suggestion.

FWIW, I have had some good success using VFIO-user to bridge software
> components to hardware designs. For the most part, I have been hooking up
> software endpoint models to hardware design components speaking the PCIe
> transaction layer protocol. The central piece you need is a way to
> translate between the VFIO-user protocol and PCIe transaction layer
> messages, basically converting ECAM accesses, memory accesses (DMA+MMIO),
> and interrupts between the two worlds. I have some code which implements
> the basics of that. It's certainly far from complete (TLP is a massive
> protocol), but it works well enough for me. I believe we should be able t=
o
> open-source this if there's interest, let me know.
>
It is what I want to do, but I'm not familiar with the vfio and vfio-user,
and I have a question. QEMU has a PCI TLP communication implementation for
Multi-process QEMU[1]. It is similar to your success. The multi-process
qemu also communicates TLP over UDS. Could you let me know your opinion
about it?

One thing to note is that there are currently some limits to bridging
> VFIO-user / TLP that I haven't figured out and/or will need further work:
> Advanced PCIe concepts like PASID, ATS/PRI, SR-IOV etc. may lack
> equivalents on the VFIO-user side that would have to be filled in. The fo=
lk
> behind libvfio-user[2] have been very approachable and open to improvemen=
ts
> in my experience though.
>
> If I understand correctly, the specific goal here is testing PCIe endpoin=
t
> designs against a Linux host. What you'd need for that is a PCI host
> controller for the Linux side to talk to and then hooking up endpoints on
> the transaction layer. QEMU can simulate host controllers that work with
> existing Linux drivers just fine. Then you can put a vfio-user-pci stub
> device (I don't think this has landed in qemu yet, but you can find the
> code at [1]) on the simulated PCI bus which will expose any software
> interactions with the endpoint as VFIO-user protocol messages over unix
> domain socket. The piece you need to bring is a VFIO-user server that
> handles these messages. Its task is basically translating between VFIO-us=
er
> and TLP and then injecting TLP into your hardware design.
>
Yes, If the pci host controller you said can be implemented, I can achieve
my goal.

To begin with, I'll investigate the vfio and libvfio-user.  Thanks!.

[1] https://www.qemu.org/docs/master/system/multi-process.html

Best,
Shunsuke

>
> [1] https://github.com/oracle/qemu/tree/vfio-user-p3.1 - I believe that's
> the latest version, Jagannathan Raman will know best
> [2] https://github.com/nutanix/libvfio-user
>
>

--00000000000068a73c0606ee16da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jiri, Mattias and all.<div><br></div><div><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">2023=E5=B9=B410=E6=9C=
=884=E6=97=A5(=E6=B0=B4) 16:36 Mattias Nissler &lt;<a href=3D"mailto:mnissl=
er@rivosinc.com" target=3D"_blank">mnissler@rivosinc.com</a>&gt;:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">hi shunsuke, all,<br>what about v=
fio-user + qemu?</blockquote></div></blockquote><div>Thank you for the sugg=
estion.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr"><div>FWIW, I have had some good success using VFIO-user=
 to bridge software components to hardware designs. For the most part, I ha=
ve been hooking up software endpoint models to hardware design components s=
peaking the PCIe transaction layer protocol. The central piece you need is =
a way to translate between the VFIO-user protocol and PCIe transaction laye=
r messages, basically converting ECAM accesses, memory accesses (DMA+MMIO),=
 and interrupts between the two worlds. I have some code which implements t=
he basics of that. It&#39;s certainly far from complete (TLP is a massive p=
rotocol), but it works well enough for me. I believe we should be able to o=
pen-source this if there&#39;s interest, let me know.</div></div></blockquo=
te><div>It is what I want to do, but I&#39;m not familiar with the vfio and=
 vfio-user, and I have a question. QEMU has a PCI TLP communication impleme=
ntation for Multi-process QEMU[1]. It is similar to your success. The multi=
-process qemu also communicates TLP over UDS. Could you let me know your op=
inion about it?</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div>One thing to note is that there are curren=
tly some limits to bridging VFIO-user / TLP that I haven&#39;t figured out =
and/or will need further work: Advanced PCIe concepts like PASID, ATS/PRI, =
SR-IOV etc. may lack equivalents on the VFIO-user side that would have to b=
e filled in. The folk behind libvfio-user[2] have been very approachable an=
d open to improvements in my experience though.<br></div><div><br></div><di=
v>If I understand correctly, the specific goal here is testing PCIe endpoin=
t designs against a Linux host. What you&#39;d need for that is a PCI host =
controller for the Linux side to talk to and then hooking up endpoints on t=
he transaction layer. QEMU can simulate host controllers that work with exi=
sting Linux drivers just fine. Then you can put a vfio-user-pci stub device=
 (I don&#39;t think this has landed in qemu yet, but you can find the code =
at [1]) on the simulated PCI bus which will expose any software interaction=
s with the endpoint as VFIO-user protocol messages over unix domain socket.=
 The piece you need to bring is a VFIO-user server that handles these messa=
ges. Its task is basically translating between VFIO-user and TLP and then i=
njecting TLP into your hardware design.<br></div></div></blockquote><div>Ye=
s, If the pci host controller you said can be implemented, I can achieve my=
 goal.</div><div><br></div><div>To begin with, I&#39;ll investigate the vfi=
o and libvfio-user.=C2=A0 Thanks!.</div><div><br></div><div>[1]=C2=A0<a hre=
f=3D"https://www.qemu.org/docs/master/system/multi-process.html">https://ww=
w.qemu.org/docs/master/system/multi-process.html</a>=C2=A0<br></div><div><b=
r></div><div>Best,</div><div>Shunsuke</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div dir=3D"ltr"><div></div><div><br></div><div>[1] <a hr=
ef=3D"https://github.com/oracle/qemu/tree/vfio-user-p3.1" target=3D"_blank"=
>https://github.com/oracle/qemu/tree/vfio-user-p3.1</a> - I believe that&#3=
9;s the latest version,=C2=A0Jagannathan Raman will know best</div><div>[2]=
 <a href=3D"https://github.com/nutanix/libvfio-user" target=3D"_blank">http=
s://github.com/nutanix/libvfio-user</a></div><br></div></blockquote><div><b=
r></div></div></div></div>

--00000000000068a73c0606ee16da--

