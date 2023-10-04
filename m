Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7D47B86C9
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:42:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5ll-0005xF-46; Wed, 04 Oct 2023 13:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5l5-0005QC-H6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:34:06 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5l1-0001IW-NL
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:34:02 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3232be274a0so774322f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440838; x=1697045638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wgGQUdIqiLvE9KKvhjp7xkKxDkuA49hJ4+Z2t/uhpA=;
 b=hZB/CKx1pd5p0+oU/wOex0HZCaYFijZ2K/ar+bchIzz/D5Fnu2njue/V4x0xcDxi2x
 OAJ0RXuQrDx5xzhc3ck+/X6wsaNLJBzDBD3C2cgRp2dZFnmt7WZKjvyNPgHwP86gayCJ
 Fzsc8SSqRNRR+jo49UolpGnkyIcPVl3vHIc19zux/5eFLC/kjpI9LBD9XEKb53YO2tlA
 +Xo4KRZUAO4Yofty+sYVxHXfcJMoA7ZP8buj4SrF2iss/mI6h7Y7wWuHrKSdZrMjeQ3l
 81pGp2KGIjMum+Oz+iSi0oYgY1XkXDuwP/GLdPn02BRv7wU60f9JOE8b3ZRhY0K2pRb2
 aNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440838; x=1697045638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wgGQUdIqiLvE9KKvhjp7xkKxDkuA49hJ4+Z2t/uhpA=;
 b=GbSNJa+S+4/4U8WvDDhFPlos3bWrak6Fle4TGh4lqZcz56RNPaLawmb7w35pxKpKoS
 d2Q1jC2GzoqCdV8mOZZDxjCnVtM6YDXnxJFIddQ8JVDqKD2g30sA05gAn6/bsKcqhXUl
 NYz76sUok19TKfpGbgkp7AoF4E83h8zk1BfbkQ/XWzC7Zg7qC0NSqH2dcaxhKOduLfZ2
 raxYlhLaJUtIqHGJzDVl7BU4qa81/qAY2hgiMsT+j/OnT1bkzdftPKCA3vrdbZ8ecpxW
 rB7i2Jxd0dM4vl8w6NZxAktvN9ZidEPM5pZ9rsWMWpV8QDeJivUrh5uUXnpoO5z8ib4l
 D6ug==
X-Gm-Message-State: AOJu0YzXGZG7i0vExhYpBatQ+eiY3SZCp5RDbZ8KhtgUXuwdQp8x0kls
 G1JHgoyMHc27vav1y97KHGcNEM5N1GffO91tJZQ=
X-Google-Smtp-Source: AGHT+IG5t9+ERq5Dx3FYyAIHdJmdCRaZM1DB1dv9z2ImlObMWh99iAzoLGLOaSxi5d0tVcFlpve3bQ==
X-Received: by 2002:adf:cd81:0:b0:31c:2f95:8056 with SMTP id
 q1-20020adfcd81000000b0031c2f958056mr249994wrj.23.1696440838160; 
 Wed, 04 Oct 2023 10:33:58 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 b7-20020a5d5507000000b003247f732c11sm4499225wrv.76.2023.10.04.10.33.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:33:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 17/21] qapi: Inline and remove QERR_PROPERTY_VALUE_BAD
 definition
Date: Wed,  4 Oct 2023 19:31:52 +0200
Message-ID: <20231004173158.42591-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


