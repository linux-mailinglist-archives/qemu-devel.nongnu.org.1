Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F367DBC7CA8
	for <lists+qemu-devel@lfdr.de>; Thu, 09 Oct 2025 09:52:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lRJ-0000CH-Cs; Thu, 09 Oct 2025 03:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lRE-0000Bf-Vy
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lRA-0004Tr-11
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xo7/waLBB+eaxCnywl7D9abhJb3gDRPAUFE9UsF2G9Q=;
 b=Ghb1MTYWP/lc5INl7RIECRYJ9iaGHP/YpvstUr0LtacvqutXJ5MYLqddRRLVu6d6YwLgd1
 M7IYE0F4ydM1uIQOIy6jhtOWL99bu8tZFqs9MpTtIWdeMqvgxOWtJjm73U1+ECJn1n+KMs
 p4v12oB6xvW8qaVhmFiqgn0nG1ha2Vw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-bVDtTozJPNmtbPaX78Zy2A-1; Thu, 09 Oct 2025 03:51:38 -0400
X-MC-Unique: bVDtTozJPNmtbPaX78Zy2A-1
X-Mimecast-MFC-AGG-ID: bVDtTozJPNmtbPaX78Zy2A_1759996297
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-40cfb98eddbso863007f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996296; x=1760601096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xo7/waLBB+eaxCnywl7D9abhJb3gDRPAUFE9UsF2G9Q=;
 b=djQgAA6VRjcp6itimi9pNe0v9IGl3KzVqThAR3QEhsfA11HeYzYNXJqaa/fAH6SwA1
 e9Smqch0DTK8U9pM/nMFhIdmytYfk8tyr9vb3IAHoAD5OKzA7yKo5DqxbwiKa0qRBIKj
 E/aaGlbgxZQEaE78jwBP9s6Qhk2pKMybheVQdO1MYtza4CRNbG3cxujHoZdYv41jD0CF
 UnaAln6b0qwwM5mkuPpVdaSnZ3UGHkdDCEvd8EcVVsQ5koZwRmf9cNDIqRst9xN3jNEc
 W8gXvxlteQwQfj7EOWoyinfgkDD6H8KhIpEESAYOXFOh0c9TeuBc427QhF0JXw/Qe3oE
 yCTw==
X-Gm-Message-State: AOJu0YwMyRLNb92VKmUkavGutAc3Y7J+aml5ouKEO0R39kA6bpeI4uTR
 rCxPOMLtNT2mnGfU+qpVpVzO7RSseMeHaC8GoHyIoRUBPpYe/qWhGjOVEaxFd/qc48PD8Q/HuE8
 kyKZ1ECmCQTa15051sXQ/MFtUrddZIq9nvv3ChIWtBRvZp7pxFzw2oi2gPNxaGzIMMObxmuPvcl
 2152PB5kZizw01H+BE/gr+W0jV6FDkAn5PLM5ykMW6oG8=
X-Gm-Gg: ASbGncsfSI/w1CKPHgzJ+I+U12WcDJ9i1Siuqs1Nj483PYNixX9Lpo1zM8Ugo5tb0/I
 GVoZMmdt4gOl6ZLQbG6Far0D4xDX7Zpl4Ujy1EpOH5jPwXBEcyhxa5cNQ0V6oyxiGEujnEUPJm6
 wKRnNoO5SLTJTD6VN6VVbbys1n7Nu1gfu5XKoRTZxaBKFMFYTdQJBp01FR6PlzKj2c4MkWo2GZs
 z8E7B3Fk3cvq/TMyBLBE3RyZrpl0TuTqklUw+z2hBmhfGKtNa91KFS3KFq641XbZ58M9p+aQ7vZ
 KYBrNY8IeaWcnfM6lqX6xqcRpS/rUIzOeHe4+6s0oqRgZcI1T2LXV1kTnYAcXtNKEBXBvC43gtV
 6PIZf2u8M32DNhkcOF+UAuOQkXYQ8jrDU3XJAl3Ayb5PRZigR
X-Received: by 2002:a05:6000:26d1:b0:3fa:2df7:6a0a with SMTP id
 ffacd0b85a97d-425829ee53emr6538894f8f.22.1759996296212; 
 Thu, 09 Oct 2025 00:51:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiENv4ZyiIXYE25XeoB7eJmYLn2B3CGZ2+pPhF1CtN7Iw86LU2UWLT4WYd4Ql83CFW1tWQdQ==
