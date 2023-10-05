Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7858B7B9B36
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:04:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIOM-0002sr-GM; Thu, 05 Oct 2023 03:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qoIOB-0002sX-JO
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:03:16 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qoIO1-0006Ql-0f
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:03:15 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1dd7139aa57so413833fac.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 00:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696489375; x=1697094175;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sykav7kHqqi8q7/u6IWk2uLR08rKtlD8qNcinnjqeE=;
 b=yF2b8CZhQGsmr1kMq+wZM/SSxuE5dGg30IFAKkV6n+uXnxLjmX310cWYwmRk5wrmCN
 JkWj5uftCDpkveSJMcXw4v/mIt+/zl+L/uJoDs+gGERBxAeJaoDp8gua5XzEDw3r1qaN
 GBdvMI0V12IJD7P0muYSUJdl7blDjTHqk1EjUsDqAJKgb1crXe1K5gPK2BDpWnMoCY4T
 U8Yf4bekOSBtFYOyRmqRWYnMUevwfERcRM8DVN2c3QGQEgaZ9imOy1vtTKwbA7BbE9a+
 IcT+MkQs/TN8W3/Bml2C1fInWC+7F7P6OmBsOsERST7OWtik3hEm1i4vVQ/merkpFFfL
 u3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696489375; x=1697094175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sykav7kHqqi8q7/u6IWk2uLR08rKtlD8qNcinnjqeE=;
 b=OdXYXw1AfZblFhfmuBGukorrPjvlFI04ikg2Rxtxq6Cps6FunJuej945ljyb4NKGpy
 5cYvzKv44+K5Ujr5+U/eTJtKHCuyQo5GPrcUGSw25V9c2KWX4USMYXyVEuh/iJlREN98
 pM9J+hwc/aoX4wLM30oC9dKRppBi06PFBof8yauvRC/UV8q69RurRnES25xFX2tuvgj9
 FvGmtA6GWM7Oczoi/VqbJqn8wk93lxzECAzXdgo9X0R4/TkFmv0KLfCfcZoCV7BJOT3J
 lzWIlr5bPdQhSz4RGZl5PNMQQbtNEtbYoytYB7yMB6mRoKTLZttBPtIs6dpDxi2V2VCM
 6DsA==
X-Gm-Message-State: AOJu0Yx4hy1dEHAPAxpC6WxICzVd7otGEceHsabY7kXIrPi8i7H57C9A
 t2rJqi4FRB2BHW8JXN2IYxB9R22WRuYYTdrYSj1tpg==
X-Google-Smtp-Source: AGHT+IEohgIk5UquNb/UwnJ5C2hvcdK98D8tmyk7HEt7s924VZVpqhRHV2s1uYLWOC8Y/4LxNPQ3sYtYYNYJ/BjIuxs=
X-Received: by 2002:a05:6870:c195:b0:1be:ffae:29a3 with SMTP id
 h21-20020a056870c19500b001beffae29a3mr4873386oad.23.1696489375332; Thu, 05
 Oct 2023 00:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNS4TbhS3XnCFAEi378+cSmJvGMdjN2oTv=tES36vbV4CaDuA@mail.gmail.com>
 <CANXvt5qKxfU3p1eSK4fkzRFRBXHSVvSkJrnQRLKPkQjhsMGNzQ@mail.gmail.com>
In-Reply-To: <CANXvt5qKxfU3p1eSK4fkzRFRBXHSVvSkJrnQRLKPkQjhsMGNzQ@mail.gmail.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Thu, 5 Oct 2023 09:02:44 +0200
Message-ID: <CAGNS4TbAgqRQepv=fMoUxo02Qea5S9LwWFm-jjt1ej8DdLjshw@mail.gmail.com>
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
To: Shunsuke Mie <mie@igel.co.jp>
Cc: cz172638@gmail.com, bhelgaas@google.com, 
 Jagannathan Raman <jag.raman@oracle.com>, kishon@kernel.org, kvijayab@amd.com,
 kw@linux.com, levon@movementarian.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, lpieralisi@kernel.org, 
 manivannan.sadhasivam@linaro.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, robh@kernel.org, 
 thanos.makatos@nutanix.com, vaishnav.a@ti.com, william.henderson@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 5, 2023 at 3:31=E2=80=AFAM Shunsuke Mie <mie@igel.co.jp> wrote:
