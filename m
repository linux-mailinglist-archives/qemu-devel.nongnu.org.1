Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B5DA044C6
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Jan 2025 16:37:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBbB-0003Is-VA; Tue, 07 Jan 2025 10:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBb9-0003H2-EZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBb7-00058H-U6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736264065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V72gLHc8eOLeuqp6z1QZn/Z6Pn3sjtYnWvuS+x+Pus0=;
 b=JLQoT9CStRZnTi9ijyU3uUGkxzVU9n7tZk5E0h6hbRhM/uQDPBuE1V9LNcceVtcz/rq0ew
 UWqn+fzUiAfW6CaO7943t8ShnqPHfpjV5humK677bIEb1IzRwsJb6uxEWfNboVSef42G9l
 QAdvDk/NIOcALc/J8Cs58qY0YrRPsHk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-EMtvT4ycNZuf3gtmN2Db0Q-1; Tue,
 07 Jan 2025 10:34:21 -0500
X-MC-Unique: EMtvT4ycNZuf3gtmN2Db0Q-1
X-Mimecast-MFC-AGG-ID: EMtvT4ycNZuf3gtmN2Db0Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E0361955D45; Tue,  7 Jan 2025 15:34:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.66])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01F2F1956088; Tue,  7 Jan 2025 15:34:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 892351800601; Tue, 07 Jan 2025 16:33:54 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, graf@amazon.com,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 16/21] hw/uefi: add to meson
Date: Tue,  7 Jan 2025 16:33:43 +0100
Message-ID: <20250107153353.1144978-17-kraxel@redhat.com>
In-Reply-To: <20250107153353.1144978-1-kraxel@redhat.com>
References: <20250107153353.1144978-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Wire up uefi-vars in the build system.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/meson.build      |  1 +
 hw/uefi/meson.build | 18 ++++++++++++++++++
 meson.build         |  1 +
 3 files changed, 20 insertions(+)
 create mode 100644 hw/uefi/meson.build

diff --git a/hw/meson.build b/hw/meson.build
index b827c82c5d7b..138f5d59e178 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -35,6 +35,7 @@ subdir('smbios')
 subdir('ssi')
 subdir('timer')
 subdir('tpm')
+subdir('uefi')
 subdir('ufs')
 subdir('usb')
 subdir('vfio')
diff --git a/hw/uefi/meson.build b/hw/uefi/meson.build
new file mode 100644
index 000000000000..d280881f457a
--- /dev/null
+++ b/hw/uefi/meson.build
@@ -0,0 +1,18 @@
+uefi_vars_ss = ss.source_set()
+if (config_all_devices.has_key('CONFIG_UEFI_VARS'))
+  uefi_vars_ss.add(files('var-service-core.c',
+                         'var-service-json.c',
+                         'var-service-vars.c',
+                         'var-service-auth.c',
+                         'var-service-guid.c',
+                         'var-service-utils.c',
+                         'var-service-policy.c'))
+  uefi_vars_ss.add(when: gnutls,
+                   if_true: files('var-service-pkcs7.c'),
+                   if_false: files('var-service-pkcs7-stub.c'))
+  uefi_vars_ss.add(files('var-service-siglist.c'))
+endif
+
+modules += { 'hw-uefi' : {
+    'vars'     : uefi_vars_ss,
+}}
diff --git a/meson.build b/meson.build
index d06f59095c67..741a61089ff4 100644
--- a/meson.build
+++ b/meson.build
@@ -3584,6 +3584,7 @@ if have_system
     'hw/ssi',
     'hw/timer',
     'hw/tpm',
+    'hw/uefi',
     'hw/ufs',
     'hw/usb',
     'hw/vfio',
-- 
2.47.1


