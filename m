Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8627F44C3
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 12:17:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5lDg-0006Cb-O7; Wed, 22 Nov 2023 06:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5lDc-0006C0-Vo
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 06:16:33 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5lDb-0002rk-EP
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 06:16:32 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3316c6e299eso3082665f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 03:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700651790; x=1701256590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mN7WowE0cZD+2afkZRG/IfGnJDv8NfDOpiIe+4Pzpyc=;
 b=XQYNtNz8f1MaXZHyrOXGyoiCfFVVKsxbBg7xWpQmCf2AT6dWNPytZ9h8PMbrwejE0W
 x7+kxmnRx+uFnkOsYzjZLbg+7zvAWZovoV8XFmy1qpuZP4O/TmiyBreJkBSijKQmAILx
 +BKstR8p4wn67mqBnsNBLZPlVE7m8203z/yj1cAjlahpQfLPobr/9xaWaPJnar8bqykA
 47AKm7UiipX9MAX9k38W3cCTNu1Aau7v3kB3cZ+Y8vEV2TqghILRMC0wd+2797mTgX8J
 7bVghUBUp5wHMGURCg4Tk4itqvOFKbHt5kkMEs5vR0eh22k1AOCNGhi3liw6H/aNtG1o
 KZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700651790; x=1701256590;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mN7WowE0cZD+2afkZRG/IfGnJDv8NfDOpiIe+4Pzpyc=;
 b=EabTIpIOiI/RiPABnZReLYxgqyGH3AQUvsU+wpHIWbqSPJK/qUH3Q6dL3eyKdqm16C
 mmJVTdtnngQn4P5bO69SYMlO+uBQhGcxolpLow6DbjgNQinzKN99jlHbPbUAj9PxoeqD
 5hvRSAenlnlmO7dA/2T3EqdMCFrlsKq492KJfQnwHffVMIbxfRzvT4p6QUtsX4EsLzWO
 qH4h/oQcZwObXpbIheVEo2C52AYpmTbURS2/D2Qc9QeMGfmHYpYUBrLO1aEKMi1GDp8Z
 2U18NjekV53Oy4mAjKU1+3FvuE+UpSZ652pzziT2SAd8Hnl7PasF+tG06VmCljtlxBV1
 09sA==
X-Gm-Message-State: AOJu0Yzz4uU4vCK6+Ne1GrjFFLyPhHTEn4Or9JEolR+upeJhmdGQzqpa
 BXOx718d9b+5yMpBaDLynGFetg==
X-Google-Smtp-Source: AGHT+IH1sCMLL9K0m9k15XP5veXQ+Y1sPhNk11m/xDCZcZJb1H7R4kgQQ/D/IAEMrN458hrrv4AhfA==
X-Received: by 2002:a5d:64cf:0:b0:32f:c29e:583a with SMTP id
 f15-20020a5d64cf000000b0032fc29e583amr1107564wri.56.1700651789745; 
 Wed, 22 Nov 2023 03:16:29 -0800 (PST)
Received: from [192.168.69.100] (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 x5-20020a5d6b45000000b0032f7fab0712sm17013258wrw.52.2023.11.22.03.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 03:16:29 -0800 (PST)
Message-ID: <4eaf8cf4-94b1-425b-a712-c006abb114c3@linaro.org>
Date: Wed, 22 Nov 2023 12:16:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ppc/spapr: Initialize max_cpus limit to
 SPAPR_NR_IPIS.
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org
References: <20231122092845.973949-1-harshpb@linux.ibm.com>
 <20231122092845.973949-3-harshpb@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231122092845.973949-3-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Hi Harsh,

On 22/11/23 10:28, Harsh Prateek Bora wrote:
> Initialize the machine specific max_cpus limit as per the maximum range
> of CPU IPIs available. Keeping between 4096 to 8192 will throw IRQ not
> free error due to XIVE/XICS limitation and keeping beyond 8192 will hit
> assert in tcg_region_init or spapr_xive_claim_irq.
> 
> Logs:
> 
> Without patch fix:
> 
> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
> qemu-system-ppc64: IRQ 4096 is not free
> [root@host build]#
> 
> On LPAR:
> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
> **
> ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
> (region_size >= 2 * page_size)
> Bail out! ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
> (region_size >= 2 * page_size)
> Aborted (core dumped)
> [root@host build]#
> 
> On x86:
> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
> qemu-system-ppc64: ../hw/intc/spapr_xive.c:596: spapr_xive_claim_irq:
> Assertion `lisn < xive->nr_irqs' failed.
> Aborted (core dumped)
> [root@host build]#
> 
> With patch fix:
> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
> qemu-system-ppc64: Invalid SMP CPUs 4097. The max CPUs supported by
> machine 'pseries-8.2' is 4096
> [root@host build]#
> 
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>   hw/ppc/spapr.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index df09aa9d6a..0de11a4458 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4647,13 +4647,10 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>       mc->block_default_type = IF_SCSI;
>   
>       /*
> -     * Setting max_cpus to INT32_MAX. Both KVM and TCG max_cpus values
> -     * should be limited by the host capability instead of hardcoded.
> -     * max_cpus for KVM guests will be checked in kvm_init(), and TCG
> -     * guests are welcome to have as many CPUs as the host are capable
> -     * of emulate.
> +     * While KVM determines max cpus in kvm_init() using kvm_max_vcpus(),
> +     * In TCG the limit is restricted by the range of CPU IPIs available.
>        */
> -    mc->max_cpus = INT32_MAX;
> +    mc->max_cpus = SPAPR_NR_IPIS;

Is SPAPR_NR_IPIS also the upper limit for KVM?

>       mc->no_parallel = 1;
>       mc->default_boot_order = "";


