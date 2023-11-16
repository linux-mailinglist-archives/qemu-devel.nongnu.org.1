Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 223E07EE54C
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 17:38:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3fN1-0004eU-Sw; Thu, 16 Nov 2023 11:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3fMz-0004dx-Dd
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:37:33 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3fMw-0004fL-M7
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:37:32 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9e4675c7a5fso148705166b.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 08:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700152649; x=1700757449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=inXKrafPd5SkQhA/cWzh8/eJIxvZt3CwOO4U8YkDwa0=;
 b=hnMmpXxwyveErSB0As1dFy6Otvp0PxUPmyg4d9YZHZ6pFtoAGkVC+ibThfZokeDin3
 g2WDMZRt5NFyz0BSAactlkrtYM2T2pVILiZ71q30ncNKUT2C52C1kJMl9JSvGlBd6ctr
 wXO+lyijySQI44rWgczVvpLF4NiyX3ydeKqzBfSPq/H+Sx7GYFBKv7hUzAsPkMtPeKGA
 QATc4UMhv43DJeJCd4G5nUNEnLc4M3b5VV1Js8QmsKKoI1e5TewxOElR5XW9xkD+puji
 FobPZw1tbmjOz/3W+73drIGDtUEO6zOgDD66yQo1NdcxD9IgQsm4u/bDQ8jidXX8BVPp
 m2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700152649; x=1700757449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=inXKrafPd5SkQhA/cWzh8/eJIxvZt3CwOO4U8YkDwa0=;
 b=TZ2NmL28kmEVnIwYsfKTt1eZg7nL5E46+xq6JpHhuxNCgGiEtpRdzubhrwzqpWUesO
 yD83EDInMeDYPEzxseYNxdEw+zPC3xnGNnXvNyOcz8gaVzNr+yQ5KdYR6vw0nv36ylJz
 WabT/GUtDPZ2r/RvTzO73MUtix2wnIL0BjEKzENX9e53576CaudwOHWWmxXX9mcNb7/G
 byb0zzB+AXcaBflQ5rEpRgBIQ/HjN/FjknuYKdXx3yF5Emo5DnXqgoMZ3K7JrybYt217
 mJ3+vgdje3a4E3xFyRcLnLPtW/sRrDHyE0ziYmwUpvW8Dg4GVuzNKBThsZ6tf3BmJIVB
 VglA==
X-Gm-Message-State: AOJu0YzIe/zBuLsghFoeZ1e181ht37NxLSkEgxpxcSXntJO9U5p0qBX9
 akD6z8uCYbEfeIrjRB7kBJqYQkJJNYUiVqSzxGI=
X-Google-Smtp-Source: AGHT+IEil7DsUSpQjxfrK+xN5oZJ2tz0iHwDJzLpTn4NoxIOHViTUXngnYr3uOt0OBQtJxptjWX8pA==
X-Received: by 2002:a17:906:6bd4:b0:9be:51ce:e91b with SMTP id
 t20-20020a1709066bd400b009be51cee91bmr13843754ejs.68.1700152648810; 
 Thu, 16 Nov 2023 08:37:28 -0800 (PST)
Received: from m1x-phil.lan ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1709062e8a00b009e676a5b158sm8521799eji.83.2023.11.16.08.37.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Nov 2023 08:37:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.0] hw/core: Add machine_class_default_cpu_type()
Date: Thu, 16 Nov 2023 17:37:26 +0100
Message-ID: <20231116163726.28952-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Add a helper to return a machine default CPU type.

If this machine is restricted to a single CPU type,
use it as default, obviously.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 6 ++++++
 hw/core/machine.c   | 8 ++++++++
 system/vl.c         | 2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index da85f86efb..160a10036e 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -24,6 +24,12 @@ OBJECT_DECLARE_TYPE(MachineState, MachineClass, MACHINE)
 
 extern MachineState *current_machine;
 
+/**
+ * machine_class_default_cpu_type: Return the machine default CPU type.
+ * @mc: Machine class
+ */
+const char *machine_class_default_cpu_type(MachineClass *mc);
+
 void machine_add_audiodev_property(MachineClass *mc);
 void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp);
 bool machine_usb(MachineState *machine);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0c17398141..baf25c3fc5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1387,6 +1387,14 @@ out:
     return r;
 }
 
+const char *machine_class_default_cpu_type(MachineClass *mc)
+{
+    if (mc->valid_cpu_types && !mc->valid_cpu_types[1]) {
+        /* Only a single CPU type allowed: use it as default. */
+        return mc->valid_cpu_types[0];
+    }
+    return mc->default_cpu_type;
+}
 
 void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp)
 {
diff --git a/system/vl.c b/system/vl.c
index 5af7ced2a1..1c28162b21 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3730,7 +3730,7 @@ void qemu_init(int argc, char **argv)
     migration_object_init();
 
     /* parse features once if machine provides default cpu_type */
-    current_machine->cpu_type = machine_class->default_cpu_type;
+    current_machine->cpu_type = machine_class_default_cpu_type(machine_class);
     if (cpu_option) {
         current_machine->cpu_type = parse_cpu_option(cpu_option);
     }
-- 
2.41.0