X-Received: by 2002:a05:6000:26d1:b0:3fa:2df7:6a0a with SMTP id
 ffacd0b85a97d-425829ee53emr6538878f8f.22.1759996295694; 
 Thu, 09 Oct 2025 00:51:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab8fdsm32956970f8f.15.2025.10.09.00.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Praveen K Paladugu <prapal@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 30/35] qapi/accel: Allow to query mshv capabilities
Date: Thu,  9 Oct 2025 09:50:20 +0200
Message-ID: <20251009075026.505715-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Praveen K Paladugu <prapal@microsoft.com>

Allow to query mshv capabilities via query-mshv QMP and info mshv HMP commands.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
Link: https://lore.kernel.org/r/20250916164847.77883-25-magnuskulke@linux.microsoft.com
[Fix "since" version. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/accelerator.json      | 29 +++++++++++++++++++++++++++++
 include/monitor/hmp.h      |  1 +
 include/system/hw_accel.h  |  1 +
 hw/core/machine-hmp-cmds.c | 15 +++++++++++++++
 hw/core/machine-qmp-cmds.c | 14 ++++++++++++++
 hmp-commands-info.hx       | 13 +++++++++++++
 6 files changed, 73 insertions(+)

diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index fb28c8d920a..664e0272465 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -54,3 +54,32 @@
 { 'command': 'x-accel-stats',
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
+
+##
+# @MshvInfo:
+#
+# Information about support for MSHV acceleration
+#
+# @enabled: true if MSHV acceleration is active
+#
+# @present: true if MSHV acceleration is built into this executable
+#
+# Since: 10.2.0
+##
+{ 'struct': 'MshvInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
+
+##
+# @query-mshv:
+#
+# Return information about MSHV acceleration
+#
+# Returns: @MshvInfo
+#
+# Since: 10.0.92
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-mshv" }
+#     <- { "return": { "enabled": true, "present": true } }
+##
+{ 'command': 'query-mshv', 'returns': 'MshvInfo' }
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index ae116d9804a..31bd812e5f4 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -24,6 +24,7 @@ strList *hmp_split_at_comma(const char *str);
 void hmp_info_name(Monitor *mon, const QDict *qdict);
 void hmp_info_version(Monitor *mon, const QDict *qdict);
 void hmp_info_kvm(Monitor *mon, const QDict *qdict);
+void hmp_info_mshv(Monitor *mon, const QDict *qdict);
 void hmp_info_status(Monitor *mon, const QDict *qdict);
 void hmp_info_uuid(Monitor *mon, const QDict *qdict);
 void hmp_info_chardev(Monitor *mon, const QDict *qdict);
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index fa9228d5d2d..55497edc293 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -14,6 +14,7 @@
 #include "hw/core/cpu.h"
 #include "system/kvm.h"
 #include "system/hvf.h"
+#include "system/mshv.h"
 #include "system/whpx.h"
 #include "system/nvmm.h"
 
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 3a612e2232d..682ed9f49b8 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -163,6 +163,21 @@ void hmp_info_kvm(Monitor *mon, const QDict *qdict)
     qapi_free_KvmInfo(info);
 }
 
+void hmp_info_mshv(Monitor *mon, const QDict *qdict)
+{
+    MshvInfo *info;
+
+    info = qmp_query_mshv(NULL);
+    monitor_printf(mon, "mshv support: ");
+    if (info->present) {
+        monitor_printf(mon, "%s\n", info->enabled ? "enabled" : "disabled");
+    } else {
+        monitor_printf(mon, "not compiled\n");
+    }
+
+    qapi_free_MshvInfo(info);
+}
+
 void hmp_info_uuid(Monitor *mon, const QDict *qdict)
 {
     UuidInfo *info;
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 6aca1a626e6..e24bf0d97bf 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -28,6 +28,20 @@
 #include "system/runstate.h"
 #include "system/system.h"
 #include "hw/s390x/storage-keys.h"
+#include <sys/stat.h>
+
+/*
+ * QMP query for MSHV
+ */
+MshvInfo *qmp_query_mshv(Error **errp)
+{
+    MshvInfo *info = g_malloc0(sizeof(*info));
+
+    info->enabled = mshv_enabled();
+    info->present = accel_find("mshv");
+
+    return info;
+}
 
 /*
  * fast means: we NEVER interrupt vCPU threads to retrieve
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 6142f60e7b1..eaaa880c1b3 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -307,6 +307,19 @@ SRST
     Show KVM information.
 ERST
 
+    {
+        .name       = "mshv",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show MSHV information",
+        .cmd        = hmp_info_mshv,
+    },
+
+SRST
+  ``info mshv``
+    Show MSHV information.
+ERST
+
     {
         .name       = "numa",
         .args_type  = "",
-- 
2.51.0


