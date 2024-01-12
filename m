Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A4782BE0A
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 11:03:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOEM4-0004Ae-T5; Fri, 12 Jan 2024 05:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rOELe-00045U-3c
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:01:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rOELb-0005d4-OZ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705053667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbxVZxR72NOA9P1voQAwoc/yPJ1UDHYRmtFd2UrWJbE=;
 b=VP5UKdeTGMHCRbthTgqNP5kSiPLBNRLCWZIw3ZnrTt5N1XgGdPpmU/p8f8EbL4Q5hy24Dy
 3bMlUgBa82QtoUrD8jyeHEdZ9L+SNnfL1jxmfuuFiJrGKm81WQlNbdOtIXKfNEip/lrhhk
 vsT6NXfvH18ZntPosY+44EW1+nEWxw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-ErD2EX8_PmOZiOsGAH85LQ-1; Fri, 12 Jan 2024 05:01:05 -0500
X-MC-Unique: ErD2EX8_PmOZiOsGAH85LQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 698BA185A781;
 Fri, 12 Jan 2024 10:01:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1DE0C08ED4;
 Fri, 12 Jan 2024 10:01:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH 2/5] qemu-options: Remove the deprecated -no-acpi option
Date: Fri, 12 Jan 2024 11:00:56 +0100
Message-ID: <20240112100059.965041-3-thuth@redhat.com>
In-Reply-To: <20240112100059.965041-1-thuth@redhat.com>
References: <20240112100059.965041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It's been marked as deprecated since QEMU 8.0, so it should be fine
to remove this now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst       | 6 ------
 docs/about/removed-features.rst | 5 +++++
 system/vl.c                     | 4 ----
 qemu-options.hx                 | 9 ---------
 4 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 6c668b8531..dff4c76f1b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -63,12 +63,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
-``-no-acpi`` (since 8.0)
-''''''''''''''''''''''''
-
-The ``-no-acpi`` setting has been turned into a machine property.
-Use ``-machine acpi=off`` instead.
-
 ``-async-teardown`` (since 8.1)
 '''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 52d240ade9..ae728b6130 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -466,6 +466,11 @@ line if the ``-nodefaults`` options is used.
 The HPET setting has been turned into a machine property.
 Use ``-machine hpet=off`` instead.
 
+``-no-acpi`` (removed in 9.0)
+'''''''''''''''''''''''''''''
+
+The ``-no-acpi`` setting has been turned into a machine property.
+Use ``-machine acpi=off`` instead.
 
 
 QEMU Machine Protocol (QMP) commands
diff --git a/system/vl.c b/system/vl.c
index f08c4c8193..7e258889f3 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3369,10 +3369,6 @@ void qemu_init(int argc, char **argv)
                 display_remote++;
                 break;
 #endif
-            case QEMU_OPTION_no_acpi:
-                warn_report("-no-acpi is deprecated, use '-machine acpi=off' instead");
-                qdict_put_str(machine_opts_dict, "acpi", "off");
-                break;
             case QEMU_OPTION_no_reboot:
                 olist = qemu_find_opts("action");
                 qemu_opts_parse_noisily(olist, "reboot=shutdown", false);
diff --git a/qemu-options.hx b/qemu-options.hx
index 57e447065a..dafecf47d6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2645,15 +2645,6 @@ SRST
     needed to boot from old floppy disks.
 ERST
 
-DEF("no-acpi", 0, QEMU_OPTION_no_acpi,
-           "-no-acpi        disable ACPI\n", QEMU_ARCH_I386 | QEMU_ARCH_ARM)
-SRST
-``-no-acpi``
-    Disable ACPI (Advanced Configuration and Power Interface) support.
-    Use it if your guest OS complains about ACPI problems (PC target
-    machine only).
-ERST
-
 DEF("acpitable", HAS_ARG, QEMU_OPTION_acpitable,
     "-acpitable [sig=str][,rev=n][,oem_id=str][,oem_table_id=str][,oem_rev=n][,asl_compiler_id=str][,asl_compiler_rev=n][,{data|file}=file1[:file2]...]\n"
     "                ACPI table description\n", QEMU_ARCH_I386)
-- 
2.43.0


