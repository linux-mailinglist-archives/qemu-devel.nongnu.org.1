Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9DA735B61
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBH3g-0005or-2v; Mon, 19 Jun 2023 11:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH3O-0005DT-Dq
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:44:37 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH3L-0001Cz-Nx
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:44:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f906d8fca3so20890235e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687189456; x=1689781456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPnCvSZ0LTnP+mwyCnVM/2nlrxmNit9JdtgjWZL7/t4=;
 b=huFBZXd5Rq/lBBTEcoH02wzruA/q0MRocs7uFC8/JiXzHNU51Fk2p20EikZjlfry6A
 CBNLQSz5cJ78haPAbyD5Yzst3yqibORAf/6I7FZ9enHEAl6UF4f9ueFD1fuDyEETrCGd
 w9XuJNw+sXfw0jMiGp+95zH2wSm1hjqxMOhiBZOqiG50K9i5kwvBE1prXhcuSizsBsit
 U/cG3ODRXU68LS45UxPSlh6MKvRVo4T/wnu+vcjuRsulwcjn+aONcvBuFItwSkSa4npI
 OCkd7u7k1HCg6Cbo8tum90wIQNOOfK3Y9Kk7yhPyiyW2fK6AHSLQF8mCGlq7oB6NTCNz
 MGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687189456; x=1689781456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPnCvSZ0LTnP+mwyCnVM/2nlrxmNit9JdtgjWZL7/t4=;
 b=RRfTEU+zK6Yi1IqhJ4abivqqKtKWL0XBZbrMYWNIkNkQQ2X9dMtJLGlRxla1vCiMo9
 p3DkC0QysXl1zvV0cp9uU7fAlTmD5qIEZGh5v9yEI+hSAf2hq2gj9PPM8ad648YRTRIF
 DT4m8qjl6jWZ3LwshYSclTWdh90cRTPbrREPO5NeyoDSzCJucUHpT//4KtiqRADx+l30
 mdyj+EidnrFLDLMSRXtnHu63I3Z+cDmUvhYdJAvyE2vRO0xi5MiKqp1hTLnvn8DhC6+Z
 ytSO/kewOzfgvNPM8r71hYxs7EiEoVKFg7iiAe05ETC2DG2iqbM2VLRq21/zTBtFCjEj
 ehpQ==
X-Gm-Message-State: AC+VfDwABLYL97KJBn8Tmp13h3FibhbbpeoE11AI3Vx6rxNMoGalWMc2
 15xU0NeNd93DXYt3iYs6mZCkS2f7oiyQ4Rh4mwMeug==
X-Google-Smtp-Source: ACHHUZ7lfxmbWYjEU/VObmOkwvTYSxFRGedvCjqzqhbGgKWxcVYe4A65Qvp5E0qw1xr/AGUC7Cszww==
X-Received: by 2002:a05:600c:2c2:b0:3f7:3699:c294 with SMTP id
 2-20020a05600c02c200b003f73699c294mr7257735wmn.29.1687189456742; 
 Mon, 19 Jun 2023 08:44:16 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 l10-20020a7bc44a000000b003f733c1129fsm21097wmi.33.2023.06.19.08.44.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:44:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/34] target/arm/tcg: Reduce 'helper-iwmmxt.h.inc'
 inclusion
Date: Mon, 19 Jun 2023 17:42:35 +0200
Message-Id: <20230619154302.80350-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619154302.80350-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Instead of including helper-iwmmxt.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h               | 1 -
 target/arm/tcg/iwmmxt_helper.c    | 5 ++++-
 target/arm/tcg/translate-iwmmxt.c | 6 ++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index c4a321c0ea..dd12fee107 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -949,5 +949,4 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 #include "tcg/helper-sme.h.inc"
 #endif
 
-#include "tcg/helper-iwmmxt.h.inc"
 #include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
index 610b1b2103..ee607a3d3d 100644
--- a/target/arm/tcg/iwmmxt_helper.c
+++ b/target/arm/tcg/iwmmxt_helper.c
@@ -22,7 +22,10 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/helper-proto.h"
+
+#define HELPER_H "tcg/helper-iwmmxt.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
 
 /* iwMMXt macros extracted from GNU gdb.  */
 
diff --git a/target/arm/tcg/translate-iwmmxt.c b/target/arm/tcg/translate-iwmmxt.c
index 57a924c578..9f6d717ee0 100644
--- a/target/arm/tcg/translate-iwmmxt.c
+++ b/target/arm/tcg/translate-iwmmxt.c
@@ -12,6 +12,12 @@
 #include "translate.h"
 #include "translate-a32.h"
 
+#define HELPER_H "tcg/helper-iwmmxt.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 #define ARM_CP_RW_BIT   (1 << 20)
 
 static inline void iwmmxt_load_reg(TCGv_i64 var, int reg)
-- 
2.38.1


