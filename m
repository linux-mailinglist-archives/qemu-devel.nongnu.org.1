Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC2979FBD3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:21:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfig-0005ns-Uu; Thu, 14 Sep 2023 02:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfie-0005nd-1z
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:20:52 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfib-0001Uo-H3
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:20:51 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9a9f139cd94so79100866b.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 23:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694672448; x=1695277248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o1rop36AMVn+zfjVENo25LieEq70uL//xvcMPBt/KDE=;
 b=mi1b96oo3JO1GgY0Lgw791cxrcehVU4NI+QMz6SSBW5NRpmqfY23RBhbms8Tqhe6ft
 Edtr+Np+Hbu3EhjNfaIVQUowgHDfSXBj+sQyISaF+mrMU4aywE0jmNu4ZoVXJxnm1A59
 vaek5gfXpUzkzgD2TdYWtqffFwl7ghYQyA4S7NldRalMm9Nxjbs89wLD1G5fY3Yn3MOS
 cl3A+ein2oxatb3GrghJbtzjxiMwPmWsVRmAkUQSqSFUgarMOOeVexlGmL815Ej1Tcrc
 1h7S2Ord9al8wNUYqefEpxEO1GyXYbNVRfvfsQaWi6GHiFWguc5C+vLUXe8yaLt4yNVy
 +2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694672448; x=1695277248;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o1rop36AMVn+zfjVENo25LieEq70uL//xvcMPBt/KDE=;
 b=hDV99FmdMRBVMEfXHHlQj1lccT1lhtE8niK/JaP5p4+9cmwC647j23n12YkuwUvc7o
 XcHX2aKQ/Y14EfA/F5vBCjfMhLoM5BKusog9p4gwgRtQ1Bw/rj7CFn1TaJTvqxWJGU2A
 0nlbxjBnlSiCcWGBdtQ1WQAkFwM1Y6GZbI0v+PRUANj3jNknum5xoP5b8iAQ/12kSf2y
 hWouHaMP75q8FAZbKl5ce8U3tTlFZeOv2iwlv3YdmtrnbFgsmaN1gVGE1/iyFCnfRuoX
 PHnD6iVDpltwo/H29+rBmwNikmRkbtt4OHwmfSt/zvsCj8dXRRGNXOBm/1BzXNT+kHZM
 ztmg==
X-Gm-Message-State: AOJu0YxT7/6zS8pT1rgwrlCM+VVZGyjx7JkEdu2hjhOFsliqeKHV0ZeX
 6GBUdCyO5srNjOWaV8RhyRGjnQ==
X-Google-Smtp-Source: AGHT+IGcpaxhhqm+H0iW1J3VxRrO6bRtJx6uhAdaFsqK2WP2y/cL6q8k/SEMA0SBJk6W8ce74fsNkw==
X-Received: by 2002:a17:907:62a5:b0:9a1:e758:fc73 with SMTP id
 nd37-20020a17090762a500b009a1e758fc73mr4100102ejc.67.1694672448035; 
 Wed, 13 Sep 2023 23:20:48 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 n19-20020a170906165300b009ad75d318ffsm523238ejd.17.2023.09.13.23.20.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 23:20:47 -0700 (PDT)
Message-ID: <4ffa33a4-803c-987c-3cdf-4170ae603e86@linaro.org>
Date: Thu, 14 Sep 2023 08:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 20/24] accel/tcg: Modify atomic_mmu_lookup() to use
 CPUState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-21-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 14/9/23 04:44, Richard Henderson wrote:
> From: Anton Johansson <anjo@rev.ng>
> 
> The goal is to (in the future) allow for per-target compilation of
> functions in atomic_template.h whilst atomic_mmu_lookup() and cputlb.c
> are compiled once-per user- or system mode.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Message-Id: <20230912153428.17816-7-anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> [rth: Use cpu->neg.tlb instead of cpu_tlb()]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/atomic_template.h | 20 ++++++++++++--------
>   accel/tcg/cputlb.c          | 26 +++++++++++++-------------
>   accel/tcg/user-exec.c       |  8 ++++----
>   3 files changed, 29 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


