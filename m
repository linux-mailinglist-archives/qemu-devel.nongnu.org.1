Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0F582D407
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 06:59:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPFzv-000834-5Q; Mon, 15 Jan 2024 00:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rPFzt-00082s-7Q
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 00:58:57 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rPFzr-0006zV-94
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 00:58:56 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5ed10316e22so75802657b3.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 21:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705298334; x=1705903134; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5WeB0636w6pjKw5CV8oafFq4pBveJbNhSI4TkJTgFU=;
 b=Um+XHrM78f3Tum7/AIObMxJPtLWhdZglPeHKFZn79HZNzP/IM8I/4DWJL2lQRLv8nY
 6qbvEB10tuiUF+F81fTGdXPKjzk8xojQOYlzrKd13qjECHN6cvO99GL5paax/7zVI+7M
 yHz7jWi966IGK4mfvul5dkfkV2niahj2R4z1Ky8DieOnUC4ZZo2chMqRAvvcZWNt8fiQ
 PbB/uV6otU5gqbl54dvW7DfRIYXhT/t+UfD5YIOehj+cYC4Rzv5jUu/qk70UCpugGDKp
 Flgg+qWDF50SBe2xBZbWvlx+dwd6iL8TTOZpdr3x273QPoctkmOIfyfVbKuikxCu2ym/
 WaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705298334; x=1705903134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5WeB0636w6pjKw5CV8oafFq4pBveJbNhSI4TkJTgFU=;
 b=YHW+pAXiTnQqZwPLaWEIaF44Qdvaj1oofO/qnHf2O0hKOdhHYmgThQHgRwLOKQ9HR8
 Q2zdqETts96DZuaU4+2nvmbmSDaR3VP5niYeAc+PUvTYVHsI9QOoPRNvJZVUrkbdEbJl
 VGEEulyOWEqCqYVnfwwl4K1/X5yM8MCJPh6rGLjEnH+B1ANK/TPh4unqJByc8KUv6dQf
 kmv1iwXsH3X+UdLzupVxdISVjqgTkl2nW41xeU+UU3zbHu1401/Jn24u6FaAYAbYHIC9
 fz1jdjztqEVWxGJMWL3T0og/T2fkX4IwIc1nLl6UESfPUORkzZL7v/qGuAO73KlM90HM
 uZGA==
X-Gm-Message-State: AOJu0Yy54Zjaur/iBDcjYjcjZgqetwRFyAln7llTfQMnNp9lfEE/wmRu
 Aoc5Xb6BdfQLYKNkErryK+QncrjJbpfWR1M0rXs=
X-Google-Smtp-Source: AGHT+IFjn8pzDis4CwGml6+P2SchouZCStUyhEj5iNAGkEJsMIWQCAZLY7hcyYOGyQ+VPLYDmYHm/zUlLgBxGOVzNec=
X-Received: by 2002:a81:a7ca:0:b0:5ff:30d2:a63c with SMTP id
 e193-20020a81a7ca000000b005ff30d2a63cmr620599ywh.14.1705298333749; Sun, 14
 Jan 2024 21:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20240109124333.224240-1-shlomop@pliops.com>
 <CAFEAcA9WYrhuokJ_ox5CH0Et+WxiB_dwfHtsTZCb9cCfAveL9w@mail.gmail.com>
In-Reply-To: <CAFEAcA9WYrhuokJ_ox5CH0Et+WxiB_dwfHtsTZCb9cCfAveL9w@mail.gmail.com>
From: Shlomo Pongratz <shlomopongratz@gmail.com>
Date: Mon, 15 Jan 2024 07:58:42 +0200
Message-ID: <CAHzK-V2E8EQsh9V2tdqrEF651dPJchA9yLAzrFjFjun1tC8nKg@mail.gmail.com>
Subject: Re: [PATCH V2] Handle wrap around in limit calculation
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, andrew.sminov@gmail.com, peter.maydell@linaro.com, 
 shlomop@pliops.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=shlomopongratz@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Thank you.
