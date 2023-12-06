Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 192D880758F
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:45:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAv19-0004AQ-JZ; Wed, 06 Dec 2023 11:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rAv13-00049g-2P
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:44:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rAv0y-0004b9-53
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701881086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1QURncaWSZkXykA1+jscCIYXqOXW6Dv+O8pl0gGys0M=;
 b=jFASih974T3raaDy+XChms9DbUPrOwdV8W59hwVM7r999LtSAVy6u6etgoZsdQYwkeu8yp
 I4SDl56MSvkovcSyp8KXNam1Ueod4u15QpMEa7N8HKhhYOlYuz9cnZJ0BBFyeApsyawrWk
 xZc16T0xkeb+wIEnHCsx5FRzphctOSM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-I-nS42CDM9ScCiBiO8DMmw-1; Wed, 06 Dec 2023 11:44:45 -0500
X-MC-Unique: I-nS42CDM9ScCiBiO8DMmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08CDF101A555;
 Wed,  6 Dec 2023 16:44:45 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 006572166B35;
 Wed,  6 Dec 2023 16:44:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] meson: sort C warning flags alphabetically
Date: Wed,  6 Dec 2023 16:44:43 +0000
Message-ID: <20231206164443.1058339-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

When scanning the list of warning flags to see if one is present, it is
helpful if they are in alphabetical order. It is further helpful to
separate out the 'no-' prefixed warnings.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

The diff looks horrendous, so look at the resulting meson.build to see
the benefit.

 meson.build | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/meson.build b/meson.build
index d2c4c2adb3..5c884cf7ce 100644
--- a/meson.build
+++ b/meson.build
@@ -433,36 +433,38 @@ endif
 add_global_arguments(qemu_common_flags, native: false, language: all_languages)
 add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
 
-# Collect warnings that we want to enable
-
+# Collect warning flags we want to set, sorted alphabetically
 warn_flags = [
-  '-Wundef',
-  '-Wwrite-strings',
-  '-Wmissing-prototypes',
-  '-Wstrict-prototypes',
-  '-Wredundant-decls',
-  '-Wold-style-declaration',
-  '-Wold-style-definition',
-  '-Wtype-limits',
-  '-Wformat-security',
-  '-Wformat-y2k',
-  '-Winit-self',
-  '-Wignored-qualifiers',
+  # First enable interesting warnings
   '-Wempty-body',
-  '-Wnested-externs',
   '-Wendif-labels',
   '-Wexpansion-to-defined',
+  '-Wformat-security',
+  '-Wformat-y2k',
+  '-Wignored-qualifiers',
   '-Wimplicit-fallthrough=2',
+  '-Winit-self',
   '-Wmissing-format-attribute',
+  '-Wmissing-prototypes',
+  '-Wnested-externs',
+  '-Wold-style-declaration',
+  '-Wold-style-definition',
+  '-Wredundant-decls',
+  '-Wshadow=local',
+  '-Wstrict-prototypes',
+  '-Wtype-limits',
+  '-Wundef',
+  '-Wwrite-strings',
+
+  # Then disable some undesirable warnings
+  '-Wno-gnu-variable-sized-type-not-at-end',
   '-Wno-initializer-overrides',
   '-Wno-missing-include-dirs',
+  '-Wno-psabi',
   '-Wno-shift-negative-value',
   '-Wno-string-plus-int',
-  '-Wno-typedef-redefinition',
   '-Wno-tautological-type-limit-compare',
-  '-Wno-psabi',
-  '-Wno-gnu-variable-sized-type-not-at-end',
-  '-Wshadow=local',
+  '-Wno-typedef-redefinition',
 ]
 
 if targetos != 'darwin'
-- 
2.43.0


