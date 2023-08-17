Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3C877FE91
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 21:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWil1-0003xG-AX; Thu, 17 Aug 2023 15:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qWikx-0003ws-8z
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 15:34:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qWiku-0005XP-Hf
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 15:34:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bdbbede5d4so1328465ad.2
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 12:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692300843; x=1692905643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xf5e9HuZ7bNbO78EalP3uJqo2rLwaF2AUK7dKzkmFmE=;
 b=JGD4PHAEpu2XKb7arnEW7p+Usb3I+Mbg+vrHJyCaKWNTc6ottAnnhxipDynqKB9IWF
 BDsj8G5A/9O2EBofOROi7gO5NhRfvXSECWoBygJPNMUBj4RAi0wqLJXNY2JQ/n+qEjSR
 1vwBKKVoPkxYJLlXsFfmXaurNzIEewFYJq5tch+m4kVmaH7Kv/EF80w2WB7oNLheI/zr
 zdYqIo4wgVmHRz/dUz5N6yarUkW0puTJOqlb4JXg4YAHipT85oLNIXKwtapn17LcpU8Q
 d2aC2NaIDpqBqB7CMC+TRR5wHHrkdq8f6BUSQlCqwziG/Z11mqkr/nHCJkTqle5EhCp9
 TH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692300843; x=1692905643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xf5e9HuZ7bNbO78EalP3uJqo2rLwaF2AUK7dKzkmFmE=;
 b=ZW0D2mnSx22vy7cAyjUOoaEz6fgkjx6JoER0Y+CgRH25NBZfTcZCA/KGiv7SDSsOuB
 RZYRnfm6uanUXAul2ip3q0UoBD8QzUwUOs4oCEzjK3TeyAr0PRtyapERdAm1Bv1MBrzd
 Sxxmdro8NIgoIFYfAbFNkfdnJir3mequW2PnDZocuyt0GB301GLnQOHBYXP3/KS5VWCA
 kshtMY6k36NyrqHc6GIv3wt23n+UnmlWHaypAPbrLaoj9n8KmOndsFbQhvD15nQtSree
 KASE9g75wH5YRqtejhSn6i2HbcA/K/8lhSUEVZ/pakR5Yoznlazf6ASPTt2KEp4rtq0E
 8a8g==
X-Gm-Message-State: AOJu0YymG7PjQyrnjt2oen9fGP56jwgX6nAoXmuVSKzcjeeVq92cFZkT
 5M8HNiGFZBcpi+EyctagxzA=
X-Google-Smtp-Source: AGHT+IEUQywPNdrh3odwA4lO72hvzd492UuU34LwfRzc0xrlIt92ugYnTg997QV74DfoWiQe+dK48g==
X-Received: by 2002:a17:903:2448:b0:1b1:9233:bbf5 with SMTP id
 l8-20020a170903244800b001b19233bbf5mr472043pls.57.1692300843161; 
 Thu, 17 Aug 2023 12:34:03 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 jh13-20020a170903328d00b001b83e624eecsm143284plb.81.2023.08.17.12.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:34:02 -0700 (PDT)
Date: Thu, 17 Aug 2023 12:34:01 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: Qian Wen <qian.wen@intel.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 babu.moger@amd.com, isaku.yamahata@gmail.com
Subject: Re: [PATCH v3 2/2] target/i386: Avoid overflow of the cache
 parameter enumerated by leaf 4
Message-ID: <20230817193401.GC3637892@ls.amr.corp.intel.com>
References: <20230816080658.3562730-1-qian.wen@intel.com>
 <20230816080658.3562730-3-qian.wen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816080658.3562730-3-qian.wen@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Aug 16, 2023 at 04:06:58PM +0800,
Qian Wen <qian.wen@intel.com> wrote:

> According to SDM, CPUID.0x4:EAX[31:26] indicates the Maximum number of
> addressable IDs for processor cores in the physical package. If we
> launch over 64 cores VM, the 6-bit field will overflow, and the wrong
> core_id number will be reported.
> 
> Since the HW reports 0x3f when the intel processor has over 64 cores,
> limit the max value written to EBX[31:26] to 63, so max num_cores should
> be 64.
> 
> Signed-off-by: Qian Wen <qian.wen@intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5c008b9d7e..3b6854300a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -248,7 +248,7 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
>      *eax = CACHE_TYPE(cache->type) |
>             CACHE_LEVEL(cache->level) |
>             (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
> -           ((num_cores - 1) << 26) |
> +           ((MIN(num_cores, 64) - 1) << 26) |
>             ((num_apic_ids - 1) << 14);
>  
>      assert(cache->line_size > 0);
> -- 
> 2.25.1
> 
> 

Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>

