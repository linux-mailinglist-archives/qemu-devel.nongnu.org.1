Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E767D70DEEA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:14:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVk-0003Ol-1d; Tue, 23 May 2023 09:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVc-0003Bl-6P
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:04 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVa-0004CR-55
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:03 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d3491609fso3279236b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850221; x=1687442221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h+RdJQ/zC7YSHEg4bhdr641ZyzAbD7cM7kABj3n3kOQ=;
 b=Koj1bKC7RgazYhoHG5o2b7zoai4YsVwVUNawjwmzzuUR7AXTo4Mh2KgUTiY0jDX81o
 dxbYuZZB2oTECfJBUmP0uZKNXEjlPmU6+Vc8LzTJanZ76VCWF2I3jMZO4OULCyj5S6Km
 oxQ2uKQ4Ag372wJpoSqbca8gDuO5BZbzTCoaMMSDRKMBGkQzQ+iEUDgHJa8wZNgRKuM2
 OqrnMzuv6d1TfVt1XcdtG03EYIwAst+8cRUBwppGD4cV5mgvtb/089JoYPNPBl68URNN
 zRdVyflsguS5ouoIzMBWE2oMt/Ca/zPFVTYLxr+29RvT2oOFTVqqxVtgP89+kMfOg4so
 VNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850221; x=1687442221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+RdJQ/zC7YSHEg4bhdr641ZyzAbD7cM7kABj3n3kOQ=;
 b=W32Vbp2wDHNQIHqz1RJB6cZivy9f7Pm2uq+nh0LhMyJCwSx+Dgl2v+beaN+hB6LC0O
 K8zLrHaAZ9SPEZx1R7DLsm7YrfGfZzF787wAPAfU+q3DRdNFH27Z4mBVWZ9itKeoa5At
 cmOXvWlvXKLBZjcPLSNDAXCX8jvcePG7IXd+Ex4bvNBCmOawXiKGkuBimtM+W48N468l
 Gb1dAVgRDt+A4l4CaTIBVMwJaz6rQ9Jq/4KongrK4UePxFtIVN6p0jluTe8yDnm7q/j3
 /HBrgU4QBZZaTMVd0qcVu8FsAPtfnd+RFm2KBOAePTdrGXS6Bh7/Oqy+4c49I4x0hPxR
 5mhQ==
X-Gm-Message-State: AC+VfDxgW7lCfki31/3F10ixx9xbSUVNv2U1iIm1QgFzJRimbvy4Qtdd
 +F3T56ri3y19cMLaRxXAcDsDEzXjQCrCYdTbA3o=
X-Google-Smtp-Source: ACHHUZ7xBqMCqV0MPnHQ8hqIxD3+yjhEcrKOD0ac1Ag2hNckZhcraQSg64OaRsjlDLtR79sscQ+L+A==
X-Received: by 2002:a05:6a20:42a2:b0:10b:8e96:561 with SMTP id
 o34-20020a056a2042a200b0010b8e960561mr7085080pzj.62.1684850220764; 
 Tue, 23 May 2023 06:57:00 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0063799398eaesm5805790pfm.51.2023.05.23.06.57.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:57:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 45/52] tcg: Define IN_TCG
Date: Tue, 23 May 2023 06:53:15 -0700
Message-Id: <20230523135322.678948-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c      | 2 ++
 tcg/tcg-common.c  | 2 ++
 tcg/tcg-op-gvec.c | 2 ++
 tcg/tcg-op-ldst.c | 2 ++
 tcg/tcg-op-vec.c  | 2 ++
 tcg/tcg-op.c      | 2 ++
 tcg/tcg.c         | 2 ++
 7 files changed, 14 insertions(+)

diff --git a/tcg/region.c b/tcg/region.c
index bef4c4756f..34ac124081 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+#define IN_TCG
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/madvise.h"
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index 35e7616ae9..678ab482f7 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+#define IN_TCG
+
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
 
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 95a588d6d2..0ecde731f4 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#define IN_TCG
+
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index f32c0fda35..dc8dcd8b4f 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+#define IN_TCG
+
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 35d67eeda0..6c70178e9e 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#define IN_TCG
+
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8c1ad49c4e..16ff61c65d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+#define IN_TCG
+
 #include "qemu/osdep.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7d0449f6a9..38321d6d54 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+#define IN_TCG
+
 #include "qemu/osdep.h"
 
 /* Define to jump the ELF file used to communicate with GDB.  */
-- 
2.34.1


