Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E37BA0BEF6
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Jan 2025 18:38:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXONM-00035Z-On; Mon, 13 Jan 2025 12:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMg-0002En-Rp
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:39 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMf-00072D-8L
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:38 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso48335545e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 09:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736789795; x=1737394595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=So15p+H+DSsGmUuH6+mgWAC3ycngOqSbmiFDKA1MmyA=;
 b=cHjv8KqM0maYDidtTkfqeZAeZ+mxjvl9vjmigK6M8AXU0qd/b60TJCFx8sDcllCIAI
 7jPz/zzxOyk6paiuea79Dufrp5ahoOSVo1vtcN6m+3MKZPQy9Bvcife75SXsjIlRxXkS
 5qgJOvMSJIKSGP+RqotdT1LZVCRym6ilkCk4D+nqxmtyouFOly3js3kw2vbQhXxs9fhJ
 ROKyMA7EXjhFeFM4dOmex2by7YgMOk/ohi6Ui8crj6DlZ8iBWxN3ZnKEXwZjCGbtOGe8
 hoye5egl+R77jp/tbPb3PFOABbW2bIlKC6e60VOP6w31RRamPv+nZNpKPFykxAIHS+PH
 4dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736789795; x=1737394595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=So15p+H+DSsGmUuH6+mgWAC3ycngOqSbmiFDKA1MmyA=;
 b=jCSCHdSAKlE/Ot42G+elOHs5pNeiXI1rSac1tzQRBHGuiSkM9TYsAUMTgIfvWS67r0
 ETZN9I99BceyJWoeoe5Defhbnscag1eG25glnSA6d/9y/X/LMuBN0YayrChAdnatYYlx
 lwNIumNjW9rrRH2ZfgT6y3IupLOYAZY9hoObVlUXirlf0Hz+2nRBB1kP8p2821jMbmtK
 dcnRj0Rt4kJqJXc26S5nK0lU+T2SAF2seMf6gNMUxhUnmEVh5dTSk369IUlaBa7gMVZZ
 af1dtPhawqFwBtVFhtE78FaOqM+eryLC8mVX28IHhCmYCeRb7WiiH5KzwN6DjQux6t3n
 C1qg==
X-Gm-Message-State: AOJu0YxI9LGckoUNRzK+vqTyRcEJ8dfyLPEXYf/zfgSZPfZpw6NkqwuR
 jfRvkE3Nk4Nu7bBcEPC6BMWCGAImCH5TkfhivY+ImIsWHARFhwtumt+UAz4u/FAJsUUeBvrf5Np
 TOEQ=
X-Gm-Gg: ASbGncv64Mrnn03w8h0fmmVfzBqLH5Cfbgc2p1RbHahco5k39bl77PkmhuTzMgjzgNr
 a/0/S0jf9JOvG9IR1pRYzohFyy1c2UJKNjggCrUxZInmAfjmOxKWjvRBhHXwzqU0LLCDFnKOqWp
 lvuHOhE0HM0W8l9OTVFOYt6H0g9t27TZmuffxztIt9Sd01ZZZmozxDBkQDjln97udIsILUjsS6i
 xcDDv3rd96LVQDFS4StyV31zJKcgTFlbMlcwLydGt50X252lcVClbdmzPauiGjDxmf1OaTHLZN2
 Qw0pxHY6xbMVm8YlX5EEklbXmDwN9Rs=
X-Google-Smtp-Source: AGHT+IHn9uN347JJfz3ougU5mSXjWhY/2H/e/aVOln9G8gCTQ7BUE2jtGL7aDApRZjl9TmL73PQJXg==
X-Received: by 2002:a05:600c:4f8e:b0:436:fb02:e90 with SMTP id
 5b1f17b1804b1-436fb021066mr56367155e9.10.1736789795403; 
 Mon, 13 Jan 2025 09:36:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm150936005e9.4.2025.01.13.09.36.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 09:36:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL v2 11/55] hw/qdev: Check machine_hotplug_handler in
 hotplug_unplug_allowed_common
Date: Mon, 13 Jan 2025 18:36:03 +0100
Message-ID: <20250113173604.46931-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113173604.46931-1-philmd@linaro.org>
References: <20250113173604.46931-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Commit 03fcbd9dc508 ("qdev: Check for the availability of a hotplug
controller before adding a device") says:

 > The qdev_unplug() function contains a g_assert(hotplug_ctrl)
 > statement, so QEMU crashes when the user tries to device_add +
 > device_del a device that does not have a corresponding hotplug
 > controller.

 > The code in qdev_device_add() already checks whether the bus has a
 > proper hotplug controller, but for devices that do not have a
 > corresponding bus, here is no appropriate check available yet. In that
 > case we should check whether the machine itself provides a suitable
 > hotplug controller and refuse to plug the device if none is available.

However, it forgot to add the corresponding check to qdev_unplug().

Check the machine hotplug handler once in the common
qdev_hotplug_unplug_allowed_common() helper so both hotplug
and hot-unplug path are covered.

Fixes: 7716b8ca74 ("qdev: HotplugHandler: Add support for unplugging BUS-less devices")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
[PMD: Split from bigger patch, part 6/6]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250110091908.64454-7-philmd@linaro.org>
---
 hw/core/qdev-hotplug.c | 10 ++++++++++
 system/qdev-monitor.c  | 14 +++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index f6422cd0e4e..ff176dc1bb3 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -48,6 +48,16 @@ static bool qdev_hotplug_unplug_allowed_common(DeviceState *dev, BusState *bus,
                        bus->name);
             return false;
         }
+    } else {
+        if (!qdev_get_machine_hotplug_handler(dev)) {
+            /*
+             * No bus, no machine hotplug handler --> device is not hotpluggable
+             */
+            error_setg(errp,
+                       "Device '%s' can not be hotplugged on this machine",
+                       object_get_typename(OBJECT(dev)));
+            return false;
+        }
     }
 
     return true;
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index e27d25c5859..861c25c855f 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -684,17 +684,9 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     dev = qdev_new(driver);
 
     /* Check whether the hotplug is allowed by the machine */
-    if (phase_check(PHASE_MACHINE_READY)) {
-        if (!qdev_hotplug_allowed(dev, bus, errp)) {
-            goto err_del_dev;
-        }
-
-        if (!bus && !qdev_get_machine_hotplug_handler(dev)) {
-            /* No bus, no machine hotplug handler --> device is not hotpluggable */
-            error_setg(errp, "Device '%s' can not be hotplugged on this machine",
-                       driver);
-            goto err_del_dev;
-        }
+    if (phase_check(PHASE_MACHINE_READY) &&
+        !qdev_hotplug_allowed(dev, bus, errp)) {
+        goto err_del_dev;
     }
 
     /*
-- 
2.47.1


