Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FBE74FD08
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 04:24:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJPV7-0005bu-O5; Tue, 11 Jul 2023 22:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qJPU3-0005Na-5Y; Tue, 11 Jul 2023 22:21:40 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qJPTl-0002tJ-PW; Tue, 11 Jul 2023 22:21:37 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b8ad907ba4so33265405ad.0; 
 Tue, 11 Jul 2023 19:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689128479; x=1691720479;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZ6sMFT4SV39lw3tLW+ciyXeP0LWgHxhcP6X9eKggF0=;
 b=CrOSs50L2nZBJeazNMBd/8Em5uxFDK/SnrZnLd4kHO+3Ylp5T0hRnLztTdsmlji2zG
 nLjgq2DXk9RKilEiF6T22RscrzQQcaoPsN+hzFJ5AlQZrIDKJN1e5NwucoELq0Vcxw8f
 eIZldUjyhRL+4zmeZpnU2cyaDOC1R5mVB9Vr6jN035+JGFivjkwd1KdDXNqL/6yc8W65
 +XayfctpKrqDChf0k98Bg4zyiXwCYj+k8yq7dBJb0N7IC8jeed+Ggfu2YwPoJMEI8F8W
 tX3cJM7eatxXndbmJYiM9e76eoGiuQB4i3QHQp3JaXhUNH19mNp6EhUtxqvGPHGjuTEl
 CgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689128479; x=1691720479;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oZ6sMFT4SV39lw3tLW+ciyXeP0LWgHxhcP6X9eKggF0=;
 b=cjDOpRcQtHEcyqk4v+OP11G89PJtg/xBECbiWE40jne6bQhnqT+P96YuqO2wABPPIw
 uCdumcJWLkBNGA2VEVSsoryKft7iK8bPQWwd4fnlEUPYof55hKCpLP8OjrPAJfrykt8l
 up5nEbm7uq8IAioI15EJZQmpO+/BxUVa30pVyqI7K3c/kEPQlfHqtPyAyr9qlOP4hKi5
 4+9x4V8/xmW+764sIIRqvMqlkcexPYHX3DZty/vl0FbPxoFBAgjU4mXCti9L/zAB2Wuz
 O74nd9HTQhcaT9uZmf8bH3RkqJ1oKy3fhzv+u4tXRwW9fMyD7WgqKhmAY3CmFZbigCoQ
 cqXg==
X-Gm-Message-State: ABy/qLagfkDJfaw0t15hiDTK68+7sDvkKLN434cfRSW7FgekPpchWuth
 wrQMB/JmQdajwkUV/f3HiRbxeEjaMiE=
X-Google-Smtp-Source: APBJJlGzOA2gmm4/zqwxunPhz5bWm9dXO+5RDbcE6Wyb9OtOW/mAQiDg29mgdgg3PaCVQx48fZAtDA==
X-Received: by 2002:a17:902:a38b:b0:1b9:e913:b585 with SMTP id
 x11-20020a170902a38b00b001b9e913b585mr3499944pla.13.1689128478842; 
 Tue, 11 Jul 2023 19:21:18 -0700 (PDT)
Received: from localhost (193-116-64-199.tpgi.com.au. [193.116.64.199])
 by smtp.gmail.com with ESMTPSA id
 ji2-20020a170903324200b001b89536974bsm2632407plb.202.2023.07.11.19.21.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 19:21:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Jul 2023 12:21:13 +1000
Message-Id: <CTZU2K7ZUGT5.1OWRLPBN4PE1O@wheely>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] ppc/pnv: Add QME region for P10
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Joel Stanley" <joel@jms.id.au>
X-Mailer: aerc 0.15.2
References: <20230707071213.9924-1-joel@jms.id.au>
 <CTWE73ZF1T37.IQUBV31TU3LF@wheely>
 <CACPK8Xd_qdxy1Z28X70fcDE9xOtBORuqRD23d6VmAOuAKy=_LQ@mail.gmail.com>
In-Reply-To: <CACPK8Xd_qdxy1Z28X70fcDE9xOtBORuqRD23d6VmAOuAKy=_LQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

On Mon Jul 10, 2023 at 10:25 AM AEST, Joel Stanley wrote:
> On Sat, 8 Jul 2023 at 01:17, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> > > --- a/include/hw/ppc/pnv_xscom.h
> > > +++ b/include/hw/ppc/pnv_xscom.h
> > > @@ -127,6 +127,17 @@ struct PnvXScomInterfaceClass {
> > >  #define PNV10_XSCOM_EC(proc)                    \
> > >      ((0x2 << 16) | ((1 << (3 - (proc))) << 12))
> > >
> > > +#define PNV10_XSCOM_QME(chiplet) \
> > > +        (PNV10_XSCOM_EQ(chiplet) | (0xE << 16))
> > > +
> > > +/*
> > > + * Make the region larger by 0x1000 (instead of starting at an offse=
t) so the
> > > + * modelled addresses start from 0
> > > + */
> > > +#define PNV10_XSCOM_QME_BASE(core)     \
> > > +    ((uint64_t) PNV10_XSCOM_QME(PNV10_XSCOM_EQ_CHIPLET(core)))
> > > +#define PNV10_XSCOM_QME_SIZE        (0x8000 + 0x1000)
> >
> > I couldn't work out this comment.
>
> I was trying to describe why we have the + 0x1000.
>
> Each core sets a bit in the xscom address space, with the first core
> setting bit 12, second bit 13, etc. So there's actually no registers
> at PNV10_XSCOM_QME_BASE, but so the addressing is easier to follow, I
> chose to start the base where we do, and make the region 0x1000
> bigger.
>
> That was my understanding at least.

Ah okay that does make sense. Because you have the core number in the
address and core number encoding is one-hot, you don't start at zero
or end at 0x4000.

It makes sense after you stare at QME model, but maybe could comment
the scheme briefly there... and now I think about it, I wonder if QME
can actually do broadcast ops to the cores. We don't use that in
skiboot but ISTR it could be done, so size might be 0x10000.

Thanks,
Nick

