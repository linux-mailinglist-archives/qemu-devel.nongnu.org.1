Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB02C7F7A88
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:43:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6aBV-0007nX-4n; Fri, 24 Nov 2023 12:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1r6aBS-0007k7-Ke
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:41:42 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1r6aBQ-0006Oy-Kr
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:41:42 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5c1714df2d8so1397304a12.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 09:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1700847698; x=1701452498; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0doE+xU3LQuc6URq/RcUDO+8m89F+MxaAiNXFDpzIfw=;
 b=QRHLvWDtGjqSPjD79gbjnzJtTykM/EcaKYUX9uKul8yTRLieBq4kXrdaOVJQL3uc6r
 O4a8ZDpvl4iglP4uHbyXzLEWir0Grgt/MYP8SfS/UuVTYL2SWDkmZ3dd7sCROwNMOK7D
 sDl4u/L+u/a1+9gaB2CWghkrwrjARCOzRE7l3oRNWU4tO81uQmPVTeUUiTfsV/j8s+ko
 kcN0iMJ/RuLZo4PjI7TKuUGylzRrmXsAV3lGITGO6prQMBAZE7FcXNvhx//LIsph9XrX
 Aa8p4nEp/ZSGh9vFiEbv38MOGZe51IZ47u4irOjV9zYZCzOgmwA7UZWXcUFh9ULwJIDG
 uV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700847698; x=1701452498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0doE+xU3LQuc6URq/RcUDO+8m89F+MxaAiNXFDpzIfw=;
 b=ssJIvaBYrCb31OawSk4l69Y/IPL5G3bWHPss+FJr8WhxOX84X63MJhoWoDkSw4am4o
 yB25NOkP4VOkdBSZXevJtBXsmCdbTjJ7pAEsIRsUmr8LClythj3IAtoF606JZE7TMiBk
 3HdiAZ1cL1xscShdzqkVihaXX7pMulFBuETrMCJ/65SXdf4sYBBKjGZa1WY6GFJ6P16M
 VZcPwXsM9BcHrNd3cnl0xGCFYnPslF9xC2bOO1vzGcxMn+e9WAUlB9CJtb6r6VKgVzJj
 7BTwmFasFQIUQ62fm3WwdEHWkTFNgM7LoYcsSjLJnfRxDLCBxS7ccocBZFB0sZw7TNnE
 ZVvA==
X-Gm-Message-State: AOJu0Yy7j+ORhsZvBQo4ascrHBPw6i2H7Od0asgiUuZgLDOYrTlYHmns
 FzWo9UCcXIO1ML82EsiEC5V4KKgaq5rvrro296YAMg==
X-Google-Smtp-Source: AGHT+IFroIa6m9vEOR6kCl8od4IepRuFGkhTwMXnjCrPAW5qYu8BHhkuhKHT7TY8RYlYZaITRIJXUOQ0xgR4OG+r6m0=
X-Received: by 2002:a17:90b:1c86:b0:280:cd7b:1fa5 with SMTP id
 oo6-20020a17090b1c8600b00280cd7b1fa5mr3788293pjb.4.1700847698386; Fri, 24 Nov
 2023 09:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20231123181300.2140622-1-christoph.muellner@vrull.eu>
 <20231124-b892dc7ca5a5f9ff4cceda6e@orel>
In-Reply-To: <20231124-b892dc7ca5a5f9ff4cceda6e@orel>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Fri, 24 Nov 2023 18:41:25 +0100
Message-ID: <CAEg0e7hy2Z+X7TR8iaQckCHZ2NGyPJV8dioco-FB2aPErMpnOQ@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user/riscv: Add Zicboz extensions to hwprobe
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Nov 24, 2023 at 5:59=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Nov 23, 2023 at 07:12:59PM +0100, Christoph Muellner wrote:
> > From: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> >
> > Upstream Linux recently added RISC-V Zicboz support to the hwprobe API.
> > This patch introduces this for QEMU's user space emulator.
> >
> > Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> > ---
> >  linux-user/syscall.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 65ac3ac796..2f9a1c5279 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -8799,6 +8799,7 @@ static int do_getdents64(abi_long dirfd, abi_long=
 arg2, abi_long count)
> >  #define     RISCV_HWPROBE_EXT_ZBA      (1 << 3)
> >  #define     RISCV_HWPROBE_EXT_ZBB      (1 << 4)
> >  #define     RISCV_HWPROBE_EXT_ZBS      (1 << 5)
> > +#define     RISCV_HWPROBE_EXT_ZICBOZ   (1 << 6)
> >
> >  #define RISCV_HWPROBE_KEY_CPUPERF_0     5
> >  #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
> > @@ -8855,6 +8856,8 @@ static void risc_hwprobe_fill_pairs(CPURISCVState=
 *env,
> >                       RISCV_HWPROBE_EXT_ZBB : 0;
> >              value |=3D cfg->ext_zbs ?
> >                       RISCV_HWPROBE_EXT_ZBS : 0;
> > +            value |=3D cfg->ext_zicboz ?
> > +                     RISCV_HWPROBE_EXT_ZICBOZ : 0;
> >              __put_user(value, &pair->value);
> >              break;
> >          case RISCV_HWPROBE_KEY_CPUPERF_0:
> > --
> > 2.41.0
> >
> >
>
> We should also add support for getting the block size with
> RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE.

Hi Andrew, this is already upstream, just the EXT_ZICBOZ is missing:

commit 301c65f49f9602f39b9f3ce0ad9ff70d4bda7226
Author: Palmer Dabbelt <palmer@rivosinc.com>
Date:   Fri Nov 10 09:37:16 2023 -0800

    linux-user/riscv: Add Zicboz block size to hwprobe

    Support for probing the Zicboz block size landed in Linux 6.6, which wa=
s
    released a few weeks ago.  This provides the user-configured block size
    when Zicboz is enabled.

>
> Thanks,
> drew

