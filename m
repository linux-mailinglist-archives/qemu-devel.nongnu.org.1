Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B7F722632
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:45:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69a2-0007q0-Bw; Mon, 05 Jun 2023 08:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69Zm-0007j4-Of
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:44:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69Zk-0004vR-Ko
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:44:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe934so41274375e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969078; x=1688561078;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8RdyoIz+4bZblgb99LiA+p9rogtj6d/k4kRwoydNRLo=;
 b=CUxI7M8Vj48qmA7zA0Llsuw4dit1IWLrkoYlQ7iYIfOHX7sdMFhGz0MV9bA/AcslEQ
 E+R6eYk4AGx2omb3cFJ0+wuPVXlSGN55ZFKukBXoPCHy1ZxTEzFcfJKXhzAQU3tQGgjb
 DprnzSl/w9kN+QH4lIne1sIn5yww2dS5ZR3BHK+2SjhEda/7zMpqfy1m/FgIgllBjcbP
 VloYdgekm8ma/qdYj1/+7nfDHzoG0aDclk7eOXQKTNHQMvrBAeiFxEiqV9W4yDQBZJ6+
 DdLjDlygaML/roPAp/oAOK/Kz6cTqhoXnfU6Eov1ljqvjmYXUD51d4v9XHeSj+UgRc+t
 wvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969078; x=1688561078;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8RdyoIz+4bZblgb99LiA+p9rogtj6d/k4kRwoydNRLo=;
 b=YvpGlS4rN2bUPSGpYOn8YTsqFiJg29FCAmR8uwm89w8Ia5ynUcKw90aJOpUb5om1q3
 DRhf8cbAmql9jkQ7GY2E6VqczPvv3rRmoOebMb7gJODypDx+M0E3a8vdDrL6VuJ28IN/
 QObEVFkqJIAvp3hqiii9+s7F5e4ikp8NZES0WIqakm0uX71Of4OBD96LAXoe9tA40CtV
 1YRQHrQjd30v6e9AN7Z9AlQUNPUHNmmjLzLom5zjKd283oPkq1e94xK+LvzPS7RyUafG
 vLkZEKWg6eAPLFWI0XfBknffSlV8iZAZ0DdIU0NZP2VrbXUPaEseFbhmOQCas1dI813Q
 n2JA==
X-Gm-Message-State: AC+VfDz3HQF/4Y9NQ8IJ1fiqPkNuKxX/rqxuztyDQnTCVOZzj7r7IuiE
 KvzeavZfxrW6yODSo2o3mGG2Sg==
X-Google-Smtp-Source: ACHHUZ4yPADxjjVGNL82Eeuf0lo608nLZwSxLZq9YKDXAqmqbmnbszlD9JaZEtEuEyj5/fOZku9XqA==
X-Received: by 2002:a7b:c44d:0:b0:3f7:81e9:2f02 with SMTP id
 l13-20020a7bc44d000000b003f781e92f02mr2182708wmi.4.1685969078209; 
 Mon, 05 Jun 2023 05:44:38 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm9698565wrq.89.2023.06.05.05.44.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:44:37 -0700 (PDT)
Message-ID: <64f51912-d449-b3c9-ea6b-c6c5c32441ca@linaro.org>
Date: Mon, 5 Jun 2023 14:44:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 13/23] hw/net/dp8393x.c: move TYPE_DP8393X and
 dp8393xState into dp8393x.h
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-14-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230604131450.428797-14-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/6/23 15:14, Mark Cave-Ayland wrote:
> This is to enable them to be used outside of dp8393x.c.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/net/dp8393x.c         | 32 +--------------------
>   include/hw/net/dp8393x.h | 60 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+), 31 deletions(-)
>   create mode 100644 include/hw/net/dp8393x.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


