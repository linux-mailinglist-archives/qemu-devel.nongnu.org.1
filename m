Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C747700D6
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 15:10:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRuZ3-00033a-3M; Fri, 04 Aug 2023 09:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRuZ0-00033H-SV
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:09:54 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRuYz-0001cB-Cp
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:09:54 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52229f084beso2746639a12.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 06:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691154591; x=1691759391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eWRjkaQpfj3muYkoWY0i/hu3KgPiRrUqVi3x8R2RCQ8=;
 b=iobysSxBW1NGcNudi5pZRfL5+JxsO0NKKfdO+ev0hr9Jc+T3Ldlgl7nshOLCsI67RI
 PtIEsyM2EoXjM85sak2db5+xlAoCxrdQGk2ffDZDTMnrjCMacsGONxefo3sRMENVQ1nU
 48UDNZK0WNqT4mBIl3ohONMlVr4F8SjHfJV2Z61xOf44TI8NSBZZk7QSk3a+uz5Qrq8y
 4Kvg/ZHT0XZswRDY8AHSjemGsYXnpNLcJEdxSYPHMTlJCqP5lLleW7ltYa9PfVXjj4bq
 2BueJC8A+LSdcBPb1gk8qlV6s9sZvib/pQbryWBG7/h4Q00jkeZioYGbpwOrOM6lnQb1
 fuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691154592; x=1691759392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eWRjkaQpfj3muYkoWY0i/hu3KgPiRrUqVi3x8R2RCQ8=;
 b=HLJB1p7VzsUrtZMFqAkz37Gx1ObVkHk8bVCtRHC30jhDfDqSZMgnGwCaNIweotcIn8
 +r97cKw9Ew3YqqeChhLOsUILpBbwi4Su8rBW3kXB0hgQBDakqLfMrwBJh0CRTRjy8neT
 YsU/Q7xWiKVRyFl6D7LBIrgE6LrZ04DdLzVa/5s6KTKC4vzD/o7SWwhm6FkgIQ+Krkxb
 h2e4FqDIBH29BAbSAVjJk4oH80Njio2YWwyxAwqaOovvqQ0ZSahjnrca1rJmK1UIF6fh
 FSFMn7gtShcFTs8WFGsqpC20eYQJWMP+vnbStoWz+ftmR8Gvdx4qC5QG1XBrMVXUaTWP
 IqFw==
X-Gm-Message-State: AOJu0YzoeOULio9qDR8yZx3QtHRB+9thKbgVH4z1sboo89vVjgkrDUce
 lk1CXbBLSLlQF+Vlu3I8QehE7eCB0O6Al2STr1TpaQ==
X-Google-Smtp-Source: AGHT+IE8frX0OKOLq3HiH2cs9Kkdr9Rh7VouWtRNc39OvHHIY2ajahccig0UtR5OUAhulPIoBZO5cOmjg85q9xCjnfI=
X-Received: by 2002:a05:6402:546:b0:522:d6f4:c0e9 with SMTP id
 i6-20020a056402054600b00522d6f4c0e9mr1715303edx.38.1691154591806; Fri, 04 Aug
 2023 06:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-17-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-17-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 14:09:40 +0100
Message-ID: <CAFEAcA9H+2utOc+phJ5S+pBB=dCYjzoFy9-5+9pBU0zt98kCVg@mail.gmail.com>
Subject: Re: [PATCH 16/44] Enable BCM2838 PCIE
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 26 Jul 2023 at 14:45, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c         | 25 +++++++++++++++++++++++++
>  hw/arm/meson.build                   |  7 ++++---
>  hw/arm/raspi4b.c                     |  1 -
>  include/hw/arm/bcm2838_peripherals.h |  3 +++
>  4 files changed, 32 insertions(+), 4 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

