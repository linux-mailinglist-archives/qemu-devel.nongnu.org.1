Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79B728307
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:50:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GyD-000331-NK; Thu, 08 Jun 2023 10:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Gy1-0002nc-P6
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:50:31 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Gxw-0001PV-Ch
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:50:22 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-516a008e495so1508784a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686235817; x=1688827817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbXypd7Rz1mw0LDVS9aDTyo9REcPEL/pMXch0URhyd4=;
 b=dzZ16daNQE2/V1BT62Djw6aY/J0WvKC+CdPbzbIurnlybb2R2cv5fF7VcT3Q7IS4k2
 64dqCzRK5eiT77FSYPOOLWCy6C0lybWr8rt1fD+UCKwovRgRdngt1r+1v8jxvDBI53fm
 ome09XjI8jnl95pXUsMZoLxNMb/cHgvXW7KGhGvVUD5yBqPiqwsDeFHQfSCB+w4YfQTb
 Upx3SaMBq9hzCqgy7KSLl4i3W7pVcTNLQKQV8c4lD3PjbQtn6AixWuVpiifsC9bERriI
 qecbT/R21O4HWB8fwDzwCKAEju4aLSNFk+FG1Z8zL2wd8wdGm4wMmnT/0M9+I7oRDErh
 tKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686235817; x=1688827817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IbXypd7Rz1mw0LDVS9aDTyo9REcPEL/pMXch0URhyd4=;
 b=CFY+L1FbG/xA7zXUnZbqWHm7SzJcY6zyZo7U7kMpEOGYzpltziO5EPsDk2xKM89Lif
 5uvRo+QYt13k4E4eLQ6bnsUhEZ1B923JYa4xPBTC9iAciirh5uNBAmVmFPPs3mkCa7Tf
 h4en9Ak6h+3+EVd/9G92f0RR7A7jsfNew64wDDI8grF/WPUsn4HTri+ibY79WxrAtfJI
 LKezhbRuiaPGuDAq+Xwqp56ypwxaMJQD8HtlV+c9/mwXazVrGixEzCFvkxH3l0PBuOgl
 tuJqCHu868s3uGkBHwP5LzYR3PeSvZq/77y9NtyWBbxwyt9tNF3fj/3PaljY9z6dQcg4
 T7Iw==
X-Gm-Message-State: AC+VfDxyKJ/zQ5vUTr8tx+5S5e6Jnnugr/kJvpwD1/09XkFyz/ZZ3leL
 gm5sFtA4hMXLHKiShRGzUTrNKL645ikOZCX8jDcSVCa2aOTiX/xQ
X-Google-Smtp-Source: ACHHUZ6wk2JKNaxUfGEllGSBRJXIIpaDJLLjuPQ2Jx85Qi/KltLXcxBqYXyAzdX6O3jttIJ/+3YeYfxRJ4gbx6XYYVI=
X-Received: by 2002:aa7:c59a:0:b0:50c:161b:9154 with SMTP id
 g26-20020aa7c59a000000b0050c161b9154mr2491617edq.11.1686235817711; Thu, 08
 Jun 2023 07:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-10-philmd@linaro.org>
In-Reply-To: <20230531203559.29140-10-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:50:07 +0100
Message-ID: <CAFEAcA91B3hyMUqHtdMcdH+YurOy+O73fuhRv-_NvOpxrY6=SA@mail.gmail.com>
Subject: Re: [PATCH 09/15] hw/timer/arm_timer: Convert ArmTimerState::freq to
 uint32_t type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Wed, 31 May 2023 at 21:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> In preparation of accessing ArmTimerState::freq as a QOM property,
> convert it to uint32_t (so we'll be able to use DEFINE_PROP_UINT32).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/timer/arm_timer.c | 2 +-

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

