Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1BE7D7E1F
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:11:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvvSU-0003u4-NV; Thu, 26 Oct 2023 04:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qvvSS-0003tK-4b
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:11:12 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qvvSP-0001Mv-6I
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:11:11 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5b92b852390so321874a12.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 01:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1698307865; x=1698912665; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9heys8O+7UDmNmpHMMq9AV55J0+mtTtsaokCB2U9UKk=;
 b=WLatK6x9JO2hMzdqUImJxzrX8RbK+cHLbZHvS/PHSjK32Os9UsdUIdKhVfFPWMH//x
 epF1/3BhpGcDuQ2t95kVar1KMLLoFTsDBOVmEG/m6XNdGdeHYcAgljY65ctu3yliO8Jy
 hlxZhxfMib2RSNaMuPvOAE+zCe/bTqkYdmU+4raN4jsIzm0CxGyl6NBnUEM11coLy2V8
 xEJSs4q22iKhRTtilTkCTMkJETkHey/N8lQdhljG45tGZU3dJOw9UAZ2cUN8rGYwL+7L
 Ag1+PTZQ8yQSWSjEufcTq16rFV2teXh1/fD0OIhzfyEqOJ8ee8io325Mz+XS3ijRWGaW
 CZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698307865; x=1698912665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9heys8O+7UDmNmpHMMq9AV55J0+mtTtsaokCB2U9UKk=;
 b=RofqPoMQh2lhy8s+3CUtX+TRDmcLm6ik+K7ubfSL52bidUV5SXbu7oSkLtbaMt30Mn
 Ib8ubvMV5OkA6IWrlggQrZMTinOefqpow3rcCUHZBFzBNSYuharF9AzxfQTdvOQDfaWg
 kIgNinV+cwhF71JoPMX4Crf3jRNr2eFxiWqifTs5N4nrTBVmu6fX3PEvx6FlC3IAo77C
 QXAuKPtdg89A+i2j/eQDAQhnBuFO4XjUj3nYuvY8DlpkyYScWJLOns5MpJEi4Pgt4oH/
 vfYbvFMGjuht9NXMmRlxHyTKUBVfZ6Atxd6fGWEwIT/orrtXDGYRH2ov+Zkl/0yZg/g0
 07eg==
X-Gm-Message-State: AOJu0Ywi4AXApPIcZ8O7iJCihGnMpoqvAIgVeIW6cc/t4a4/KdKKPJhZ
 XdzQsVTueFiull3mJG3CmsOMzGsjFJQSAmooA/U2dw==
X-Google-Smtp-Source: AGHT+IFKWQ51SyRmyjOXKQn5hln57qewK+7wNGiCp0eiCbhNN4YDIzyqmsgFksuJ6sZnFsqQHeqOk/FQ+vmOtK/sMQY=
X-Received: by 2002:a17:90a:f30d:b0:27d:427f:1bf4 with SMTP id
 ca13-20020a17090af30d00b0027d427f1bf4mr16144525pjb.19.1698307865392; Thu, 26
 Oct 2023 01:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230914174436.1597356-1-richard.henderson@linaro.org>
 <20230914174436.1597356-7-richard.henderson@linaro.org>
 <CAJ307EjR0oKs6W=7ZgsqeM1XrHbTYF4sXN2vV9jn1eiRsMewVA@mail.gmail.com>
 <79b3bf7e-71dc-4ac2-bbb0-eb27e6c70ae5@linaro.org>
