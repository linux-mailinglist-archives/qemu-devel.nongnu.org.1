Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 079BA7B86C7
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:41:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5ja-0003C4-ES; Wed, 04 Oct 2023 13:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5jW-0003A3-Sq
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:32:26 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5jV-0000wR-ES
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:32:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40537481094so569695e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440742; x=1697045542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBDxOWnGC99luImlqjntVhvHvQ5f4z9cF2Uz6KLOjxk=;
 b=VSp17taar6VbWZfp9AnJdLculXNb7EzI8Dnwscv462lHqLzlYqw/y4CyFkunO52/dE
 cxPizSyaUzKfJrRTlWCUMkKSO8IoVKOe9lFeJ62WykY8apykTO7EerUUAxQAYperJGcI
 CbGBc439kYpxUy04d2iXe+BmI6JzixbKIv6LVGJ2Px6y8WtizoEoo5NvVZC23HvQZurw
 yXOWufh8COCAVsQeYzDx+L+xwLwPJJCIoS6nFphY5RorLQcwd2jTrMXxlO05dQA9IQ7a
 JxkRcbdF5s4FezaXNdyQmQEY8LEHO9Vp95TGjZ76wQYX1CvrbWPUvLbrIcjN1fEM/4wD
 Razg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440742; x=1697045542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bBDxOWnGC99luImlqjntVhvHvQ5f4z9cF2Uz6KLOjxk=;
 b=bgOfzc4lWnthomkzNciV0bBLTzT2Ziko55QT6Yn5nc5VuS5D99nfXyPAwZ3BOl3Rio
 z49VcQJeo13o+bAkEJhmkl3jCX/CxfTHu661JeEaPRdejA3aCi4q9Xjz/qnPOcI80Oq+
 1H56ZF8VgyJMG3kzuD+Pii0yiyz1ZoIoNrQ2r7ygbWCaV134LK/YCpOfnIfK2hB53quE
 Twq2XcWS95rAxsSOHISknHXnVa8gYdQTi7DP7+zl4OILf8ntRM1DGZP1ZXW7gEzO3iM3
 MtTSNWf4mIgsAP4+tZ3dLg+0bjpShKPhQlwt8cTCuooCEbnfppnDUxcP65x6yhI8Vdmy
 AhGg==
X-Gm-Message-State: AOJu0YxPJRTirZ0/GEeIm2DgDp8bKbE8E9c3sBe1ONk24LAk88McVTiY
 vu8AFzZR/HSjIiqy9eYuDPb8AT7wYDL7BtCgZtI=
X-Google-Smtp-Source: AGHT+IEVljxrxbsTZQVFDgQIe0njJ4Lx923OxtxzyYWRZsBZF6rMONC8Boq2o3sO5PkWTZQcaosXkg==
X-Received: by 2002:a5d:6991:0:b0:320:976:f940 with SMTP id
 g17-20020a5d6991000000b003200976f940mr2718283wru.13.1696440742687; 
 Wed, 04 Oct 2023 10:32:22 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 d9-20020adff849000000b003248a490e3asm4502639wrq.39.2023.10.04.10.32.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:32:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 03/21] qapi: Inline and remove QERR_DEVICE_IN_USE definition
Date: Wed,  4 Oct 2023 19:31:38 +0200
Message-ID: <20231004173158.42591-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Mechanical transformation using sed, manually
removing the definition in include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qapi/qmp/qerror.h | 3 ---
 blockdev.c                | 2 +-
 chardev/char-fe.c         | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 168177bcd7..daa889809b 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_DEVICE_IN_USE \
-    "Device '%s' is in use"
-
 #define QERR_DEVICE_NO_HOTPLUG \
     "Device '%s' does not support hotplugging"
 
diff --git a/blockdev.c b/blockdev.c
index e5617faf0f..da39da457e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2345,7 +2345,7 @@ void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
     }
 
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_RESIZE, NULL)) {
-        error_setg(errp, QERR_DEVICE_IN_USE, device);
+        error_setg(errp, "Device '%s' is in use", device);
         return;
     }
 
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 7789f7be9c..7d33b3ccd1 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -217,7 +217,7 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
     return true;
 
 unavailable:
-    error_setg(errp, QERR_DEVICE_IN_USE, s->label);
+    error_setg(errp, "Device '%s' is in use", s->label);
     return false;
 }
 
-- 
2.41.0


