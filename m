Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58147B167F9
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Jul 2025 23:01:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDup-00026T-Bm; Wed, 30 Jul 2025 17:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDZk-0005o6-FJ
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:39:01 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDZb-0007WS-HT
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:38:59 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so265842b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753907930; x=1754512730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ifr2/N9JDfuAYJkj5xeTJ1eEcAUBRgJgoDwBo3ISkeE=;
 b=JvrZukI8QYQivyNonp9Nt1UmrMDa4GEXz/BcRxBt6WMWOGqnbu8mMUSskiBOeKr1pZ
 m4httvvQtX24xxT7hraetJiB3vXT4mR7KbDZeD9HEdCkXb6W7m5VspBcwf//JrVldFjt
 MBU6xIvOH4v0+/IgywbuQPOZBQ1Dx2ShMBaYo3e2X91hj/675osBb4OKtnvMBwGWfZV2
 aKTIhePinjUQTfIoRwmWfGAc6/8rC2isuW4AAEzim/IXe/ZYFE6pTcPe7B6db8N3Syky
 wnpgpNJPDWqra8wOC1Be2usg7YL7dWjkiQSK0qLdpQTWq51N4Q5smvSLZgvZH6vMXpZ8
 k4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753907930; x=1754512730;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ifr2/N9JDfuAYJkj5xeTJ1eEcAUBRgJgoDwBo3ISkeE=;
 b=nWOFiteHXwWDebGOWYJxX1PECU0tqkpFSDyRHLVNAZbFwkkTNLae7FOei1vTx6MSdT
 4XfO5dbZJzYZpNi/b77rNnTi+thpWTtJANwKb1f+NZD8ovhpWllRlvfwQjO7QiLDdK3k
 znKqg3NX/eovouQBwkVnDG3osfFb/sCZq33P3sjKJ5eQB3cjZWf80mgLJJTQKjhdEsJd
 q5mFlEOCql7u+wRzQUibrqPaGO92uCQ1jg2hexdXFxFIUxMKWRuQIJXIYuG33B9Fykp0
 qCQZ/FZuW5Cof4mcVvDVcw1MQ5xWPOOfUZxNnJoombLI2jLjIvwDGvjCl08z4P+2uOq9
 COKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8Kbk7HjSVVDtCKP7WOceWuZ3Kiqlqp756s9dy9SxdZHHhgHrLG1OayEzh8j9220EtVNxQNMujssuK@nongnu.org
X-Gm-Message-State: AOJu0Yx1jNKrLbo5BZPcd3n+jFZYB8wk1fEmB2R1v5HJB7QGU+COo3FI
 i2qyWfUu/bP+kwJoPRjhRP7BgBw+8Gxv4467NCmhyq0eh2bsYrUszC0g5FKhg+5FJfA=
X-Gm-Gg: ASbGnctJSLMkBH2qMJmlj+7ZordEky4razK+JKEJhrp9NPv6WmmSAJZuIY62q2p4uAu
 DcGXvasT/GFC+0oTD4QyL8CN2qVed/tGz4ix6yoFBkqYi8Bryviy9L+ucxGl91Qiu1D53DBMuL/
 SMjMwvKofI23rnfcWdvwgWGHBRNKNFfZVBQ/mWJlrkZZpUHW45xUFB7/ZITUs3X6+nEzGw1QmtM
 In5YBF6qOl+tsQcBkzlMP2vRyI9f08fkRxcXNlZU6wT/xKZghWuygT34Qi5XjbN0OKwzDWn7MWR
 58FHmdK4sE1yTBk21d//D5eNs45cekdAeoQtYY9P3+57DXIvMIxp9CgyXPsZdKGcQMWf6coxKo2
 bXByBxzTu8uWChNVfRzm5upB8oRMG4a+eU8I=
X-Google-Smtp-Source: AGHT+IGMXtRiN+GNULZFB3RamOLlpQuOqyJCvEyNLLevY9IoMW6ve7aeCssXCcnt9JzDrtFZA7FpDw==
X-Received: by 2002:a05:6a21:9998:b0:220:4750:1fb1 with SMTP id
 adf61e73a8af0-23dc0d0444emr8171511637.4.1753907929657; 
 Wed, 30 Jul 2025 13:38:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f58bec0sm10020075a12.17.2025.07.30.13.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:38:49 -0700 (PDT)
Message-ID: <e49e1598-e86d-494f-b07a-bc0f3b8f2c32@linaro.org>
Date: Wed, 30 Jul 2025 13:38:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/82] target/arm: Add isar feature test for FEAT_S1PIE,
 FEAT_S2PIE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu-features.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


