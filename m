Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BAC83216B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 23:10:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQaZq-0008WK-K9; Thu, 18 Jan 2024 17:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQaZm-0008Vz-1O
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 17:09:30 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQaZk-0007fB-2b
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 17:09:29 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d5f56912daso827865ad.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 14:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705615766; x=1706220566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yHUXJC5CQRdX/VA1kt2X7TkqIQIo4nsq6BbA3pVr68I=;
 b=B4UoJKnoBOQZIl6A2wGHKFwD93ks7XkwRzQqs2XQ3Rv9am3MbjBBxsHZWA12/3UENa
 H6n8B9AUfjv2tYgu6vwwqJ+iuFV0WKkol1ZmrjiMfBF2tz7l3TrTLzOTSAhkO1ZmIX4x
 Af2L4wMoNptQoi0TqB4YIQbkvGMHuj8BAbrBeEVWFgosZOuLO9h2QiILCMwufHtJSSf3
 ARkSjt7cD+Ms73ty/wfd6jrqwpmI06TE3LpBc+9pAz8apgUrC3cjEq/pZKbNiGPyzMol
 HMrMVBOy4MM6wMKx+vvR9Oa2QT9iGaQ0LGUhvfErjg3qlS9XP9LWp9y4nvBk7JOi4Lzn
 Kagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705615766; x=1706220566;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yHUXJC5CQRdX/VA1kt2X7TkqIQIo4nsq6BbA3pVr68I=;
 b=iKTEpoSvjMUvDFm1GTv2srZrUFJ5ceMbY4KS7NWn4YGW0Gv+7wXxjE5e+5XBUIAF/k
 rUtgVg0aUEkMI8ojldocSzvguW1DlFwCAQATKXxw3RQxyr7alBhT8I30ytN2XpC6qtof
 NxxTm6cppeOD3kYZsECm2DbTlOjh3xYBxQu6E++SH7Q3vIpIIXWDN8EzUCrgO3a/FNgt
 MK5qJ2NdiPSCgLXWMqdMlVvyzkQz8gG6XzKNvjGgi9U+oFWQ2UZnSkoRViJukrER530J
 WZjn+BRPqHbGc5WttIRKl2AA7grhvc2rHbhrlkp9dx0K6gbEQ8yuauzXKgNYA5i0inQw
 IvpQ==
X-Gm-Message-State: AOJu0YwKjLx6xpi5k5aVnDEF2f8VSJ6Lu5aDQqkTtXROmLObLO91/9nG
 CitIIgADth+Wee7MD7Fv6zpLcHLEp7KomuwyQUePFMeMQYNu1dXyCJ30L6rdQVk=
X-Google-Smtp-Source: AGHT+IEBeYsZTrYEnDdQnj2NPoftglEZJHJ9YCGl8eDep+9CWWz1loscDCvww0GEci+8yzZWurjEgA==
X-Received: by 2002:a17:903:11c8:b0:1d5:ccf:3597 with SMTP id
 q8-20020a17090311c800b001d50ccf3597mr1845542plh.42.1705615766114; 
 Thu, 18 Jan 2024 14:09:26 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:321b:4bd7:3071:22d6:a756?
 ([2001:8004:2728:321b:4bd7:3071:22d6:a756])
 by smtp.gmail.com with ESMTPSA id
 bf2-20020a170902b90200b001d4f607ab24sm1822426plb.205.2024.01.18.14.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 14:09:25 -0800 (PST)
Message-ID: <f8d6fd3e-07c3-4f8f-a4b7-d3e08d94aec0@linaro.org>
Date: Fri, 19 Jan 2024 09:09:18 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] target/ppc: Implement attn instruction on BookS
 64-bit processors
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240118152523.178576-1-npiggin@gmail.com>
 <20240118152523.178576-3-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240118152523.178576-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/19/24 02:25, Nicholas Piggin wrote:
> +/* attn enable check                                                         */
> +static inline int check_attn_none(CPUPPCState *env)

Don't mark inline ...

> @@ -2150,6 +2170,7 @@ POWERPC_FAMILY(405)(ObjectClass *oc, void *data)
>       dc->desc = "PowerPC 405";
>       pcc->init_proc = init_proc_405;
>       pcc->check_pow = check_pow_nocheck;
> +    pcc->check_attn = check_attn_none;

... since it is never called directly.


r~

