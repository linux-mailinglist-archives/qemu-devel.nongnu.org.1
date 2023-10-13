Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F17777C86DB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:32:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIFy-0003Wx-11; Fri, 13 Oct 2023 09:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrIFs-0003V5-QK
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:31:05 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrIFq-0002SS-LM
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:31:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-69101022969so1857889b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697203861; x=1697808661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mjK0/EF22J+MjBjpmhG9PdbKfbf7dLtA/pUA6JhGNQ8=;
 b=VKr6PJJly8I/+xBGAfSgpIcFk2BgWdJXBnKalzh8m3ZtsG30kq3sBwqpqYQHn6WC1H
 Hve98BJRvR3KzjA7VQGvF4YwY58/foC4Xmw+tCGzEiJwO5d2Wt1SwUuElMCQ+sUFp0nV
 QFhDOVG+9KOJSGhI27XWQku3R1gTr0pFFBQlBJDSpgSbOo9Xirr1D4yXq1Ydpu0nfama
 MmsRfUtJQf2gc+yDav4vXfPMHUy8IokOPQC73HLjcmTc6bdD9S3eE0R0blt0ntW7QUGM
 s7kYuWjavnQcRLFBDlFkpc9cFnch1n5LU7MohWRKpjKUoQC5G9U1IDOus5HgfCF1Gx92
 fQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697203861; x=1697808661;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mjK0/EF22J+MjBjpmhG9PdbKfbf7dLtA/pUA6JhGNQ8=;
 b=TccX04pJTDkNVWPNJMS05PuM2oNia/uT3cKGoCfsGCIGgACghxcqNM8W5cEKEGLa24
 m1wbkC/TueBR9Rqdy3uDFLQfu7wUPIojN/KbXzf9ptduQGsCgV+P5uqQtjJVthzV0XWh
 Tw3Jiu/k7IHqi4CA0eAIL0oAdRoNqd/JcXkzcsD1xEN0z4R1yNAh5UiwjksWxfnZBiHg
 wE8JfHpf8lhzhnyIFSHnauXl3gZfU+SEu0/mB83E0oOGu+ZS2u9yei8FUlmZLRWaAsGK
 +m1Ny6+ER8TK7bY2rknL4yjBwxDps37WN8lBuSNj6nDVb1Tfq9eOjXYGXy5MnA0B1+hm
 h36g==
X-Gm-Message-State: AOJu0Yz75d21u2V1aoTo3LIKtlbDQTu33wgkbj3IfrVV7q4ChDktDJCU
 LVIc8rhJ0AegXLs1E+NRPLxjxA==
X-Google-Smtp-Source: AGHT+IErxOOteRcRwZr8Pj+DAmPFM5qFz9dK1ygviScFsaq2d4yMqMX9+hLov+mD0m20lxRHZMgS4Q==
X-Received: by 2002:a05:6a20:7d95:b0:16b:8067:23a7 with SMTP id
 v21-20020a056a207d9500b0016b806723a7mr25210788pzj.24.1697203860813; 
 Fri, 13 Oct 2023 06:31:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 je6-20020a170903264600b001bbb8d5166bsm3875120plb.123.2023.10.13.06.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 06:31:00 -0700 (PDT)
Message-ID: <7ca0730c-0e48-49a0-bc2b-a07b831f95ae@linaro.org>
Date: Fri, 13 Oct 2023 06:30:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/ppc: Define powerpc_pm_insn_t in 'internal.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231013125630.95116-1-philmd@linaro.org>
 <20231013125630.95116-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013125630.95116-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/13/23 05:56, Philippe Mathieu-Daudé wrote:
> PM instructions are only used by TCG helpers. No need to
> expose to other hardware.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu-qom.h  | 10 ----------
>   target/ppc/internal.h |  9 +++++++++
>   2 files changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

