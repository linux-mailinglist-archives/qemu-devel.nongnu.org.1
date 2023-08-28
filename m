Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E9378BAE8
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:15:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qakVI-0007VA-EN; Mon, 28 Aug 2023 18:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakVF-0007Ra-Uf
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:14:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakVC-0004KT-6Z
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:14:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fef56f7248so34754215e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 15:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693260868; x=1693865668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcV1pV5u9SuvcmRud4Mp8xFzvcnx8scdTw95EYi68HA=;
 b=bxys3YdYXJMKN8Kf6vU6UW4r1EKUcN2fNWrONVtP01NlPtiYRw27SKaD6bmMD6VRzW
 Ky+oyZgPLMcQPvgufNSDSpXcCknrPeDiP9zKOetvIJuqurbAko6sc+5bx7BZ8HSwJCgV
 FtkBLRA0dPESqjxg/BOjyt8+VacRJ6A1AHkwr1mHSIsWTwhKEqXJPkYH+guOhIhSF0Uz
 ZeUEOaAGzlfWwnEoBoeyJs0oYWrnER9CyXCwxkUof+5v4ymtz/UpT4omvWZlK+FPNfk8
 6aMlIGhiLwFU37h3a1A44dktaQK7OC0l1GsiI9aw8at5iunAWKy9padnz+SMFX3yGPmF
 Sl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693260868; x=1693865668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcV1pV5u9SuvcmRud4Mp8xFzvcnx8scdTw95EYi68HA=;
 b=JIriTv8xGMaNsU8P/kU4toIb67tAFmExJqTkAHghUY/aVTlOHTPiL7KL0/vJiczy/r
 e3D98YXaY1nLENcKY2Loo3imtJfQpS/NxAQzfrUMH8vwtVPgH76yKYbAXOBRVgqQczgk
 Ik3ZHxxxc5z9twqv1PTdfgY8zcg9rAWRcrJIK4Aei4PpOmmr+LIYfMq/6NsUowuz96+u
 QUZSAvezq4PBw0QB9JMpSj9KEKpNmdvdJui++4nKYT5+yoHVraM6MuDHCnXxni5/3Yon
 Ajfy9T/nR26ttKWn6etpoBj+ky4O2TM10wXgKtjHHzBvlSJ1GqS/kxhVOBtp0WDQf95Q
 m8Cw==
X-Gm-Message-State: AOJu0YxzRmjdUBl9POX5rH9TJt+KLo7EsMHd42kaeDY6lcF8/2dNIzWY
 VZCHcdx5AjpU59EWQKYpfr8wuFoaETDxOD9houI=
X-Google-Smtp-Source: AGHT+IFpSwWHdeitvfzjQL2Qo7QEnZZexfoyi5OWqkugfCiTnY9cz8wLwSAWbi3uVZuaV7EGQhAhhA==
X-Received: by 2002:a05:600c:b42:b0:3fe:2b76:3d7 with SMTP id
 k2-20020a05600c0b4200b003fe2b7603d7mr19786764wmr.10.1693260868477; 
 Mon, 28 Aug 2023 15:14:28 -0700 (PDT)
Received: from m1x-phil.lan ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 m24-20020a7bca58000000b00401b242e2e6sm13062052wml.47.2023.08.28.15.14.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Aug 2023 15:14:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/11] exec/translation-block: Clean up includes
Date: Tue, 29 Aug 2023 00:13:14 +0200
Message-ID: <20230828221314.18435-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828221314.18435-1-philmd@linaro.org>
References: <20230828221314.18435-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

'qemu/atomic.h' and 'exec/target_page.h' are not used.
'qemu/interval-tree.h' is only required for user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/translation-block.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 5119924927..b785751774 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -7,11 +7,11 @@
 #ifndef EXEC_TRANSLATION_BLOCK_H
 #define EXEC_TRANSLATION_BLOCK_H
 
-#include "qemu/atomic.h"
 #include "qemu/thread.h"
-#include "qemu/interval-tree.h"
 #include "exec/cpu-common.h"
-#include "exec/target_page.h"
+#ifdef CONFIG_USER_ONLY
+#include "qemu/interval-tree.h"
+#endif
 
 /*
  * Page tracking code uses ram addresses in system mode, and virtual
-- 
2.41.0


