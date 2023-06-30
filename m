Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AC9743CA4
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4i-0007cY-EP; Fri, 30 Jun 2023 09:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4g-0007bZ-9S
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4e-0003N3-HN
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc0981756so15774345e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131326; x=1690723326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lUkCksRepDyJ8GSSdRoBq8cm8bf7/10tPEy1hDkGHcA=;
 b=ovDjW/I62QwH9YT8eIZnAFSsRNPFYn3voVOh4biYZxPk4jfjdfHVUa/BbHgsR0425w
 1zH4yxitjLx78dmngkoF7gq3i1FJ8DLhtxvY9ONXjCrrp3kdCmS+u5mQG2rAWiAWJrxA
 B8efsqj+ciwpNdyZPYRA+cTeHdqnVLP/c7s/dF46ZcSiZV75KGLJu6QzGP9XZV/4zGdE
 1NshZmcYk1LwqX4GPvGGNhmxRH9TLbfB2uujuGN7UnCpT8w+X8qQbccqjNbKkzZojHQv
 V7kWFuGQr9GFYeD5r5WEpeDPnaNYioXO+u6xvq1FGyv4nKquyk66QrqRr6dGdM7iPqk6
 q2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131326; x=1690723326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lUkCksRepDyJ8GSSdRoBq8cm8bf7/10tPEy1hDkGHcA=;
 b=aMYkywIiI++CXwOad83EnrKUQ8hl4a8WJaQbRYmIUh2DGjEvsATljn2fz7hEszAUIe
 GShP1eZx3v+Tw6rn2hAwTdXEazlBNBWLfnfZ43SUdj2Np3aWY4jHaNkmUfOdP0HIeq5J
 UinvKzaLJP76Hzi4nwXLu68LjC0XNzuvA1sfkQzbdc/DSphnktdHF90VDi8FAl7zXDnb
 D/4GAycjzbq0VMgqTOFa/v7Z1UVlr6qR+7U/d3pNQ0ggJKXWeX6vhXEH9AK6ZyQkOtqP
 lRNEvmdMip/6yQxH2csP3aL0aHemTwNvGF7Om5FevcOFvxXffBOYYWXl5z0rGIteZ+Bo
 bxKg==
X-Gm-Message-State: AC+VfDwE/dBHg9cTQkWT+oAAkYQIwfJ76jtreSBR5ZrTe0GzTXWzoEFr
 xbOm5feN5JE8HnijD6MiRBLN/HvIVCWNhVhIqWcOYw==
X-Google-Smtp-Source: ACHHUZ6R/92PCLmBUR/NC+RYaHmZ7asCN3tyXVb9uk/1Wt4rLF511nTjtueerhjUb8iPoEvrhzmeDQ==
X-Received: by 2002:a7b:c393:0:b0:3fb:403d:90c0 with SMTP id
 s19-20020a7bc393000000b003fb403d90c0mr1792388wmj.39.1688131326194; 
 Fri, 30 Jun 2023 06:22:06 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 07/24] accel/tcg: Introduce page_check_range_empty
Date: Fri, 30 Jun 2023 15:21:42 +0200
Message-Id: <20230630132159.376995-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Examine the interval tree to validate that a region
has no existing mappings.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 11 +++++++++++
 accel/tcg/user-exec.c  |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 8018ce783e..5b2c230d52 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -224,6 +224,17 @@ void page_set_flags(target_ulong start, target_ulong last, int flags);
 void page_reset_target_data(target_ulong start, target_ulong last);
 int page_check_range(target_ulong start, target_ulong len, int flags);
 
+/**
+ * page_check_range_empty:
+ * @start: first byte of range
+ * @last: last byte of range
+ *
+ * Return true if the entire range [@start, @last] is unmapped.
+ * The memory lock must be held, as the caller will want to ensure
+ * the result stays true until a new mapping can be installed.
+ */
+bool page_check_range_empty(target_ulong start, target_ulong last);
+
 /**
  * page_get_target_data(address)
  * @address: guest virtual address
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 8fbcbf9771..25c605dc1b 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -598,6 +598,13 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
     return ret;
 }
 
+bool page_check_range_empty(target_ulong start, target_ulong last)
+{
+    assert(last >= start);
+    assert_memory_lock();
+    return pageflags_find(start, last) == NULL;
+}
+
 void page_protect(tb_page_addr_t address)
 {
     PageFlagsNode *p;
-- 
2.34.1


