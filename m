Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 719088316BB
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 11:39:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQPmm-0003cq-D3; Thu, 18 Jan 2024 05:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQPmk-0003cG-11
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:38:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQPmi-0006v3-4B
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705574286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvLwrdsBtAbxG6dH0UjFC0ASo69JEa85T3xvMU5mOgY=;
 b=NEUbE1MzItTaI8jFSmpETPzeEdjaQBY7hhI7vHW35vFz48bhfOt7ma+K5NEf/DySbwSeE6
 /AY0SLvWKtTaJZX7t6lH1KNjjUK9MWyuS/VTtDfrHspxkY4rBTmS01MHIn43OElZybjhYu
 2kXmjbNoogo66OTAbQzaz8a5r/fqVJ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-TqlUHSPdMdq_wXJG7_FMRw-1; Thu, 18 Jan 2024 05:38:05 -0500
X-MC-Unique: TqlUHSPdMdq_wXJG7_FMRw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE23580007C;
 Thu, 18 Jan 2024 10:38:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE028492BC6;
 Thu, 18 Jan 2024 10:38:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/4] qemu-options: Remove the deprecated -no-hpet option
Date: Thu, 18 Jan 2024 11:37:56 +0100
Message-ID: <20240118103759.130748-2-thuth@redhat.com>
In-Reply-To: <20240118103759.130748-1-thuth@redhat.com>
References: <20240118103759.130748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst       | 6 ------
 docs/about/removed-features.rst | 8 ++++++++
 system/vl.c                     | 4 ----
 qemu-options.hx                 | 7 -------
 4 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index f48fc83d85..bf2150f00c 100644
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
index b66570ae00..57e447065a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2654,13 +2654,6 @@ SRST
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


