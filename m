Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5FB72C2B7
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:19:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8fYp-000124-JG; Mon, 12 Jun 2023 07:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q8fYm-00011k-Ux
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:18:09 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q8fYk-0003nE-TG
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:18:08 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30e56fc9fd2so4015391f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1686568684; x=1689160684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AgTI5deA364UUh8NaL8UyUcsEHOt0UcF8y5DcqDUL/c=;
 b=LPAbUTR6a9xIRCrMpc9mebL9KcxXMY3/EUhkebR9DY2/VWpp0hxGZgUZ2yngycylYP
 rrqy2p9f4T00xynWdp0saSs2o7eJFQOINzLmL0JxWNJHLs6229akI1caUixkGMCe9nRX
 VrHEE077HLO9WE7h9WIBHfeSm9EgvLxEbjw3AVwT5nNg1ieSsb8RR7gROtHhHfFt9phr
 6hD7aoxAV3aALlNOY57A4g0vDZ2/elpOS9Ko7BTEvIbEVlL3Wt8LN+2uz5YBHwka0eiB
 Xy9E4k492/JVS6eTA0sCXBWKtE0bm8iR3C8BoVmPV/bYLsXuYeux/n9RzY63NlpqvTlc
 LTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686568684; x=1689160684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AgTI5deA364UUh8NaL8UyUcsEHOt0UcF8y5DcqDUL/c=;
 b=W7t3VFgxmsjjWZc3m5nLKsGdpr0nL++5uFr5h+77TUajXT19Qj2+HT8BmDld6aaJ77
 TqMw0MBehpagrK6pO0sFWZJVtL1iBsh3inbnW8rpU9c9STvfc5xyASowzbiPJoMgo94M
 g6ZeFxN7xSMvuDlv6aL5jQ2iTIHAHbbsq6MLk++b1iN6cDSESfoZxc3lcz4KxC+r3ob3
 uPJBZJMleNEB+b/GeJx5a7aANW++Z+vLHPAKoBat3vqygG255wLb6WHlN5UbXp2R8jxx
 hc8I1KDvLGTDCxzwzwIv1w4R4G0CrsWUeGQYsl1HUzMOMyFkkCONtlcJuYN09YHtSBxf
 4SwA==
X-Gm-Message-State: AC+VfDzc2YmDtRYWhZPdwe4AASBaP5vUNhHI0wZzjF8xLYWq/vZXxSSn
 BArJCvI0Xr8r3LZsvorB14qNAlRYc1k+FvAWkummgwyu5djcjkv5
X-Google-Smtp-Source: ACHHUZ6Tnz9rF3qg2MW0BXr2yXB3L/U/G1TZ4R+aowUVvIqURqDtGNSHmjRfdLFpPYzNVEff9zFDrEY+HCyF6BPWuTk=
X-Received: by 2002:a5d:4743:0:b0:307:8879:6cc1 with SMTP id
 o3-20020a5d4743000000b0030788796cc1mr5037265wrs.71.1686568684690; Mon, 12 Jun
 2023 04:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
 <fe417dd1-c639-dc75-14bf-2679dde0911c@ventanamicro.com>
In-Reply-To: <fe417dd1-c639-dc75-14bf-2679dde0911c@ventanamicro.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Mon, 12 Jun 2023 13:17:50 +0200
Message-ID: <CAEg0e7g8b-8B0ObGwiWzipt4aUgypEcpGT5Ox-Ouu6pnWVw5ZA@mail.gmail.com>
Subject: Re: [PATCH 0/9] disas/riscv: Add vendor extension support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-wr1-x42b.google.com
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

On Tue, Jun 6, 2023 at 7:38=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> Can you please rebase on top of Alistair's riscv-to-apply.next and re-sen=
d?

Done.

Thanks,
Christoph

