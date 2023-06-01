Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B94CD7190F8
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 05:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Yfo-00023D-B0; Wed, 31 May 2023 23:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Yfh-00022C-L7
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:08:17 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Yfg-0001EB-12
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:08:17 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-53f70f5ef60so305878a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 20:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685588894; x=1688180894;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8KfAGvtkr6GX96m1nAUrNOzhHmaS5FcOXoTr5uMDWus=;
 b=yDj+H+w71wc+m+G7Dg03ysbXZtnOa4mhnzwXH3K8s80reOFZS3jh2WP8i7YFiIP1xb
 gVG8aFUhpqIFzuEncARIt5EtcfR7uHLVLTjaEe/ow/XsvVN6qwxjDeY88AK/F8vIjKeN
 Ms7c+yAsxBqD0WJz+eAoFVU3/ZUNnWCrFuar7wFNsi8vjFNlXjio0QjiVd5t4nuCpHuf
 22EhJWLp6qTHH4/F4qkY+QUhAY4VZtdSPI3dTn02k4o1sCvrJU5LX7CdLE6j3AWocdPe
 B0Qs6lH77C0LZxKX5yHh8I1QdSzCWCwEvZb55jYWfLzlYQT125foc6MvVWAu1m8IC4Ca
 JRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685588894; x=1688180894;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8KfAGvtkr6GX96m1nAUrNOzhHmaS5FcOXoTr5uMDWus=;
 b=FVb3rcJScHCw6ifSRpIN1PQfzPTwEjIBA24FqufDSAgFfRkS5obXacBCAKo61N3Yvj
 eMf7Y3W3mCiusTInha5ow59JJkdRfBK0SQtlTmO/qpzwYbXa65OgEQyQPPv1TSLGKtTU
 GqQa3xP7BGkEnMfMJGoLiN5HiscAQaP6nz6gXs5Ajl5Smq2Cv7NuSW0Vou8WDj6qbw3+
 E1uWuhIKEiE6/nqyYGbabdUYjIuMSF1cYIuZzt3MolAnpIS/fZcH7FifKnqbf+/vkVpt
 QNJ1M90ykxdMAwgjM3OVNwPAwrZhHalU7EUKnMq/zulIAL91HhqufemRv1MmogXwiQd7
 zDhw==
X-Gm-Message-State: AC+VfDymH9SB1oWEtTJpxxWGuMrI0nkiEw8UyeCrlCPbw1VOIkhqEhNc
 VVNAqp/jijh0mw3el3UWBD0BQTXYLeWVuP8yjZ0=
X-Google-Smtp-Source: ACHHUZ7JrL9FzwuPrZ9fY88Cmf2CgaZe/95dIK4JjloNLPV4yjqgE8gXQKKIr0w6PNnfBzCAVTkpoA==
X-Received: by 2002:a17:903:189:b0:1ad:e2b6:d2a0 with SMTP id
 z9-20020a170903018900b001ade2b6d2a0mr679882plg.11.1685588894419; 
 Wed, 31 May 2023 20:08:14 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a170902a50900b001add653dba2sm2135653plq.108.2023.05.31.20.08.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 20:08:13 -0700 (PDT)
Message-ID: <5c0d5d77-aed9-a6dd-b4c5-af2cdded00b3@linaro.org>
Date: Wed, 31 May 2023 20:08:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/7] hw/sysbus: Introduce sysbus_init_irqs()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20230531223341.34827-1-philmd@linaro.org>
 <20230531223341.34827-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230531223341.34827-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/31/23 15:33, Philippe Mathieu-Daudé wrote:
> +void sysbus_init_irqs(SysBusDevice *dev, qemu_irq *p, unsigned count);

unsigned count does not match qdev_init_gpio_out_named int n.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

