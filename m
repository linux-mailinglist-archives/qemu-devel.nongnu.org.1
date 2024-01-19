Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE30832C52
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 16:27:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqkE-0002IY-77; Fri, 19 Jan 2024 10:25:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqkB-0002HU-6C
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqk9-00018p-Ii
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705677917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZI8PiOZ6ShiVDFwBkL3K7EiPQwuUxWIDxrHeBFUDKms=;
 b=FxdPfftLmQDiADHPFgzRIrb0/UZfikC3hKnLVUy4V7dMVSeI26WzIG+v9cA/2qrf/ND6Wz
 jKAecL6v2DUko/XlvIQxOaYwEBEVWvEEkg5lzxw/JmLFfTkywmcf+rabHRlKQlNISQNaK7
 EvdQQaAI0pAX04z8vo82evOu40BT97o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-QFhKNgJ-OK-COQOTqPwmew-1; Fri, 19 Jan 2024 10:25:15 -0500
X-MC-Unique: QFhKNgJ-OK-COQOTqPwmew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD1CF106CF92;
 Fri, 19 Jan 2024 15:25:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBE1440D1B60;
 Fri, 19 Jan 2024 15:25:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 04/11] qemu-options: Remove the deprecated -no-hpet option
Date: Fri, 19 Jan 2024 16:25:00 +0100
Message-ID: <20240119152507.55182-5-thuth@redhat.com>
In-Reply-To: <20240119152507.55182-1-thuth@redhat.com>
References: <20240119152507.55182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240118103759.130748-2-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst       | 6 ------
 docs/about/removed-features.rst | 8 ++++++++
 system/vl.c                     | 4 ----
 qemu-options.hx                 | 7 -------
 4 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 2e15040246..3dcb652132 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -63,12 +63,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
-``-no-hpet`` (since 8.0)
-''''''''''''''''''''''''
-
-The HPET setting has been turned into a machine property.
-Use ``-machine hpet=off`` instead.
-
 ``-no-acpi`` (since 8.0)
 ''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index f04036987b..52d240ade9 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -460,6 +460,14 @@ in this case.
 Note that the default audio backend must be configured on the command
 line if the ``-nodefaults`` options is used.
 
+``-no-hpet`` (removed in 9.0)
+'''''''''''''''''''''''''''''
+
+The HPET setting has been turned into a machine property.
+Use ``-machine hpet=off`` instead.
+
+
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/system/vl.c b/system/vl.c
index 53850a1daf..f08c4c8193 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3373,10 +3373,6 @@ void qemu_init(int argc, char **argv)
                 warn_report("-no-acpi is deprecated, use '-machine acpi=off' instead");
                 qdict_put_str(machine_opts_dict, "acpi", "off");
                 break;
-            case QEMU_OPTION_no_hpet:
-                warn_report("-no-hpet is deprecated, use '-machine hpet=off' instead");
-                qdict_put_str(machine_opts_dict, "hpet", "off");
-                break;
             case QEMU_OPTION_no_reboot:
                 olist = qemu_find_opts("action");
                 qemu_opts_parse_noisily(olist, "reboot=shutdown", false);
diff --git a/qemu-options.hx b/qemu-options.hx
index 1912b19cb8..38d38abd6d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2656,13 +2656,6 @@ SRST
     machine only).
 ERST
 
-DEF("no-hpet", 0, QEMU_OPTION_no_hpet,
-    "-no-hpet        disable HPET\n", QEMU_ARCH_I386)
-SRST
-``-no-hpet``
-    Disable HPET support. Deprecated, use '-machine hpet=off' instead.
-ERST
-
 DEF("acpitable", HAS_ARG, QEMU_OPTION_acpitable,
     "-acpitable [sig=str][,rev=n][,oem_id=str][,oem_table_id=str][,oem_rev=n][,asl_compiler_id=str][,asl_compiler_rev=n][,{data|file}=file1[:file2]...]\n"
     "                ACPI table description\n", QEMU_ARCH_I386)
-- 
2.43.0


