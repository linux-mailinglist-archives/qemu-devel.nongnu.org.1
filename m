Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1491825729
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:53:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmQx-0001O4-V3; Fri, 05 Jan 2024 10:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmPc-0004cE-2a
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:47:08 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmPZ-00043A-S5
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:47:07 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3367f8f8cb0so1468698f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469624; x=1705074424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jtVroaWgerQaDsLUvyZtuo+bUywnLD5o4M9nlpDsZ0=;
 b=VDQijkwCJ1HQdAfQ8E/PlYw7sxAyESEgnmZs6dVZKBNsnXMuMg6CBFOswzB1oBXfqb
 Ubf4CdJQL+seN+B9F+atrsqRkPt4pWS7x004/4aAwP3/r9aO0Nq1ThB8ekZbNZOt83yq
 LCLTsYha78OMsOfhiRfOgE+rU+NJYsScHk6fKIK39i4wzOj9snK6GL8wu+Pxu1W0iADH
 UtJS/T1ewG3je3XyHlqotnMpg0z6Fb+RkpiGizwE6v2mlLBxMrFKh+wrFsUP0MoXx5oj
 Sq5ZsNyq6OjI6uawou0unKvZPEMZGvGI197tzV8VNds4saxStWFRfOWHincotvqr1AW6
 KMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469624; x=1705074424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1jtVroaWgerQaDsLUvyZtuo+bUywnLD5o4M9nlpDsZ0=;
 b=D4uZp3xaDsKpyc3ozj3Oby8Phda76fh579VdAL6rf3pNS4+PkN2VSt+7jD0XBwEhTN
 qQjh8ulx5ZNWMmyLt8PN+ASXVcfFjfIcwzVHeJ0V8AIzJ1rRwvp0VVdg9r/77Up/RD97
 t/9uaKb9tARjRcL+FiUQaBHDpRD2LkRbcCaVa02SaUkKUb/Bm41Z313VWEzzcCn7UBJW
 nTh9tSsfq1BB1g8Jwt01N98kKWtrWJ5KZylTjc5NEigTDJkHHC/T06how/Xp3X/7y7Ww
 MpS5tVh4Z0OCfBpjYc8nxt5CirWmCEznq++64gFNnpBGvj0LVPI/0/9jzacljGi0M8Bh
 481w==
X-Gm-Message-State: AOJu0YymvdtB06JbFswOnfksb61tTDxR2JkgDzPnYh+4/y+/n9aNTeyQ
 Qp1Iq0lmHvzGOx/PGaqhOxy8K8HIKRGwgT3Jksi3c+/1JRE=
X-Google-Smtp-Source: AGHT+IGfX7XLY0IInv1rRiBr+Cbo3ElbzjQJv5YKvlcD1AnhJvNIAIYMskwmmCU3K/gIuIls72lsow==
X-Received: by 2002:a5d:4c46:0:b0:334:ada5:3835 with SMTP id
 n6-20020a5d4c46000000b00334ada53835mr1414314wrt.4.1704469623925; 
 Fri, 05 Jan 2024 07:47:03 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 cx12-20020a056000092c00b00336b702af06sm1612524wrb.16.2024.01.05.07.47.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:47:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/71] hw/cpu/core: Cleanup unused included header in core.c
Date: Fri,  5 Jan 2024 16:42:28 +0100
Message-ID: <20240105154307.21385-36-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

Remove unused header (qemu/module.h and sysemu/cpus.h) in core.c,
and reorder the remaining header files (except qemu/osdep.h) in
alphabetical order.

Tested by "./configure" and then "make".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231127145611.925817-2-zhao1.liu@linux.intel.com>
---
 hw/cpu/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index 9876075155..495a5c30ff 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -8,12 +8,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/cpu/core.h"
-#include "qapi/visitor.h"
-#include "qemu/module.h"
-#include "qapi/error.h"
-#include "sysemu/cpus.h"
+
 #include "hw/boards.h"
+#include "hw/cpu/core.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
 
 static void core_prop_get_core_id(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
-- 
2.41.0


