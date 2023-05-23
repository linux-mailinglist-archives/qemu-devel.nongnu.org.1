Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D9E70DEF8
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:16:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVn-0003UD-Ar; Tue, 23 May 2023 09:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVf-0003I9-PU
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:07 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVd-0004DC-8C
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:07 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d341bdedcso3312969b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850223; x=1687442223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HKdjWZZDyCzXoRyD/E9HH3fJ0gjM+XwFZKOPdo6BjpI=;
 b=WkRLK51883e7bpZO/iYsoVq5BCzR3k7C+jg6D5BDuDoJDXOAZH287tRVXOBM5QH/g5
 cagbifNN3OlwCvrHoBOmZmjzsaTvQtsuEAUraq4kn2I7/FrhGo6Dvif94Gkh1xXyy+48
 bIhEcyJhKFyEFB91Qk6T5OwDsakHJr7lYt+S9l2UQmrHyJe3A2UqjDzN/uwuIy76pp0/
 XhZGm9d8FOUzpKf4TJAZfXcI2NKxS3sUmmOub1bspkkGycHZJQmbRrGphUdKNMBg15Qz
 1os8MqPS58yQ2vbxQatfy2iUoMRC3w1Alu0Z1Kc47uQRNX1vwtjKCFv3XCDyqcYnk7Fq
 VJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850223; x=1687442223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HKdjWZZDyCzXoRyD/E9HH3fJ0gjM+XwFZKOPdo6BjpI=;
 b=ZuihwQb8LayMCHQ6wnOKgd6lewRv7s074BFGVN5tIxgBnRALOI1MaSCOn4RMMA8FL2
 6hGCqlvjfYdRXD6YSxxGJOePRMJLGccTGBxtK0rGXie7bmI9UyICjL5161vsrgZgvfE4
 /k8D+wyD2ZuBFFufAA/IwIpC9s3JYEYAEH7h311Bdpx0aQKqJZaXtLG/9SeTtxvY6EoD
 c+fnEicWw9ZKxlz/LVnQ+SlL9pxdF3/w0S/CpFHpenhIZcDUTLW3EIs/BOG6If3qf6x1
 a9CJHCYv4m+iuoObcmguEJ13egYU7XxEa03rn9Z2nGDFsBruN2RnLAVT6alqMcK77IkN
 ogiQ==
X-Gm-Message-State: AC+VfDxZSUmDGCrgZGvMp4nqiR7LrlzIFFSjkVkbi7T3mgtcRhamyYvb
 AziYO05Fqoka8wiYBhM9Vrj3HEgqMjTEL5qMN6s=
X-Google-Smtp-Source: ACHHUZ5y86anIC+mrp4VO4A1bp5+q925y2mz0EoDyqpjKbHdwuv3zoDF07d0CYcCxKlVzhzNed7urQ==
X-Received: by 2002:a05:6a21:7891:b0:103:b0f9:7110 with SMTP id
 bf17-20020a056a21789100b00103b0f97110mr18064168pzc.11.1684850222872; 
 Tue, 23 May 2023 06:57:02 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0063799398eaesm5805790pfm.51.2023.05.23.06.57.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:57:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 48/52] tcg: Remove target-specific headers from tcg.[ch]
Date: Tue, 23 May 2023 06:53:18 -0700
Message-Id: <20230523135322.678948-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This finally paves the way for tcg/ to be built once per mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h      | 1 -
 accel/tcg/plugin-gen.c | 1 +
 tcg/region.c           | 2 +-
 tcg/tcg-op.c           | 2 +-
 tcg/tcg.c              | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 635fa53fdb..a498f31967 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -25,7 +25,6 @@
 #ifndef TCG_H
 #define TCG_H
 
-#include "cpu.h"
 #include "exec/memop.h"
 #include "exec/memopidx.h"
 #include "qemu/bitops.h"
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 3e528f191d..5c13615112 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -43,6 +43,7 @@
  * CPU's index into a TCG temp, since the first callback did it already.
  */
 #include "qemu/osdep.h"
+#include "cpu.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
 #include "tcg/tcg-op.h"
diff --git a/tcg/region.c b/tcg/region.c
index 184e684b04..cf4568bb8f 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -32,8 +32,8 @@
 #include "qemu/cacheinfo.h"
 #include "qemu/qtree.h"
 #include "qapi/error.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg.h"
+#include "exec/translation-block.h"
 #include "tcg-internal.h"
 
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 16ff61c65d..ba12bf053e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -25,10 +25,10 @@
 #define IN_TCG
 
 #include "qemu/osdep.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
 #include "tcg/tcg-op-common.h"
+#include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
 #include "tcg-internal.h"
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 38321d6d54..06085f4c99 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -36,7 +36,7 @@
 #include "qemu/cacheflush.h"
 #include "qemu/cacheinfo.h"
 #include "qemu/timer.h"
-#include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "exec/tlb-common.h"
 #include "tcg/tcg-op-common.h"
 
-- 
2.34.1


