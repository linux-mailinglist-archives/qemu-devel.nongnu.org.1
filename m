Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 126627BB739
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 14:02:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qojWE-0008S4-Uc; Fri, 06 Oct 2023 08:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qojW2-0008Pk-PL
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:01:11 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qojVx-0006L3-H6
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:01:10 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6c7c2c428c1so583948a34.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 05:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696593664; x=1697198464;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4dHLe022tfg6JAJt/ugwVPdl75c59qlrzkRNqgnv8E=;
 b=bzwCGJn6wNuCb6VYnOFXqbhyA8vqPBlXJTUdO+OiLOxq9rbdLxOjV8Ag60GWEvvJCf
 H2R7FEM7VPRAmt7kK6G8vq1m3kM3ucHr4N9zl62uhYSGr3oFfaw0OG4dWUcy1uzWy4ZN
 dEFJibg0V6XlazbhgqP8cBNefr+i3dj0VmqEblZ5dv3cYEI+g7lgXwlUVOCpFmOumHCB
 4fRmLD5IHcJHEu7GZ7AVQytxexl2DxeC1oawF4Q6yX0uIlDo4cYSw1vI38elhh1suenm
 TIuBG/oj9CyUwJR6m3RukQjWOqkDhhiA/ynoHiK4oEIkQaspXeLrVAEkDaxJkulFvxaa
 rCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696593664; x=1697198464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4dHLe022tfg6JAJt/ugwVPdl75c59qlrzkRNqgnv8E=;
 b=t7mey5psMSSm3MH6y63NNgFXH0HAnCPrg8PAwI0PwTFzyyD+HqhFb3vWmKCSXqG4cZ
 OcZdTbD9wFfUK1oyFyGaME0lsleRLWacGc0GVqi6vM1iAOJqiONOvRG8ZVTQZk5Zv2/Y
 +k3zAlfkDYlmtHcJ4I4Wy6bki9GDCQB1APIYHrWxOU5lWJywalW3Pj3bD8Dt8CZ1QMkU
 XIEfucQmJOpOJXWbYGXmGb/pVK12Snz0OkF9aVZYV8xy9vLmmzV8Jvgn3STr/E7GWfBN
 zcOb69pRclW9pf03qBQwA+zIuCuUeG1qCbbV5tQd1rdj5mMFD1IQpYgFDq3DLMKx1awN
 A7qg==
X-Gm-Message-State: AOJu0YyiMxOVFVzNhnvzjqDcrADhjKScMVC2+EvZ+P+QUmneV+0q5cX0
 8iZ6TfP1GYdKWNME+uCCtquOJardixouczWJCvMqMg==
X-Google-Smtp-Source: AGHT+IHtR0I2S6gwdB3Du4+URFD8ib3OjGxKppuEG08esn3Jzi/IpuBRLxCeeR6aXGWBXeA+lBOhwhRbkeyse6Zpz+w=
X-Received: by 2002:a05:6870:c192:b0:1d6:ce75:d472 with SMTP id
 h18-20020a056870c19200b001d6ce75d472mr2307177oad.6.1696593663716; Fri, 06 Oct
 2023 05:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNS4TbhS3XnCFAEi378+cSmJvGMdjN2oTv=tES36vbV4CaDuA@mail.gmail.com>
 <CANXvt5qKxfU3p1eSK4fkzRFRBXHSVvSkJrnQRLKPkQjhsMGNzQ@mail.gmail.com>
 <CAGNS4TbAgqRQepv=fMoUxo02Qea5S9LwWFm-jjt1ej8DdLjshw@mail.gmail.com>
 <88775092-78d7-d1b6-100b-369079ff979b@igel.co.jp>
In-Reply-To: <88775092-78d7-d1b6-100b-369079ff979b@igel.co.jp>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Fri, 6 Oct 2023 14:00:52 +0200
Message-ID: <CAGNS4TbhB19XZN-eXe4uT=ShjLUfmzC9qAkR4abzC1EUg4=r6A@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=mnissler@rivosinc.com; helo=mail-ot1-x334.google.com
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