>
> Some patches can't be applied cleanly, in particular patch 2, which confl=
icts
> with Weiwei's "target/riscv: Split RISCVCPUConfig declarations from cpu.h
> into cpu_cfg.h" that landed into riscv-to-apply.next a few weeks ago. In
> this particular case patch 2 of this series would need to move just the
> bits of target/ppc/translate.c to the already existing cpu_cfg.h file.
>
>
> Put me in the CC when you re-send and I'll review it asap. Thanks,
>
>
> Daniel
>
> On 5/30/23 10:18, Christoph Muellner wrote:
> > From: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> >
> > This series adds vendor extension support to the QEMU disassembler
> > for RISC-V. The following vendor extensions are covered:
> > * XThead{Ba,Bb,Bs,Cmo,CondMov,FMemIdx,Fmv,Mac,MemIdx,MemPair,Sync}
> > * XVentanaCondOps
> >
> > So far, there have been two attempts to add vendor extension support
> > to the QEMU disassembler. The first one [1] was posted in August 2022
> > by LIU Zhiwei and attempts to separate vendor extension specifics
> > from standard extension code in combination with a patch that introduce=
d
> > support for XVentanaCondOps. The second one [2] was posted in March 202=
3
> > by me and added XThead* support without separating the vendor extension=
s
> > from the standard code.
> >
> > This patchset represents the third attempt to add vendor extension
> > support to the QEMU disassembler. It adds all features of the previous
> > attempts and integrates them into a patchset that uses the same
> > mechanism for testing the extension availability like translate.c
> > (using the booleans RISCVCPUConfig::ext_*).
> > To achieve that, a couple of patches were needed to restructure
> > the existing code.
> >
> > Note, that this patchset allows an instruction encoder function for eac=
h
> > vendor extension, but operand decoding and instruction printing remains
> > common code. This is irrelevant for XVentanaCondOps, but the patch for
> > the XThead* extensions includes changes in riscv.c and riscv.h.
> > This could be changed to force more separation with the cost of
> > duplication.
> >
> > The first patch of this series is cherry-picked from LIU Zhiwei's serie=
s.
> > It was reviewed by Alistair Francis and Richard Henderson, but never
> > made it on master. I've added "Reviewed-by" tags to the commit.
> >
> > I've added "Co-developed-by" tags to those commits that are derived
> > from the series of LIU Zhiwei.
> >
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2022-08/msg03662.h=
tml
> > [2] https://lists.nongnu.org/archive/html/qemu-devel/2023-03/msg04566.h=
tml
> >
> > Christoph M=C3=BCllner (8):
> >    target/riscv: Factor out RISCVCPUConfig from cpu.h
> >    disas/riscv: Move types/constants to new header file
> >    disas/riscv: Make rv_op_illegal a shared enum value
> >    disas/riscv: Encapsulate opcode_data into decode
> >    target/riscv/cpu: Share RISCVCPUConfig with disassembler
> >    disas/riscv: Provide infrastructure for vendor extensions
> >    disas/riscv: Add support for XVentanaCondOps
> >    disas/riscv: Add support for XThead* instructions
> >
> > LIU Zhiwei (1):
> >    target/riscv: Use xl instead of mxl for disassemble
> >
> >   disas/meson.build         |   6 +-
> >   disas/riscv-xthead.c      | 707 +++++++++++++++++++++++++++++++++++++=
+
> >   disas/riscv-xthead.h      |  28 ++
> >   disas/riscv-xventana.c    |  41 +++
> >   disas/riscv-xventana.h    |  18 +
> >   disas/riscv.c             | 384 ++++++---------------
> >   disas/riscv.h             | 297 ++++++++++++++++
> >   target/riscv/cpu-config.h | 159 +++++++++
> >   target/riscv/cpu.c        |   6 +-
> >   target/riscv/cpu.h        | 114 +-----
> >   target/riscv/translate.c  |  27 +-
> >   11 files changed, 1374 insertions(+), 413 deletions(-)
> >   create mode 100644 disas/riscv-xthead.c
> >   create mode 100644 disas/riscv-xthead.h
> >   create mode 100644 disas/riscv-xventana.c
> >   create mode 100644 disas/riscv-xventana.h
> >   create mode 100644 disas/riscv.h
> >   create mode 100644 target/riscv/cpu-config.h
> >

