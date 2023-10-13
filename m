Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 013537C8F5B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:37:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiH-00069a-FB; Fri, 13 Oct 2023 17:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiG-00069I-5l
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:52 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiE-0000P2-Jk
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:51 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1e9db321ed1so700751fac.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232529; x=1697837329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rsg3oMew0Lf3QeNbn4pBTwxs+cU3sH8kSpn+SCSCyic=;
 b=yBc/aFvDab8zU9QdWBIsr5txUMz1ktmVJuYol1z7SPm3bVdiIfrGROy0jHlY825GcB
 KFpeQwqmzKP6Dz9NCKLIVA/D5CHcIOItaNC5fQCDHPQefQtV/5kDOQDJiDN/DAhdxl+I
 86VEpKFwjpDfNaqeUHAlVU3FYUkvhbCvNQddHQmb+vDU5Dcl5TvB3NJuatrIze6gQLDw
 2yGfKwmRlKvGr/xiJtnnf/QQ3KZQIAwOa7Qs+KYkXWFNpj4ee0Rrt220leUS0aIxO7Un
 eyQchpzAvNghZJV2cLX6twjemY2OdcMvLogsMcCWE5ev2K2IocHjRoX1fA4afZir80qt
 c9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232529; x=1697837329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rsg3oMew0Lf3QeNbn4pBTwxs+cU3sH8kSpn+SCSCyic=;
 b=CsU6XXJ+WJs7H0V4zSYoEmbrcsSNXY0MD+ThFvRtZRx1dcxOhOw4ROvXgKLnhdoJDg
 q9kytGgaMjW0sUkpq0/30BE+Rimh8pow0bao352E1qpf23FBgnzrO67CrR4XmHxcg8/5
 SdjD/EigkA57l8aRzQ4+j0loAOjVN8DtiUjb2ezt0NJiA1TCeclhnzPjLXcH+1rxybO0
 +6RoH3N2aKzaHFpduuFnWh0XX+j0oL7ceuc/kzzGTT+QNCU86lRm1Cu8Gzy378xjVWz6
 Nsvv83T7hoBRTH1gbj9GTVPqOffLxigD4uTd06AIpwR5LtxUPyTtuo16j2+1VBordE/0
 NpGA==
X-Gm-Message-State: AOJu0YyAskQ+pVP8bxvP2yq20BlCO9oy44vRe2T2MombSEW2jTr7lU1u
 BuTRQqlk6V6gjtssskGMvMB5kSVD4/SJ/1wVOwU=
X-Google-Smtp-Source: AGHT+IHBGvASUqK9+nbZ4Fa0oTP2I5wjN/u9wJJVa0zURd4pZw5mglXKWkhuvTLd43igz4kiKzUCWQ==
X-Received: by 2002:a05:6870:f155:b0:1d5:bb9e:a30e with SMTP id
 l21-20020a056870f15500b001d5bb9ea30emr33205597oac.34.1697232529036; 
 Fri, 13 Oct 2023 14:28:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:28:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 01/85] target/sparc: Set TCG_GUEST_DEFAULT_MO
Date: Fri, 13 Oct 2023 14:27:22 -0700
Message-Id: <20231013212846.165724-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

Always use TSO, per the Oracle 2015 manual.
This is slightly less restrictive than the TCG_MO_ALL default,
and happens to match the i386 model, which will eliminate a few
extra barriers on that host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index b3a98f1d74..9fc5c401d2 100644
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


