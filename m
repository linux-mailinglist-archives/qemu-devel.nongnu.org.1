Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8991874A406
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:57:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHU9o-0000Tu-O9; Thu, 06 Jul 2023 14:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qHU9i-0000TG-DU
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:56:43 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qHU9g-000347-E6
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688669800; x=1720205800;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h9Aw93+KkhRdw/4+fISFiGgpCUIVeymTStHVIw5+xsc=;
 b=jqbQDkRInOEIXU8A6ywslfvmvQ81vkF2r9sWaYaPxdxvPqTS7RqaoQN5
 banmxTQCaJKcVfHqeTP/ZSgMPod2GEXy+j5oiAnN8VRcfR28I7oJyaooQ
 Bbj932YksFwmP40nr2Bupfj+LR1ZO7zCNoGjjugrfQP4PFSF99TpI6w2j
 N9nTV9PnJ/APQodQdIO4un6MkyQcKqkOylWLzyGX7oqb+O2reH1cItFRs
 WJm8Hjr0PFuq4JSiM1ysc2O8hRT/cQp3TrUZcflImb1PCerrm5e1cY9BP
 ZsHGymm/3PicABT+lnKpTyoGrQxXt4Y232F8OYi6SE4kGtNISXHnfq2vX g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="344024317"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="344024317"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2023 11:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="809755788"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="809755788"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by FMSMGA003.fm.intel.com with ESMTP; 06 Jul 2023 11:56:31 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] ui/gtk: skip refresh if new dmabuf has been submitted
Date: Thu,  6 Jul 2023 11:33:55 -0700
Message-Id: <20230706183355.29361-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230706183355.29361-1-dongwon.kim@intel.com>
References: <CAJ+F1C+9hbdgv7tLibnYKS-3fOBotVU=MHwYq6Ly2Wccf-Dd_g@mail.gmail.com>
 <20230706183355.29361-1-dongwon.kim@intel.com>
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

Skip refresh if a new dmabuf (guest scanout frame) has already been
submitted and ready to be drawn because the scanout will be updated
with new frame anyway.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c     | 4 ++++
 ui/gtk-gl-area.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index d59b8cd7d7..859aa8185e 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -144,6 +144,10 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
     gd_update_monitor_refresh_rate(
             vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
+    if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitted) {
+        return;
+    }
+
     if (!vc->gfx.esurface) {
         gd_egl_init(vc);
         if (!vc->gfx.esurface) {
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 7367dfd793..7da75bd025 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -123,6 +123,10 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
+    if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitted) {
+        return;
+    }
+
     if (!vc->gfx.gls) {
         if (!gtk_widget_get_realized(vc->gfx.drawing_area)) {
             return;
-- 
2.34.1


