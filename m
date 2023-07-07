Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 283D874AB9A
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 09:09:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHfZS-000078-JR; Fri, 07 Jul 2023 03:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qHfZL-00006Z-4d; Fri, 07 Jul 2023 03:07:55 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qHfZI-0005ha-3r; Fri, 07 Jul 2023 03:07:54 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9922d6f003cso198705166b.0; 
 Fri, 07 Jul 2023 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1688713670; x=1691305670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qvsBYWi8i/gEb3hsQA9Xu/URk8DZgAbHwgvtgCdzRdk=;
 b=gfgQtHlhiBekADnlcP1ITHDlPA2wTMPhu4jsVLZilEWdkGqLxYkyWIxac4yNKuYB+e
 DPyS/YxAuufm9B6XVanVdqlF+5uNDwU4Nu4ZN8ThZgiUYFFfz5Ho1pU28Yh8s8R4bP+U
 1XPR3qw/vurDT/hZ0CBjSNGP8H9905wY/Yty8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688713670; x=1691305670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qvsBYWi8i/gEb3hsQA9Xu/URk8DZgAbHwgvtgCdzRdk=;
 b=XNs8NEmviIVlQ9Pb8Rd6sIc327VzSuffWiqBLqjtLSdNqsSyslt12IMIuSxwHW3b45
 v8sJwSu+ljSTd/iZwxcolB5/aDwXpN77reb7CSWeWXVd5+NVpKcR9uywZ2s/N7M7qwAi
 AkyGw9ioA2iig5oiapBJCqLt31EpmFiyWx7/iVCdSJLFGQBYpAixhcntGDhQdTZn0wEx
 dBDV6lfJ6u5I1XvaiDR8mlMhD/6yOdL0DWopgYj0muLLOI3Dr6w+8T4YnRLgQCpSXT5u
 xQOLhMAgiyR6scB7nsQT4zxJ/VTZiR/weSSk8lpp+MX3nRQq+My4Grj04BQ0puB1vsVf
 FNYA==
X-Gm-Message-State: ABy/qLahVV1+KIswEvoWMEKp6IfKnwTFVmKDHeTbXoUzP0yWeUZ1jmHf
 o0Or6Hg74RO69OHldyXCZt2x0ppYXeec/l92B0o=
X-Google-Smtp-Source: APBJJlHGuG8B8wqZBk0QvYnNm2FKive1DwNjAbQWcYGg2A5TzU6jv8XApWrv2A7K5/TYsqc0sJiqvKCMSPyAuiFcknY=
X-Received: by 2002:a17:906:297:b0:98d:5293:55f7 with SMTP id
 23-20020a170906029700b0098d529355f7mr3282253ejf.6.1688713669786; Fri, 07 Jul
 2023 00:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230707040631.66021-1-joel@jms.id.au>
 <78344793-d55a-c8fb-bd1d-171064ad9ec7@kaod.org>
In-Reply-To: <78344793-d55a-c8fb-bd1d-171064ad9ec7@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 7 Jul 2023 07:07:37 +0000
Message-ID: <CACPK8XfCOA19Nj7bt5L+BRj8fRubgC0rRHmQHhQ9XhYYv-9iBg@mail.gmail.com>
Subject: Re: [PATCH] ppc/pnv: Add QME region for P10
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URIBL_CSS=0.1 autolearn=no autolearn_force=no
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

On Fri, 7 Jul 2023 at 05:04, C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> pnv_quad_realize realizes power9 and power10 quad objects but ...
>
> >   }
> >
> >   static Property pnv_quad_properties[] =3D {
> > @@ -528,6 +581,9 @@ static void pnv_quad_power10_class_init(ObjectClass=
 *oc, void *data)
> >
> >       pqc->xscom_ops =3D &pnv_quad_power10_xscom_ops;
> >       pqc->xscom_size =3D PNV10_XSCOM_EQ_SIZE;
> > +
> > +    pqc->xscom_qme_ops =3D &pnv_qme_power10_xscom_ops;
> > +    pqc->xscom_qme_size =3D PNV10_XSCOM_QME_SIZE;
>
> xscom_qme_size is only defined on power10 and it is 0 on power9. The regi=
on
> is nevertheless initialized on power9 and never mapped.
>
> I think we should introduce a specific realize routine for each proc now.

I overlooked the P9 behaviour, thanks for pointing that out. I'll make
the realise proc specific.

Cheers,

Joel

