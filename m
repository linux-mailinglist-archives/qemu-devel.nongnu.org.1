Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B7A739287
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 00:32:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC6MB-0002uW-Nk; Wed, 21 Jun 2023 18:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qC6MA-0002uN-Db
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 18:31:18 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qC6M8-0001dO-8f
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 18:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687386676; x=1718922676;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZXVTYKbHn95t5VLZ8AdpjvdzMM4jUosF0lox3KgS1O8=;
 b=FOQVsDxrSCe5Ual/JElK/yYP7ZIeWV5bbNSJMoJNufJn1Lb25kzytNZO
 4ilQXNVKPwA0c3ruwt51JJIsj0Yh5NtpOjw/x1l1Uh88LnH6mc1y951JQ
 byIONwLCDoqPZaydT34NuHRTrHt6xxyG0ySU5a2nQK7NQC0GdWMWLS7Vj
 tM9guUyWynlGahEITgWuxdkoUfemRkhgRSEiOBi2d1qJqpLypIpH1B239
 2IymoN+csJdGKP/KN2Md37ghn3UWaMU1CCpPvp4kEQSgbpH7VuTu5bgfR
 BOFd1D+25QJ1rov2o7hyj7lNbzdBuxfX0Mq6q7POJhvzfXw8xuOE/mzE+ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="340666759"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; d="scan'208";a="340666759"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2023 15:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="888868967"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; d="scan'208";a="888868967"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga005.jf.intel.com with ESMTP; 21 Jun 2023 15:31:09 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] ui/gtk: making dmabuf NULL when it's released.
Date: Wed, 21 Jun 2023 15:11:34 -0700
Message-Id: <20230621221134.29802-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=dongwon.kim@intel.com;
 helo=mga17.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Set vc->gfx.guest_fb.dmabuf to NULL to prevent any further access
to it after the dmabuf is released.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index e50f950f2b..0b8bf8ea8a 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -587,8 +587,12 @@ static bool gd_has_dmabuf(DisplayChangeListener *dcl)
 static void gd_gl_release_dmabuf(DisplayChangeListener *dcl,
                                  QemuDmaBuf *dmabuf)
 {
+    VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 #ifdef CONFIG_GBM
     egl_dmabuf_release_texture(dmabuf);
+    if (vc->gfx.guest_fb.dmabuf == dmabuf) {
+        vc->gfx.guest_fb.dmabuf = NULL;
+    }
 #endif
 }
 
-- 
2.34.1


