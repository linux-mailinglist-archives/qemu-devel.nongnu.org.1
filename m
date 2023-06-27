Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6587273F02C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 03:13:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDxGS-0000JK-NM; Mon, 26 Jun 2023 21:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qDxGP-0000Ia-Sk
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 21:13:01 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qDxGN-0005p1-It
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 21:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687828379; x=1719364379;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=smRXhU983mdYGLuwnagfDBTpOKUYvQitBewTc3eA6v8=;
 b=SQVOPDYG6tmNSGMA+vwFzs95nO2ld74SMoDXQn5nZjPu5t7wdIH2KTYd
 Ty1fZ7A7SZ6rWsYlINNoNsedhwIccGRfftzv2FQVXUOx+fz1FP9K5D1w9
 DiEt6HmIQjMNVy8xDsPxF9FO7xVyWBi6M4Ox3NXPzyuN6ZRytsRka4kty
 VXPWGVAxdSsUbZApBAfYn696pf0qW/xpEcy7cY9VKAMpnkTiSVbJBWaYj
 yihZoC2Ob3GWcAqeJDZTpEPWUinHBSmSiP+WD8qgkI5aFddEtf700FJ1Y
 xC6Jc5AMO8LP6NRd65t2s5DvV3Cybk/zCBq8ZBIqL5A8KPOzrxT6vDSqk Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="363981925"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="363981925"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 18:12:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="1046718264"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="1046718264"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by fmsmga005.fm.intel.com with ESMTP; 26 Jun 2023 18:12:55 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH v2] ui/gtk: making dmabuf NULL when it's released.
Date: Mon, 26 Jun 2023 17:53:16 -0700
Message-Id: <20230627005316.5627-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1f1d2da4-4402-d92a-c0f9-5f7f06089ccb@linaro.org>
References: <1f1d2da4-4402-d92a-c0f9-5f7f06089ccb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=dongwon.kim@intel.com; helo=mga09.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Set vc->gfx.guest_fb.dmabuf to NULL to prevent any further access
to it after the dmabuf is released.

v2: move declaration of vc inside ifdef

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index e50f950f2b..2a9a0d23e6 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -588,7 +588,12 @@ static void gd_gl_release_dmabuf(DisplayChangeListener *dcl,
                                  QemuDmaBuf *dmabuf)
 {
 #ifdef CONFIG_GBM
+    VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
+
     egl_dmabuf_release_texture(dmabuf);
+    if (vc->gfx.guest_fb.dmabuf == dmabuf) {
+        vc->gfx.guest_fb.dmabuf = NULL;
+    }
 #endif
 }
 
-- 
2.34.1


