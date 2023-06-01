Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90388719123
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 05:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4YlB-0005YB-S7; Wed, 31 May 2023 23:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Yl9-0005XM-Oi
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:13:55 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Yl7-0002Eh-U3
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:13:55 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-565ee3d14c2so3628637b3.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 20:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685589232; x=1688181232;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1kVwc1Qzq4GNqnCYUhxAQDhPsJqMamvHEqwga7wa9hQ=;
 b=iaOVW8bGn3pI3s0kInLPVvuwIX4xsk8ruXBqBZSeqOEM+5bRSGmGyJ+GqOxzJ7hDFA
 od17UqXkLPhhsQwc8OqCllJ5Umzrv4yzeZVzydR6+CwkUJfCHVgTLNHvw/beX8uCD1G9
 h1dT1JPsxx1l68HuHtcmlcvvT0+zG+7S3xEoImEzMGD/WShF/mvHmNB3mW6U9ON1H9sY
 W44VTx5pTMzALF71Qv+IGiEqj+TRjkdDy7bMJivZChOy4oyW3r5q+1OWZEDbHNZgSUss
 Lwwgq3p2JbT1lwYI/KHl0KeaHy/z7wfH/mD/h26zHsIEEyhcOXzQbW111GD67ITQIEaW
 uU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685589232; x=1688181232;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1kVwc1Qzq4GNqnCYUhxAQDhPsJqMamvHEqwga7wa9hQ=;
 b=K1M0EjL+aDR2e0c522omDBQP2gO/Dju/5krF+Iq75AgesH2uJ51YL539cTYglu6xuu
 v7zX5XdRQvuBJWBenUSNsIW+7325uwjGphM7aE3A6uQi6/oduds2ZHtVc1AwAaHB1Xco
 1vcmCNpuYJg1bfQXZc3lHeIW90F++opo4IsfTeRCCjsHve94osgSWowDH30bbqaCXbLe
 a8nojUgxRdeKN1myypGLtuSBfilYN0J+qorbg8+yi3PM6fIVqeK30K3In+wi9QJi2/bA
 hnRH/tP8kOiRrP9W0Ao7uWKrxKnkESWlxYtkoDKKmcutb+b5Ivjr827J+w5Mcv/oxRki
 K//A==
X-Gm-Message-State: AC+VfDxnQG2dJ4D1V3rtq+hNy7hsF+zqbYodoGtoZ/kEQiiRVctnypVK
 n+jV7lrYDMryOxa/iKuzdrziTw==
X-Google-Smtp-Source: ACHHUZ7TQ46J3NvApi3NkHDq8P17vsNJJdkHT19YarYUQslZf0Osc0BxBBZ+HkPscVG8Dq9K6MAqKg==
X-Received: by 2002:a81:4f4a:0:b0:567:aea3:75ba with SMTP id
 d71-20020a814f4a000000b00567aea375bamr8534682ywb.4.1685589232374; 
 Wed, 31 May 2023 20:13:52 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 l30-20020a635b5e000000b0053f5ff753e2sm2019553pgm.23.2023.05.31.20.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 20:13:51 -0700 (PDT)
Message-ID: <cf845d37-31c7-6214-b36a-3e2e93490a1e@linaro.org>
Date: Wed, 31 May 2023 20:13:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/7] hw: Simplify using sysbus_init_irqs() [manual]
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20230531223341.34827-1-philmd@linaro.org>
 <20230531223341.34827-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230531223341.34827-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1129.google.com
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
> Audit the sysbus_init_irq() calls and manually convert
> to sysbus_init_irqs() when a loop is involved.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/intc/loongarch_extioi.c | 3 +--
>   hw/intc/omap_intc.c        | 3 +--
>   hw/pci-host/gpex.c         | 2 +-
>   hw/timer/renesas_tmr.c     | 9 +++------
>   4 files changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

