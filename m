Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD0580DF41
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 00:10:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCpOd-0005Qg-9V; Mon, 11 Dec 2023 18:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpOb-0005O0-QL
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 18:09:05 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpOZ-0004IZ-Mg
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 18:09:05 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5be30d543c4so2901815a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 15:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702336142; x=1702940942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QfhNWbmoXN4Gnyw9XxQzdHQrwd2hN1K3fA4Sp2YTG6Q=;
 b=rsZb6/Y8toGvhCOzXwJlruXO1BEU7KDIit1N8g1oI771+nn6OUogNBVazj0B7Jy/2J
 6Qb8KqtRiLtv/jOwA3aW6xLErtGSwTKjqNHTG/eQy/F+AOk6n5ccENDO7HmgRHPIc00K
 MEAriM/aGvu115phuEpf1YNjAqHd9BCffaP+2hxXLiNbGtZu3DV5bNkHwd1cgoYj9Kxz
 OPz7ksaN6xyKXAlVE9IHiojwgpXzqvKDm0icTYe/tLXSwX86WcKUouaVtqRjh2UAOClV
 avEkbKOxPc40v2zAWfxzLzOO5K23dmPC7H5ooGy9GS+yE9ec8DVnpG311heXvqeIc1pc
 p3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702336142; x=1702940942;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QfhNWbmoXN4Gnyw9XxQzdHQrwd2hN1K3fA4Sp2YTG6Q=;
 b=TWDxyergA4oYeJlD0tdkgLenn8cTqE5oAOv/6Z6SjQWJTKYLYTAQ8iOAc87KU0zonH
 n097tRJ++3S3MtkVsZ1l5+Mr3qXJc7stnv63uFxPeMDgm2rFSz68pbzV7QrgVFHHBhqc
 AEM3MW/2Sz/taOD8z2uY9b3SBX4fQqLaV99iLZHhSysXT99174GaT9Ytbxzdtikn9+KI
 tw3Jc87VnU5tVdCJpRsWW+5O+8PcvNt95Rr04JBNF6SgE57pqnfm3Li77l4y65odH/Vx
 mfj2wi7sq+c3HeyE45DnqYsRdATA51tu4RFYVzUywUC5VcpJo775q5CklQ3NJNOXAG3M
 hl5A==
X-Gm-Message-State: AOJu0YzYOinZAakeBtR69HvNe2dPGMSYsIrXsvVCrLQ3p0FeLVcnh8bS
 Mp6Sr3Q7icXikdmCbL6+SXd8h/tsSdu3focGpVz38g==
X-Google-Smtp-Source: AGHT+IGROdGKUEgAHJuLlzbbOPCnNxF3aXNvBYfvW+v4CovZJeheQ5J8DSKmHLF+rmcUQ2GSK0f2Zg==
X-Received: by 2002:a05:6a20:320f:b0:190:6d43:be53 with SMTP id
 hl15-20020a056a20320f00b001906d43be53mr2643756pzc.119.1702336141845; 
 Mon, 11 Dec 2023 15:09:01 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 y31-20020a056a00181f00b006ceba4953f0sm7084605pfa.176.2023.12.11.15.09.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 15:09:01 -0800 (PST)
Message-ID: <27b31c35-1b60-48b3-81c0-c18f4debbf96@linaro.org>
Date: Mon, 11 Dec 2023 15:08:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] exec/cpu-all: Reduce 'qemu/rcu.h' header inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-17-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211212003.21686-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
> "exec/cpu-all.h" doesn't need definitions from "qemu/rcu.h",
> however "exec/ram_addr.h" does.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu-all.h  | 1 -
>   include/exec/ram_addr.h | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

