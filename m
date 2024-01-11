Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B6582B2DF
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 17:25:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxrP-0004Nq-3w; Thu, 11 Jan 2024 11:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNxrM-0004NT-L1
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:24:48 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNxrK-00018y-Tv
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:24:48 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50e766937ddso6432118e87.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704990284; x=1705595084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iBi25ZUfbpHVLkBsSCP+3iFKheXkRA4Fy++onwN3ifw=;
 b=vzHgg568jXPN7bqv4EarFoXedwStlZc7oNsmv3AU8Ny4MZDdnLS4z2oMLsP9xQGT5I
 TlezR3S/vrik3jJaDFwSJe/jgWnZgy+7bEBPOcRr4r+2g1brWfRFIRIZ2tr6ECg1MOA2
 BxWYIjmpsXFXSa0EskwdGLoO9CNu6F/VXZPfnlWGgQlyrP9/H9sCzh1mq2rcMMlMQQwN
 yrgTIt+CZqeR5nsBYOKQOHN9rZtPc4spaqCZaa81InrmE/TyZDl9TrHw5j2LHbHnScQu
 2v6qEf/px7H8x+ay4UEKH5dNqZLXWk59l6LgS9mCjBEhlLyyfHX1sjjr1prbt3EDHzWf
 DmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704990284; x=1705595084;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iBi25ZUfbpHVLkBsSCP+3iFKheXkRA4Fy++onwN3ifw=;
 b=wH3kvp1/k/QQVqkcNd3u/pxH1Dhr0qlGw6TVtgz0MH4kNxIJztV36eYVRa9K5CPa/q
 bZIrrCeii9NKduoGZGnIaqe85yfagMgT1Uyyx2vHR6HUsYZwbyHYbsFUtzj6BuM4be2e
 AQpOaAHDJ9/er9P3FOBYsJc78OU8b3zIoG9jAEjGsemWwS6usY1/vQJ3KXOlSchYqNKQ
 KFWXjJPq8IbdlSRd93GuMmdublPcPWRjKLKN1lNamtybb/GaU3YATbBoT4ADeqlxeerx
 Cd4lBgueizFO4BPwHd97g95VuSQJrlOvF7Ae5OAQCMhysq9xaD8y/kv0ZCeHPvUFHBWa
 EP9A==
X-Gm-Message-State: AOJu0YwuTv/cpctIrFlob/dzfLJGIE+eRn/R/jeR7+bmjMgWZX+Q8roD
 3Z1g0KSW4b2zRH7ZgboTAD3qQuTGoLa26kaWx2JKZTFy75hMtA==
X-Google-Smtp-Source: AGHT+IF2cBR0sXqbLEVTPCbkaE9pofFEnE9BaOzualgdeQ+Ov1MOYKDDKBvdFJxncZdrcWnNTqfY+w==
X-Received: by 2002:a05:6512:3ca4:b0:50e:3812:c075 with SMTP id
 h36-20020a0565123ca400b0050e3812c075mr862736lfv.117.1704990284664; 
 Thu, 11 Jan 2024 08:24:44 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.145])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a1709065a8d00b00a298c766585sm756127ejq.57.2024.01.11.08.24.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jan 2024 08:24:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] accel/tcg: Include missing headers to 'tb-jmp-cache.h'
Date: Thu, 11 Jan 2024 17:24:42 +0100
Message-ID: <20240111162442.43755-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

Due to missing headers, when including "tb-jmp-cache.h" we might get:

  accel/tcg/tb-jmp-cache.h:21:21: error: field ‘rcu’ has incomplete type
     21 |     struct rcu_head rcu;
        |                     ^~~
  accel/tcg/tb-jmp-cache.h:24:9: error: unknown type name ‘vaddr’
     24 |         vaddr pc;
        |         ^~~~~

Add the missing "qemu/rcu.h" and "exec/cpu-common.h" headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tb-jmp-cache.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/tcg/tb-jmp-cache.h b/accel/tcg/tb-jmp-cache.h
index bb424c8a05..b13a02e45d 100644
--- a/accel/tcg/tb-jmp-cache.h
+++ b/accel/tcg/tb-jmp-cache.h
@@ -9,6 +9,9 @@
 #ifndef ACCEL_TCG_TB_JMP_CACHE_H
 #define ACCEL_TCG_TB_JMP_CACHE_H
 
+#include "qemu/rcu.h"
+#include "exec/cpu-common.h"
+
 #define TB_JMP_CACHE_BITS 12
 #define TB_JMP_CACHE_SIZE (1 << TB_JMP_CACHE_BITS)
 
-- 
2.41.0


