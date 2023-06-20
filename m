Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8078F7371F2
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:42:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBePR-0003bF-4w; Tue, 20 Jun 2023 12:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBePO-0003ai-T8
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:40:47 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBePN-0002Ex-8X
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:40:46 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9883123260fso375546766b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687279243; x=1689871243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPf1D09XBosKpfusFcd/K7cOyuSSQsl9blqVQhukeQo=;
 b=rvGZeXyFJ3ImPbesUIK0abCtwB1wCtcVe3EbcgjCDzFwFlAfWf+Df0n7x2iwGZotOD
 0sLk2pfS2ihyXIfTUOBHl3UmBpsZ2w4BZdWUH+UrwXIW25Xiuz1jxD7CRKju18KDNioi
 77TX/x6XOGDJIripOB5HwVgAOpyMWsayxmXEVdOV+THHwM8Gt+nZFYZh4DleCkJatCJm
 3b+UZ9cBcJKWW4W9D4M7QQxgZvseHqAfY4sQVIwVPklfK2J0q4ceP3M2l6gRKf/3Vmhn
 Y/sE8MyFuEFKlPbe0HaYUpJhiCsnkrZpS5MZwt/d3Y4B+48QDcw2x3WN47ogF4lXuwPR
 NH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687279243; x=1689871243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPf1D09XBosKpfusFcd/K7cOyuSSQsl9blqVQhukeQo=;
 b=Lz/jdg0qOLA/QWS878H68XdWtg7wBdkH2X2yl9K9tL3gdMFDJTSQygH876ruRdNPRv
 OWhrIwZb06IoP+7m3qEwRUXeo5FMm6AkotXwz81wczZGjM2LLDu7i4L2XdBVU+VwIaHb
 BPIPBIFcPgAPcCVs9HNKU+UyTain/6FGNPNZl/qaciVn6jgqgH8JxEFz6hNpQgU7UAaZ
 qsCD1qeS6YlstKSiNb3aeQUfMJvQW5gZCqNgPGD/Cm4tkunWG0jQf3m/LywMM/Sekcd3
 CF3kA8x4CoIXdGm8Vxx3ap3PTV0TqLGqutaJXF05KajVhNkw0FPqYqd3VAmsZhVl2S9o
 Es4A==
X-Gm-Message-State: AC+VfDz7wzVwIXBkOzfSTesx5ayWGi1n2mb1N2zOYFixacAFC6w6aZKd
 lfqtA7gOiQsccU5HJIOXq6T0131FJMaoB/DTYQ3UOJqs
X-Google-Smtp-Source: ACHHUZ5M40LebBlAL+xcLbqmqZ2AIVquLCaJWyAbKXJ3sGF4dyshKsTTRYCSOI1BRGsLhsZmzIEM7g==
X-Received: by 2002:a17:907:a42:b0:96a:48ed:5333 with SMTP id
 be2-20020a1709070a4200b0096a48ed5333mr11601512ejc.50.1687279243649; 
 Tue, 20 Jun 2023 09:40:43 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 ks25-20020a170906f85900b0098864f474cesm1685589ejb.126.2023.06.20.09.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 09:40:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 1/2] target/sparc: Set TCG_GUEST_DEFAULT_MO
Date: Tue, 20 Jun 2023 18:40:39 +0200
Message-Id: <20230620164040.912490-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620164040.912490-1-richard.henderson@linaro.org>
References: <20230620164040.912490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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

Always use TSO, per the Oracle 2015 manual.
This is slightly less restrictive than the TCG_MO_ALL default,
and happens to match the i386 model, which will eliminate a few
extra barriers on that host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 3d090e8278..49c53f5c40 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -6,6 +6,29 @@
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 
+/*
+ * From Oracle SPARC Architecture 2015:
+ *
+ *   Compatibility notes: The PSO memory model described in SPARC V8 and
+ *   SPARC V9 compatibility architecture specifications was never implemented
+ *   in a SPARC V9 implementation and is not included in the Oracle SPARC
+ *   Architecture specification.
+ *
+ *   The RMO memory model described in the SPARC V9 specification was
+ *   implemented in some non-Sun SPARC V9 implementations, but is not
+ *   directly supported in Oracle SPARC Architecture 2015 implementations.
+ *
+ * Therefore always use TSO in QEMU.
+ *
+ * D.5 Specification of Partial Store Order (PSO)
+ *   ... [loads] are followed by an implied MEMBAR #LoadLoad | #LoadStore.
+ *
+ * D.6 Specification of Total Store Order (TSO)
+ *   ... PSO with the additional requirement that all [stores] are followed
+ *   by an implied MEMBAR #StoreStore.
+ */
+#define TCG_GUEST_DEFAULT_MO  (TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST)
+
 #if !defined(TARGET_SPARC64)
 #define TARGET_DPREGS 16
 #else
-- 
2.34.1