In-Reply-To: <79b3bf7e-71dc-4ac2-bbb0-eb27e6c70ae5@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Thu, 26 Oct 2023 10:10:54 +0200
Message-ID: <CAJ307EhjPxBjX0dGGefA7Q0pBRrU7P_OwBK8YvYjsts-YC=UfQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] accel/tcg: Always require can_do_io
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=chigot@adacore.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Oct 26, 2023 at 2:44=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/24/23 02:50, Cl=C3=A9ment Chigot wrote:
> > Hi Richard,
> >
> > This commit has broken some of our internal bareboard testing on
> > Risc-V 64. At some point in our programs, there is an AMOSWAP (=3D
> > atomic swap) instruction on I/O. But since this commit, can_do_io is
> > set to false triggering an infinite loop.
> > IIUC the doc (cf [1]), atomic operations on I/O are allowed.
> >
> > I think there is a CF_LAST_IO flag missing somewhere to allow it, but
> > I'm not sure where this should be. Do you have any ideas ?
> >
> > Sadly I cannot provide a reproducer that easily, mainly because our
> > microchip has a few patches not yet merged making our binaries not
> > running on the upstream master.
> > But here is a bit of the in_asm backtrace:
> >
> >    | IN: system__bb__riscv_plic__initialize
> >    | Priv: 3; Virt: 0
> >    | 0x80000eb4:  1141              addi                    sp,sp,-16
> >    | 0x80000eb6:  0c0027b7          lui                     a5,49154
> >    | 0x80000eba:  e406              sd                      ra,8(sp)
> >    | 0x80000ebc:  00010597          auipc                   a1,16
> >              # 0x80010ebc
> >    | 0x80000ec0:  47458593          addi                    a1,a1,1140
> >    | 0x80000ec4:  f3ffe637          lui                     a2,-49154
> >    | 0x80000ec8:  01878693          addi                    a3,a5,24
> >    | 0x80000ecc:  00f58733          add                     a4,a1,a5
> >    | 0x80000ed0:  9732              add                     a4,a4,a2
> >    | 0x80000ed2:  4318              lw                      a4,0(a4)
> >    | 0x80000ed4:  2701              sext.w                  a4,a4
> >    | 0x80000ed6:  08e7a02f          amoswap.w               zero,a4,(a5=
)
> >    | 0x80000eda:  0791              addi                    a5,a5,4
> >    | 0x80000edc:  fed798e3          bne                     a5,a3,-16
> >              # 0x80000ecc
> >    |
> >    | ----------------
> >    | IN: system__bb__riscv_plic__initialize
> >    | Priv: 3; Virt: 0
> >    | 0x80000ed6:  08e7a02f          amoswap.w               zero,a4,(a5=
)
> >    |
> >    | ----------------
> >    | IN: system__bb__riscv_plic__initialize
> >    | Priv: 3; Virt: 0
> >    | 0x80000ed6:  08e7a02f          amoswap.w               zero,a4,(a5=
)
> >    | * Freeze *
>
> I would expect two translations:
>
> (1) with the original TB, aborts execution on !can_do_io.
> (2) with the second TB, we get further into the actual execution and abor=
t execution on
> TLB_MMIO.
> (3) with the third TB, we clear CF_PARALLEL and execute under cpu_exec_st=
ep_atomic.
>
> Both 2 and 3 should have had CF_LAST_IO set.
> You can verify this with '-d exec' output.
>
> As a trivial example from qemu-system-alpha bios startup:
>
> > Trace 0: 0x7f2584008380 [00000000/fffffc0000003ee4/01000000/ff000000] u=
art_init_line
> > cpu_io_recompile: rewound execution of TB to fffffc0000003ee4
> > ----------------
> > IN: uart_init_line
> > 0xfffffc0000003f20:  stb        t8,0(t6)
> >
> > Trace 0: 0x7f2584008a00 [00000000/fffffc0000003f20/01000000/ff018001] u=
art_init_line
>
> Note that the final "/" field is cflags.  The first "Trace" corresponds t=
o (1), where the
> store is in the middle of the TB.  You can see the io_recompile abort, th=
en the second
> "Trace" contains {CF_COUNT=3D1, CF_LAST_IO, CF_MEMI_ONLY}.

With the exec, it's indeed a bit clearer.
I do have a new translation made by cpu_io_recompile which sets
CF_LAST_IO (2). But afterward, it somehow loops back to the previous
translation which doesn't have CF_LAST_IO which calls cpu_io_recompile
again, etc. This triggers an infinite loop between these two
translations
  | ----------------
  | IN: system__bb__riscv_plic__initialize
  | 0x80000eb4:  1141              addi                    sp,sp,-16
  | ...
  | 0x80000ed4:  2701              sext.w                  a4,a4
  | 0x80000ed6:  08e7a02f          amoswap.w               zero,a4,(a5)
  | 0x80000eda:  0791              addi                    a5,a5,4
  | 0x80000edc:  fed798e3          bne                     a5,a3,-16
            # 0x80000ecc
  |
  | Linking TBs 0x7f0d3199db40 index 0 -> 0x7f0d3199dd00
  | Trace 1: 0x7f0d3199dd00
[00000000/0000000080000eb4/0b02401b/ff280000]
system__bb__riscv_plic__initialize

(1) First exec of amoswap without CF_LAST_IO.
  | ----------------
  | IN: system__bb__riscv_plic__initialize
  | Priv: 3; Virt: 0
  | 0x80000ed6:  08e7a02f          amoswap.w               zero,a4,(a5)
  |
  | Trace 1: 0x7f0d3199df80
[00000000/0000000080000ed6/0b02401b/ff200601]
system__bb__riscv_plic__initialize

(2) Second exec with CF_LAST_IO.
  | cpu_io_recompile: rewound execution of TB to 0000000080000ed6
  | ----------------
  | IN: system__bb__riscv_plic__initialize
  | Priv: 3; Virt: 0
  | 0x80000ed6:  08e7a02f          amoswap.w               zero,a4,(a5)
  |
  | Trace 1: 0x7f0d3199e140
[00000000/0000000080000ed6/0b02401b/ff298001]
system__bb__riscv_plic__initialize

Loop back (1) and start the infinite loop between (1) and (2).
  | Trace 1: 0x7f0d3199df80
[00000000/0000000080000ed6/0b02401b/ff200601]
system__bb__riscv_plic__initialize
  | cpu_io_recompile: rewound execution of TB to 0000000080000ed6
  | Trace 1: 0x7f0d3199e140
[00000000/0000000080000ed6/0b02401b/ff298001]
system__bb__riscv_plic__initialize
  | Trace 1: 0x7f0d3199df80
[00000000/0000000080000ed6/0b02401b/ff200601]
system__bb__riscv_plic__initialize
  | cpu_io_recompile: rewound execution of TB to 0000000080000ed6

I'll continue to investigate. Even if the workaround you provided
works, there is something weird happening here.

> In the short term, try adding CF_LAST_IO to cflags in cpu_exec_step_atomi=
c.
Thanks for that workaround.

Thanks,
Cl=C3=A9ment

> I think probably the logic of CF_LAST_IO should always be applied now, si=
nce can_do_io is
> always live, and thus the flag itself should go away.
>
>
> r~

