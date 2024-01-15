Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A9382D781
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:38:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKLn-0008B7-Pv; Mon, 15 Jan 2024 05:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPKLl-00089E-I9
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:37:49 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPKLj-0002Ra-Fm
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:37:49 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55790581457so9663528a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 02:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705315065; x=1705919865; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2ufC2Kf6yhASwqWFu2blUJGKFvpgtr/YEH0NIDcJJQ=;
 b=VXMKAbLI/I4lmWjRAi1oTNlCvDNsjaABY4Hl9L5JRY4YjAxF845/1f1upWHuRaYnTB
 GE7Ac63jhx3lpzabI1In8brswKYr3DdyWop2oTCBWk1rvV1F3Y2eJOVK8fy/4PFV/fEk
 L7Q0bXtgOAyrFYWRUOfhmLhPQTJSyzqMN0waq1Sv0pdA8VIdvLgGYJBeBOk6ceh8oTZl
 O34cMv+mJTaPQM4TDHIzv/k68LYZXLb0lajk+P4lDlUMPHaQPO/mRks++RyjM10BgGuH
 QcjtzV8GmlNhUTi8pcoc4tBATPYqrsaS4VO6CP03Xw7cUCTw2UQ/dOZ1qnXesk4NLNI+
 sQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705315065; x=1705919865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2ufC2Kf6yhASwqWFu2blUJGKFvpgtr/YEH0NIDcJJQ=;
 b=mchNrC6zNpehMA9CU+D0UMd9rTg9c2YZClSx4B71m08GaHC9KyudJu94XMmUzSJNjU
 U/CExPWw8T3gxnRuswTEgNzY5kkEyB/PS5Kj8fL6Q3ive6TxnpAZ4B9Czw1FhgWgrx8l
 UxsO2cWdmCs/ZcqFpxHVqwu7nzSxRb99ICtJVF32zharz5E1IGRaEhCHbSYR53sc8ENW
 ejQEfkw/7Fq6kVmElaxPIEft8zf3qX2ki59WqqKg9gdHb6UJNtfLcXc8FTiUdJ/9Mnxu
 eZZqjlWgBoUtZC7e+s+SggKYhR49y/YeoIxuwrKRvosfZ19afiuBi+lqYEix2zmpTdwa
 hlWw==
X-Gm-Message-State: AOJu0YxsajBUPbNHZShF1fZ/KgH+fKqTp0Pkf6pDJV9b/GtO113Q7S5o
 WfxWyFV7Xmayx6RZ7w/8Xw1JUHAXyG5Mx+2D36cWIxOJH7aY5Q==
X-Google-Smtp-Source: AGHT+IFQgd0JW/yf0eld4SjSeOS1uiQcTzyChNwm7aBkJXw0NXehhAv7h5NcPqaJqhJo4VgITWMVC6PCcWVIlovC5j8=
X-Received: by 2002:a05:6402:17d5:b0:558:f625:b9d0 with SMTP id
 s21-20020a05640217d500b00558f625b9d0mr1565402edy.51.1705315065593; Mon, 15
 Jan 2024 02:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20240109124333.224240-1-shlomop@pliops.com>
 <CAFEAcA9WYrhuokJ_ox5CH0Et+WxiB_dwfHtsTZCb9cCfAveL9w@mail.gmail.com>
 <CAHzK-V2E8EQsh9V2tdqrEF651dPJchA9yLAzrFjFjun1tC8nKg@mail.gmail.com>
In-Reply-To: <CAHzK-V2E8EQsh9V2tdqrEF651dPJchA9yLAzrFjFjun1tC8nKg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 10:37:34 +0000
Message-ID: <CAFEAcA-fFRSf2ndOwANjByUCyp0Z_rqjdQgoSHFKumz2041c8g@mail.gmail.com>
Subject: Re: [PATCH V2] Handle wrap around in limit calculation
To: Shlomo Pongratz <shlomopongratz@gmail.com>
Cc: qemu-devel@nongnu.org, andrew.sminov@gmail.com, peter.maydell@linaro.com, 
 shlomop@pliops.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 15 Jan 2024 at 05:58, Shlomo Pongratz <shlomopongratz@gmail.com> wr=
ote:
>
> Thank you.
> Please see comments inline.
>
> On Fri, Jan 12, 2024 at 7:03=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Tue, 9 Jan 2024 at 12:45, Shlomo Pongratz <shlomopongratz@gmail.com>=
 wrote:
