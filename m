Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC9839E32
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Jan 2024 02:24:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSS0A-00045B-2Z; Tue, 23 Jan 2024 20:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSS00-00041w-FN
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:24:16 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSRzx-00036i-PD
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:24:15 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso3526375a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 17:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706059452; x=1706664252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N/sWT9OhmRADi08c5CWgU8jH2w7OHrcforBmTLg1c8k=;
 b=vAXmqsD+FP/NRoAEs15vF3WxkT7NAR3aPInttA3ex4+vQrvuLHHwIPH3+3UwJiZS18
 +ACD5d3Yt2stsY5tfSPxjEsGwydUOe3nJPS10qTTyyTDxRN3lsJYCLtatXf+UqvQgyjf
 GshOvr02gHRvaaCkTr6CQZWnWWw7NZbBdB1ND43FHYcCKoicCl90blXQPESwLUS8Uc0b
 ra0F/HhI6EMLS03L7MFOhETf7We3RX/N6MKY083SVrCGIzHMsUALJHzgLwW4/uzG1gys
 BwHKBrorknFDZmJ/kC+ElUVgoIUgBMQzaX6192IilgvDoP4hMMQ4GZdYRgkQ4egeFlf+
 ZpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706059452; x=1706664252;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N/sWT9OhmRADi08c5CWgU8jH2w7OHrcforBmTLg1c8k=;
 b=ig/radvJihqqPQK+7WB+rYo91GpF0iW5f6Ee+v5o/ZbbYQzdpVXRm29s4c9hVONnBF
 i0+fE44bXiwlWh0ndVkF4zTkV7mv3ml+jBCk1qsKzBDcXybrMwtWEdq3Gb7skiVIxNhS
 dHTLg/Kdif09Lq6yM+JRcjWyhdyRC3jsLZWh8fVNQPzau6bCY4a4tG+CuRbWkg07I7/f
 Gz+K6Vex7fqY5zD3TsshG7eYT5uMM8WpT2OMQVwhfZCirRp069jBqwhEJbqL0q/DEpLf
 vG+t3MdW2opYSgehRRqA0T3/nWHFWF8mEGMUAfnaYpgsfYg2PGzr7Sgi2u1yFYxQyodC
 E0jg==
X-Gm-Message-State: AOJu0YyKXldgJGqpHFlCQMCww255u/txy3tD/LoH2jghrFFUpXLOIIno
 xp9XOf33LbsPBGV6XVkWh8/suotEpvLMFKuy7hTqCPH19VRbhtqCVYakZKIiNJs=
X-Google-Smtp-Source: AGHT+IFzeOOlCTW9sQTfUbpbMyf0nEZMY8OnxE4iSdRwLsQw2Ei4i5qrgo54riw5n25GiwLh9nVkQg==
X-Received: by 2002:a05:6a20:a8a9:b0:19a:b7f6:7d5b with SMTP id
 ca41-20020a056a20a8a900b0019ab7f67d5bmr94652pzb.103.1706059452220; 
 Tue, 23 Jan 2024 17:24:12 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a635314000000b005d4156b3ea2sm1099201pgb.93.2024.01.23.17.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 17:24:11 -0800 (PST)
Message-ID: <ad27bb5c-1de2-4614-b80f-56fe83a8706d@linaro.org>
Date: Wed, 24 Jan 2024 11:24:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 22/34] accel/tcg: [CPUTLB] Move
 CPU_TLB_DYN_[DEFAULT|MIN]* to cputlb.c
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-23-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-23-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> These macros are only used for softmmu targets and only used in
> cputlb.c, move definitions there.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/exec/cpu-defs.h | 3 ---
>   accel/tcg/cputlb.c      | 3 +++
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

