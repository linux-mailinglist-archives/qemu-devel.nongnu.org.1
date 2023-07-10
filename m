Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DC274C940
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 02:27:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIeil-0002S3-5k; Sun, 09 Jul 2023 20:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qIeig-0002R1-Tl; Sun, 09 Jul 2023 20:25:39 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qIeie-0000mR-LG; Sun, 09 Jul 2023 20:25:38 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-400a39d4ffcso17598301cf.0; 
 Sun, 09 Jul 2023 17:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1688948734; x=1691540734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gpxPJ+4MDhO+EraeAsgmB5eHeMoIj8ka0fXr5czMZZI=;
 b=ZYZLYgtMHeuISKn9XX0ckB+sqHreghffDTw2vO61ltccpoCHYUst4lvQVPO3ENn7vz
 TCcY/EnYGaT05rcAv9sFebgDalB3LeeJAMuJRtR42BlFn2DfwNFNkP2/rCk1tT71NPf3
 4GG2P7Tex18Kc78y5leSIoT9Mfo/4YGXYSFOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688948734; x=1691540734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gpxPJ+4MDhO+EraeAsgmB5eHeMoIj8ka0fXr5czMZZI=;
 b=LBqtevARsiI9I2TFvDe5vympB14BUQwnKzfTzqSRKTpKlH3uWK+CrU9u/XIcUE3vdO
 ZbK2UzCUJALwnfcr8FQCM+YSexj2shyzCtnAE/nHMN3Ox04ftkSWhc3t5jYk3smrRLgY
 ppWepdHFi7yqjHdQh55wUAZUlAVfxKyQ+OcmX47xXSH1tkFd5f69lmHO8Pmkq9pRl5wL
 oksDA3Z0SgGMoK9yg/2EyKuambavdUxLSEZaoh/q/wpVi/Or8e6kTthGomJPq86/e+c0
 Uij4KaPWlrrhUYiThCyIQVTngL1fpgXvgCI53/4NWIx0OU0c2avD7Iewn5Q+ds2w5+Gj
 HbKw==
X-Gm-Message-State: ABy/qLaYVKTWwa7s1+7zOjk4+ACfH8h8eWJ2f2TIjEOAdPsUEODpIYhw
 Bk2oGadjv9W+U8pKbBArHLXPZq/fBhzaPMRGfA0=
X-Google-Smtp-Source: APBJJlEzcKIH519TLbOjMiUICqINGk6Tb60NnYchjAPOd1DuvJlZmR7/0z2EXDyReKziJb5EHKUshanL2ENuJrgG0B4=
X-Received: by 2002:a05:622a:1a1e:b0:403:9d01:dd42 with SMTP id
 f30-20020a05622a1a1e00b004039d01dd42mr8586623qtb.6.1688948734356; Sun, 09 Jul
 2023 17:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230707071213.9924-1-joel@jms.id.au>
 <CTWE73ZF1T37.IQUBV31TU3LF@wheely>
In-Reply-To: <CTWE73ZF1T37.IQUBV31TU3LF@wheely>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 10 Jul 2023 00:25:21 +0000
Message-ID: <CACPK8Xd_qdxy1Z28X70fcDE9xOtBORuqRD23d6VmAOuAKy=_LQ@mail.gmail.com>
Subject: Re: [PATCH v2] ppc/pnv: Add QME region for P10
To: Nicholas Piggin <npiggin@gmail.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=joel.stan@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sat, 8 Jul 2023 at 01:17, Nicholas Piggin <npiggin@gmail.com> wrote:

> > --- a/include/hw/ppc/pnv_xscom.h
> > +++ b/include/hw/ppc/pnv_xscom.h
> > @@ -127,6 +127,17 @@ struct PnvXScomInterfaceClass {
> >  #define PNV10_XSCOM_EC(proc)                    \
> >      ((0x2 << 16) | ((1 << (3 - (proc))) << 12))
> >
> > +#define PNV10_XSCOM_QME(chiplet) \
> > +        (PNV10_XSCOM_EQ(chiplet) | (0xE << 16))
> > +
> > +/*
> > + * Make the region larger by 0x1000 (instead of starting at an offset) so the
> > + * modelled addresses start from 0
> > + */
> > +#define PNV10_XSCOM_QME_BASE(core)     \
> > +    ((uint64_t) PNV10_XSCOM_QME(PNV10_XSCOM_EQ_CHIPLET(core)))
> > +#define PNV10_XSCOM_QME_SIZE        (0x8000 + 0x1000)
>
> I couldn't work out this comment.

I was trying to describe why we have the + 0x1000.

Each core sets a bit in the xscom address space, with the first core
setting bit 12, second bit 13, etc. So there's actually no registers
at PNV10_XSCOM_QME_BASE, but so the addressing is easier to follow, I
chose to start the base where we do, and make the region 0x1000
bigger.

That was my understanding at least.

Cheers,

Joel

>
> Thanks,
> Nick

