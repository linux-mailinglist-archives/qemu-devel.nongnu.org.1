Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D928258D7
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 18:06:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLndF-0007va-Jn; Fri, 05 Jan 2024 12:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLndE-0007ur-27
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:05:16 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLndA-0005QO-Dx
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:05:15 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e384404e7so9407365e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 09:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704474310; x=1705079110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aEKJmkt/kEh0jAkLCdfh1+fpI+Ncd11yrNhGOqJTJao=;
 b=MogocZ9bwYR+2NE7ubyx9IQJTk/rqodPdS2872oCx0LPBs+5WvAK/Y4FaAyJEwi8w3
 n9l7Hzpmx6/FLzBHQcWHQGaGZo+FljbNg6Q56SWgH7UDYpiZZmWBPplMfRHTOXyhfeTG
 Ecmq7FGSsIPAkwwhXLijx73OLk3iS6LAlsb/vQbE8DXO2R8MIZW8Ep0hqA8FR6DjBVtG
 DGp+pggwzptanAEsGI9Hh78w60kdGCQF7rO80x6OILypmuLRHt8ZEiLxXoJUUlrchEmG
 0yX7Mi53Ecf+gGLR17wjol1AbRddSdMvNAbiqwmnXV+pXSXW+4EMMupTUT+32rmqZidc
 +1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704474310; x=1705079110;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aEKJmkt/kEh0jAkLCdfh1+fpI+Ncd11yrNhGOqJTJao=;
 b=kw661Ts9ZBOF2LfbDgANLusG0CXd5PijyqLZ3jlsJR6cK5HBGO2uflztnWOybAP27l
 pRO4bfo6a/twDWVq3xLY9gELU30y91yXjV45obtm5M055npucxLXpKnHbj1syOkX8m5X
 ilcdQ7RvM7cu89jMiJWAeKP1dlJ+05MAHYh4SO4/e0FUzF1vBPgfdRwvP0+CcRMYQGKX
 dX9nYB0dN0dmN+pjJrQGoxMEyGEox3e/HCQ4m1P6MrB6W6DnUeQZmAVOK4fcycMLlQq8
 oxAkAhU/hizvY24TXsZC845wjl/KAizxou1KGuUqUW+PWNQ5GqoL8CErvVUrkuS6VWbi
 n1Mw==
X-Gm-Message-State: AOJu0Yxhnr0bSepYkv+a1iZ4x5f0Gr19F8vkTjdTy+nEsZqCNLNLmAU4
 0jaystxaBRXnYQneXE4vhbas8rptBolxrCoYC1xvygyjiP0=
X-Google-Smtp-Source: AGHT+IEzGMVIaFFpOtQ3MJiOm/QErUDRTnXNULZjgHpiLM7Fqf3LNNQJXBiZ/5uH3kUircJDBwyWCw==
X-Received: by 2002:a1c:4c18:0:b0:40d:7eb2:bf93 with SMTP id
 z24-20020a1c4c18000000b0040d7eb2bf93mr1384600wmf.46.1704474310418; 
 Fri, 05 Jan 2024 09:05:10 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 fc12-20020a05600c524c00b0040d5a9d6b68sm2143198wmb.6.2024.01.05.09.05.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 09:05:10 -0800 (PST)
Message-ID: <566d5a05-5cd3-40fe-b40e-8e82524d8ea6@linaro.org>
Date: Fri, 5 Jan 2024 18:05:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/71] HW core patches for 2024-01-05
Content-Language: en-US
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20240105154307.21385-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 5/1/24 16:41, Philippe Mathieu-Daudé wrote:
> The following changes since commit 05470c3979d5485003e129ff4b0c2ef98af91d86:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-01-04 19:55:20 +0000)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-cpus-20240105
> 
> for you to fetch changes up to a318da6b3f6a88e6cfd6953c519def9457e8962f:
> 
>    target/sparc: Simplify qemu_irq_ack (2024-01-05 16:20:15 +0100)
> 
> ----------------------------------------------------------------
> HW core patch queue
> 
> - Unify CPU QOM type checks (Gavin)
> - Simplify uses of some CPU related property (Philippe)
>    (start-powered-off, ARM reset-cbar and mp-affinity)
> - Header and documentation cleanups (Zhao, Philippe)
> - Have Memory API return boolean indicating possible error
> - Fix frame filter mask in CAN sja1000 model (Pavel)
> - QOM embed MCF5206 timer into SoC (Thomas)
> - Simplify LEON3 qemu_irq_ack handler (Clément)
> 
> ----------------------------------------------------------------


> Philippe Mathieu-Daudé (37):

>    backends: Simplify host_memory_backend_memory_complete()

I neglected to run checkpatch.pl on this patch, so it lacks:

-- >8 --
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 30f69b2cb5..987f6f591e 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -346,5 +346,7 @@ host_memory_backend_memory_complete(UserCreatable 
*uc, Error **errp)
      unsigned long maxnode = (lastbit + 1) % (MAX_NODES + 1);
-    /* ensure policy won't be ignored in case memory is preallocated
+    /*
+     * Ensure policy won't be ignored in case memory is preallocated
       * before mbind(). note: MPOL_MF_STRICT is ignored on hugepages so
-     * this doesn't catch hugepage case. */
+     * this doesn't catch hugepage case.
+     */
      unsigned flags = MPOL_MF_STRICT | MPOL_MF_MOVE;
@@ -365,3 +367,4 @@ host_memory_backend_memory_complete(UserCreatable 
*uc, Error **errp)

-    /* We can have up to MAX_NODES nodes, but we need to pass maxnode+1
+    /*
+     * We can have up to MAX_NODES nodes, but we need to pass maxnode+1
       * as argument to mbind() due to an old Linux bug (feature?) which
@@ -393,3 +396,4 @@ host_memory_backend_memory_complete(UserCreatable 
*uc, Error **errp)
  #endif
-    /* Preallocate memory after the NUMA policy has been instantiated.
+    /*
+     * Preallocate memory after the NUMA policy has been instantiated.
       * This is necessary to guarantee memory is allocated with
---

Since the PR is already in the testing pipeline:
- if it get merged, I'll send a cleanup patch
- otherwise if it fails I'll fix it.

Sorry for missing that.

Phil.