Please see comments inline.

On Fri, Jan 12, 2024 at 7:03=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 9 Jan 2024 at 12:45, Shlomo Pongratz <shlomopongratz@gmail.com> w=
rote:
>
> Hi; thanks for this patch.
>
> > Hanlde wrap around caused by the fact that perior to version 460A
>
> Is this "460A" version number a version of the hardware
> we're modelling ?
>
> > the limit was 32bit quantity.
> > See Linux kernel code in:
> > drivers/pci/controllers/dwc/pcie-designware.c
>
> "/controller/"
>
> > function: __dw_pcie_prog_outbound_atu
>
> There don't seem to be any comments in this kernel function
> that say anything about wrap-around:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc=
/pcie-designware.c#L468
>
> so I'm not sure what you're trying to explain by referring to it.
This is just to give some  context.
If you look at the original submission of the controller patch d64e5eabc4c7=
e20c
pci: Add support for Designware IP block by Andrey Smirnov it is written th=
ere
"Add code needed to get a functional PCI subsytem when using in
    conjunction with upstream Linux guest (4.13+)."
>
> > Now in a 64bit system the range can be above 4G but as long as
> > the limit itself is less then 4G the overflow is avoided
> >
> > Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
> >
> > ----
> >
> > Changes since v1:
> >  * Seperate subject and description
> > ---
> >  hw/pci-host/designware.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> > index dd9e389c07..7ce4a6b64d 100644
> > --- a/hw/pci-host/designware.c
> > +++ b/hw/pci-host/designware.c
> > @@ -269,11 +269,24 @@ static void designware_pcie_update_viewport(Desig=
nwarePCIERoot *root,
> >  {
> >      const uint64_t target =3D viewport->target;
> >      const uint64_t base   =3D viewport->base;
> > -    const uint64_t size   =3D (uint64_t)viewport->limit - base + 1;
> >      const bool enabled    =3D viewport->cr[1] & DESIGNWARE_PCIE_ATU_EN=
ABLE;
> > +    uint64_t tbase, tlimit, size;
> >
> >      MemoryRegion *current, *other;
> >
> > +    /*
> > +     * Hanlde wrap around caused by the fact that perior to version 46=
0A
> > +     * the limit was 32bit quantity.
> > +     * See Linux kernel code in:
> > +     * drivers/pci/controllers/dwc/pcie-designware.c
> > +     * function: __dw_pcie_prog_outbound_atu
> > +     * Now in a 64bit system the range can be above 4G but as long as
> > +     * the limit itself is less then 4G the overflow is avoided
> > +     */
> > +    tbase =3D base & 0xffffffff;
> > +    tlimit =3D 0x100000000 + (uint64_t)viewport->limit;
> > +    size =3D ((tlimit - tbase) & 0xffffffff) + 1;
> > +
>
> I find this patch a bit confusing, partly because the comment
> seems to be written from the perspective of what the kernel
> driver is doing, not from the perspective of the hardware
> behaviour.
>
Again I refer to the original patch comment.
The original patch was written to support Linux kernel 4.13+ and a
specific implementation i.MX6 Applications Processor.
I've looked at the i.MX6 reference manual and it was silent regarding
the wrap-around case.
There is no reference to the  relevant Synopsys' Designware's specification=
.
Note that the pci version of the QEMU is 0, therefore I assume that
the implementation was tailored
to a specific implementation.
> What is the behaviour of the actual hardware here, both before
> and after 460A ? Which version are we trying to model?
I don't have access to the pantora of Synopsys' Designware's root port.
I can only conclude from the Linux kernel code that although the base
address was always 64 bit quantity,
then before version 460A that the limit quantity was 32 bit quantity
and from version 460A it is 64 bit quantity.
And the document that the original patch was based on didn't say what
is the behavior in case of wrap around.
I don't want to model any specific version, I just want to work with
device tree definitions that has regions above 4G,
which are possible since the base address is 64 bit quantity as long
as the regions size are
less teh 4G.
>
> thanks
> -- PMM

