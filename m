Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4E5754021
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:05:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKMDO-0002lE-2p; Fri, 14 Jul 2023 13:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKMDL-0002kk-2E
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:04:19 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKMDJ-00007n-7o
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:04:18 -0400
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-1b9d80e33fbso13310005ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 10:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689354255; x=1691946255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AvX3Nc9jmaGe01NxlTbm0wSMwwPj2eAlaNRMzuO7WcY=;
 b=NHI/8kvqzJU+KcItuzNddbrwwt/0msDQp3hzpRnghRnmBMX+juF///weTtCHfDFGBo
 5SyLTWF9vn0JWLQZvl7skhrEMEQzkXYDzYiBDLnZSS+oGnVctuN0HpVLS9wcMD+E1w/K
 2N6yA3iWZ3GrGroN2MzxZtXSKUeC1oqhzxe15WvoO6k7tVwJY+befYsn3x3Fw9+B64Xk
 zEHJ+XtcFKoITwWmSNzTO+xDY7KwqiECTRO9Ij5qD9P4N3Iw/h+lkdB0DsH8jb1SwPEp
 Jn70TYML+d109jH0GhLskNfR3PEfKVKTZvD5m8qOtGBVO5mb0H2wl7x5vxW9mT4JIs6l
 LNVA==
X-Gm-Message-State: ABy/qLYqxqQcIzgMZozb0RQWiRuuYneCc5G5hjPDz8wVVgPWQ5JiM+Br
 SgrogVOC/sInwQXMPYJLLDbJvzjb0eE=
X-Google-Smtp-Source: APBJJlH1jS3vPjyUVBCxqZUD5uf6Vl2TBCpv/m9f62XsW26ROxxiJjalBFm5NDUQdar1ga+VfqEDNg==
X-Received: by 2002:a17:903:11cf:b0:1ac:8475:87c5 with SMTP id
 q15-20020a17090311cf00b001ac847587c5mr4228823plh.56.1689354255105; 
 Fri, 14 Jul 2023 10:04:15 -0700 (PDT)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com.
 [209.85.214.170]) by smtp.gmail.com with ESMTPSA id
 z12-20020a170902834c00b001b8a2edab6asm7996686pln.244.2023.07.14.10.04.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 10:04:14 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-1b9ecf0cb4cso13129375ad.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 10:04:14 -0700 (PDT)
X-Received: by 2002:a17:902:ecc1:b0:1b8:9b78:df44 with SMTP id
 a1-20020a170902ecc100b001b89b78df44mr3913039plh.20.1689354254034; Fri, 14 Jul
 2023 10:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-12-j@getutm.app>
 <581b037d-ccb7-8df7-8946-df8198cb04e6@linux.ibm.com>
 <fe8ea892-0690-2308-5036-f31e10da0351@linux.ibm.com>
In-Reply-To: <fe8ea892-0690-2308-5036-f31e10da0351@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Fri, 14 Jul 2023 10:04:03 -0700
X-Gmail-Original-Message-ID: <CA+E+eSCC2F-2bsO7OiCoS0weo7bh4daL7M5GYxa=6r-6qKcGmg@mail.gmail.com>
Message-ID: <CA+E+eSCC2F-2bsO7OiCoS0weo7bh4daL7M5GYxa=6r-6qKcGmg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] tpm_crb: support restoring older vmstate
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.214.180; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f180.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Jul 14, 2023 at 7:51=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 7/14/23 10:05, Stefan Berger wrote:
> >
> >
> > On 7/14/23 03:09, Joelle van Dyne wrote:
> >> When we moved to a single mapping and modified TPM CRB's VMState, it
> >> broke restoring of VMs that were saved on an older version. This
> >> change allows those VMs to gracefully migrate to the new memory
> >> mapping.
> >
> > Thanks. This has to be in 4/11 though.
> >
>
> After applying the whole series and trying to resume state taken with cur=
rent git
> master I cannot restore it but it leads to this error here. I would just =
leave it
> completely untouched in 4/11.
>
> 2023-07-14T14:46:34.547550Z qemu-system-x86_64: Unknown ramblock "tpm-crb=
-cmd", cannot accept migration
> 2023-07-14T14:46:34.547799Z qemu-system-x86_64: error while loading state=
 for instance 0x0 of device 'ram'
> 2023-07-14T14:46:34.547835Z qemu-system-x86_64: load of migration failed:=
 Invalid argument
>
>     Stefan

To be clear, you are asking to back out of 4/11? That patch changes
how the registers are mapped so it's impossible to support the old
style register mapping. This patch attempts to fix that with a
migration path but I realized that I missed the "tpm-crb-cmd"
ramblock. It can be added to v3 for this patch. Similar to the logic
to have `legacy_regs` we will add a `legacy_cmdmem` memory region that
is not registered with the system bus but only exists to migrate the
data. Would that work? Also open to better ideas on migrating legacy
saved state.

If we back out of 4/11 (the split mapping), then the proposed way for
working on Apple Silicon would not be available and we would have to
go down the path of emulating AArch64 instruction in HVF backend (or
decide not to support Apple Silicon).

