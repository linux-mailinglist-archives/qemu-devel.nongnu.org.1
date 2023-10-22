Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 379B27D2134
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:01:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW1-0000Te-78; Sun, 22 Oct 2023 02:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVy-0000NM-32
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:42 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVu-0001UR-2a
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:39 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5859a7d6556so1729791a12.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954436; x=1698559236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xd5Svu0+B7OGG++QiM45a02WgNYRHjpbrT0y5ShkAgs=;
 b=cd6jvtOq9pwgTqPmNqOzqIj6EO0/D41oaEtIzb6j1Q5+ww33cbs9Iy/4zambvCyk2A
 VnWdnLQqVGVGH8ro3FHTpNVGVjanoV79Mtbj6Oa1dLOPrfdlsa58mtN+kt1Vdnpej0VP
 2uXASFYxvmfjbYblwmrj5oPcjQX8QQ2SroannGENomUYwoa9nXQruW8fx3E+Mtg7f+lQ
 LdzLWi9RgpQCZOXiMmOatfaTfUIZ5dYusVKbG3Fg+5Fnt9qYQeylhd1+66KdZe8gCi3d
 xvgBjZN5l16BG8kHlDilrLW2ip2Jl3lE2KMbFzKJrZZCZOgk9MGk/vxqRSQYyHYFHTTJ
 XOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954436; x=1698559236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xd5Svu0+B7OGG++QiM45a02WgNYRHjpbrT0y5ShkAgs=;
 b=aihDWFq8FWYwxpP+JSeO7tgiSHJK+vtFOhGGT7WA83z3PkkA42KvutTLmrvdrLXsbx
 9zTC2lS58aO1/JrrXJdTxTY+aNMeHL06LUXRYZ3KVqFb+UlGNT10ZGBr3QZE0bTvd21r
 0Ow4wZSRo9aGxsP6ZGuy76lVLK9pPhvB7xv9ej0gXoXe7fqLCMzrgUiZPf+1sNNAobYQ
 5VGgHIqwfRRYXagUPNHIckXWMcFTrEcRCddkm8oNdsgxRaQEcUyc701h5oza/e4f7Z+a
 2HQTCcG0ZaFXRt8AVo5df/7cb68i1W+tT3dD84RUCrdpcwBlGJA0DIdC1q9t7Yr7VO8Z
 iSPA==
X-Gm-Message-State: AOJu0YwNFtkaaEm0OAJf27JS16iFoujFi+JX6BdYNIv76Cje6TAcGYEh
 ZBikxHZ1Itd97oJI8DN1gOe+S3LD9wXJss/Eei8=
X-Google-Smtp-Source: AGHT+IE0bCqpfTnhG6ay/GpPbCRw4WCBtynrGCcl7nmjaekwRCo/N+j/3cP3dR+9dH10TxRCH2q9Qg==
X-Received: by 2002:a17:902:e0cb:b0:1c9:e85a:4296 with SMTP id
 e11-20020a170902e0cb00b001c9e85a4296mr5017259pla.6.1697954436531; 
 Sat, 21 Oct 2023 23:00:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 04/90] target/sparc: Set TCG_GUEST_DEFAULT_MO
Date: Sat, 21 Oct 2023 22:59:05 -0700
Message-Id: <20231022060031.490251-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


