Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 648C2B1B7B8
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Aug 2025 17:40:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujJl9-0003Yi-Qt; Tue, 05 Aug 2025 11:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujJbp-0004Md-6a
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 11:29:49 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujJbn-0000Po-6F
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 11:29:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b786421e36so3263048f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754407779; x=1755012579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b73e4dbI2xnTEbKM50mLEVw9lhz38ZpES+dSUT7bVfA=;
 b=JQC6x0yIgKvcpzCUT3wSYFvs8TrrAJz/IYx1zrhU4AfsP01yjaoRYiI0KHg8hyGIaA
 lbCrAho/uOGGloLfEqyX2Sl23FAxUQ5gvD1bnS7BYDVsxVRGPJj67XTLlQ5WnllhTYgw
 nWJzp5K3dlyh/5Wbe2V/B+0zFccaFBPT3zPnYNZbymOOrqsGpJKy/11hZFJdKaGoaHAR
 P4LCrRllws7ZdUfdfh/cwrw7EkFfdP77IaTehmR9wIZDPFqLQXbWITxTdRg2qGWlBAlg
 IVj6xTLq3avqijlyVCrZtGdF+wWrjElJ/utxGUM/m1Wfwnsdi0lH0EgMbJnj2QEC7D6T
 NX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754407779; x=1755012579;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b73e4dbI2xnTEbKM50mLEVw9lhz38ZpES+dSUT7bVfA=;
 b=CTEtwfJ0WojI551Wyz9WML/v5+U8XF5cg7e+Gq+Ey4tRAUHnSUJ7oLAdJNEu1Tth5Q
 LH7x/TAJkxnUsEy7aLH94GuB0HN0INEauthibMcShT77uqPo9JvZynU3QtmM4DE+jFJK
 RkYB4FkehDpoQB9eMmBU+ERAWzOqCUghJVXF5IY0Y0fRz7HldLQD1/hRXOvWiHRxzF4n
 q7vz9hWbyV1MPAohkKupCX6toGc3/StalSrnjd2NEYteLhIOYw/lmp6gg9irZFljeDJD
 d/bbWR6UP1GhR0/V/DGsVprj2ryoawSo1+wH6QCFDJkofp8SfefXv8O6XQxUHsgQDW1v
 xknQ==
X-Gm-Message-State: AOJu0Yzk7MXGtmHhBPR9g7OlPHcjPnulKX/REdQrBYMrGL/GjqGEnoLb
 0cfCTojo4yAKlnSaDWMH0ZRRR5iob+KrUIzZvR8Pd724xhP8RdyY+wLT4yVhh5BEjwA=
X-Gm-Gg: ASbGncsp8BITs5w0Hvta7xAwtA/28oic/rz13rM7mrGmJHA6w/VXheH1N8SZ3EXzKDt
 B5XGKzRlE4hyW3zMMKw/Jt5oqwCukFzbRi7GehlAoxaaMzDcqXGuurwzocovnswT0Slnn/f8IfE
 V8PQgtHHQVi7EeQhjJudbiU22/aJBFp2cJdtPASzmxa5pnsa5jrRcJdZuGV7c4T9rOh3Ze6U7eN
 wAz6JsrRHZ38gzj8L25Opn36drHZPIV6ZaRuF8+AG+G7FS4Ot6rPleF6+uuHWXptMEajIkxR8v/
 qTyhXvw/jbd1n4xixl0BFzyIL1IYa0rr7mgJ23fMDOJMzEv/N0ZsoZ/kZp1CBLuOpITOKa23wsj
 wtkeCjEqavx/4V55/vqrNj7/XqaAIkAvb+LumDbYsRKVbGjzOrqVIHsF+/9j0DjQ8OQ==
X-Google-Smtp-Source: AGHT+IFu3jjObrrdQWT+x9JLMZK50A5OGKOiTrR7xIBUqSLbeygeCBWTdr7pqrMCzVtqhLNrqw7G6Q==
X-Received: by 2002:a5d:584e:0:b0:3b7:8a28:3e35 with SMTP id
 ffacd0b85a97d-3b8d9468f10mr10322711f8f.2.1754407778983; 
 Tue, 05 Aug 2025 08:29:38 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5d0b1afsm4945935e9.26.2025.08.05.08.29.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 08:29:38 -0700 (PDT)
Message-ID: <192fddd3-3ca8-4e7c-a258-143b77c963e8@linaro.org>
Date: Tue, 5 Aug 2025 17:29:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for v10.1] i386/cpu: Move addressable ID encoding out of
 compat property in CPUID[0x1]
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Chuang Xu <xuchuangxclwt@bytedance.com>
References: <20250804053548.1808629-1-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250804053548.1808629-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 4/8/25 07:35, Zhao Liu wrote:
> Currently, the addressable ID encoding for CPUID[0x1].EBX[bits 16-23]
> (Maximum number of addressable IDs for logical processors in this
> physical package) is covered by vendor_cpuid_only_v2 compat property.
> The previous consideration was to avoid breaking migration and this
> compat property makes it unfriendly to backport the commit f985a1195ba2
> ("i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX
> [23:16]").
> 
> However, NetBSD booting is broken since the commit 88dd4ca06c83
> ("i386/cpu: Use APIC ID info to encode cache topo in CPUID[4]"),
> because NetBSD calculates smt information via `lp_max` / `core_max` for
> legacy Intel CPUs which doesn't support 0xb leaf, where `lp_max` is from
> CPUID[0x1].EBX.bits[16-23] and `core_max` is from CPUID[0x4].0x0.bits[26
> -31].
> 
> The commit 88dd4ca0 changed the encoding rule of `core_max` but didn't
> update `lp_max`, so that NetBSD would get the wrong smt information,
> which leads to the module loading failure.
> 
> Luckily, the commit f985a1195ba2 ("i386/cpu: Fix number of addressable
> IDs field for CPUID.01H.EBX[23:16]") updated the encoding rule for
> `lp_max` and accidentally fixed the NetBSD issue too. This also shows
> that using CPUID[0x1] and CPUID[0x4].0x0 to calculate HT/SMT information
> is a common practice to detect CPU topology on legacy Intel CPUs.
> 
> Therefore, it's necessary to backport the commit f985a1195ba2 to
> previous stable QEMU to help address the similar issues as well. Then
> the compat property is not needed any more since all stable QEMUs will
> follow the same encoding way.
> 
> So, in CPUID[0x1], move addressable ID encoding out of compat property.
> 
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Inspired-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> Fixes: commit f985a1195ba2 ("i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX[23:16]")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3061
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/cpu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Patch queued, thanks!

