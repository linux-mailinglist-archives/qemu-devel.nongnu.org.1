Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3D0934D26
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jul 2024 14:24:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUQAC-0008OO-Tj; Thu, 18 Jul 2024 08:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUQA6-0008BG-7Y
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:23:07 -0400
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUQA1-0003tU-Cy
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:23:04 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721305378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKoQny0JNC81tqepEH2Y0PTkyMY6TR51gl8HfjhZtEc=;
 b=vjdMU4deM2ZJ1QarabnSb0baLWgkPzgCFmae83G2Khqe+kvuDaiAzMFR2u9M+tKMRN5XL1
 JKjkLQN9n5p868DWYsRBZwBihhY7DotAJecWbtQqwK8r7FW7yJutCCiOTz81JTvKyc8+up
 8dEJIYnPTmmLR44tXAi84lemYDQOQ04ojMLJy/b1Pk28ihO2pecNqnlJb8GwKfIYwQo4Bf
 phBDQZgThuDmck5Jm2kF1JaDKXYDRfQc0OqSDL+q5b/lMh0MMRgr7PdkdzvLrFfZ+k9EM7
 UJN7PkgqakiC0J14JxFtoCbiPs9YtYVUPe30GtU6qKEPmvN0TdypJnsOsHymIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721305378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKoQny0JNC81tqepEH2Y0PTkyMY6TR51gl8HfjhZtEc=;
 b=AbLg6E5LQZoJn6sqLzPx0hZ5dd9G1i1lpc8mJyZEkVOk5sWJ9DaId8tGYCmxLWnVJ4rcrA
 jG4gDVB+TIzLMEDQ==
Date: Thu, 18 Jul 2024 14:21:45 +0200
Subject: [PATCH v5 1/4] docs/interop/firmware.json: add new enum FirmwareFormat
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240718-qapi-firmware-json-v5-1-0dba12d7aaf5@linutronix.de>
References: <20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de>
In-Reply-To: <20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721305377; l=1463;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=yaoqLoJ9oEeYkWdBz3Fajrr9wjMuB4kwcL7T+Hk31YE=;
 b=ateWysdE4erDgR85k71zHF4cR0v7c+ZOBtDmkukazYHONtlpwQam7U95x0PniXTqsE9J3f4fu
 Dao6gsaLsrYD0IxvASJgiTUG2/aEzy+AV82vVLdP6EuEGDm2oUyBj9A
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

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 54a1fc6c1041..a26fe81bf2fe 100644
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
+# @qcow2: QEMU image format.
+#
+# Since: 9.1
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


