Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5831F82FB71
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 22:55:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPrOz-0000us-D7; Tue, 16 Jan 2024 16:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrOx-0000uW-NS
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 16:55:19 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrOw-0000qf-8z
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 16:55:19 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-558b5f4cf2dso5749478a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 13:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705442116; x=1706046916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LqIxJuFbD22k07FwE3Q+Ir31UoLx9HbVtZenl1/tEd8=;
 b=YXti8tmwjHDCVitL6SqpuF6a5puNORojVL/9LrVh3PdhsZFXBXlIxQbpwsE/6A8atQ
 DYaqav+ccBdISaJgtckKweZrQ3SS9IRKUF4IVXQ95txBB1z3zg8C4poe0fSFVmWLB4Te
 5q82lXtQBgLhhF7TEKx4YutHKknPeFNYvEjQKQNpz+ZRtpOaDmwUe4kv8RJe7rDXbOzS
 tHOe6JuemcslLqsH6ZNA4zE+0Cq8m5sn24LKw009VRe9Fb6YfGyr3I8ujb51FfOwlY1g
 Mr2+YvzgdWAWGHJXtGxgoS+26aACKtRSWA3UKAjtXCMK9MocI2Cn+fKBc2+RNLXinn+6
 lrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705442116; x=1706046916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LqIxJuFbD22k07FwE3Q+Ir31UoLx9HbVtZenl1/tEd8=;
 b=dsNfudaKqyR5lhLwrCJwNXDNY39e6Ixt6Wt8T9axHOiLFJDRGXROqe8Scj+vPKt9r/
 oBf2GCxvAR8WWAisD2HdwWoJDCyfVwuVz5xS3Pg/KZ8eFSCn9XIjWV/DKLmyyzzk12wv
 3+uZBpxDtoRQG1R6n+aOWnI5uZSiIFFdmBmLgXINMkUKvF/oR5t52pIXkDAXksFJqnQj
 IwDakdoiLsYodvHnHCdhVK+oUqQALCmnLb+5aVnfU1y7d7pR8xyG+qvW878CnaExevLF
 qwlzyHtUsLhc4e/L1QYAKsrT8riT1YncH39P0dXiObWnn/iFa17WkIdaVQ0hydsYwoWv
 IQJQ==
X-Gm-Message-State: AOJu0Yw0Skb0EHCypDj/ZAyONYpa1kQwGkueUufufGKS8Lp4ZG6wLtyf
 /ZpagxmTtmKiUUBZ3nbyR3svc2zCfO7n7dijp0vLJVeRnrI=
X-Google-Smtp-Source: AGHT+IFJjBLFdjHZBKwo0GbgLY95fa908v9lsAFRRBSVN6ofYrRXLu2iXPGHndlupia9BaMGHgiKQg==
X-Received: by 2002:aa7:cd62:0:b0:558:5cd2:7646 with SMTP id
 ca2-20020aa7cd62000000b005585cd27646mr4232037edb.51.1705442116633; 
 Tue, 16 Jan 2024 13:55:16 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 ev24-20020a056402541800b005581573e251sm7274608edb.2.2024.01.16.13.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 13:55:16 -0800 (PST)
Message-ID: <499bd179-d765-4f49-bc84-698566196068@linaro.org>
Date: Tue, 16 Jan 2024 22:55:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 35/38] tcg/s390x: Split constraint A into J+U
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-36-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/1/24 23:44, Richard Henderson wrote:
> Signed 33-bit == signed 32-bit + unsigned 32-bit.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target-con-set.h |  8 ++++----
>   tcg/s390x/tcg-target-con-str.h |  2 +-
>   tcg/s390x/tcg-target.c.inc     | 36 +++++++++++++++++-----------------
>   3 files changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


