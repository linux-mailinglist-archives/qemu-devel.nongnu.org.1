Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A9773788C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 03:05:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBmGI-0007pj-8Q; Tue, 20 Jun 2023 21:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGG-0007p6-9V
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:52 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGE-0001Gy-Iv
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687309430; x=1718845430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dlMd5Y05RlitQ/LDn4QHI3iY/Scnnj1sren1XCBp1Gw=;
 b=Wb3w+EvlgTBNjKv+xhkG/232K0Wb5rrpEpyErmB3+eKadw/74Ga48fCe
 AaWORwY3ifNNLkGqMGwDrcWt+SlYHJu9qWTRZY67z7KagJIbTrHjjHFiO
 mc/5cW6SY/fNhSg9xg5HA5xhOzkIXvVcWwzeNd961iwV43m9IxkNPCV4m
 Ru/972KzgF6NA4HeSwF2uQbV9hFLJRiZ9AICqk1eFjQ1TcS905TQGtjK5
 U0u/kxXyIhBOy582ree+DeSi8p3i/rgFIqnyvyeVBzwX5aP1CrLFJkcF0
 n7+pcBvhLPVyFXKI6G3tQm7ku1rxWA066AfRG62PnZt5WA9clZktmsK4u g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357522840"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="357522840"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 18:03:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838429580"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="838429580"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 18:03:44 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, armbru@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, vivek.kasireddy@intel.com,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [RFC PATCH 8/9] ui/gtk: skip drawing if any of ctx/surface/image
 don't exist
Date: Tue, 20 Jun 2023 17:43:54 -0700
Message-Id: <20230621004355.19920-9-dongwon.kim@intel.com>
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

Rendering of scanout could be skipped if ctx/surface/image don't
exist due to an asynchronous event such as monitors being disconnected.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index aa22ebbd98..8eae2b4b1f 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -106,6 +106,11 @@ void gd_egl_draw(VirtualConsole *vc)
         if (!vc->gfx.ds) {
             return;
         }
+
+        if (!vc->gfx.esurface || !vc->gfx.ectx || !vc->gfx.ds->image) {
+            return;
+        }
+
         eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                        vc->gfx.esurface, vc->gfx.ectx);
 
-- 
2.34.1


