Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 925628331FE
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 01:54:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQzbe-0001rt-Iw; Fri, 19 Jan 2024 19:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQzbb-0001rA-LL
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 19:53:03 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQzbZ-0000HV-HK
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 19:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705711981; x=1737247981;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UmuSXtMKLQfmwnfzVXPDW5lf8tnHK7D5DmWuTya8UEE=;
 b=dL0FCcarpjhkx0r6z+nF5RCWfz8O9oN55Jw5GqOxAoIT8zkqd6fxWY02
 NpUCZwEYyV+pbvL1pN/PQn92kb82uuBRJGRqMIfx9ul61R5jfOgaR4KmE
 Zcx2DLRq5dqQBMGeZm84OJOZyBxTkhz0o9y1NcO1VIC+1IdSQSFfytIcv
 r8mknfw3mparzTP3Sa9nG3dKQYB8u/fyU4na2z85bpHTm+I9LLKnaR4PR
 dyHXuP4ah41ltwK3jrT50+l/Rb5ZuFryXwMj6MwEtyDP/pkDSUEep2JVR
 LyD8UzbbVJ1tWgdWoaBj4wFywDa2ri0W3GNrwPC7hA4SWamPgFeh/9j4B Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="399763755"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; d="scan'208";a="399763755"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2024 16:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904297439"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; d="scan'208";a="904297439"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2024 16:52:52 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v1 2/7] ui/spice: Enable gl=on option for non-local or remote
 clients
Date: Fri, 19 Jan 2024 16:30:08 -0800
Message-Id: <20240120003013.1829757-3-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240120003013.1829757-1-vivek.kasireddy@intel.com>
References: <20240120003013.1829757-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Newer versions of Spice server should be able to accept dmabuf
fds from Qemu for clients that are connected via the network.
In other words, when this option is enabled, Qemu would share
a dmabuf fd with Spice which would encode and send the data
associated with the fd to a client that could be located on
a different machine.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/ui/spice-display.h | 1 +
 ui/spice-core.c            | 4 ++++
 ui/spice-display.c         | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index e1a9b36185..f4922dd74b 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -151,6 +151,7 @@ struct SimpleSpiceCursor {
 };
 
 extern bool spice_opengl;
+extern bool remote_client;
 
 int qemu_spice_rect_is_empty(const QXLRect* r);
 void qemu_spice_rect_union(QXLRect *dest, const QXLRect *r);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 13bfbe4e89..3b9a54685f 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -849,9 +849,13 @@ static void qemu_spice_init(void)
 #ifdef HAVE_SPICE_GL
     if (qemu_opt_get_bool(opts, "gl", 0)) {
         if ((port != 0) || (tls_port != 0)) {
+#if SPICE_SERVER_VERSION >= 0x000f03 /* release 0.15.3 */
+            remote_client = 1;
+#else
             error_report("SPICE GL support is local-only for now and "
                          "incompatible with -spice port/tls-port");
             exit(1);
+#endif
         }
         egl_init(qemu_opt_get(opts, "rendernode"), DISPLAYGL_MODE_ON, &error_fatal);
         spice_opengl = 1;
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 6eb98a5a5c..384b8508d4 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -29,6 +29,7 @@
 #include "ui/spice-display.h"
 
 bool spice_opengl;
+bool remote_client;
 
 int qemu_spice_rect_is_empty(const QXLRect* r)
 {
-- 
2.39.2


