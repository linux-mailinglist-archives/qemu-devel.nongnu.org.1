Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A76372E437
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 15:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q94B5-0007jN-Ff; Tue, 13 Jun 2023 09:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q94B2-0007cd-NG
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:35:16 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q94Az-0002QQ-Ug
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:35:15 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-97460240863so889902766b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686663312; x=1689255312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HE4rMdwDzn7Z5hU0mldHp9um1gTSDI5fOpSWPoLYcO8=;
 b=qO0Wk4mIqHnzhNQNLP9LR5c32xCPrPUIGMAF7lcBLHHSnc0q9qbpBy8Jud/I1th9T8
 3b4d/ZyOOK8PV+4yoRM1ngyTX7/uLTegjEsyWeBK3fHH9y4P/SBN05zziEY/WJqvqXc6
 zhGxUtiMpb0pkwXKLJ8MYhwL3mqwczaBsgSjFC7NEGcDD4Gu2+t7sVCQFouKUPpXkmil
 ROCIaLgtxln9B5/HeGddUWuHC5O65NaTkuBmovEh1Fh4ES/cpO4MklBQZk0IXNuaSx5B
 hrZaPCAF5aootiuaDD8Gw1TMcnDv/dqVrfQRUfbq6CDEi6KsSdX0fTRP4HWeU3IMZjDj
 WZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686663312; x=1689255312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HE4rMdwDzn7Z5hU0mldHp9um1gTSDI5fOpSWPoLYcO8=;
 b=NtKbhnRvdIoVMg6BpQ/A+1SzikP2i+8kXClIEB7Gipr2YrJxdjzaKXXW/vxDMwdWD+
 PNjUdYg2PIaAPp99We8rTz4Czs6gUrcSkDfF815KgAxe7Ex2RBTCYlguVrJ50SXikwni
 mZ6ennjhImrD4687ht8HT7LOT7mlE8KvPmFfUrvIJQDlAwqNCOpvEaViW4uJ2GuiLKwh
 bY3yTQbcU0GKzpEChN2rKW96mX4XYprLECrwfdpkQnAcAFUKGHX0Ns5trc3UZoQbtfsy
 hXvfUpqMcGn9WL7nstEcH9W4YdZQijekDU8HC0DRQS+r7wt29sAAZ0zANWuPZw9lA32D
 zvAg==
X-Gm-Message-State: AC+VfDw3c/Qlq+CzcmhsT+aDVt6zfy5FT9x4fcRSjG3wGUigxJRaE9tw
 mYWr4S4TUFldlEXeYNGOnJgvFFVEqZ1RBxWRoQY=
X-Google-Smtp-Source: ACHHUZ45NWw30EIEYhqRjTisNztnOqv4ALmbqLlInZ/AdwFhpOxdH7yl0bVqKDWj+9re+WyZ+Yj/uw==
X-Received: by 2002:a17:907:7b9f:b0:982:25d1:bfd3 with SMTP id
 ne31-20020a1709077b9f00b0098225d1bfd3mr4198341ejc.15.1686663311927; 
 Tue, 13 Jun 2023 06:35:11 -0700 (PDT)
Received: from localhost.localdomain ([213.235.133.109])
 by smtp.gmail.com with ESMTPSA id
 qt17-20020a170906ecf100b00968242f8c37sm6598096ejb.50.2023.06.13.06.35.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 06:35:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/9] target/tricore: Remove pointless CONFIG_SOFTMMU guard
Date: Tue, 13 Jun 2023 15:33:40 +0200
Message-Id: <20230613133347.82210-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613133347.82210-1-philmd@linaro.org>
References: <20230613133347.82210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

We don't build any user emulation target for Tricore,
only the system emulation. No need to check for it as
it is always defined.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 284a749e50..951024d491 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -31,7 +31,6 @@ enum {
     TLBRET_MATCH = 0
 };
 
-#if defined(CONFIG_SOFTMMU)
 static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
                                 int *prot, target_ulong address,
                                 MMUAccessType access_type, int mmu_idx)
@@ -57,7 +56,6 @@ hwaddr tricore_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     }
     return phys_addr;
 }
-#endif
 
 /* TODO: Add exeption support*/
 static void raise_mmu_exception(CPUTriCoreState *env, target_ulong address,
-- 
2.38.1


