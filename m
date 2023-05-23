Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3252E70E999
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:29:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bQn-000220-II; Tue, 23 May 2023 19:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bQl-00021m-Ko
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:28:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bQj-0001kq-UI
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:28:39 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ae763f9a94so1885085ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684884516; x=1687476516;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R1afHpMo8k+UAXoPPfe4d17I0FWS0+yHm6TDiQsDBFI=;
 b=ZgPdyyI7S/rgqGwxUdK4iMEiFz+9EDBHr8JCgZahLx1RZB/YUMy1SsbSDL7ayf99PF
 V1R9CMos6sptgiEW3FrJe33IM53CD8SXxzeEsbmUM4fd5bM0kgurx6+fixtBH9kGHG6L
 u4pGioCI6WMCjozsRSnPe0usuSEB3hdwnDDk6leeJLEsLR7kP7nJoiB+Q5oahXbduwLb
 1Kxy0Ovsa3FPK+4O5YRcmjqJegpzOUpczvEhK8n5OpmtuseyHxWV85R76UNIBLZMBmEe
 4Hnad+1A8vyrIzTbBgqDvBz248fkV8oyzK15Kqv+kCUoC47ES+QpB2OuLiRQBaAkSD75
 MelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684884516; x=1687476516;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R1afHpMo8k+UAXoPPfe4d17I0FWS0+yHm6TDiQsDBFI=;
 b=HhDmjpvhH5AxBOaonAHIVW0ZqcovrQz3KZhnbUePyjcc7U3OC7AmBVW2AOIruYr+db
 2BuRIVd3ShFRepWJGfPU4XuwuUKcc91cnDpF/VScCcoithPhH4h4VV/y8P+mXLK4hfBX
 cZ+rzGHKW0XbQli6hTYrQqPGSNmTs7UDKZSZtawZwiihU2DqGMoXGNVKsJlzuyWy6dGM
 VXGsrTwn5ZlE1fZR+Sza7uJI65wy8DReF9f4NE3eqgldknrHdZ5KcbbVRjb5drT6N2xT
 j1g5kFdj23HZYAtu/md7jmQGr0k1Y8HPS/SlgSnfa7YQXHgSeahS0ppcjqcqKXaSw3pY
 Ox2g==
X-Gm-Message-State: AC+VfDwXVScQo5asNb86ACsY/+FlgMJk08fQqLzvGp0UKtH+uvW+L0CU
 Vq0SJxHqGVNWbD9XHYcONXJtnA==
X-Google-Smtp-Source: ACHHUZ7T/00353t2LcRfmv54mPW2F+GQeKBvixc+W8Z6Q5wQ+mNLOIgvs+UJZXsRhssbdvbkVyigNQ==
X-Received: by 2002:a17:902:e88d:b0:1af:a143:b0e7 with SMTP id
 w13-20020a170902e88d00b001afa143b0e7mr12596447plg.10.1684884516170; 
 Tue, 23 May 2023 16:28:36 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d50500b001a9a8983a15sm7311595plg.231.2023.05.23.16.28.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 16:28:35 -0700 (PDT)
Message-ID: <cfad3770-d883-3011-bee4-c3749891f886@linaro.org>
Date: Tue, 23 May 2023 16:28:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/11] hw/virtio/virtio-iommu: Use target-agnostic
 qemu_target_page_mask()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523163600.83391-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 09:35, Philippe Mathieu-Daudé wrote:
> In order to have virtio-iommu.c become target-agnostic,
> we need to avoid using TARGET_PAGE_MASK. Get it with the
> qemu_target_page_mask() helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/virtio-iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 1cd258135d..85905a9e3d 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -20,6 +20,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "qemu/iov.h"
> +#include "exec/target_page.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/virtio/virtio.h"
>   #include "sysemu/kvm.h"
> @@ -1164,7 +1165,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>        * in vfio realize
>        */
>       s->config.bypass = s->boot_bypass;
> -    s->config.page_size_mask = TARGET_PAGE_MASK;
> +    s->config.page_size_mask = qemu_target_page_mask();

This could be

   = -(uint64_t)qemu_target_page_size()

without adding the new function.  But either way,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

