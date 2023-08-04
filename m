Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C884B77075B
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 19:56:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRz1O-0004Vs-Kg; Fri, 04 Aug 2023 13:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRz1M-0004V1-D9
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:55:28 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRz1K-0004yc-LO
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:55:28 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fe21e7f3d1so4113674e87.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691171725; x=1691776525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qpSkj9Wt2GgvEGZFPe+U/mpLX6PkdwpuMMae8lgDl6Q=;
 b=p/bxFx4ltoiazj82R8NEKkF1F37bgiMDqC0nbd1aW1JuFWW2wTA3QFxzhAj5SLdwz1
 g55DArupcB6M+ePyqHfBlQ2afqxkDsrpSdHlSc+m4cI/FQ1jWgE+Zavd59clNISz64iX
 gwuyZnsDVZu5QmKJnrAmeVXOj0uTg82UFM3qK20PP1v0jXvTQPcceIryMSgTvIpOMQgz
 IKoz51JUeNj+NLdOZQ6AKtDjn4EG5jTs2FjWEYx3vzTxsQZPGY+rkDw4wtYdjXi6jhZ4
 VFVgmuQBaHGEMueSmTN42t1Vux2NENuQUO6UybP1RCoAbQGlhrfYoaDrr9WpGrT97dRP
 bXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691171725; x=1691776525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qpSkj9Wt2GgvEGZFPe+U/mpLX6PkdwpuMMae8lgDl6Q=;
 b=eZJLVfN10cALoIguFQaTews8VEIXlLzhrESYwHFnq9SwrxWzA2ixa8C1i7YAbs6lVS
 1i7YzuBr6b8EIYcj3I7LP4OlZx+iN+q9r4ZwkXS+cAhOx9zbtKxISfmeK4Be6KMm1nYs
 EWTQ+I47OMScPuNkfqyILr6o04FcBUaT0SqqM6sPPZq3EMlieeoJRzzhpVSdcE32YNty
 rN+0ud9DVFugvaSqWudqTBCQOwaZoRr5JhAXxQpW/bfDk1MQd/kLGthhmgLMaaN4R2rz
 fPhuIA73iFtRldMjUoIslFNhjBNvEADDOLW/exZ56IoUs+cidmpad0tX1/DqGuQnk/XN
 mFLg==
X-Gm-Message-State: AOJu0YzgOhMCqZhUHK+SlUkLmq8qY22reP/SPUCZYipWTkde0KaFhZ8b
 7CWxYsTLrU0cwcEbkACYkXMy5MxzWtmUZzHQhIYMkA==
X-Google-Smtp-Source: AGHT+IG7yXdODXRRg2sXu9kV+D4VXsMdIYfct27DLOcds3iQ7dg9VqDB6Ct3sqnJJ3oYMI7xjmi8CJYQgIvWVfRTewI=
X-Received: by 2002:a05:6512:4c5:b0:4fe:ca4:7cd3 with SMTP id
 w5-20020a05651204c500b004fe0ca47cd3mr1640898lfq.23.1691171724151; Fri, 04 Aug
 2023 10:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230802170157.401491-1-jean-philippe@linaro.org>
 <20230802170157.401491-3-jean-philippe@linaro.org>
In-Reply-To: <20230802170157.401491-3-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 18:55:13 +0100
Message-ID: <CAFEAcA_PwcBQYQqwJHpoQQoQ-FmdDzeYpcmASpD=piBscTrX=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] target/arm/helper: Fix tlbmask and tlbbits for
 TLBI VAE2*
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 2 Aug 2023 at 18:02, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> When HCR_EL2.E2H is enabled, TLB entries are formed using the EL2&0
> translation regime, instead of the EL2 translation regime. The TLB VAE2*
> instructions invalidate the regime that corresponds to the current value
> of HCR_EL2.E2H.
>
> At the moment we only invalidate the EL2 translation regime. This causes
> problems with RMM, which issues TLBI VAE2IS instructions with
> HCR_EL2.E2H enabled. Update vae2_tlbmask() to take HCR_EL2.E2H into
> account.
>
> Add vae2_tlbbits() as well, since the top-byte-ignore configuration is
> different between the EL2&0 and EL2 regime.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

