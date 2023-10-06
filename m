Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E697BB61D
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:15:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinE-00088B-Ic; Fri, 06 Oct 2023 07:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoin4-000873-7V
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimx-0000IO-LA
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o3cXt43+FQ9EnnJkDNOxNY5f5+ZzR2mdEtgZC0Jw9AQ=;
 b=JdEaUXjWyA1A7PFFEbpKK2L77Zkw8eEA3SCbLojAY3PI28DurBHcdtSoG+coD2Pv32iY1u
 n/XlgJmVZxGANYKiRLfHc7hQgGkYCo01wtRpFHQW9PWEQO6JZ0EYjWLYGbpqbXOtIQy0d4
 i06XZzuMTuE0q5fXBZsC2GKKoppH33A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-dbh-XtYZNACf6IpNFZNfxg-1; Fri, 06 Oct 2023 07:14:33 -0400
X-MC-Unique: dbh-XtYZNACf6IpNFZNfxg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-537fb536554so1818171a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590872; x=1697195672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3cXt43+FQ9EnnJkDNOxNY5f5+ZzR2mdEtgZC0Jw9AQ=;
 b=QdO8cyU07reysCCsHMS6CIWAt+lzFBJen87RePwLC0SvJJVL8W2AwqFVUMTOt6+vA3
 ycKQe5BZFWLEGV8bpYWb/5nX++WvWPD5DRIlekXQp4cgdIogvvPIz9tsF13bMsw+Xm9R
 wvloM7A+emMNs1CLr0m4jJp9YDmp5sLM13kdJv6QbsB33AHeC7/dl8zLoUxRRpWmlyzL
 mkG6c4vI+ZWEivZj+++yExq9zFpjkrONQcc+p6W8PVaDqqDTm8jC7sv65iOpuJhwXFFZ
 0QBoXuJKS4Jdt5RilIx3pmqz2zbF+IwVDHap9IvfvJ/vYleMFECL/qVw/UsOJc9GCmst
 +kyw==
X-Gm-Message-State: AOJu0Yzg2EiAjFDlChz/aibqF/lQ3nwMy3ZV4rRzBFZ5YrdKEI0jZ07v
 JiSn1A+Fcs0nGsV0tmXMw+gpDGICvC3C1LKHJNgRu+DCQli5C58oHk/C9VIexV07Vwx/5G8h+6Y
 cSwHPb3eKoV9AJWmHxJk4O/8Kmj1QiiCGzSZEwUiSTIpekDifGNPDW/D08hVVXikipp2yLgweHd
 A=
X-Received: by 2002:a05:6402:6d4:b0:533:4c67:c911 with SMTP id
 n20-20020a05640206d400b005334c67c911mr7269537edy.19.1696590872060; 
 Fri, 06 Oct 2023 04:14:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2UaqAZpxVjHRdLXoSSxAISDySWV6mfojDYSRdE2Xkdg3q0nFcnzZSnH8xnPjkHeyFhZrxoA==
X-Received: by 2002:a05:6402:6d4:b0:533:4c67:c911 with SMTP id
 n20-20020a05640206d400b005334c67c911mr7269519edy.19.1696590871653; 
 Fri, 06 Oct 2023 04:14:31 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a056402181200b0053782c81c69sm2397206edy.96.2023.10.06.04.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/26] accel: Rename accel_softmmu* -> accel_system*
Date: Fri,  6 Oct 2023 13:13:56 +0200
Message-ID: <20231006111412.13130-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Rename accel.softmmu -> accel.system in file paths
and the register_types() method.

Rename sysemu_stubs_ss -> system_stubs_ss in meson
following the pattern used on other source set names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004090629.37473-7-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel-common.c                      |  2 +-
 accel/{accel-softmmu.c => accel-system.c} |  6 +++---
 accel/{accel-softmmu.h => accel-system.h} |  6 +++---
 accel/meson.build                         |  2 +-
 accel/stubs/meson.build                   | 10 +++++-----
 5 files changed, 13 insertions(+), 13 deletions(-)
 rename accel/{accel-softmmu.c => accel-system.c} (96%)
 rename accel/{accel-softmmu.h => accel-system.h} (77%)

diff --git a/accel/accel-common.c b/accel/accel-common.c
index df72cc989a9..965318daa36 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -30,7 +30,7 @@
 #include "hw/core/accel-cpu.h"
 
 #ifndef CONFIG_USER_ONLY
-#include "accel-softmmu.h"
+#include "accel-system.h"
 #endif /* !CONFIG_USER_ONLY */
 
 static const TypeInfo accel_type = {
diff --git a/accel/accel-softmmu.c b/accel/accel-system.c
similarity index 96%
rename from accel/accel-softmmu.c
rename to accel/accel-system.c
index 9c804ba9e3b..fa8f43757ce 100644
--- a/accel/accel-softmmu.c
+++ b/accel/accel-system.c
@@ -28,7 +28,7 @@
 #include "hw/boards.h"
 #include "sysemu/cpus.h"
 #include "qemu/error-report.h"
-#include "accel-softmmu.h"
+#include "accel-system.h"
 
 int accel_init_machine(AccelState *accel, MachineState *ms)
 {
@@ -99,8 +99,8 @@ static const TypeInfo accel_ops_type_info = {
     .class_size = sizeof(AccelOpsClass),
 };
 
-static void accel_softmmu_register_types(void)
+static void accel_system_register_types(void)
 {
     type_register_static(&accel_ops_type_info);
 }
-type_init(accel_softmmu_register_types);
+type_init(accel_system_register_types);
diff --git a/accel/accel-softmmu.h b/accel/accel-system.h
similarity index 77%
rename from accel/accel-softmmu.h
rename to accel/accel-system.h
index 5e192f1882e..d41c62f21b1 100644
--- a/accel/accel-softmmu.h
+++ b/accel/accel-system.h
@@ -7,9 +7,9 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef ACCEL_SOFTMMU_H
-#define ACCEL_SOFTMMU_H
+#ifndef ACCEL_SYSTEM_H
+#define ACCEL_SYSTEM_H
 
 void accel_init_ops_interfaces(AccelClass *ac);
 
-#endif /* ACCEL_SOFTMMU_H */
+#endif /* ACCEL_SYSTEM_H */
diff --git a/accel/meson.build b/accel/meson.build
index 638a9a03ba9..3376810921d 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,5 +1,5 @@
 specific_ss.add(files('accel-common.c', 'accel-blocker.c'))
-system_ss.add(files('accel-softmmu.c'))
+system_ss.add(files('accel-system.c'))
 user_ss.add(files('accel-user.c'))
 
 subdir('tcg')
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 6b0f200efe9..91a2d219258 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -1,6 +1,6 @@
-sysemu_stubs_ss = ss.source_set()
-sysemu_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
-sysemu_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
-sysemu_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
+system_stubs_ss = ss.source_set()
+system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
 
-specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: sysemu_stubs_ss)
+specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
-- 
2.41.0