> >
> > Hi; thanks for this patch.
> >
> > > Hanlde wrap around caused by the fact that perior to version 460A
> >
> > Is this "460A" version number a version of the hardware
> > we're modelling ?
> >
> > > the limit was 32bit quantity.
> > > See Linux kernel code in:
> > > drivers/pci/controllers/dwc/pcie-designware.c
> >
> > "/controller/"
> >
> > > function: __dw_pcie_prog_outbound_atu
> >
> > There don't seem to be any comments in this kernel function
> > that say anything about wrap-around:
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/d=
wc/pcie-designware.c#L468
> >
> > so I'm not sure what you're trying to explain by referring to it.
> This is just to give some  context.
> If you look at the original submission of the controller patch d64e5eabc4=
c7e20c
> pci: Add support for Designware IP block by Andrey Smirnov it is written =
there
> "Add code needed to get a functional PCI subsytem when using in
>     conjunction with upstream Linux guest (4.13+)."
> >
> > > Now in a 64bit system the range can be above 4G but as long as
> > > the limit itself is less then 4G the overflow is avoided
> > >
> > > Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
> > >
> > > ----
> > >
> > > Changes since v1:
> > >  * Seperate subject and description
> > > ---
> > >  hw/pci-host/designware.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> > > index dd9e389c07..7ce4a6b64d 100644
> > > --- a/hw/pci-host/designware.c
> > > +++ b/hw/pci-host/designware.c
> > > @@ -269,11 +269,24 @@ static void designware_pcie_update_viewport(Des=
ignwarePCIERoot *root,
> > >  {
> > >      const uint64_t target =3D viewport->target;
> > >      const uint64_t base   =3D viewport->base;
> > > -    const uint64_t size   =3D (uint64_t)viewport->limit - base + 1;
> > >      const bool enabled    =3D viewport->cr[1] & DESIGNWARE_PCIE_ATU_=
ENABLE;
> > > +    uint64_t tbase, tlimit, size;
> > >
> > >      MemoryRegion *current, *other;
> > >
> > > +    /*
> > > +     * Hanlde wrap around caused by the fact that perior to version =
460A
> > > +     * the limit was 32bit quantity.
> > > +     * See Linux kernel code in:
> > > +     * drivers/pci/controllers/dwc/pcie-designware.c
> > > +     * function: __dw_pcie_prog_outbound_atu
> > > +     * Now in a 64bit system the range can be above 4G but as long a=
s
> > > +     * the limit itself is less then 4G the overflow is avoided
> > > +     */
> > > +    tbase =3D base & 0xffffffff;
> > > +    tlimit =3D 0x100000000 + (uint64_t)viewport->limit;
> > > +    size =3D ((tlimit - tbase) & 0xffffffff) + 1;
> > > +
> >
> > I find this patch a bit confusing, partly because the comment
> > seems to be written from the perspective of what the kernel
> > driver is doing, not from the perspective of the hardware
> > behaviour.
> >
> Again I refer to the original patch comment.
> The original patch was written to support Linux kernel 4.13+ and a
> specific implementation i.MX6 Applications Processor.
> I've looked at the i.MX6 reference manual and it was silent regarding
> the wrap-around case.
> There is no reference to the  relevant Synopsys' Designware's specificati=
on.
> Note that the pci version of the QEMU is 0, therefore I assume that
> the implementation was tailored
> to a specific implementation.
> > What is the behaviour of the actual hardware here, both before
> > and after 460A ? Which version are we trying to model?
> I don't have access to the pantora of Synopsys' Designware's root port.
> I can only conclude from the Linux kernel code that although the base
> address was always 64 bit quantity,
> then before version 460A that the limit quantity was 32 bit quantity
> and from version 460A it is 64 bit quantity.
> And the document that the original patch was based on didn't say what
> is the behavior in case of wrap around.
> I don't want to model any specific version, I just want to work with
> device tree definitions that has regions above 4G,
> which are possible since the base address is 64 bit quantity as long
> as the regions size are
> less teh 4G.

But we must model *something*, which is ideally "what the spec
says" or possibly "what some specific version is". In this
particular case, we need to be clear about whether we are
modelling the pre-460A behaviour or the 460A-and-onward
behaviour. "This change seems to be enough to make Linux
work" is generally not sufficient to justify it.

If all we have is the Linux driver code then the flow
has to be:
 * look at what the kernel does
 * deduce what we think the hardware implementation must
   be, based on that plus common sense about what is and
   isn't typical and easy for hardware to do
 * implement that, with comments about where we're making
   guesses

For instance, the kernel code suggests that pre-460A
there's a 32 bit limit register, and post-460A there
is a 64-bit limit (with an "UPPER_LIMIT" register to
access the top 32 bits), plus a PCIE_ATU_INCREASE_REGION_SIZE
flag bit. That suggests we might either:
 (1) implement all that
 (2) say we're implementing a pre-460A version with a
     32 bit limit field
Presumably we're aiming for (2) here, but I find the
arithmetic you have in this patch completely confusing:
it doesn't look like something hardware would be doing
when it has a 64 bit base address register and a 32 bit limit
address register. It's also weird as C code, because you
add 0x100000000 when calculating tlimit, but this will
have no effect because of the AND with 0xffffffff in
the following line.

My guess at what the hardware is doing is "the actual
limit address takes its low 32 bits from the limit address
register and the high 32 bits from the high 32 bits of
the base address".

thanks
-- PMM

