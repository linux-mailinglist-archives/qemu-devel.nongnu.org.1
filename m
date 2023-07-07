Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FA974B84B
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:47:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsLz-0005xd-IK; Fri, 07 Jul 2023 16:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsLw-0005wk-Vr
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:46:57 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsLu-0008SK-Av
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:46:56 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3144098df56so2559111f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762813; x=1691354813;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WadSlGkzT+nLc8LrPi/jN/5tcYKZz3Ah3s0PQ8Lj3XE=;
 b=Lu2yB1wkeYZKpyqASd7xzXpMSReCobifCxwNayZC8oLjaz4s9b6S7rcRYY9OaSu8pe
 p0mavcrirhwXs0EX1BmZwRQcIlt7/YlRBgkQFQYlDvamicHjKcT4iPOZVKz+qDuB8QQY
 SXcUgppxyL7CAHlcW8I04n1gWafnTRYu3JGxIICXDUzOsEZjDns1ud/ZzC1ryFxcBJdg
 D3UIoJogxLx26eF4ym7JQNtLJycOykjTIfMQc6704Foxkh1Ez6LfYwnYQYCH0V8BuzRa
 6d0Nx+bCGAzdGpsFHbTS7D5PtwqZQx4GnvbUZM80JaQ0texqdfTZ5oCDPX4pvPvogP2M
 Dmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762813; x=1691354813;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WadSlGkzT+nLc8LrPi/jN/5tcYKZz3Ah3s0PQ8Lj3XE=;
 b=PadtZeIthdi6LRGYygGbYPcq45zQataAi3IDYjvHmIUfHD26jCC0F7xYG4YSdG6VjA
 N/0jNEE69HhXWfQTYG65nbKuU64akUvTV9LU9ZQeZwJKsqyuZrBBmDqLt/+SWCh89qCX
 N5XWHNttrq84CxoA//PwW46a8vcCkXlBCu1MEAuvQO79SczohVKXWq3tR1TJNwMgsEDi
 FukYlcITAy+XT6AIyCoS/CmvmSR7XH6jlEDhU4/JVJRLg1dSda3hqgtAk8RvvRnfdfMp
 uSaAWGG6fv9X5CHMSDC7BDC0OxqtvPeo9V5vozgl02AUFdGZsk7BUgC+3vYvfQuVW69m
 vqmQ==
X-Gm-Message-State: ABy/qLZx5y6jGFPZlOxPLJelVuOAS7e6bqdeEKd1JRJqDbILBkG9+4ca
 e3XPgESyFH5XE2+Dq70M7b/vQACHY+WTcha9vkSzRA==
X-Google-Smtp-Source: APBJJlGzy4ncTelfFqitNJj5l+jWJBMGReuIFQPVpOv9D2eyQWzjAajcVLuU7+vlgXlc8m0+gI4FLA==
X-Received: by 2002:adf:e501:0:b0:314:2732:e81e with SMTP id
 j1-20020adfe501000000b003142732e81emr5217442wrm.8.1688762812843; 
 Fri, 07 Jul 2023 13:46:52 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a056000010500b0030c4d8930b1sm5288548wrx.91.2023.07.07.13.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 13:46:52 -0700 (PDT)
Message-ID: <d9891d6a-6543-fdf7-9aa0-b9bb4735bf31@linaro.org>
Date: Fri, 7 Jul 2023 21:46:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/6] hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN()
 macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230707151719.70613-1-philmd@linaro.org>
 <20230707151719.70613-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230707151719.70613-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/7/23 16:17, Philippe Mathieu-Daudé wrote:
> Use TARGET_PAGE_SIZE to calculate TARGET_PAGE_ALIGN
> (see the rationale in previous commits).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/virtio/vhost-vdpa.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

