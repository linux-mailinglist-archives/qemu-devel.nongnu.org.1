Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F39E57190E1
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 05:04:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Yag-0001TQ-7c; Wed, 31 May 2023 23:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Yad-0001Re-LS
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:03:03 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Yac-0000Dp-9M
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:03:03 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso510180b3a.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 20:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685588581; x=1688180581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sa4WW09uHbexrRDkmXl7+aU4WR6hV7Akvwy4cS9oZ/8=;
 b=ZV8ldvgkKYp5bAdgcyoJYD2yvj6wbQzk/l1W6N+jdEVuS/3N7FQ6evMb27yNoDHAz6
 Dmbvy3ox6eyd5DG07ofjdiQeUxkK5+1E+tIOWvtIh5oo5sdEwBu/Qx9sywN2wX73I2zV
 Th7osV4HnWb+tLJs33B09KYt7DXx6jeNW4y/8OsOmACjuwUxLekzr25dSD7UGc/ZHOc9
 VR2Kblps2sI6ojHGmZOr7wcZ1f17i4T3a//HRSPYP2qIsVMAzQzcncjAw6wNYPYZb5Du
 LZ7yQWRSMIw0BcNoS3Foq0qVugq1qbGyigemXixGLSYQ6uOcr7mEaV9Cyuqc8O2uSbgj
 krWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685588581; x=1688180581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sa4WW09uHbexrRDkmXl7+aU4WR6hV7Akvwy4cS9oZ/8=;
 b=UXnt4RBm8z8cWwQPkHNIC9Y2V/5ggty+Il2sOremlLYrSHiHDDgPA7VHxovpznHxyY
 /bZxJ4GO8fCkoQ/WxEG1yp8CYTIKKPzdZ/ZCnCO8mg/nDpjugH4+/Ng8zL5cZeC06cCE
 BYYfZC0IRNMhlfOz+Q7JijrvMYd8bEKvTln1YOFkbdeYqFygeu+XswplONRkRI007PS/
 jXjMR3NTv2A7V8O9uA7YF2IT4HHucl7Tc7Ba4E47oQAucuQZyJ3iEWRQpMszbestTwpG
 L9K/TZwwyOFGdTlQdwmnf9hxhSuLDI/U3TzK36FkUIrGW9DyE0SQsvk9bNZuPcEl4rZe
 IBFw==
X-Gm-Message-State: AC+VfDxr/jmQOq93lRAQkpb0uW8T+iYul6oQY6gB8FoGJlHWHlMkraJd
 dJNhVASqBqBccU91uziVE4YP4Q==
X-Google-Smtp-Source: ACHHUZ4QhpzYG368/WSaxKICyttwswmyHEG9C1w2aCuEmdH/ikxVdr8hysPbZBNMB6JIYnzOHvHOyg==
X-Received: by 2002:a05:6a00:9a0:b0:63b:8eeb:77b8 with SMTP id
 u32-20020a056a0009a000b0063b8eeb77b8mr9669934pfg.13.1685588580813; 
 Wed, 31 May 2023 20:03:00 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a62e707000000b0063b7f3250e9sm3970360pfh.7.2023.05.31.20.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 20:03:00 -0700 (PDT)
Message-ID: <1726f0fa-989d-b853-92f8-2c5473767de2@linaro.org>
Date: Wed, 31 May 2023 20:02:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/7] hw/arm/xlnx-versal: Do not open-code
 sysbus_connect_irq()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20230531223341.34827-1-philmd@linaro.org>
 <20230531223341.34827-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230531223341.34827-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/31/23 15:33, Philippe Mathieu-Daudé wrote:
> The SYSBUS_DEVICE_GPIO_IRQ definition should be internal to
> the SysBus API. Here we simply open-coded sysbus_connect_irq().
> Replace to use the proper API.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/xlnx-versal.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

