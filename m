Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FEE737888
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 03:05:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBmGJ-0007qU-HB; Tue, 20 Jun 2023 21:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGH-0007pU-4A
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:53 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGF-0001GW-CN
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687309431; x=1718845431;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NADUm1702aVn1LWj7KvqXMVwTggCDu8sw+9YZB3ZF08=;
 b=U8uObmwoVfgkknpcZ07grSTyfEPzQ3czWXOXdoUkleVb//7e8SmMLmBo
 G1eDgZ+wsHqDEzjRTvvteCC+/NDrAsBMnpbZPg2ixUBgaGKuZZNR/hons
 MH/ze9EYTDKDC3LipbJSj9HhGG7NBeR/oz6a6iyFVZxSYwPVjpDc0BeBY
 AlDjC6fwc1td587zIK17IPW6Ll48zd96+hYNdjH4qirFUUaJek+VOcGn/
 /1Va6HVK9ni0gKlghmwtiyFJfVISz45MH708bz0QlHv38dBYcn4kafHxL
 R9zXaQSuzlkmPMLLaMhVwcdr+ImSCX6t3aGncgCqRwgkaPRXNF3i+FRiI g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357522845"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="357522845"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 18:03:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838429584"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="838429584"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 18:03:45 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, armbru@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, vivek.kasireddy@intel.com,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [RFC PATCH 9/9] ui/gtk: skip refresh/rendering if VC is invisible
Date: Tue, 20 Jun 2023 17:43:55 -0700
Message-Id: <20230621004355.19920-10-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230621004355.19920-1-dongwon.kim@intel.com>
References: <20230621004355.19920-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=dongwon.kim@intel.com;
 helo=mga11.intel.com
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

Skip any drawing activities if VC is invisible because it can't be finished.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c     | 4 ++++
 ui/gtk-gl-area.c | 4 ++++
 ui/gtk.c         | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 8eae2b4b1f..63bfad1f06 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -148,6 +148,10 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
     gd_update_monitor_refresh_rate(
             vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
+    if (!vc->gfx.visible) {
+        return;
+    }
+
     if (!vc->gfx.esurface) {
         gd_egl_init(vc);
         if (!vc->gfx.esurface) {
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 8228cc9f3f..8d01addb3b 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -123,6 +123,10 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
+    if (!vc->gfx.visible) {
+        return;
+    }
+
     if (!vc->gfx.gls) {
         if (!gtk_widget_get_realized(vc->gfx.drawing_area)) {
             return;
diff --git a/ui/gtk.c b/ui/gtk.c
index e4ef1f7173..0bc35b64e0 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -847,6 +847,10 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
 
 #if defined(CONFIG_OPENGL)
     if (vc->gfx.gls) {
+        if (!vc->gfx.visible) {
+            return TRUE;
+        }
+
         if (gtk_use_gl_area) {
             /* invoke render callback please */
             return FALSE;
-- 
2.34.1


