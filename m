Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8AC937473
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jul 2024 09:37:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUiBP-0000KK-2X; Fri, 19 Jul 2024 03:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUiBK-00006b-QM
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:37:35 -0400
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUiBJ-0002iK-1a
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:37:34 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721374647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMGl9jqa2JX2JXlzmVzHZvDEzGMjndqRdkBkMf/NXW0=;
 b=IqV9zlETyGsY61Pj9xDlGH4FBcflIezCaae9wHFTDAIcYLi7Z1dcnWOzVNFXIRyF9JTb+t
 am/8Q2jBFGsoJsWV1oHjfa4JzMit3be0mjqY9hNoVA5jN0bRjg6IL84BbXnmUmM3VXYzxr
 J30bC8yq/XHmJZlilHX7EyGyt1KK7kDtpTUkdN+vTkBSizREzAHdlaZ/mcyB/hkfTSg5q/
 XRf4OYxRrTi4X+wM7ixVg0Ac2+tgcWYMafjGtvMQpTB1eU3Hsp98uq4dXVxgQhtnZ7TYZA
 fgzftQiu31+kkzWVZqBFYJGR01NKGenHpCV5h8ykSrbAtaUK55mtSA2yw0dcDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721374647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMGl9jqa2JX2JXlzmVzHZvDEzGMjndqRdkBkMf/NXW0=;
 b=1hamqpNdxtiIsWqWFjc8QfvxpRqQe2ehqz57i+Y6KxSroWx+RLN8xI8EB2AXf2UfSHgYm3
 uawPFyT957qjNgAA==
Date: Fri, 19 Jul 2024 09:37:22 +0200
Subject: [PATCH v6 1/4] docs/interop/firmware.json: add new enum FirmwareFormat
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240719-qapi-firmware-json-v6-1-c2e3de390b58@linutronix.de>
References: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
In-Reply-To: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721374646; l=1600;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vMBCf78tFJlMpxrrXcs5qdQiSATuySGI8Q19NujvRDo=;
 b=OuYFr3zNUax2scvsGYhsEqxx/ODpgUi2aM0U+yU6ERGqFqf/pIMxxn1kca89X48VLk4KATZfX
 /TbwJjAifaxDnoY/IdCqUNepQVQKw+jZ7LXuATfwhrhwppOZk8GmBTW
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=2a0a:51c0:0:12e:550::1;
 envelope-from=t-8ch@linutronix.de; helo=galois.linutronix.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Only a small subset of all blockdev drivers make sense for firmware
images. Introduce and use a new enum to represent this.

This also reduces the dependency on firmware.json from the global qapi
definitions.

Claim "Since: 3.0" for the new enum, because that's correct for its
members, and the members are what matters in the interface.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 54a1fc6c1041..d5d4c17f230b 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -15,7 +15,6 @@
 ##
 
 { 'include' : 'machine.json' }
-{ 'include' : 'block-core.json' }
 
 ##
 # @FirmwareOSInterface:
@@ -200,6 +199,20 @@
              'enrolled-keys', 'requires-smm', 'secure-boot',
              'verbose-dynamic', 'verbose-static' ] }
 
+##
+# @FirmwareFormat:
+#
+# Formats that are supported for firmware images.
+#
+# @raw: Raw disk image format.
+#
+# @qcow2: The QCOW2 image format.
+#
+# Since: 3.0
+##
+{ 'enum': 'FirmwareFormat',
+  'data': [ 'raw', 'qcow2' ] }
+
 ##
 # @FirmwareFlashFile:
 #
@@ -219,7 +232,7 @@
 ##
 { 'struct' : 'FirmwareFlashFile',
   'data'   : { 'filename' : 'str',
-               'format'   : 'BlockdevDriver' } }
+               'format'   : 'FirmwareFormat' } }
 
 
 ##

-- 
2.45.2


