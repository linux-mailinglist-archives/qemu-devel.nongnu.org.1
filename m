Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7262AAB8400
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 12:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVpy-0001xX-47; Thu, 15 May 2025 06:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnj-0005Yf-Bv
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnh-0008I6-Gl
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:55 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so8375115e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304812; x=1747909612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JIJ68JD30MH+HTSlMGv4lj+b/tYOhGflwYgAmJjygGk=;
 b=SORyhL88O8zkaGfW9yqK/cALn9uEfxuS2ErkfgBV+199FJDqSFhGzrDZwjUYYaQ5r0
 YAYc7pgxU59/+kXpopPu5cuHQpZlo6xe/PNwBOac7VoJj2VYw1hjfPAxNxOo6DWDByav
 hzmsq9J8t1ufTQm8jxecjPYJrifGPVr9plI0fAjLV3zbVHfYhvnPzlgzJ/vIKtx3aqCH
 bX0ylXfMNgtkzXmxR7j/DdEOjITToZgx6u0BFeBO/5R1W6VPo/3gENAWiHXkcsreh407
 lRTlr92ab0paNhrs1l2TkRPhZhg5w13x6rJWESinmilo5zGigi4nji5MrkcbUdw796cu
 KB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304812; x=1747909612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JIJ68JD30MH+HTSlMGv4lj+b/tYOhGflwYgAmJjygGk=;
 b=vRheP40YS6G/kwvasOVzND5KICxZ/P8R/NxmuraF4H592zWJT1vdEreah8BQw+Vl7r
 z8ryg9u+p7UV5D0PUQRSKZlYIvZVdg0EOXguMhSNrNtmbbJuEaDwUjaNxLUJvSaXOGkt
 9OsZYybj/gFPae6hrEE2t0jOVuOVXkwRgeeusMP1LMlYx+gM9I1TKkCYicyBV+T0ZV2G
 rOPNifsWBxyk4Bt9pdrMtXMSgyg9WvTNG5YIo9MJyIUREWJkzkU4UotQsUbEj5HqWFmp
 8ve/tN56AqoQri3dPHvKsTeWv22UPkKYxX9vOmYZMHqK6AUKpiSAuC022rQBCZBoGD+S
 HBsA==
X-Gm-Message-State: AOJu0YyLpjv9OUAGO9dh0mboEtumnUAHKIgFYTDFKu3st4C6UDTip4Ru
 Y/1GbvZl8VtGedPMecsSw+CRjGv5ezGPQSonFH9uNxORndqjp0dj0YTgthOwzkzTByoj41W3n4j
 x96c=
X-Gm-Gg: ASbGncv3Y7yjEQliUl6m/ILWAptzpq60CWal7wDhgon+93mNL+/LsPAtCIkSTy+0MVV
 vxgNZgFzCctpY8TgSUK9np5EQp0K1AzT3uih6/rNgN+2iiExcw3UwlBRqCHq08cQzTr+8UQ76rN
 bdEtyT23PoiBHtANZzKZ0BBki8IfEMft65TagSMvNHzow3Nu31zSsT8dBBKj7hX2Mu42n+nLx6O
 2F/xZO2XwWmn7YM7i4kV1FKNsW8a5MOKLod9t6W5wjy8ZijUE+IXyvUgzuAJAdZUttL4h5LEifU
 XkpF9mJxIBO/8BWJBcHfet1Ak0u9a5pibYFrh4g67LxBYwE5XHqAAXOmz6aQTVha2wy5
X-Google-Smtp-Source: AGHT+IH8Ao10mWry0tW5kUeQtCKIwH1T+t4Q+pf+oFqCXw34SRBaR35MdIYURf/zL03gyel7DjcwQw==
X-Received: by 2002:a05:600c:190d:b0:440:68db:a013 with SMTP id
 5b1f17b1804b1-442f970aa3cmr17178395e9.25.1747304811919; 
 Thu, 15 May 2025 03:26:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/58] target/arm/tcg/iwmmxt_helper: compile file twice (system, user)
Date: Thu, 15 May 2025 11:25:40 +0100
Message-ID: <20250515102546.2149601-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-43-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/iwmmxt_helper.c | 4 +++-
 target/arm/tcg/meson.build     | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
index 610b1b2103e..ba054b6b4db 100644
--- a/target/arm/tcg/iwmmxt_helper.c
+++ b/target/arm/tcg/iwmmxt_helper.c
@@ -22,7 +22,9 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/helper-proto.h"
+
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
 
 /* iwMMXt macros extracted from GNU gdb.  */
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index cee00b24cda..02dfe768c5d 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-  'iwmmxt_helper.c',
   'm_helper.c',
   'mve_helper.c',
   'neon_helper.c',
@@ -68,7 +67,9 @@ arm_common_ss.add(files(
 
 arm_common_system_ss.add(files(
   'hflags.c',
+  'iwmmxt_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
+  'iwmmxt_helper.c',
 ))
-- 
2.43.0


