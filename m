Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EAE833203
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 01:54:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQzbi-0001t8-NS; Fri, 19 Jan 2024 19:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQzbd-0001ru-ST
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 19:53:05 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQzbc-0000HV-17
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 19:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705711984; x=1737247984;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0l+PsH2fLrrdH4iP9164gk31Qk9B4U0bQLvvhVpe58M=;
 b=Pv4BhBECiqxDv/7v/JMTL460RkbcL1cG7HheGgYZU1UFSuiR3i2vcW30
 r1ao8vHTOtVqy4orCJ1f+v2Id4urqKiV+++C8xDAaGwui0mKZPGx/Koxy
 hYtZfHhA/P9m4D4p46Xbqxo23w+PIDlNgddQtjNArTG52bNaqDoTG47DG
 +YdArDKtyrM8nQxC1kfMS67K9XrEldQQqgApdfRXg7w+zWGVCjr41rIMI
 wRg1Dz35dup36o7BhJnr/969KiO0GrQk5vdgMIGOW9NaDt2nl1Se1Ss6x
 c6wFOERL8Jhr7UlKYVqeO6ZEHlVK/Upe7klbShik9ipeSwOzJzxCowtTJ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="399763765"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; d="scan'208";a="399763765"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2024 16:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904297449"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; d="scan'208";a="904297449"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2024 16:52:52 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v1 5/7] ui/spice: Override the surface's glformat when gl=on
 is enabled
Date: Fri, 19 Jan 2024 16:30:11 -0800
Message-Id: <20240120003013.1829757-6-vivek.kasireddy@intel.com>
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

When testing with gl=on on an Intel Host, it was noticed that the
R and B channels were interchanged while the Guest FB image was
displayed. This was only seen if the display layer (virtio-gpu)
did not directly share the dmabuf fd with Spice (i.e, blob=false).

One of the main differences in the case where blob=true vs blob=false
is that we create the dmabuf fd from a texture in the latter case
whereas we directly pass the fd from the display layer to Spice in
the former case. Although, the surface's format (PIXMAN_BE_b8g8r8x8)
is the same in both cases, the creation of the texture (which involves
copying data from Pixman image into a GPU buffer) appears to somehow
result in having the R and B channels interchanged. One way to ensure
correct behavior is we have glformat=GL_RGBA while creating the texture.

It looks like having glformat=GL_RGBA and gltype = GL_UNSIGNED_BYTE
should work regardless of the Host's endianness but let us limit
this change only to this specific use-case for now.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 ui/spice-display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 90c04623ec..08b4aec921 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -900,6 +900,9 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
     }
     ssd->ds = new_surface;
     if (ssd->ds) {
+        if (remote_client && surface_format(ssd->ds) != PIXMAN_r5g6b5) {
+            ssd->ds->target_glformat = GL_RGBA;
+        }
         surface_gl_create_texture(ssd->gls, ssd->ds);
         fd = egl_get_fd_for_texture(ssd->ds->texture,
                                     &stride, &fourcc,
-- 
2.39.2


