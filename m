Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 119657A0D9B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:58:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrWu-0007q3-RI; Thu, 14 Sep 2023 14:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrWs-0007pU-Hq
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:57:30 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrWr-0007SW-1I
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:57:30 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so1638682a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694717847; x=1695322647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WvL3ArqDJTyQMa7Dhgweczo+eomNigdqJoFYXgKa+wU=;
 b=t0Mi3kXu6kKqN5Eo5ESu/k0OyC2spq01VIl2JNbcQNOphJuzBwbuMr0AoRhxU8OB0J
 KPQEYbauPzIEw3sD+qgJcO+z/NKQ4bx9bYOxd25s7nmDMA1UoFz3bdqYIfK3GS+wrHip
 ySryFQ1TIppkOL0bKAeaWOqIV7YrGOKGi0/ZtaLy/hRz35svLUO4AL0UkMaH34gCQy3W
 eTCvkCeWjLdk0rhwEytgZr9bNvXFwo1pmT0kGgOk9ebs3ofEoAXoMYIoaOVZa5V3ixS3
 uY59TNQ3mSbkInXPz8U6UKTKYnV0tYIkeh0NLlgLZF9CzHak5P/TUKCAgDPosdPvQMMa
 OKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717847; x=1695322647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WvL3ArqDJTyQMa7Dhgweczo+eomNigdqJoFYXgKa+wU=;
 b=SA/af6iuXl3ih1Jc3/yKUZBAlQCTqzw5ue6F9TTbbdiOnEiTprtKshy+NG3MKCWa7h
 ohx4Kav19dToW9DjWkWrjl+bTisyJIPUk3ECxQVSivcBYkUT4l/7B0a45xzFEcjwsICq
 GyP17/H3/JKQ8OoSVTkDzyFmjStPjRsCVFYzpNBoQ+APvh8sE/7IEfh2Wz6rKJCj7Kvc
 LZCQiQefVzgzEQukBQ1vZe2elu0rxxNFdjvc3UVz/owVDFVBTQJtghBimg9czRVM70vJ
 DlHemTPECAQp2ytKVHdQd/hPqEC05RyWdpXYMAW5Oy29oAiDSd/CtPWvObSnWKL0pBSW
 4pVg==
X-Gm-Message-State: AOJu0YxU1Q/iBcJ+1DbIJGf2wJUH4c8ffwl7TpxrkxEnFXJjZFTzsLi5
 roEGv+wkDa+aAn9ltByXW/O69NJnrBQgjjsiW54=
X-Google-Smtp-Source: AGHT+IHDYAEa5TZcbZhYbmcLS0ut7IVlOIzUfaZHdYGWcp9X52P2PwS+2Kzs2P1w9NaBSDHLB/o1eg==
X-Received: by 2002:aa7:c147:0:b0:523:d51:bb2 with SMTP id
 r7-20020aa7c147000000b005230d510bb2mr5420515edp.15.1694717847409; 
 Thu, 14 Sep 2023 11:57:27 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a056402120b00b005232c051605sm1259921edw.19.2023.09.14.11.57.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 11:57:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/11] exec: Make EXCP_FOO definitions target agnostic
Date: Thu, 14 Sep 2023 20:57:07 +0200
Message-ID: <20230914185718.76241-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914185718.76241-1-philmd@linaro.org>
References: <20230914185718.76241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

The EXCP_* definitions don't need to be target specific,
move them to "exec/cpu-common.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-all.h    | 7 -------
 include/exec/cpu-common.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 3b1cec390b..71efc2d404 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -26,13 +26,6 @@
 #include "hw/core/cpu.h"
 #include "qemu/rcu.h"
 
-#define EXCP_INTERRUPT  0x10000 /* async interruption */
-#define EXCP_HLT        0x10001 /* hlt instruction reached */
-#define EXCP_DEBUG      0x10002 /* cpu stopped after a breakpoint or singlestep */
-#define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external event) */
-#define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
-#define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
-
 /* some important defines:
  *
  * HOST_BIG_ENDIAN : whether the host cpu is big endian and
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 41788c0bdd..360b8298a4 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -7,6 +7,13 @@
 #include "exec/hwaddr.h"
 #endif
 
+#define EXCP_INTERRUPT  0x10000 /* async interruption */
+#define EXCP_HLT        0x10001 /* hlt instruction reached */
+#define EXCP_DEBUG      0x10002 /* cpu stopped after a breakpoint or singlestep */
+#define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external event) */
+#define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
+#define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
+
 /**
  * vaddr:
  * Type wide enough to contain any #target_ulong virtual address.
-- 
2.41.0


