Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2796879A9D2
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:36:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfiwn-0001Ac-1Z; Mon, 11 Sep 2023 11:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfiwB-000199-Ci
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:34:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfiw7-0002Bf-0d
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:34:54 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31f7400cb74so3762061f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694446485; x=1695051285; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Y6K0hTr2Md/Dr/243637rZyKNMssQ5d0pl3QgsQJQw=;
 b=RTJ8Hb1bOc11Yo6OW3YUuBQgw3MybN1nhfzbkzuSBTzv1wOhS5XCwYlD1y4T8R6/t/
 eCzpFgaZ9ZnBfkOvmGt0pSLZlSph/1W8NOyXcp9Nux9fvpT8/Iqju1fzBaLusy+JoKaI
 IbVLCfj5rRakA97K0x/yY3omItb1ck/ur2NW5ogXtWNfTG5tYGdr6Ews9X84jxWDO14e
 FKdpKLa742gB4iaWmIOUaXz+IvNRlTXiTJ0zDwfNbMvuHNS1YSwv8jZjRVvWNIdvUaFs
 DUcu3fhW3YVADpbhv/UvjVi5NvydiCfJt9pn7/UvNhNBo2vmt52UBegWfuzSR4jsAqq7
 kMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694446485; x=1695051285;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Y6K0hTr2Md/Dr/243637rZyKNMssQ5d0pl3QgsQJQw=;
 b=fASTa9GfUB+WS6aS6P1RjZ6LMihZ9PSRF4YIGHKGiIzGIHSVKmiUyfHCKi0t2ZuDua
 6+UAbPFmIhCN7bY5bVXwkDqDS1+8ltjy4n8OrCWbtmwzWn/ixsXAPwqzgDuNMXprJAQY
 bpRa1NWMkzMvGkg7CiSARFQtjkysETLkBvwDA5+bFDyuzpUx5p23y2eZ6V8CGGw24UVZ
 UTD8l7bEFSLX1zu5ZOv0sGNNz76NHFPKn4ShnzZT1FKptr7VMGcJLUkNv3bBSuWd8xlF
 fX6h9ySqOLg+eOHGjarFg3wksMa9/cA70DP32mXcLEi612TPH5NKTdzGHyJTL8FeBfPH
 RdRA==
X-Gm-Message-State: AOJu0YxD0N7NBErMo9VqXbJ4AkWpYtAJ97FvkJ16vczpADRy4w3660LU
 bSXypYxEKHVDny0EezwMvOMGfGuL4y/ZnSKGCKytqQlpef7DK23q
X-Google-Smtp-Source: AGHT+IHyYax2ciKXizpEaEVmn3ZgUQ/IOYoew5jBKAT7h98ZpuWjV5EVjF20K10L2XFFu3c+u2trrF8iU78RTUdIaI4=
X-Received: by 2002:adf:cf02:0:b0:313:eee0:89a4 with SMTP id
 o2-20020adfcf02000000b00313eee089a4mr8025325wrj.12.1694446485327; Mon, 11 Sep
 2023 08:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230909131258.354675-1-mjt@tls.msk.ru>
 <20230909131258.354675-8-mjt@tls.msk.ru>
In-Reply-To: <20230909131258.354675-8-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:34:34 +0100
Message-ID: <CAFEAcA9kJt7orFVFjdVy+KRo8YN5RfpQAhE+Ytx7MgYOdTGNPw@mail.gmail.com>
Subject: Re: [PATCH 7/7] hw/other: spelling fixes
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

On Sat, 9 Sept 2023 at 14:16, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>


> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index e8b2be14c0..bc87cd3670 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -155,7 +155,7 @@ stm32f4xx_syscfg_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
>  stm32f4xx_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
>
>  # stm32f4xx_exti.c
> -stm32f4xx_exti_set_irq(int irq, int leve) "Set EXTI: %d to %d"
> +stm32f4xx_exti_set_irq(int irq, int level) "Set EXTI: %d to %d"
>  stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
>  stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""

Unlike all the other changes, this is a code change, not a
comment change. But it's OK, so:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

