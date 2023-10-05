Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C764D7B9AC3
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 06:52:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGKV-0005Sq-2h; Thu, 05 Oct 2023 00:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGKQ-0005NY-Ve
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:51:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGKO-0005Ve-Ax
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:51:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so4906025e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481471; x=1697086271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tlfU+e5P66No2dfLjlw3nceh1BAOvyaTo2g5TESIX0=;
 b=Z7iD+z5lHYf0k9kk2uatQUYFyePgewaDtoxGu60m3AWyMGEXNkcDDAc/ogv5MmM5LP
 p19bNmHH7j/mN4nEGdMUIyprb7sbm7TV6WCCTY+LfBbvoz0podAciwDjrLxQ7NMOHTbJ
 mBNwSYafVOwdu3Zk/C19+HDV5VVOVFywGIfkvMMOe944qypBo6vAXWSSfTvRTTQN/fpv
 VM30NbCUjmM1mNfMM0VBQf10YFtjvShsGVnTPJw1kVUdSjHbE6AYBg+MnKLuB5f4Uj+o
 GArdoDdfcMMXLVsPGxbpRRJKBjHp0yQIF62v8amEIIMLy9f3XuEK7WA/vSkRbJJC/fVL
 9afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481471; x=1697086271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tlfU+e5P66No2dfLjlw3nceh1BAOvyaTo2g5TESIX0=;
 b=WvvuJ9CoPrgByLoZz+qVYFTeKwOPnXUy3DiStTY0VnUSGkLaUxG3J9LLgiLh87/Nah
 F5WKIZfZjdn1R1eHbjnct128+4Tejr7p94OkI9Pycy+x6tB81xgLt03+Z1fapTsKg8/W
 OAov0ES9oJYmGjF0kKAkgLNDxrireaaeqMqekHKdU69vV7zvKNp2gpGwrIhyylcBG3hT
 AaHOoNkFJ42ForMWxmXsj/HlhiLnz76Q109bQlb+fKX1BG+7x+DQ7AeeIn/GGwqDUt2Y
 naSEW2Iz56lwX9qjHNuZsUwuSWxp7cQ4hq6jxHj2lZO96pjSHcy0PHO5FITwxg2rk6kU
 JEZQ==
X-Gm-Message-State: AOJu0Yx8rYtEr5DPhPehBT5xVm1RA0khv+EkFnmHC97lmtKKG8fCXcpY
 5xPij9bT7Kc6S+OMZwZtdnsCuA1Nma1IIUBtvmg=
X-Google-Smtp-Source: AGHT+IFm1CIEWt3+Nlt6La1BcPpPerwV/gnhHtX4vkGNvaOT67sUlRjmPNE8M7RK8nR174fILy9ltw==
X-Received: by 2002:a7b:cd85:0:b0:403:cc64:2dbf with SMTP id
 y5-20020a7bcd85000000b00403cc642dbfmr4199063wmj.27.1696481470736; 
 Wed, 04 Oct 2023 21:51:10 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 m20-20020a7bca54000000b00406408dc788sm2866220wml.44.2023.10.04.21.51.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:51:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 04/22] qapi: Inline and remove QERR_DEVICE_NO_HOTPLUG
 definition
Date: Thu,  5 Oct 2023 06:50:21 +0200
Message-ID: <20231005045041.52649-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005045041.52649-1-philmd@linaro.org>
References: <20231005045041.52649-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
 hw/core/qdev.c            | 3 ++-
 softmmu/qdev-monitor.c    | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index daa889809b..e93211085a 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_DEVICE_NO_HOTPLUG \
-    "Device '%s' does not support hotplugging"
-
 #define QERR_INVALID_PARAMETER \
     "Invalid parameter '%s'"
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 43d863b0c5..9b62e0573d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -479,7 +479,8 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     static int unattached_count;
 
     if (dev->hotplugged && !dc->hotpluggable) {
-        error_setg(errp, QERR_DEVICE_NO_HOTPLUG, object_get_typename(obj));
+        error_setg(errp, "Device '%s' does not support hotplugging",
+                   object_get_typename(obj));
         return;
     }
 
diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index 3a9740dcbd..a964bd80df 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -911,7 +911,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
     }
 
     if (!dc->hotpluggable) {
-        error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
+        error_setg(errp, "Device '%s' does not support hotplugging",
                    object_get_typename(OBJECT(dev)));
         return;
     }
-- 
2.41.0


