Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC236818BDA
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 17:09:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFce1-0003iz-U6; Tue, 19 Dec 2023 11:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFcdz-0003iF-CF
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:08:31 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFcdw-0002oX-Ik
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:08:31 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-552fba34d69so4359698a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 08:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703002106; x=1703606906; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4N2fo9k+Y0Kfq2cFNWNz3ppIkZmhmegkgvOQe8zaU88=;
 b=aTWCQhMqK7qRDeb4tU8mSi3HMBlPAJ8RJU+THSNeMGtpYpebVfJi1Kx7b5OLxRkmXd
 org6Bm3WgmScR+C6jaoPpbAyTWi9xtVgKjDRcFN1s3S6zlIJK7wtqy6+6gOZZNTIiOh4
 srqRPR97Sxg9TjpRlG8+UpE1H05tnRKavOHHhl3Wkqrl3dqJ6NKvOiWj30N4AMHZCwk0
 Svdo/nTSxqt4JZ8EQPPiDoQQQWfJtiUkwR87E266WNkErOFfsTx8gstYyZfgJyNifknu
 1OgTyoXnuP0nziPGmIuMkJfs/GK0rmryVTz+1aYjbRshO/EhcvjGShOBgyMx0RfgakTW
 s1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703002106; x=1703606906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4N2fo9k+Y0Kfq2cFNWNz3ppIkZmhmegkgvOQe8zaU88=;
 b=L05SzYTg6HGexmQ5Sv9a3zs1eIlcdr0DfDvAnN+yYchfakGQqg7huiUF0ehouMhfLT
 gs2j+p4Q62MknILaMdqrxG1rnDBsv0OKX5HlOXbpKkLqOBs+wLgeIsGmIgyFIJGSbqTi
 FesiiAahS3mtye1ufioH4RiHN88rPRKmKWZfgXfdzHkyvmNN+A6auqAgANVI0WAyGV0Y
 +gKcuCbYI9fFgl8t/GTwjoIKVmDaCpQo73dLhtlyz0YRkW/RJikwig0T/jh7WfJO+b54
 Km1ZaHZOt/oaTNgmZItL/nXyur4+E04itUNPOtCRvqpP+43Icyxl2ONjDCGWi069qvAP
 bVwQ==
X-Gm-Message-State: AOJu0YyuNuFaShCzkM13UxbkfNRqIVKq7TNM2frIub+yZiAXjXVQTLJf
 hrxvishtDrukhl6+bSFLSxolOk5pYk5z3qPFiQ6hjw==
X-Google-Smtp-Source: AGHT+IGa4MTLKi8gWOoniKi1faoCgnwMb3abaZxgLle+i3a25uJ62FhvZN2xmtGUn654pleHpg0rlSt8bexMQDXXaeY=
X-Received: by 2002:a50:ccd1:0:b0:551:656:d48b with SMTP id
 b17-20020a50ccd1000000b005510656d48bmr1406490edj.71.1703002105965; Tue, 19
 Dec 2023 08:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20231219105510.4907-1-n.ostrenkov@gmail.com>
In-Reply-To: <20231219105510.4907-1-n.ostrenkov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2023 16:08:15 +0000
Message-ID: <CAFEAcA-Gp-8ooEhHazJg5Q-xyQ5xB2ox2+fU_tNBYV0HTkwg6A@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: add cache controller for Freescale i.MX6
To: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 19 Dec 2023 at 10:55, Nikita Ostrenkov <n.ostrenkov@gmail.com> wrote:
>
> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> ---
>  hw/arm/Kconfig    | 1 +
>  hw/arm/fsl-imx6.c | 3 +++
>  2 files changed, 4 insertions(+)

Thanks for this patch; it looks fairly obviously right,
but I wanted to let you know I won't be able to do proper patch
review and take it into the arm queue until I get back from holidays
in January.

-- PMM

