Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 709CC777A3E
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 16:14:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU6Pr-0006Hi-RJ; Thu, 10 Aug 2023 10:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU6Pp-0006Fd-Kg
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 10:13:29 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU6Pm-000481-DV
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 10:13:29 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fe426521adso1396205e87.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691676804; x=1692281604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bpsGhHIebT3uDW2J9NegMXt5fhq0bVbral1fmGDwzlo=;
 b=HE8LqcQ75MMHWmm4AVKZWkow8vMV25DRx8H0su44OnVDJjb8p2W2H8X8Qo/tKOXHv/
 B1E//s/WDGvmQIm4a6zopEJXV242kXGckDiDCDZnvE76AK6+uOE7KZNqirRDG/1K6jce
 X/+bldiQQBj0W/nZO1m0uXhOtuT1OyHA1k0zPFIpbKr091G29TDu5DJlZ5iszp1WQdSV
 vrmSlt7umHNoH1ekQXDjyUk7GuDeNnqhxQYRNy59FkgaGKi5WtFNWFFon9QllaVUylDh
 lhYCmCla7FILevQUv/JjIv7gIyTTwAvbcj+DERx4JznRBE5duqHWkkF8WSHAPGEPQ5R9
 1UuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691676804; x=1692281604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bpsGhHIebT3uDW2J9NegMXt5fhq0bVbral1fmGDwzlo=;
 b=dstmz9GXE5tQYm3GOoPDGFNfUdCsY6qAUR3vpZR+4CLjaSn5mADPDM3Z8o05dv8uEG
 AXN6FZynmRYgUyskC2lpja/dnRISGH5wqrdnEOUPimBgboqGx/cmE8epSPKWnFxPUNhx
 g2JMy59m89JumriUhI4xMAbjA85yuuEbrCAZ1m6Hvqz/XLyftB0Ia8zOUMkXJxDUPb6K
 TT+/8U/RI2s0GQT+kHtnhuSY+6YPUVayPydM6igzQK7sps6NXAd2zM43Et9FD0THoG8q
 AvlMClFhF0BmnWEhm6cubsSu8f7TgyrU9ffl33HBE1QgwK13oWz1ol97V/cb1fvOPuNx
 8VOg==
X-Gm-Message-State: AOJu0YzJl8JZT5syzsPV98/muDtyCAzr4hwsPtmzjCCy/Gv+7IFqZg1q
 ZKRdWH3Aub2SKXrEK7s4qlPvhKh0yf5zt5WXWTRUTQ==
X-Google-Smtp-Source: AGHT+IFoGHKGkiErxnUHJ6Hn9UqjFqTd2+uCwQtWgzpnkKJZU1Aeyt/TXuz2OOfLZ91FidvTRFmrFtgFYJU4DNjpMFM=
X-Received: by 2002:a05:6512:3456:b0:4fe:cca:c6f7 with SMTP id
 j22-20020a056512345600b004fe0ccac6f7mr1576692lfr.48.1691676804391; Thu, 10
 Aug 2023 07:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230810023548.412310-1-richard.henderson@linaro.org>
 <20230810023548.412310-4-richard.henderson@linaro.org>
In-Reply-To: <20230810023548.412310-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 15:13:13 +0100
Message-ID: <CAFEAcA_ezGixc++DuUC9ZGsikP3=gPHoYtLP1m=SyUnnBz6wVQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] target/arm: Allow cpu to configure GM blocksize
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Thu, 10 Aug 2023 at 03:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Previously we hard-coded the blocksize with GMID_EL1_BS.
> But the value we choose for -cpu max does not match the
> value that cortex-a710 uses.
>
> Mirror the way we handle dcz_blocksize.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

