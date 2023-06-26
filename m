Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF0073E3C7
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:44:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoLH-0001pn-DB; Mon, 26 Jun 2023 11:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJq-0000Ii-Vk
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJm-0002qd-Jj
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-312863a983fso3978437f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793993; x=1690385993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfNF0XMtfGM0LprKOtGtXD7cr7UhlGd46dndzk9ShbU=;
 b=IXRDGB/ZDsukMsYNv3CqymgM2RCrePZ3YzaA0FuJxNDemMgLhpEcKyPdK0fkM7ffLO
 C7R1gj+Ill8PIAyq83HDWOOBj6S2BDEmGQvnuXnzkYT9PT2ltxdR+yQ+Qd2oOvSN4thf
 /QiBUzG35GFXuqpUE5bRFk9DXZnW99wBRYdy5CdgSwjqmEQbO0qhMm11avpRV9/7jRK6
 XfxzNc82wsKeV041gLMb4y4HR5gcMomoZu8Lf4xE9NBuq0r7X7yrLzPM2er7tRlifJxD
 CBU36ZD5XSHIJozZL3eVMW0+snu+eHYDHGl5BB9rFmLrOxIaA1tu5xpCbP4DbMhA6iHj
 F0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793993; x=1690385993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qfNF0XMtfGM0LprKOtGtXD7cr7UhlGd46dndzk9ShbU=;
 b=WAAnzlECLwHHb5eBDHQBe3T2lgI9uwLciaZUPjsHhQXTnHMfGIqwvpIXH7oDXLM8QR
 /EpvZ8YfYNg1ZEnaCIPuNV8/uuUpD+KXJ6y9GvY9oCrlYYLai5dtNJTeIO5MzysbtzJF
 Nm9XoAK+joaP6QwY2j5L/PaF7Mv+Mr0OBRkEnHZZ2jtS06IXbhohB0ZjIB/R5X72MwTA
 6F5P0+/me8+7+Exe1Q4OVS1VYo2vtjbnv42zCIKmpe+WGdQIXg10lujGoxvg6KeHHKxp
 SbyR+ehv5p5UkIz7kn7FP+fWj0vuLRALabtO4E1z7MSItS2vEjJO2lueH5vSSC/HY8Zs
 UnBQ==
X-Gm-Message-State: AC+VfDxIMdvd/2RhVXFNSuDtRzJYRkGZRtwVIkqK7zAkPp9FerwbU/Qk
 P2Qn/wrSupKldpopy1mBa/uuLMPuKOHillQwyxnMNDXA
X-Google-Smtp-Source: ACHHUZ4KS76rDkerPUGpLMVMhMJGMpqhQd/HasjrDgbz0jbEa7W9lLRlRVhzP+Xe1HbaTQt8InEvAw==
X-Received: by 2002:a5d:6785:0:b0:313:f990:c631 with SMTP id
 v5-20020a5d6785000000b00313f990c631mr118388wru.44.1687793993236; 
 Mon, 26 Jun 2023 08:39:53 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 11/22] cpu: Replace target_ulong with hwaddr in
 tb_invalidate_phys_addr()
Date: Mon, 26 Jun 2023 17:39:34 +0200
Message-Id: <20230626153945.76180-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Anton Johansson <anjo@rev.ng>

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621135633.1649-13-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 2 +-
 cpu.c                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index cc1c3556f6..200c27eadf 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -526,7 +526,7 @@ uint32_t curr_cflags(CPUState *cpu);
 
 /* TranslationBlock invalidate API */
 #if defined(CONFIG_USER_ONLY)
-void tb_invalidate_phys_addr(target_ulong addr);
+void tb_invalidate_phys_addr(hwaddr addr);
 #else
 void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs);
 #endif
diff --git a/cpu.c b/cpu.c
index 65ebaf8159..1c948d1161 100644
--- a/cpu.c
+++ b/cpu.c
@@ -293,7 +293,7 @@ void list_cpus(void)
 }
 
 #if defined(CONFIG_USER_ONLY)
-void tb_invalidate_phys_addr(target_ulong addr)
+void tb_invalidate_phys_addr(hwaddr addr)
 {
     mmap_lock();
     tb_invalidate_phys_page(addr);
-- 
2.34.1


