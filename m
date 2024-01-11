Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8256782B6F7
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 23:06:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO3Ar-000358-7C; Thu, 11 Jan 2024 17:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO3Aa-00031o-BP
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:05:00 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO3AX-0004sy-Ve
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:04:59 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d3ef33e68dso41295585ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 14:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705010696; x=1705615496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e1joFAJW/0/8RZrXhHsRgdQeuHcbfY5horetVe6u+Gk=;
 b=hhpfncBnPCgyvjMhajMlNtpGmfIDfjqO1fmWPNJGq2t0n7bMXicuBxnQoU7rCexTbz
 2hWAyZtFpWsmipXIuBhKdhgg5/6uhKQCfKrt1RFCGYHEAxlIehOlDy5b9qNmWN4pmGB/
 GJuU5qKpCp6i0Q4NPCcrDFTxHc7YZvJFK5nGmj2Ft6BMyjGlGs9ObyM12FXUxIgf8PZI
 qAUu22PChWxud00sRJ8d2RdcirnAV0k0hNAdyqcUoQYbsJMczL6qF4sbkBsy4sBEA2qT
 nP5QoozJvuAE9nvdjPgsX5AXRc3JcTTVQvLdYq6tq3JR7gAraLmhokEtq4kEanfc4qCX
 nOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705010696; x=1705615496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e1joFAJW/0/8RZrXhHsRgdQeuHcbfY5horetVe6u+Gk=;
 b=Qwc16Z9UKpee1MlvdD/PhaZ/XZeC6X6056dqs2o43SKtLbBajJO1PRc8UsEIGAMb5r
 2vMn6pjzksW2JmVd0LakrLR3HrYYzcGX2UAsuqfEX3PWn5ac1AiLAZtdifPUJVLRTrrV
 O4+m+77FYwy18WkN+CObodkheGhrpyCYLW8Q7fmV1lrlngZOcBEZhwPIyBuSqne/yJbB
 DMu07iunFA7iD9st9a7TWqaaqludYwCPOjAJlhYBixCrv9TvEgTv4xK13WBr6YTrLuOO
 OK5qYgzQORusgTyFYD+Q/RYVtCy+oTFIFmetE48xKlyG38gwNuPuWUYFiukOFXgmyd1S
 UOjg==
X-Gm-Message-State: AOJu0YwzM1UUq9NNzBvvAam6GqEWi3nxbPNVgttcyOX9FUEExWB1jSYW
 VdaMDTaVCrrLnzicMoLCcQ/53TFlFSLIig==
X-Google-Smtp-Source: AGHT+IF4XOeTkTRlnnlCyAFUQtS5miFWkHU4ULK53ICnTX3yTw/Um4vS2F4QQl8GbgoWm2hBaAvMDQ==
X-Received: by 2002:a17:902:cf4a:b0:1d4:cae:99f9 with SMTP id
 e10-20020a170902cf4a00b001d40cae99f9mr822904plg.45.1705010695747; 
 Thu, 11 Jan 2024 14:04:55 -0800 (PST)
Received: from [192.168.5.64] (180-150-47-34.b4962f.syd.static.aussiebb.net.
 [180.150.47.34]) by smtp.gmail.com with ESMTPSA id
 ka8-20020a170903334800b001d4910ff835sm1651470plb.3.2024.01.11.14.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 14:04:55 -0800 (PST)
Message-ID: <76fa391a-9f3c-4308-a84c-2b84ddadbb88@linaro.org>
Date: Fri, 12 Jan 2024 09:04:48 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] plugins: implement inline operation with cpu_index
 offset
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-2-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240111142326.1743444-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/12/24 01:23, Pierrick Bouvier wrote:
> Instead of working on a fixed memory location, allow to index it based
> on cpu_index and a given offset (ptr + cpu_index * offset).
> Current semantic is not modified as we use a 0 offset, thus inline
> operation still targets always the same memory location.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 60 +++++++++++++++++++++++++++++++++++-------
>   include/qemu/plugin.h  |  1 +
>   plugins/api.c          |  7 ++---
>   plugins/core.c         | 11 +++++---
>   plugins/plugin.h       |  5 ++--
>   5 files changed, 65 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

For the to-do list: add mul -> shl strength reduction in fold_mul().


r~

