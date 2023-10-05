Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D607B9ABB
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 06:51:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGKS-0005PB-Na; Thu, 05 Oct 2023 00:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGKN-0005Ik-LC
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:51:12 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGKI-0005TQ-QH
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:51:11 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32488a22810so506350f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481464; x=1697086264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBDxOWnGC99luImlqjntVhvHvQ5f4z9cF2Uz6KLOjxk=;
 b=Nyu1TCQdiopw44rhqWnMJC4Usmj2wzlevTkghe2KtCvEA11j5RQJZI3RY9uT04GSMy
 d/vnj0qElBgbi6icb4NlMfyYsNgo8tb/0aOvMQ6wIn8KBavfTFSxk6bfXTEvPR+Jbk62
 LJdcrjXaiRllBViJOOwRX6xZ2XaxE5D5V2aHnI5WbX21WnDSAZdvTsdmgwBZmJ03AuaS
 SXYubDi0/D1wnlP78bTzDL9HOEIYsMt0sdhj3WHK4NJq9GKlrtfypWAdp0IZvAvEQO66
 4CA0flnL3bytOQiWqbJnFEqRz+HS3E1lrgo758MkGYc9iBuOsNYT7DFC6yTtScGNY9rj
 Aaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481464; x=1697086264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bBDxOWnGC99luImlqjntVhvHvQ5f4z9cF2Uz6KLOjxk=;
 b=Z77dJl31EoKg54WnPLb0yuDG3K87Dd63ROZOTtw2yejKVUQSSDJtdWZhKr5uvK3onp
 OjTU05MK5sENkEx+2FpXrB9HavjmIaPIb+4ERu5qHzW9TzIAGJq8abCN/bP7QAvg78xk
 IZYo9xs37bAsbtF1n7u5UGfk0x9CvGGx1TXaU+kQJuel4fH4DLu/+ituRrqDckDhlzC+
 VB9wKBPbwvJRNlyKmniKDs74eiCnP8+mPbfIryYLzhSd+Tj7q7X4Lx7H8uOnuBTXXDmL
 0Lpyy/AZbyOFEE6TOfpB6FeNDSG3/MPE9AGLvxSxXtHo6q+YOL1mkn4vFSU+dKWDQZkx
 J5Wg==
X-Gm-Message-State: AOJu0YxxXdylr/l+mKypnnz7wJbDis6BfDuXoYaJbPg2bv4QHrMjcDXj
 9b6khfOLLF8Bd04oohdumwkBORnaz/eBK/0YH7o=
X-Google-Smtp-Source: AGHT+IHFH7QfagmcVwLqFgmMMrfZ0kWySwyK7D/doQHCwTROio4M1n23sN5r2LuUIAkgIgnDQWH86g==
X-Received: by 2002:a5d:5309:0:b0:319:68ce:2c53 with SMTP id
 e9-20020a5d5309000000b0031968ce2c53mr3713824wrv.25.1696481464321; 
 Wed, 04 Oct 2023 21:51:04 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 f14-20020a5d568e000000b00315af025098sm749160wrv.46.2023.10.04.21.51.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:51:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 03/22] qapi: Inline and remove QERR_DEVICE_IN_USE definition
Date: Thu,  5 Oct 2023 06:50:20 +0200
Message-ID: <20231005045041.52649-4-philmd@linaro.org>
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


