Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DE5818BCE
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 17:06:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFcbH-0002Oo-Va; Tue, 19 Dec 2023 11:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFcb4-0002M3-Ub
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:05:31 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFcb0-0002S6-A2
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:05:28 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-550dd0e3304so5830202a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 08:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001924; x=1703606724; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fOKdS/r03mPWw+5f0KyqZFD6OmzNmBSvAaVBFMMXsTA=;
 b=vHDjRkD98UAgdCEfCcnFLk1CHlna6dgqejKgc80mk7oWNXzQpiexDyqwjPh+pyrM5K
 2ZztMSEHOCKLdCCpayW4vMIbyByhynZRhaxhQzB8MZivG5d1w/RC05pl/tS0Xei/tz9J
 a4EA3IGS3u7yKQRcew7ditZ8ysu7O138J7yBD6gXR76x5lj8wpytzHpWoXyzLicgDx5g
 bafyzjH8tRpRUTgPVdSEGDJtVPBrWeynn4oZLexbA6PS/f7DwMAdTdhnLOCTq3DSachC
 kw3JO2mFak9Z4f68LioY4qxsIZdOJ4qBt0Y5APEqiKZhicYNAGq0ZwE8WjIP+nada5z1
 Kchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001924; x=1703606724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fOKdS/r03mPWw+5f0KyqZFD6OmzNmBSvAaVBFMMXsTA=;
 b=QqnE4EE0o6W5TGmObov9Acm9mb2dvE8r+0kM/8n46HONeVfDNlRUcssEgz/JQpbFKp
 YUVcjf0oi51+2U7qxK8UGh9V4OBEgVw9m/+WP+M8KE8PJ3mWI2FAgnCL2u94cJq274t8
 HbxoUZaKAJzAsB/iIay08hURjd94PCdEmkv0ZvojaOUy/YsK01T1bZ/5KRy9cDoF4kds
 Tszb6Kkutc1ICuq8TJjOmCl4k0AR+7GiAoaqIlOA6BKPBqSF9r4m/crdBN1itVJ0k4SP
 i7TaZNNfEaisEEG+keVPUNmTWJZYYo4bryz6Z1Dew945HZBJXf4aHhNR/2Kese6oVpCT
 K7Eg==
X-Gm-Message-State: AOJu0Yx+16Tj+P/0fJ6GDEIopovtqD9ZGWOwgZda5xhg8v30zpCYlKvS
 +ibMMWMesfL47YVeAJS3BMA4iUngz7/l5Ij5FlA5KQ==
X-Google-Smtp-Source: AGHT+IEIIW1rKyC+4AtYBqibyqnSo2P6bmujuM3wkdT1p+liMEM25fKspf0baCeZdL1OFSxhKtglLedUKqz6pxhxPXk=
X-Received: by 2002:a05:6402:604:b0:553:b3ee:5840 with SMTP id
 n4-20020a056402060400b00553b3ee5840mr159074edv.79.1703001924393; Tue, 19 Dec
 2023 08:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20231216182740.3305724-1-sam@rfc1149.net>
 <878r5tqnyu.fsf@rfc1149.net>
In-Reply-To: <878r5tqnyu.fsf@rfc1149.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2023 16:05:12 +0000
Message-ID: <CAFEAcA8sTLZSQdqZmNGSv4yp3TZvq86kwbhU8gFmK2=j8vVZhQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add "num-prio-bits" property for Cortex-M devices
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, Anton Kochkov <anton.kochkov@proton.me>,
 qemu-arm@nongnu.org, 
 Alexandre Iooss <erdnaxe@crans.org>, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Sun, 17 Dec 2023 at 07:37, Samuel Tardieu <sam@rfc1149.net> wrote:
>
>
> > Samuel Tardieu (3):
> >   hw/intc/armv7m_nvic: add "num-prio-bits" property
> >   hw/arm/armv7m: alias the NVIC "num-prio-bits" property
> >   hw/arm/socs: configure priority bits for existing SOCs
>
> Any idea to why patchew fails to apply thoses patches? The mbox at
> <https://patchew.org/QEMU/20231216182740.3305724-1-sam@rfc1149.net/>
> applies cleanly on master AFAICS.

This is because you put a Based-on: tag in the cover letter.
Based-on: means "please apply this other patch first before this
series, because there is a dependency" (we use it for things
like "this patchset has to sit on top of some other cleanup
patchset I sent last week and which hasn't got into git yet").
So patchew applied Anton's original patch from 2022, and then tried
to apply your three patches on top of that, which caused a conflict.

Anyway, I just wanted to say that this patchset is on my
todo list to review but I'm not going to be able to get to
it before I break for Christmas, so I'll get back to it
in January. Thanks for the contribution!

-- PMM

