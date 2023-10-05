Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 691B07B9AD0
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:00:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGMN-0000Ka-2M; Thu, 05 Oct 2023 00:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGMB-00089P-2I
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:53:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGLx-0007WX-AE
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:53:02 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3231d67aff2so597174f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481564; x=1697086364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wgGQUdIqiLvE9KKvhjp7xkKxDkuA49hJ4+Z2t/uhpA=;
 b=SDEOpmTikw5g6deflJo53rh1/u3ysaag+xEQYrSkZhB9D9VnjdbRWNVgTQbFaPi4aj
 P1LH4jyGNXWfOVDbXaXIMigRV7NYqahh+zMpR0By5Vj28JC5SzrOl6uQe0I3I4OeCCiS
 Fed528RNplbg+m5tN/yPHokmcLMaS8d2HYrorvFf+NcMLkReHP24kuFbjJX0OVtJns5S
 aWFZgCJtv4FuMNhONmpdkbKMplPQIZ4EbcRP4gP+U4Js9ylPIG6pcrqkQL6XNRx5m/ZQ
 /dHJFZSCroIg1eg56q/HRJoGnFdyUBkWw0M8cS8xV5lwUYfqwYvfRtcB1yG7w+BWzAzy
 pRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481564; x=1697086364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wgGQUdIqiLvE9KKvhjp7xkKxDkuA49hJ4+Z2t/uhpA=;
 b=H+JR/yip2ECOtJYEgfUR5CXReuYZsFerEfCrmVaFH46HBXXC+qlRNp3qdqRkqM/wQF
 KoipSY+uSWFlid1oE7FWRudrbP6p0I5pH3FG5n1s39vOYH+oDX71QAp/K7wEI0exp/Af
 ja+M52dESvP1VPr4MWhGzjBug1F0BiRkLlw3sEpj0b3ucA/n0HYEwliTF4bsnyEMCAem
 PkGj4ffRQzg0jHnYmfI55zevmsk2YGVNmeMsZkpN4TNQUtzml2Xrqbp2RAQnoOfu1jPh
 5RB0g7NsKwRU6+mAaltn33xMB7D9TBKiJWdikLBcksl1l+GjjRwcrNoKHw37SEtD4aRy
 he1Q==
X-Gm-Message-State: AOJu0YzxyCyoxfQa/7dmENvvqlGlZX1RGzsuVZqlBO9OC2TQRrZmf4bq
 RmBeyyJBQFB/q3/gozbdIhyiJU372BcOIqdTYEc=
X-Google-Smtp-Source: AGHT+IFdav5P3cunxf2E/jQegfKMGYv08pZ7bZhiz9vgbp6gkm+EstEbxiR3/Xr+1DqtOXhWpCpZKQ==
X-Received: by 2002:a5d:628a:0:b0:320:bb1:5a73 with SMTP id
 k10-20020a5d628a000000b003200bb15a73mr4072042wru.22.1696481564050; 
 Wed, 04 Oct 2023 21:52:44 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 e14-20020a5d594e000000b0030ae53550f5sm749481wri.51.2023.10.04.21.52.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:52:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 18/22] qapi: Inline and remove QERR_PROPERTY_VALUE_BAD
 definition
Date: Thu,  5 Oct 2023 06:50:35 +0200
Message-ID: <20231005045041.52649-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005045041.52649-1-philmd@linaro.org>
References: <20231005045041.52649-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Manual change. Remove the definition in
include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qapi/qmp/qerror.h | 3 ---
 hw/core/qdev-properties.c | 2 +-
 target/i386/cpu.c         | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index b0f48f22fe..7862ac55a1 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_PROPERTY_VALUE_BAD \
-    "Property '%s.%s' doesn't take value '%s'"
-
 #define QERR_PROPERTY_VALUE_OUT_OF_RANGE \
     "Property %s.%s doesn't take value %" PRId64 " (minimum: %" PRId64 ", maximum: %" PRId64 ")"
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 357b8761b5..44fc1686e0 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -682,7 +682,7 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
         break;
     default:
     case -EINVAL:
-        error_setg(errp, QERR_PROPERTY_VALUE_BAD,
+        error_setg(errp, "Property '%s.%s' doesn't take value '%s'",
                    object_get_typename(obj), name, value);
         break;
     case -ENOENT:
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ed72883bf3..e5a14885ed 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5190,7 +5190,7 @@ static void x86_cpuid_set_vendor(Object *obj, const char *value,
     int i;
 
     if (strlen(value) != CPUID_VENDOR_SZ) {
-        error_setg(errp, QERR_PROPERTY_VALUE_BAD, "", "vendor", value);
+        error_setg(errp, "Property 'vendor' doesn't take value '%s'", value);
         return;
     }
 
-- 
2.41.0


