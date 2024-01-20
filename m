Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B2F833201
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 01:54:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQzbe-0001rr-Il; Fri, 19 Jan 2024 19:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQzbb-0001rB-PE
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 19:53:03 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQzba-0000HA-1R
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 19:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705711982; x=1737247982;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w6zsMuKR5+dos2BSIN9Npc/spxx3lltKpXTlvh/rSkg=;
 b=dyGbyXxfsN3GGJdRD7svG8LKuvZOXpeb1P7MEOfmyGzncU4LZjbrfJ+c
 eVvpDE2OxFkEmBGqkl5w1nup4eGlSR+5fjFpDyGLO6SFXZ9/AUuHLpXB8
 mjqlopVcq0iIgoXpMJeeaXm73y5aX/+g6JC3+Dq+Tlx45N2LFvQ0F/dba
 mNp9TMSBBcCSIsEguRptoFuwldJW/evXb1C1H6vVhvyB8JHOMLgNNiE9r
 AOV5gVLJndu/SRuHe3yDvwOmYHl28dzjxxEmcjht50p7zEHKYVbQaWglY
 nq4Oo+Mx8A77icWz1O3rS5szbY59QBNNHJes/3M/IfZvPrQCOSX6EMUEJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="399763762"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; d="scan'208";a="399763762"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2024 16:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904297445"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; d="scan'208";a="904297445"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2024 16:52:52 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v1 4/7] ui/console-gl: Add an option to override a surface's
 glformat
Date: Fri, 19 Jan 2024 16:30:10 -0800
Message-Id: <20240120003013.1829757-5-vivek.kasireddy@intel.com>
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

In some cases where a UI component (e.g, Spice) needs to choose
a particular glformat for a surface while creating a texture,
this new GLenum provides an option to do so. One situation
where this needs to be done is when the Host endianness is
causing issues such as interchanged R and B channels.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/ui/surface.h | 1 +
 ui/console-gl.c      | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/ui/surface.h b/include/ui/surface.h
index 4244e0ca4a..a39fee55a2 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -20,6 +20,7 @@ typedef struct DisplaySurface {
     uint8_t flags;
 #ifdef CONFIG_OPENGL
     GLenum glformat;
+    GLenum target_glformat;
     GLenum gltype;
     GLuint texture;
 #endif
diff --git a/ui/console-gl.c b/ui/console-gl.c
index 103b954017..dee317f42c 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -72,6 +72,12 @@ void surface_gl_create_texture(QemuGLShader *gls,
         g_assert_not_reached();
     }
 
+    /* The caller wants to override the glformat in some specific cases */
+    if (surface->target_glformat &&
+        surface->target_glformat != surface->glformat) {
+        surface->glformat = surface->target_glformat;
+    }
+
     glGenTextures(1, &surface->texture);
     glEnable(GL_TEXTURE_2D);
     glBindTexture(GL_TEXTURE_2D, surface->texture);
-- 
2.39.2


