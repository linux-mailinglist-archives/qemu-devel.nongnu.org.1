Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CF8832C4C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 16:26:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqkG-0002JL-Mp; Fri, 19 Jan 2024 10:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqkE-0002Ib-0S
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqkB-00019M-Oj
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705677919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XAk5N9tdPH0GW6+TcTTbW38mcVWARQGPvDBp8mntwY=;
 b=iUICU0ji7CnZSz3MzApoYqZfiF+LE634O3IDyFukFg49cWLPu8zO2jyC8CxuRpdSz+UtSA
 Fmqhvjcso9mhebisGARL0ZLzS/5S6UxxnUDLG02tWIMfOLwVDSocGOAYFbOK5UkopbX6YU
 NOEWx2RrkPrxPK0o0o88qJi6njAtglY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Rq7caEV7O5u68VyytYCkCA-1; Fri, 19 Jan 2024 10:25:17 -0500
X-MC-Unique: Rq7caEV7O5u68VyytYCkCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30F20868A0B;
 Fri, 19 Jan 2024 15:25:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2923440C95AD;
 Fri, 19 Jan 2024 15:25:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 05/11] qemu-options: Remove the deprecated -no-acpi option
Date: Fri, 19 Jan 2024 16:25:01 +0100
Message-ID: <20240119152507.55182-6-thuth@redhat.com>
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

Message-ID: <20240118103759.130748-3-thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst       | 6 ------
 docs/about/removed-features.rst | 5 +++++
 docs/specs/tpm.rst              | 4 ++--
 hw/i386/pc.c                    | 4 ++--
 system/vl.c                     | 4 ----
 qemu-options.hx                 | 9 ---------
 6 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 3dcb652132..aa2cbe0d74 100644
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
diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index c96776a369..68cb8cf7e6 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -343,9 +343,9 @@ In case an Arm virt machine is emulated, use the following command line:
 
 .. code-block:: console
 
-  qemu-system-aarch64 -machine virt,gic-version=3,accel=kvm \
+  qemu-system-aarch64 -machine virt,gic-version=3,acpi=off \
     -cpu host -m 4G \
-    -nographic -no-acpi \
+    -nographic -accel kvm \
     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
     -tpmdev emulator,id=tpm0,chardev=chrtpm \
     -device tpm-tis-device,tpmdev=tpm0 \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 496498df3a..803244e5cc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1348,7 +1348,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     Error *local_err = NULL;
 
     /*
-     * When -no-acpi is used with Q35 machine type, no ACPI is built,
+     * When "acpi=off" is used with the Q35 machine type, no ACPI is built,
      * but pcms->acpi_dev is still created. Check !acpi_enabled in
      * addition to cover this case.
      */
@@ -1396,7 +1396,7 @@ static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
     X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
 
     /*
-     * When -no-acpi is used with Q35 machine type, no ACPI is built,
+     * When "acpi=off" is used with the Q35 machine type, no ACPI is built,
      * but pcms->acpi_dev is still created. Check !acpi_enabled in
      * addition to cover this case.
      */
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
index 38d38abd6d..844a189fb0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2647,15 +2647,6 @@ SRST
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


