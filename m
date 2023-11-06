Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B17E1DC3
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:59:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzwLx-0007sL-5m; Mon, 06 Nov 2023 04:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzwLv-0007lx-I7
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:57:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzwLu-0008Tz-1s
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699264621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJbN66is0rq3NleJYaE0Jf3JCOZlcB7xHJzQcJyNAwM=;
 b=cEoWdk+amfC0TAhiVKR7fBcs+jlv6JBJsbkEHdQZ2JFSIy/JpMZVZfYple8PI11hbdPLAM
 pq+5/vOmOl0rz+mWyuRH9wuGhkpXOPqynQxr5YXR25DgCzwbYl7ZQph1VUDH1Slr1ZK0SK
 0epdgvcC1TY6VIw2roOdoLcb/Z98GPE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-ICStj1kmNMmZ_fYZQck4gw-1; Mon,
 06 Nov 2023 04:56:51 -0500
X-MC-Unique: ICStj1kmNMmZ_fYZQck4gw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F91F38116FA;
 Mon,  6 Nov 2023 09:56:51 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 648A3492A;
 Mon,  6 Nov 2023 09:56:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 16/24] ui/vnc: VNC requires PIXMAN
Date: Mon,  6 Nov 2023 13:55:33 +0400
Message-ID: <20231106095542.1852973-17-marcandre.lureau@redhat.com>
In-Reply-To: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
References: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 meson.build    | 6 +++++-
 ui/meson.build | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 2d67cbf6d6..f3fc1ba68d 100644
--- a/meson.build
+++ b/meson.build
@@ -1536,7 +1536,11 @@ endif
 vnc = not_found
 jpeg = not_found
 sasl = not_found
-if get_option('vnc').allowed() and have_system
+if get_option('vnc') \
+             .disable_auto_if(not have_system) \
+             .require(pixman.found(),
+                      error_message: 'cannot enable VNC if pixman is not available') \
+             .allowed()
   vnc = declare_dependency() # dummy dependency
   jpeg = dependency('libjpeg', required: get_option('vnc_jpeg'),
                     method: 'pkg-config')
diff --git a/ui/meson.build b/ui/meson.build
index 7c99613950..19723188b5 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -46,7 +46,7 @@ vnc_ss.add(files(
 ))
 vnc_ss.add(zlib, jpeg, gnutls)
 vnc_ss.add(when: sasl, if_true: files('vnc-auth-sasl.c'))
-system_ss.add_all(when: vnc, if_true: vnc_ss)
+system_ss.add_all(when: [vnc, pixman], if_true: vnc_ss)
 system_ss.add(when: vnc, if_false: files('vnc-stubs.c'))
 
 ui_modules = {}
-- 
2.41.0


