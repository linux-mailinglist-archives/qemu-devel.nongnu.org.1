Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8317793F4
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:11:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUhz-0002Sf-Jp; Fri, 11 Aug 2023 12:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUUhw-0002SF-Ua
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:09:48 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUUhv-0001Dg-9M
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:09:48 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bdb801c667so6136455ad.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691770186; x=1692374986;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oB26QBoLreLPO1Ggyj5LdAQx1D7O5lqPSeheJrZwNXM=;
 b=SBUyiE86rLn5j2g46oazLU6iUHiIJ3mrYZw2dwYq5yeiE02vwP46TpqpFrfj6oSpYm
 4mCSn1Kr0suRdG6JslVNvgESc66kQBFb2jAYeRxv0ecg5eCxDwnFLAFz0bIInS5drTWr
 I4N/Uhp3iU7zdEkweYLqbdSt48mQOaGgZDpNS4x/H931Jxax6QpuDGtoAWoscten4SEi
 oVs4t09dAePt4ns6VvZkpsN8JmRegm+N71Bx6u9w3hgEFYMZpnor/cZB+fYv3OKzy1qm
 rquOUjpPgfjxZrsIOIVTOZ9Of0vgHO9sC70CqFcAKpYG04xN1po/DnNTogLzqY4pi4Yj
 UJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691770186; x=1692374986;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oB26QBoLreLPO1Ggyj5LdAQx1D7O5lqPSeheJrZwNXM=;
 b=Jn6IvqrbuQ71JLXmzhdNVWr22EmyGMDNfgtQiT6ZrpmuAnkSArQJ1Zjbp/+aHT5AV7
 ewSTJ6YRO7dhpPkuCtapYaBfXnb/RnTEhltzKVZb9I25Lo27GmjfJMD2iwYlFHDQxnSC
 wpF7SfPBB331CE65T7XJjKkpK86yzm5oUBTpI15OhFit207WpW4TdgE0YjfRzeuKw9Ma
 RkUhQ5ehr//FIo3BghvtKg6XjQnEHvVsZB06bfBX4UhGPBfWMqJ/DwZtxiwMPqgpWUSn
 vBozzsGpRTQeQGKYYohVC5ZCP3VbRGYgnbk+v50H1OtM8k6ISc5cOcBFwVSRIiBUZyG0
 uNqg==
X-Gm-Message-State: AOJu0Ywxw4cWVUAXqeHjBzQwAGAntX4SLI+H1+/Hj1A6ZPJjRXVbYY24
 7mZsCZ2dNt5TGCN/UGeppcqUwQ==
X-Google-Smtp-Source: AGHT+IF5sz85WhggRs+PFC9k6fItlA/WciU9el4b0EeiOHgMWIWQM2t3ENz5levR3TJcd6RjfxzLtA==
X-Received: by 2002:a17:902:cec3:b0:1bc:c82:9368 with SMTP id
 d3-20020a170902cec300b001bc0c829368mr2694008plg.32.1691770185875; 
 Fri, 11 Aug 2023 09:09:45 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:e773:351d:2db2:8a8a?
 ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a170902864600b001bc56c1a384sm4079651plt.277.2023.08.11.09.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 09:09:45 -0700 (PDT)
Message-ID: <64439183-7776-c8ad-59fe-28145a69a5e4@linaro.org>
Date: Fri, 11 Aug 2023 09:09:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/8] target/loongarch: Add avail_FP/FP_SP/FP_DP to
 check fpu instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn, c@jia.je
References: <20230811100208.271649-1-gaosong@loongson.cn>
 <20230811100208.271649-5-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230811100208.271649-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/11/23 03:02, Song Gao wrote:
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   .../loongarch/insn_trans/trans_farith.c.inc   | 96 ++++++++++++-------
>   target/loongarch/insn_trans/trans_fcmp.c.inc  |  8 ++
>   target/loongarch/insn_trans/trans_fcnv.c.inc  | 56 +++++------
>   .../loongarch/insn_trans/trans_fmemory.c.inc  | 32 +++----
>   target/loongarch/insn_trans/trans_fmov.c.inc  | 48 ++++++++--
>   target/loongarch/translate.h                  |  3 +
>   6 files changed, 157 insertions(+), 86 deletions(-)

Since the manual does not explicitly list "basic floating point" vs single vs double, I 
can only give you an

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

