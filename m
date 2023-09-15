Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C115E7A1FE2
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 15:34:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh8wU-0004zy-DQ; Fri, 15 Sep 2023 09:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qh8wJ-0004rs-2s
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:32:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qh8wD-0008Tb-Iy
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:32:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-402cc6b8bedso24771415e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694784767; x=1695389567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKmCXGdF513ZUDMT3ATipCBLXUXXnoYQzqFSa/oBSDI=;
 b=tlorPF8UtTg0cfYXNCsamwNiHDEdwpRxoGUrXNK3UODltUEDRc2tpBcKBcUtYS8zLK
 7TWoQr6G9vQQhMYesuaYBto4K+QjN9k7ewmU7dEmDEI3hxA9cerxiXt2g30GbRffBylC
 c+Vc5mmWwfUeHCdrFHJNPtGIfmiXcvM2Lczbe7bwWfwQZ1+P0M5kadJmf7wglDREV2w4
 ZY7uwntQ81iPWFHlaw9GA+1DSdwxZD3NPDiPjRp/Hc+Zc+/1xX/BC8ZdW1C2d5PIGiQq
 5DXZGXry5YMeENO8+jpqb7bHA9VwRhKFNCSpDhNpNnVVZ6cuAAbdk2JpIw3XYIGTphBL
 hI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694784767; x=1695389567;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZKmCXGdF513ZUDMT3ATipCBLXUXXnoYQzqFSa/oBSDI=;
 b=XUAaLGGW4yAAJCeIuV/pxxVwpEk5IHfEBuJBclyraAfT9VdLe+qzFyyA+XGEHrBpEY
 K+p11D7liNZm9biMhUSpKaQxh40V1YwgtUmGsKE1+QEhX1X25YFH9IY/RRl4NOZmAqao
 ob8UP4m1sZ1fRsfllXnF1QPRnFyb+OTbzWTRN6tlMsbyvWq/AlqJvAgmJBd5ijTs7UHx
 5NH5vbHviqd5Q+RNJjw6SzR3P7bMT2TUd+K6f1MwGWcF+7fGTOx7czMLAB3UazdtrBXN
 c/ZJN70nh6pxZGAPPEjOGCIlQUTNVc/rYIFEr0fYN2EoO+qltembrQlWgAL0K5N0mLDm
 O3iQ==
X-Gm-Message-State: AOJu0YwQT1NQ49v2ZXtBvhxRbVxo2MX2bVHbDrkQOPIWpbVelaKfuvrI
 p7tYSm+UAHuU7WNMYaxnbqCF+g==
X-Google-Smtp-Source: AGHT+IEEMRkaMK37cNJ57K4rNHLguoxGd1gNLh9YntSmegzjZ4vcMe4y9ldyYcdkXel9chJdyNjjdw==
X-Received: by 2002:a05:600c:2241:b0:403:787:e878 with SMTP id
 a1-20020a05600c224100b004030787e878mr1835726wmm.21.1694784767590; 
 Fri, 15 Sep 2023 06:32:47 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a05600c214d00b003fc16ee2864sm4642524wml.48.2023.09.15.06.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 06:32:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A33821FFBB;
 Fri, 15 Sep 2023 14:32:46 +0100 (BST)
References: <20230915110507.194762-1-danielhb413@gmail.com>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org,
 npiggin@gmail.com, aik@ozlabs.ru, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes
Date: Fri, 15 Sep 2023 14:32:41 +0100
In-reply-to: <20230915110507.194762-1-danielhb413@gmail.com>
Message-ID: <87y1h7r281.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


Daniel Henrique Barboza <danielhb413@gmail.com> writes:

> Update all relevant PowerPC entries as follows:
>
> - Nick Piggin is promoted to Maintainer in all qemu-ppc subsystems.
>   Nick has  been a solid contributor for the last couple of years and
>   has the required knowledge and motivation to drive the boat.
>
> - Greg Kurz is being removed from all qemu-ppc entries. Greg has moved
>   to other areas of interest and will retire from qemu-ppc.  Thanks Mr
>   Kurz for all the years of service.
>
> - David Gibson was removed as 'Reviewer' from PowerPC TCG CPUs and PPC
>   KVM CPUs. Change done per his request.
>
> - Daniel Barboza downgraded from 'Maintainer' to 'Reviewer' in sPAPR and
>   PPC KVM CPUs. It has been a long since I last touched those areas and
>   it's not justified to be kept as maintainer in them.
>
> - Cedric Le Goater and Daniel Barboza removed as 'Reviewer' in VOF. We
>   don't have the required knowledge to justify it.
>
> - VOF support downgraded from 'Maintained' to 'Odd Fixes' since it
>   better reflects the current state of the subsystem.
>
> Acked-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

