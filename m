Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC7E82FAFA
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 22:45:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPrEh-0006bI-Pj; Tue, 16 Jan 2024 16:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrEf-0006Zn-Cs
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 16:44:41 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrEd-0007L6-S1
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 16:44:41 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5592d1bc4fbso3114607a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 13:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705441478; x=1706046278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RvMiuFysWpJjqixnibe0Kb2SDcSwodPrxUFnIN3HNJ4=;
 b=yjkLVp5o3OkGNDVd24OJmgbB8JnuLDzBbYKlOI/1flHdH7OrY6LhqC2nyS2qcK5+n7
 ewba03G8R2fOUuhBIab4qmoj3L9LwBozQNppbcqs0OU4jrkUnY4eZd0k0AcZjl+du4fi
 tWUIYMUrBeGGiaBkWIK4cdidDFq7lffS1tyJ3WZKF+xQnlmkPmmqrkrX64yRjTec72ZE
 ohURCw6Ji8pw7Tul8oDCqIvlMyuJg85mGrZXj8Vh3Haw/nqh6qsgykaQCSQODsf+feyC
 m+qs6jlpSF+sOXkbjwuHZcX7qpgIhEL5OP0IWBKeL5Wf03r25gdENTe3NHGJeeJvBEE4
 3p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705441478; x=1706046278;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RvMiuFysWpJjqixnibe0Kb2SDcSwodPrxUFnIN3HNJ4=;
 b=mC4u2nE0FQDQzmqVyjc9ah0cI5ZCYn3DQJwkY0KxOpiEv6dFhMQRMxNItQYnB/NijO
 mPLTu46cc+z+ziryVJRN+pk4CXfLG7+3izi8RRJQRv2t13o4ifYXIQNl3lDzQQJINmyf
 l1yqsEQrWjM9pjm8+pXRnjI9hVzcnsO0Oeb45PyLMrjSNs8ORAF0dPqgATsxdFX1gxkJ
 ABKYK+lhRjnXHhMKDBUVpsjLUZhL9XKwEekSRo3ScMjTfZb4upzceUDY4kbDwCxLbfji
 qXLZCTlqFI9tRtxKWUMQJqOhJYn6JmF4CEbtf04T9ZKXvuZAX1f7OxzM9DmcOoEHZ5pD
 vajA==
X-Gm-Message-State: AOJu0YxFjbFnfLC9RL8jjxXwJQNSY/Wju9FLc/jiohJ0dAkO5y6zXiIk
 hYn7Vhr375JNQc8KwtR5/4B+mLA5JuCulyk4UpB6sRkJBvY=
X-Google-Smtp-Source: AGHT+IGFm3FNLG9Afws9msqYb9JgPVzQ8c588yrWtrGNfPqI0Du9HZWRUKKY3gWUg2P4K020+qKDiQ==
X-Received: by 2002:a05:6402:308e:b0:558:f4d6:e8d5 with SMTP id
 de14-20020a056402308e00b00558f4d6e8d5mr2784775edb.28.1705441478240; 
 Tue, 16 Jan 2024 13:44:38 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 ew3-20020a056402538300b00558a1937dddsm7079218edb.63.2024.01.16.13.44.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 13:44:37 -0800 (PST)
Message-ID: <3aced0a5-4b8d-4f0d-9d2c-cfbcfb5d8dc6@linaro.org>
Date: Tue, 16 Jan 2024 22:44:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/38] target/sparc: Use TCG_COND_TSTEQ in gen_op_mulscc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 10/1/24 23:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



