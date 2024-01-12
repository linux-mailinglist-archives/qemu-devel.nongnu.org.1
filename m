Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A74182C6FF
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:09:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPiD-0005k9-Iy; Fri, 12 Jan 2024 17:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPi7-0005jl-M7
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:09:07 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPi2-0001sv-Au
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:09:03 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5cf495b46caso500269a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 14:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705097315; x=1705702115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mhAGi+WYyiV5vR1v5/nJx/H1o7pooXUfKSQgTLQae+0=;
 b=IpbHA8jc+/KM6NM7HAK+FxRv6UiGhZ4/zlfFtaGp3S8rnI2gCWR3ZZKxmRCMEKUQEj
 lPact/18YYGq5w7Dmb1kRd8Nm7czlBnVpG2fw4E0314jbnVdqcWrsyLSgj5PzWvU/pPJ
 oKpfs6aFvDOYbSsJWqP5neMYDAzPN4epzVkZerU7+QIwvTMfb3dh9ZvRThvQxoD1b1JX
 xoNQFgAC7tPDXSN0ehAbH+Rfftvqka9cPBeZBql/DrS4QfsAO4v1DYXFjW4ECLpLtnVL
 SgdpLOqojCLMC0IKjWGQ3JL9pkOk7ZoxpteG+8QXEHeB7AbZumqB18kOxpG8rtSHn7h/
 MtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705097315; x=1705702115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mhAGi+WYyiV5vR1v5/nJx/H1o7pooXUfKSQgTLQae+0=;
 b=QRCC/56Pa8myWri2E2Rosbh2ORVJiov5BoZ8hzdRpItl/0/608nPBAsOFv4vYXUJxw
 S2QFj1+i8MbB4oXiP77QrKt0dQXNVs0wwnDHEs8Z0II6kwJz1tcWepCSq59ki9ytH6d3
 8AiFxqwcZD1qF564R8X2VqNgXar80xPYQUtyi4k1L5KuEf+UKlJGANNg0RuVNLB/07XC
 0b+x+b2tua2pvP1slyxlj1thWj4xovxof29jDwuVoZWT8vS2+5KdIFEmRJCPDfQayAK7
 FpyIh4b/qDenBl1avvXx8bDPDqJoYd0da5JNgQcmMDlf8+SLJHfNEYzYHtSudJvYR6M5
 6fCw==
X-Gm-Message-State: AOJu0Yyw8qm8kkl8seY5qvOHG906ok2lZ4KbuiGUys0Q4AYpIY2xxY/W
 mbXqH28HDd+yEX+MWkIvjX0enel/sF/gTU06uYbjWr95oIGrfA==
X-Google-Smtp-Source: AGHT+IGzWa+FQ3rilwY71uM7ZXGeexmrTd7KDcQfTMP19xT/aKqRuvBzrZw/W6j1hwBhLkcjjaZ3BQ==
X-Received: by 2002:a17:902:dad0:b0:1d4:3d04:cdd with SMTP id
 q16-20020a170902dad000b001d43d040cddmr1141378plx.32.1705097314861; 
 Fri, 12 Jan 2024 14:08:34 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a170902a60d00b001d4b73f60e4sm3641032plq.149.2024.01.12.14.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 14:08:34 -0800 (PST)
Message-ID: <8f278bdc-d12b-421b-a3c1-99d68820cc49@linaro.org>
Date: Sat, 13 Jan 2024 09:08:31 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] target/hppa: Export function hppa_set_ior_and_isr()
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240112102927.35406-1-deller@kernel.org>
 <20240112102927.35406-8-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240112102927.35406-8-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 1/12/24 21:29, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Move functionality to set IOR and ISR on fault into own
> function. This will be used by follow-up patches.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   target/hppa/cpu.h        |  1 +
>   target/hppa/mem_helper.c | 23 ++++++++++++-----------
>   2 files changed, 13 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

