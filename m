Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 151DA831C01
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:08:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTz5-0007FC-T7; Thu, 18 Jan 2024 10:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTz3-0007AS-NJ; Thu, 18 Jan 2024 10:07:09 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTz2-0007qj-7C; Thu, 18 Jan 2024 10:07:09 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d70a98c189so4346445ad.1; 
 Thu, 18 Jan 2024 07:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590426; x=1706195226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Qm/qBc7xw4k/QzMtPvB782F7uhFe9bOJTuo4589f0o=;
 b=DzVKUyTetNXWaXd5ePu/tQiLYirz2cV0ZO0QMSBGpJuUJa/RY9xr//UuM+k04qSYUw
 ypdxZ6X8r6sEPkTk2WlY68NPv2lO0UGB4cr9ZeJ40oqg0ZphA3lOviNH2wlX7O4kUG1G
 UvYvx9k5e2xghHKgvoHjHLz9jSGBJdi7J5trD+2mg5+iqQYPiz6ReRBjYHFhJWjnqwS7
 tZG6w6D7TVqgDqovN5L5pJQR29ael2Fku1ZmcXDnrNqDoA9PKlz6/tO6QHG99VvSP1Qy
 wbCP6iUFXfhvNR0DI/YJEnPtwx5ftfVorwIQHUkufO6YS4oe8OTt5t3+DKZc6b6kWd/p
 2vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590426; x=1706195226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Qm/qBc7xw4k/QzMtPvB782F7uhFe9bOJTuo4589f0o=;
 b=XiIqBRU0pJPN59OwzShLUOOCHluS4M8Xt1BrZYFYxd+V8bGFXaakCo+eT5MXCxPg/v
 EKwYXWjF/3UHvNQw0DyNJFKg8fUbDPUZBoeEYu6I0q3qUK1HXwTZzk/cgGmAO2fIWvzy
 A5/kCjZbOLfqNvxl4HrbsycKd57+z2Z9Qs21na6Ma71IRf/ezOk03859PcYES7naakV6
 zdH4ZDOjA+P0Dy7xHOuG48yfBZL07RARYdO7R3rCzWFNXXi4Bgo/WycvZkdCuqIU7mlW
 oWcH4QJJqdHNtLMKapci8EdYNRfLKxCRfqriKYtw2qJH3GV/DzuDL9e0fRYTjMdMpTgU
 xItw==
X-Gm-Message-State: AOJu0YxsBupTAc0/kqetJ5c0vYtiMtyt3jRjou2u6NumftjyRsdw3rDa
 4aqgoQWgTeCvd7rvNZPvmgGh7ITNSwPkZd18SISWM3EMNhQvo9yrObLiMb6h
X-Google-Smtp-Source: AGHT+IE+fBevvTAxUk2knvF39GtNnFd5Uhj88odsSylExCjwiZYZ5XNzMZPrNvBA9i9U+xPdL2tp+w==
X-Received: by 2002:a17:903:244d:b0:1d6:f139:cc20 with SMTP id
 l13-20020a170903244d00b001d6f139cc20mr1152506pls.32.1705590426277; 
 Thu, 18 Jan 2024 07:07:06 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:07:06 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 02/26] target/ppc: Prevent supervisor from modifying MSR[ME]
Date: Fri, 19 Jan 2024 01:06:20 +1000
Message-ID: <20240118150644.177371-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Prevent guest state modifying the MSR[ME] bit. Per ISA:

  An attempt to modify MSRME in privileged but non-hypervisor state is
  ignored (i.e., the bit is not changed).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index e0b2dcd02e..bd17c14136 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -264,6 +264,11 @@ int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
         value &= ~MSR_HVB;
         value |= env->msr & MSR_HVB;
     }
+    /* Attempt to modify MSR[ME] in guest state is ignored */
+    if (is_book3s_arch2x(env) && !(env->msr & MSR_HVB)) {
+        value &= ~(1 << MSR_ME);
+        value |= env->msr & (1 << MSR_ME);
+    }
     if ((value ^ env->msr) & (R_MSR_IR_MASK | R_MSR_DR_MASK)) {
         cpu_interrupt_exittb(cs);
     }
-- 
2.42.0


