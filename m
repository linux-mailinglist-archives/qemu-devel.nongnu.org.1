Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7CF743B2D
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 13:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFCg7-0008CS-I2; Fri, 30 Jun 2023 07:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qFCg2-0008BN-D5
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:52:40 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qFCg0-0005Lp-NB
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:52:38 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b69e6d324aso28640941fa.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 04:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1688125952; x=1690717952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENpZ15T1KQzq6FVhBNrSJPeAGv1Owh5QSPOQTnIyhiE=;
 b=j/fi+M3YfdiNAdMs081mAkgRxxI6XsSucvglZycHmVbeoSSB5cTGe0NJeRtWcVFr1t
 fPA64Stbe2z2E0Q+Yi3iNyL/C4udOy8OcFSrr5UYilaEy/gknumfLO9pUzE67i8IAay/
 wB7lE/L5D2yTcF3RmraG0yxy2z9rf9ZvCg/qngWpb/Nceo+N0d8Ttih+clp/LMLJyZu7
 Ul5xUFBd/IrRY6nTuwTLAUUCClV7Q+sHZx1QM73EhP21GipOCOHEGEXbxmYkex0Xr3IT
 drhLoI5evMPp7+Uz3f46FNi8CAWUAPa7dJU1DS4PWQaVeKKeI9DQZ3Vfeoty0NYLYXZQ
 EiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688125952; x=1690717952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ENpZ15T1KQzq6FVhBNrSJPeAGv1Owh5QSPOQTnIyhiE=;
 b=Kw4BK/sgTiQfww1/itpAh9Kn6WzmOE6aDESNrRj1kODS20m4OPawh5JsBOCbR+J6xm
 UUdJNW/5WADVwTMM5QxxPtlk1+/H3uUGkPfStoaV//uN7Q0Xt1KzEeMLtpNdOghQQJMw
 r/GnsseXM/soxxUMxUjqrDWuOqOLPHdtrCJRXZbFR16kp3hrQCnsOCOGYyj4iqtl0dD1
 JDBuB4uSjZKXSo87bWC0iGFONIEJ9PHDNvES2qt55710sHM/RZx6L85CHsA9tDaO5ThQ
 +zLPj56X3UF78+r+froiNoOuDw6T+4nKiQwhhUnBmxkIz3dvJYsSZ9EkgoQM0EoXdDTs
 JZ7Q==
X-Gm-Message-State: ABy/qLYniMMuldbhnQ+MAF51B/AnA/Mkgbuf8inzCfCqxeHH1dwYBUNE
 nkU3GU09BinpUOMcqcg2EwCHr1l7ukW/vWQTuDrrFw==
X-Google-Smtp-Source: APBJJlEzMpKlT5fOQb//99bnOPSFq3efcusLVkBfz09OmQZUf9lHiWSg8CIIH6JLL6udT3xupRhXZKG/cCTegmLoVe8=
X-Received: by 2002:a05:6512:3e22:b0:4fb:8435:3efc with SMTP id
 i34-20020a0565123e2200b004fb84353efcmr2452232lfv.16.1688125951817; Fri, 30
 Jun 2023 04:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230630091303.1676486-1-christoph.muellner@vrull.eu>
 <20230630091303.1676486-4-christoph.muellner@vrull.eu>
 <69901e50-52e8-f937-a848-53b8042c2eeb@linaro.org>
In-Reply-To: <69901e50-52e8-f937-a848-53b8042c2eeb@linaro.org>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Fri, 30 Jun 2023 13:52:17 +0200
Message-ID: <CAEg0e7j_e24XK==6nmA4+YjX4qAR8k57wQzCxpUh_x5tCCXjWw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] DO NOT MERGE: tests/tcg/riscv64: Add test for
 fcvtmod.w.d
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Jeff Law <jeffreyalaw@gmail.com>, Tsukasa OI <research_trasio@irq.a4lg.com>, 
 liweiwei@iscas.ac.cn, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Rob Bradford <rbradford@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-lj1-x22c.google.com
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

On Fri, Jun 30, 2023 at 11:46=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/30/23 11:13, Christoph Muellner wrote:
> > From: Christoph M=C3=BCllner<christoph.muellner@vrull.eu>
> >
> > This patch introduces a test for Zfa's fcvtmod.w.d instruction.
> > The test cases test for correct results and flag behaviour.
> > Note, that the Zfa specification requires fcvtmod's flag behaviour
> > to be identical to a fcvt with the same operands (which is also
> > tested).
> >
> > DO NOT MERGE!!!
> > Although this test works just fine, it requires a toolchain
> > that supports the Zfa extension. Unless this is available
> > this patch cannot be merged.
> > DO NOT MERGE!!!
>
> That's what
>
>    /* fcvtmod.w.d rd, rs1, rtz =3D 1100001 01000 rs1 001 rd 1010011 */
>    asm(".insn r, 0x53, 0x1, 0x61, %0, %1, f8" : "=3Dr"(ret) : "f"(fpr));
>
> is for.
>
> > +    __asm__ __volatile__("fmv.d.x %0, %1" : "=3Dfp"(fpr) : "r"(inp));
>
> Always "f" not "fp".  "fp" is *two* constraints, "f" and "p", and the sec=
ond is incorrect.

Fixed, tested and merged into the other patch.

Thanks!

>
>
> r~