>
> Hi Jiri, Mattias and all.
>
> 2023=E5=B9=B410=E6=9C=884=E6=97=A5(=E6=B0=B4) 16:36 Mattias Nissler <mnis=
sler@rivosinc.com>:
>>>
>>> hi shunsuke, all,
>>> what about vfio-user + qemu?
>
> Thank you for the suggestion.
>
>> FWIW, I have had some good success using VFIO-user to bridge software co=
mponents to hardware designs. For the most part, I have been hooking up sof=
tware endpoint models to hardware design components speaking the PCIe trans=
action layer protocol. The central piece you need is a way to translate bet=
ween the VFIO-user protocol and PCIe transaction layer messages, basically =
converting ECAM accesses, memory accesses (DMA+MMIO), and interrupts betwee=
n the two worlds. I have some code which implements the basics of that. It'=
s certainly far from complete (TLP is a massive protocol), but it works wel=
l enough for me. I believe we should be able to open-source this if there's=
 interest, let me know.
>
> It is what I want to do, but I'm not familiar with the vfio and vfio-user=
, and I have a question. QEMU has a PCI TLP communication implementation fo=
r Multi-process QEMU[1]. It is similar to your success.

I'm no qemu expert, but my understanding is that the plan is for the
existing multi-process QEMU implementation to eventually be
superseded/replaced by the VFIO-user based one (qemu folks, please
correct me if I'm wrong). From a functional perspective they are more
or less equivalent AFAICT.

> The multi-process qemu also communicates TLP over UDS. Could you let me k=
now your opinion about it?

Note that neither multi-process qemu nor VFIO-user actually pass
around TLPs, but rather have their own command language to encode
ECAM, MMIO, DMA, interrupts etc. However, translation from/to TLP is
possible and works well enough in my experience.

>
>> One thing to note is that there are currently some limits to bridging VF=
IO-user / TLP that I haven't figured out and/or will need further work: Adv=
anced PCIe concepts like PASID, ATS/PRI, SR-IOV etc. may lack equivalents o=
n the VFIO-user side that would have to be filled in. The folk behind libvf=
io-user[2] have been very approachable and open to improvements in my exper=
ience though.
>>
>> If I understand correctly, the specific goal here is testing PCIe endpoi=
nt designs against a Linux host. What you'd need for that is a PCI host con=
troller for the Linux side to talk to and then hooking up endpoints on the =
transaction layer. QEMU can simulate host controllers that work with existi=
ng Linux drivers just fine. Then you can put a vfio-user-pci stub device (I=
 don't think this has landed in qemu yet, but you can find the code at [1])=
 on the simulated PCI bus which will expose any software interactions with =
the endpoint as VFIO-user protocol messages over unix domain socket. The pi=
ece you need to bring is a VFIO-user server that handles these messages. It=
s task is basically translating between VFIO-user and TLP and then injectin=
g TLP into your hardware design.
>
> Yes, If the pci host controller you said can be implemented, I can achiev=
e my goal.

I meant to say that the existing PCIe host controller implementations
in qemu can be used as is.

>
> To begin with, I'll investigate the vfio and libvfio-user.  Thanks!.
>
> [1] https://www.qemu.org/docs/master/system/multi-process.html
>
> Best,
> Shunsuke
>>
>>
>> [1] https://github.com/oracle/qemu/tree/vfio-user-p3.1 - I believe that'=
s the latest version, Jagannathan Raman will know best
>> [2] https://github.com/nutanix/libvfio-user
>>
>