On Fri, Oct 6, 2023 at 1:51=E2=80=AFPM Shunsuke Mie <mie@igel.co.jp> wrote:
>
>
> On 2023/10/05 16:02, Mattias Nissler wrote:
> > On Thu, Oct 5, 2023 at 3:31=E2=80=AFAM Shunsuke Mie <mie@igel.co.jp> wr=
ote:
> >> Hi Jiri, Mattias and all.
> >>
> >> 2023=E5=B9=B410=E6=9C=884=E6=97=A5(=E6=B0=B4) 16:36 Mattias Nissler <m=
nissler@rivosinc.com>:
> >>>> hi shunsuke, all,
> >>>> what about vfio-user + qemu?
> >> Thank you for the suggestion.
> >>
> >>> FWIW, I have had some good success using VFIO-user to bridge software=
 components to hardware designs. For the most part, I have been hooking up =
software endpoint models to hardware design components speaking the PCIe tr=
ansaction layer protocol. The central piece you need is a way to translate =
between the VFIO-user protocol and PCIe transaction layer messages, basical=
ly converting ECAM accesses, memory accesses (DMA+MMIO), and interrupts bet=
ween the two worlds. I have some code which implements the basics of that. =
It's certainly far from complete (TLP is a massive protocol), but it works =
well enough for me. I believe we should be able to open-source this if ther=
e's interest, let me know.
> >> It is what I want to do, but I'm not familiar with the vfio and vfio-u=
ser, and I have a question. QEMU has a PCI TLP communication implementation=
 for Multi-process QEMU[1]. It is similar to your success.
> > I'm no qemu expert, but my understanding is that the plan is for the
> > existing multi-process QEMU implementation to eventually be
> > superseded/replaced by the VFIO-user based one (qemu folks, please
> > correct me if I'm wrong). From a functional perspective they are more
> > or less equivalent AFAICT.
> >
> The project is promising.
>
> I found a session about the vfio adapts to Multi-process QEMU[1] in KVM
> Forun 2021, butI couldn't found some posted patches.
> If anyone knows status of this project, could you please let me know?

Again, I'm just an interested bystander, so take my words with a grain
of salt. That said, my understanding is that there is an intention to
get the vfio-user client code into qemu in the foreseeable future. The
most recent version of the code that I'm aware of is here:
https://github.com/oracle/qemu/tree/vfio-user-p3.1

>
> [1] https://www.youtube.com/watch?v=3DNBT8rImx3VE
> >> The multi-process qemu also communicates TLP over UDS. Could you let m=
e know your opinion about it?
> > Note that neither multi-process qemu nor VFIO-user actually pass
> > around TLPs, but rather have their own command language to encode
> > ECAM, MMIO, DMA, interrupts etc. However, translation from/to TLP is
> > possible and works well enough in my experience.
> I agree.
> >>> One thing to note is that there are currently some limits to bridging=
 VFIO-user / TLP that I haven't figured out and/or will need further work: =
Advanced PCIe concepts like PASID, ATS/PRI, SR-IOV etc. may lack equivalent=
s on the VFIO-user side that would have to be filled in. The folk behind li=
bvfio-user[2] have been very approachable and open to improvements in my ex=
perience though.
> >>>
> >>> If I understand correctly, the specific goal here is testing PCIe end=
point designs against a Linux host. What you'd need for that is a PCI host =
controller for the Linux side to talk to and then hooking up endpoints on t=
he transaction layer. QEMU can simulate host controllers that work with exi=
sting Linux drivers just fine. Then you can put a vfio-user-pci stub device=
 (I don't think this has landed in qemu yet, but you can find the code at [=
1]) on the simulated PCI bus which will expose any software interactions wi=
th the endpoint as VFIO-user protocol messages over unix domain socket. The=
 piece you need to bring is a VFIO-user server that handles these messages.=
 Its task is basically translating between VFIO-user and TLP and then injec=
ting TLP into your hardware design.
> >> Yes, If the pci host controller you said can be implemented, I can ach=
ieve my goal.
> > I meant to say that the existing PCIe host controller implementations
> > in qemu can be used as is.
> Sorry, I misunderstood.
> >> To begin with, I'll investigate the vfio and libvfio-user.  Thanks!.
> >>
> >> [1] https://www.qemu.org/docs/master/system/multi-process.html
> >>
> >> Best,
> >> Shunsuke
> >>>
> >>> [1] https://github.com/oracle/qemu/tree/vfio-user-p3.1 - I believe th=
at's the latest version, Jagannathan Raman will know best
> >>> [2] https://github.com/nutanix/libvfio-user
> >>>

