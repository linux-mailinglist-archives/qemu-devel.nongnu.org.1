Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE534718467
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:12:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MYb-0006UR-Hd; Wed, 31 May 2023 10:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MYY-0006PX-Lh
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:12:07 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MYX-0008KH-2C
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:12:06 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f3b4ed6fdeso6432595e87.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685542323; x=1688134323;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8n8aFRX8bqggUsIoutNjoOm+pvrdg2yibL9DY7HKVLo=;
 b=YNQuaT1MfuIgflhQxaCS059QODEYzqoa7xHofUx7+d3X3gdfRI7+VnG/wONSWwyQI9
 hIgH1nHuPQjKcY9Yq30pGOCP8ibEYem2f9gGJ9G8e2ktsZzU43pFK4pWDouDPRY671oQ
 LMxiz18q8GijZ4OptfInKzGSNJX4+yshhHMWl9lzmY9OG9925rbDeS6xkdZUHZOZyobB
 kZmtCQsrh/mAeUzPJIMksLhci8PryRYfSqcUxl5oEfAl0TArF3xUJOKeWVv5QEG0n34Q
 1wd55kF2MB+gHf10Vqncuf6SM76fOoqz55Baqe9qtTQwELOUgS8BM6UlX08PEQA3ZTx/
 ktaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685542323; x=1688134323;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8n8aFRX8bqggUsIoutNjoOm+pvrdg2yibL9DY7HKVLo=;
 b=RPOwM9HJGSelgi3KNLNgsvxdEpg9LtOyL4P/AsjBI3nAfp5SNltGcTRnCKVm8jSKVY
 B7aHQU1jxbwembVtXY2vE+JgGh9msDfJVbXEelTOgfQjcS3ZD/vsYwGpGYawgoLaXwzX
 lR57rBv78aimSa5LeErYqSf/8q/vdU/lk3trLOfrfZcNSHwY4VyfGAnfRO4eJdczkmQc
 3h9jOFpXtu84I9/Rad2rpmx/ww0/S3JRB4PBG4LmGq5iuaIVvKHSsLVGK0//k1GkAphe
 DbkzUWfNzPnEePhMh6uTPmVESjhPdq5nAH8EveFBQ7vQWFF9J8ml4pZLbDbviJy+tWSG
 xrbQ==
X-Gm-Message-State: AC+VfDz4QWQpRtTm27SjvnnoRk9xwtZNS4DpAkpTaWO4rsXzg5BDQDE8
 ViiFESaFK1L4vAu5WJ4AqMa4hg==
X-Google-Smtp-Source: ACHHUZ6dwWpw0GjTWq56GjwTXB+Aw0jc+8Ju4UXQKk8vZnJPyDwSwYUYuKXtBsKpkxkfCh2UWSWswA==
X-Received: by 2002:a19:f601:0:b0:4cb:280b:33c9 with SMTP id
 x1-20020a19f601000000b004cb280b33c9mr2787972lfe.24.1685542322700; 
 Wed, 31 May 2023 07:12:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a1c7505000000b003f6f6a6e769sm14622401wmc.17.2023.05.31.07.12.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 07:12:02 -0700 (PDT)
Message-ID: <0ecf2156-18d6-fae5-269e-01c48238a526@linaro.org>
Date: Wed, 31 May 2023 16:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 04/48] tcg/sparc64: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

On 31/5/23 06:02, Richard Henderson wrote:
> All uses replaced with TCGContext.addr_type.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target.c.inc | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


