Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AD57E5F7E
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 21:54:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0pZD-0004DT-MN; Wed, 08 Nov 2023 15:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0pZB-0004Cz-H4
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:54:25 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0pZ9-0005Ae-Vt
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:54:25 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4084b0223ccso449065e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 12:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699476862; x=1700081662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jxWM5gghNMTyNCmQetEsuoBMrwfBJUtbiH+7K8iHtVQ=;
 b=UOOttCP4ltlmm4sdg2BZLI1GVzw3gdOJ40cWqVM5au2gUEza+nJMNrgAgdnvSzyAu6
 slIsM2dE545Qi/ijOZnnaa9jTnKARWUgCV6wN3JUwLEFcGbPsrESRWWW46NCSr5d/28K
 A70z/f+mT+nwqczc6/cXGQacfYCGTdWB+FHd1K2Sh30nag7H8IkEAT9h+g4zTAytO7wg
 ErLkDVZjLQL2Fup6dEPMWCBRJBk5fi4XVN0nJydXo4i4crq/AxzV6+nb9cAS6LMoJh0r
 BBPu3v53VlVcmPTho2lpYRHfaKDbIS1f0WhELikwCUowwCR+UMBognql3JkTLi/OEj6c
 DcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699476862; x=1700081662;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jxWM5gghNMTyNCmQetEsuoBMrwfBJUtbiH+7K8iHtVQ=;
 b=nOUbIka5Npaf53QFb1UIfTGNhRqDLVaRhm5LboY3rPQe1IrlbwFw/M9+kThMkKmAF/
 qFgPoYckG865Xhbb5TF250fYupDVIxBli92NH8rHQ6MohCBORFeSZbvu8qAoct+84ATv
 YzfEKdRR6lbj35X9fBxjnhvVG/ysLta6x8WKU4IkfGlBiJpYxh2uYgzvDVrVnvCYlR9d
 ETmOGhDDj8Ik9e+ERjG6nD+qirF5cXYOEmoCYVzkd4Hw7lsb9nuSP1bdH4jtWkL+aYWN
 9xnh0PrL4y7TPTAIxL/lzRO79Z1aqe8vTNxpLWhA5GudV1L5yI2Raiq/2WURjzC1KMbL
 VPwQ==
X-Gm-Message-State: AOJu0YyQTB/QIUiTAdQzgvPz2CD2s9T0SEYr0zT3JAQZiIiNsoyHI3M/
 XdIx6gbVkqOxgIRn/dYKIIHv48KEjYBQeUntY2w=
X-Google-Smtp-Source: AGHT+IFKb0MhnMbQPdZvyC34i+VgI0LpdUId1iln1H8b8gKQXkTrTWGb12MQ4virwUJfhrhQ22qdpw==
X-Received: by 2002:a05:600c:a4c:b0:406:52f1:7e6f with SMTP id
 c12-20020a05600c0a4c00b0040652f17e6fmr2959737wmq.12.1699476862427; 
 Wed, 08 Nov 2023 12:54:22 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c3b8500b004064e3b94afsm20771584wms.4.2023.11.08.12.54.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 12:54:22 -0800 (PST)
Message-ID: <416c160c-d973-45dc-8bbe-5a4645819cd6@linaro.org>
Date: Wed, 8 Nov 2023 21:54:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/35] target/alpha: Use TCG_COND_TST{EQ,NE} for
 CMOVLB{C,S}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-34-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 28/10/23 21:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/translate.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


