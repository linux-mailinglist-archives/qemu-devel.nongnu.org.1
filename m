Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F73B8812C2
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Mar 2024 14:55:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmwPj-0005RB-MI; Wed, 20 Mar 2024 09:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rmwPD-0005Db-LD
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rmwPC-0000Ep-3h
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710942897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfM5qhRsMgeZ9ObyeIq+96OOE4ZTxePrPvMEn3jqxjU=;
 b=T5DmBOLSRovj4rtUzNFS5JU8g9X//6H812308xCj6rxGKJ5VBhXVpBNznkmHnwKqnvgUl4
 q4nYtRgtuxOIP+55Sf/1ZIYhnx3Y9AW/qVdR3+vtpD/dOHrZhUT950f6g7olv1cpXp6Cap
 23hzu+e1dgsmvakQwR3z/rFWi2RjkrE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-DXKRI6AjNiOnw40HDfCFeA-1; Wed, 20 Mar 2024 09:54:53 -0400
X-MC-Unique: DXKRI6AjNiOnw40HDfCFeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73FAE186E28B;
 Wed, 20 Mar 2024 13:54:53 +0000 (UTC)
Received: from localhost (unknown [10.39.208.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2781140C6DB7;
 Wed, 20 Mar 2024 13:54:51 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/5] ui: compile dbus-display1.c with -fPIC as necessary
Date: Wed, 20 Mar 2024 17:53:49 +0400
Message-ID: <20240320135349.2139402-6-marcandre.lureau@redhat.com>
In-Reply-To: <20240320135349.2139402-1-marcandre.lureau@redhat.com>
References: <20240320135349.2139402-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Building dbus-display1.c explicitly as a static library drops -fPIC by
default, which may not be correct if it ends up linked to a shared
library.

Let the target decide how to build the unit, with or without -fPIC. This
makes commit 186acfbaf7 ("tests/qtest: Depend on dbus_display1_dep") no
longer relevant, as dbus-display1.c will be recompiled.

Fixes: c172136ea33 ("meson: ensure dbus-display generated code is built
before other units")

Reported-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ui/meson.build b/ui/meson.build
index 0b7e2b6f6b..a5ce22a678 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -90,8 +90,7 @@ if dbus_display
                                           '--interface-prefix', 'org.qemu.',
                                           '--c-namespace', 'QemuDBus',
                                           '--generate-c-code', '@BASENAME@'])
-  dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies: gio)
-  dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, sources: dbus_display1[0])
+  dbus_display1_dep = declare_dependency(sources: dbus_display1, dependencies: gio)
   dbus_ss.add(when: [gio, dbus_display1_dep],
               if_true: [files(
                 'dbus-chardev.c',
-- 
2.44.0


