Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3429E832C59
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 16:27:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqkR-0002Oa-1W; Fri, 19 Jan 2024 10:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqkN-0002Na-DP
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqkK-0001Bu-3q
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705677926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K2AlAs+bdSDNPYLeRb0302SDGMicBMsA8BLHJOdE49E=;
 b=eS22Z0kS7WFMvAHNBApcT1MzTochGwqQWceDfxFKz8L8Pe1NH75FnDrKGa+4G4z2XfGuhg
 fgmMkoL5RXe1mv+i+luNVjxnJDa9oypq4mQwrJ8Yu5hOYkSLgQdbH4WnICHkmnVjP+RbNU
 k+xxH55dsJwv9KDa/1dr13nC9yeZjTA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-4vH7wt5qOQuRPhZTsuoOyA-1; Fri,
 19 Jan 2024 10:25:22 -0500
X-MC-Unique: 4vH7wt5qOQuRPhZTsuoOyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F5143C2AB0F;
 Fri, 19 Jan 2024 15:25:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24B1940C1430;
 Fri, 19 Jan 2024 15:25:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 09/11] hmp: Remove deprecated 'singlestep' command
Date: Fri, 19 Jan 2024 16:25:05 +0100
Message-ID: <20240119152507.55182-10-thuth@redhat.com>
In-Reply-To: <20240119152507.55182-1-thuth@redhat.com>
References: <20240119152507.55182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This command has been deprecated before the 8.1 release,
in commit e9ccfdd91d ("hmp: Add 'one-insn-per-tb' command
equivalent to 'singlestep'"). Time to drop it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: "Dr. David Alan Gilbert" <dave@treblig.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240117151430.29235-3-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst       |  9 ---------
 docs/about/removed-features.rst |  6 ++++++
 tests/qtest/test-hmp.c          |  1 -
 hmp-commands.hx                 | 13 -------------
 4 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 25527da423..316a26a82c 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -167,15 +167,6 @@ points was removed in 7.0. However QMP still exposed the vcpu
 parameter. This argument has now been deprecated and the remaining
 remaining trace points that used it are selected just by name.
 
-Human Monitor Protocol (HMP) commands
--------------------------------------
-
-``singlestep`` (since 8.1)
-''''''''''''''''''''''''''
-
-The ``singlestep`` command has been replaced by the ``one-insn-per-tb``
-command, which has the same behaviour but a less misleading name.
-
 Host Architectures
 ------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index a8546f4787..855d788259 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -635,6 +635,12 @@ Use ``migrate-set-parameters`` instead.
 
 This command didn't produce any output already. Removed with no replacement.
 
+``singlestep`` (removed in 9.0)
+'''''''''''''''''''''''''''''''
+
+The ``singlestep`` command has been replaced by the ``one-insn-per-tb``
+command, which has the same behaviour but a less misleading name.
+
 Guest Emulator ISAs
 -------------------
 
diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
index fc9125f8bb..1b2e07522f 100644
--- a/tests/qtest/test-hmp.c
+++ b/tests/qtest/test-hmp.c
@@ -64,7 +64,6 @@ static const char *hmp_cmds[] = {
     "qom-get /machine initrd",
     "screendump /dev/null",
     "sendkey x",
-    "singlestep on",
     "wavcapture /dev/null",
     "stopcapture 0",
     "sum 0 512",
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 2db5701d49..17b5ea839d 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -398,19 +398,6 @@ SRST
   If called with option off, the emulation returns to normal mode.
 ERST
 
-    {
-        .name       = "singlestep",
-        .args_type  = "option:s?",
-        .params     = "[on|off]",
-        .help       = "deprecated synonym for one-insn-per-tb",
-        .cmd        = hmp_one_insn_per_tb,
-    },
-
-SRST
-``singlestep [off]``
-  This is a deprecated synonym for the one-insn-per-tb command.
-ERST
-
     {
         .name       = "stop|s",
         .args_type  = "",
-- 
2.43.0


