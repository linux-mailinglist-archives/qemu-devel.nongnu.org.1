Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D73070AD97
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 13:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0hBh-000853-Ft; Sun, 21 May 2023 07:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0hBY-00084E-6z
 for qemu-devel@nongnu.org; Sun, 21 May 2023 07:25:13 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0hBV-0006uF-RB
 for qemu-devel@nongnu.org; Sun, 21 May 2023 07:25:11 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30781184e78so1643965f8f.0
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684668307; x=1687260307;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cGOd7de+C6KqqBn+qFOsd6c4POAn9QXbdMPkg1b2pZg=;
 b=i2QeOwIJnFvbo2ZCf9EXW4pHu0V74ceF+gVPWuwtJYwkzMO4ODb7YXoRx0L9PabbZQ
 8WjhU/IJRV4upqD7asA9Pff7ltZ5nq026eqb5iKe1FIajSBXVTtmvZ5++H9BpCf5KJKw
 RFPgumvw6dHBmKQg/lBUZJ6XVc/GMGanRtSh7aAEbRUHX1uOzTsmMlzvdCB4nQ5IjcLR
 nf3iYG14czrvJIMnpWTAnatR7F0tn2+o8kOY9SsRtw3ENjpN+Q+hOZdT+0h/7dOYkWHA
 wKuCSZUH72oJi/M5zuk81Y3UgbGm5J6nNP5mutaduVufIxkv0ztb60SlxkmWu3RC5Gxp
 H2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684668307; x=1687260307;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cGOd7de+C6KqqBn+qFOsd6c4POAn9QXbdMPkg1b2pZg=;
 b=T7xZbXVGQUHi5KtCFdEBs53NiaaY4wT5vZggLfusoqvQf21LcykXRmsOHROejaA/R4
 jy3c6i70/MPgCyXCIGq/P0NZM1aaks5w8V+tsk+c/SJnpJ41oiFiz1kPwqpAgdyV6t6u
 ziVpbKd4zhQiHbouuETkdvXhGdvvr4c0V71P0IxztU75cIXnvu9ZDLVOog3Bw9SOAwUN
 6/i3ZgdaZjTDUceic565UTj+Utc33KbxaUVCpbCg4YarA5w7Qk2gaiHCFgcPVunRH6Td
 UGMpa4pCVLEbA+DBOQg5XCTNFJ06qCxvV2NpV0mUgfi5sy/dU3okt28aD7gHd+JM53Xh
 bP5Q==
X-Gm-Message-State: AC+VfDxlsxmcG/sFwV2oHLwaDRzHsZ+aGj+SqVxkHReiADSsAOfsn4sX
 Zm8rVqWDlb9cQFqq7K0FOn+tCCTXdlfRVS/Wm14=
X-Google-Smtp-Source: ACHHUZ5lHJ5TQnslLRogQHVlmk0oAXiDUEn+bUlfOKJonPwMAWNY6JNLj5Q3pkNMiQa0qEKdqs3Msw==
X-Received: by 2002:adf:f6ce:0:b0:2f6:661:c03c with SMTP id
 y14-20020adff6ce000000b002f60661c03cmr5493984wrp.28.1684668306900; 
 Sun, 21 May 2023 04:25:06 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.152.177])
 by smtp.gmail.com with ESMTPSA id
 y11-20020adfd08b000000b002fae7408544sm2243082wrh.108.2023.05.21.04.25.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 04:25:06 -0700 (PDT)
Message-ID: <33eb8ef5-d08b-4f8d-5d09-af250e0b07d4@linaro.org>
Date: Sun, 21 May 2023 13:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 24/27] tcg: Split out tcg/debug-assert.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-25-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230520162634.3991009-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 20/5/23 18:26, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/debug-assert.h | 17 +++++++++++++++++
>   include/tcg/tcg.h          |  9 +--------
>   2 files changed, 18 insertions(+), 8 deletions(-)
>   create mode 100644 include/tcg/debug-assert.h

While here:

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -156,6 +156,7 @@ F: include/exec/target_long.h
  F: include/exec/helper*.h
  F: include/sysemu/cpus.h
  F: include/sysemu/tcg.h
+F: include/tcg/
  F: include/hw/core/tcg-cpu-ops.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


