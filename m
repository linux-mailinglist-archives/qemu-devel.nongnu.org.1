Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE60972BD01
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8e9Y-0003K6-Ms; Mon, 12 Jun 2023 05:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q8e9W-0003Jk-6W
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:47:58 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q8e9U-00045H-Cf
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:47:57 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30e3caa6aa7so4058530f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 02:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1686563274; x=1689155274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68yK9YpbPZeRYh+gEbj6bSXzJfW5T3mG0JEA9KzTtjk=;
 b=SLcG8WeJSJSTLUY4gllal6//l3P2C25ZFsviioTSK6h6ePhDPkBnRnGtUzSOeE+yeY
 30job2f+CDRom50bjyP6hBgA8TojvlRoQtHMS55X9hcVEGwo43ggMvxZUX2DnaGSRgOC
 j4Hf+0Kg++96QrViu1PhDtk9anEqAKbnYsgyO/PlDJihx2bKO2//YRDYCzUNQC7bslMV
 hJKtARZkAqndX5a2JRBs44FrXW5hwkOLd5CX1QTEnBb1vMaxsWN4xco/rOnEzg6dL08o
 N24Ci0gRykd7S7OL44OjXPg4GxInCavrj0TLyKOX5baioBKj1QtBMLjpZJ8T9LCg3DDh
 U3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686563274; x=1689155274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=68yK9YpbPZeRYh+gEbj6bSXzJfW5T3mG0JEA9KzTtjk=;
 b=bZdvaqjL/jjG9hr9xF6PbKIgD0CtdVSdxlJaeePxYBt/QrwnE1gxQKzo52WuS+7BTF
 wxWbyZrXnP9JauVzL/B//LZwoArDLAyUWustvzHsH6Yosm5hEsqHJmi99iXi29X8RW4Z
 tvRPGY9AW+WHK+QPNDXqxnA3PsZ28A7kfPeIC+jvSKFFFj4pTTwkaadPjTKB96a04qbC
 hFSppXU6nDEWTsxrsEF9u7ye8obeB0gRteXg00N6/6azi6fZpUxp2nc3wWu6bHgN+mg1
 sqHJ/w8XSCROSz8HHatEGB2hDC7wPX+rKYKA/AWfE+Owguf6po5XnFzZNM3tpZB05otC
 OzNw==
X-Gm-Message-State: AC+VfDzNB4foPDXyz+WZpW+BLJiWUf72yxyUPNH+F8Uuyh4dvelTbD6t
 ZPanGNq5IUA3+hnCjjtB8m8RkQt7E0yt4PxX+4sj/g==
X-Google-Smtp-Source: ACHHUZ4n40Jma1128giyjFo+iFxhU3OFDXalpUNeGboUMgJzFRAmpSGE/DL+wLxMHUjhuU9lP9BGo2DchiOD6fJ34Mc=
X-Received: by 2002:a5d:6148:0:b0:30f:b948:6f8f with SMTP id
 y8-20020a5d6148000000b0030fb9486f8fmr2759287wrt.70.1686563273971; Mon, 12 Jun
 2023 02:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
 <20230530131843.1186637-7-christoph.muellner@vrull.eu>
 <29c57d6a-247c-ef4c-da4c-f3021bb0ea54@gmail.com>
In-Reply-To: <29c57d6a-247c-ef4c-da4c-f3021bb0ea54@gmail.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Mon, 12 Jun 2023 11:47:40 +0200
Message-ID: <CAEg0e7iShmcrvqXJkfy+wv+v4e2y=S4go52aTs8cZ_+Lb6rvwg@mail.gmail.com>
Subject: Re: [PATCH 6/9] target/riscv/cpu: Share RISCVCPUConfig with
 disassembler
To: LIU Zhiwei <baxiantai@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>, 
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-wr1-x433.google.com
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

On Mon, Jun 12, 2023 at 8:25=E2=80=AFAM LIU Zhiwei <baxiantai@gmail.com> wr=
ote:
>
>
> On 2023/5/30 21:18, Christoph Muellner wrote:
> > From: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> >
> > The disassembler needs the available extensions in order
> > to properly decode instructions in case of overlapping
> > encodings (e.g. for vendor extensions).
> >
> > Let's use the field 'disassemble_info::private_data' to store
> > our RISCVCPUConfig pointer.
> >
> > Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> > ---
> >   target/riscv/cpu.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 5b7818dbd1..6f0cd9a0bb 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -819,6 +819,9 @@ static void riscv_cpu_disas_set_info(CPUState *s, d=
isassemble_info *info)
> >   {
> >       RISCVCPU *cpu =3D RISCV_CPU(s);
> >       CPURISCVState *env =3D &cpu->env;
> > +    RISCVCPUConfig *cfg =3D &cpu->cfg;
> > +
> > +    info->private_data =3D cfg;
>
> I don't know if this field will be overridden by the binutils. Can we
> extend the struct disassemble_info, and add some fields like supporting
> for Capstone?


Initially I wanted to add a new field, but then I noticed that the field
'disassemble_info::private_data' is used for a similar purpose by
disas/cris.c, disas/m68k.c, and dias/xtensa.c.
So I decided to not add yet another field, which only serves one architectu=
re.

But if that's the preferred way, then I can change.

Thanks
Christoph

>
> Zhiwei
>
> >
> >       switch (env->xl) {
> >       case MXL_RV32:

