Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 966BC8331FF
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 01:54:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQzba-0001qo-Na; Fri, 19 Jan 2024 19:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQzbX-0001qU-Gd
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 19:52:59 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQzbV-0000HA-69
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 19:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705711977; x=1737247977;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xpMDzIHqzApRxub5vxUFd2LIh2G+nE3xd3Hb1B1F9bo=;
 b=ZOIgTimrT3AWzF/iefGbCUvghc1Cfhj0CJpZyKvEwiYGjVH/w8S6yKXi
 Rboi+OgXtcIhhcOlzefCqNWClyCZzk65lpJLpSx3nPzxk9jRzgFoywAcP
 V2nJdpRVomYWqK2Y+p65dvDwK3T+7C+INo5JfCePPaS7xd/GYxV51FfKZ
 ZfcLYsjMWNhLXhSSNUxFNLC1J8OD1cCnSJYmvVf5K9ZMPltaPSickTqH5
 cFi2uLhPKHPUGdAJ0CBup3p29/ant6LrKUBH94sa/mEVeg7VjSGeIO8qh
 /aYE2/uPPmlVbIGjqcdfdrXbre01ugUgIirc+tYFkbQrSljDtd8rQLtXg Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="399763749"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; d="scan'208";a="399763749"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2024 16:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904297434"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; d="scan'208";a="904297434"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2024 16:52:52 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v1 0/7] ui/spice: Enable gl=on option for non-local or remote
 clients
Date: Fri, 19 Jan 2024 16:30:06 -0800
Message-Id: <20240120003013.1829757-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.39.2
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

To address the limitation that this option is incompatible with
remote clients, this patch series adds an option to select a
preferred codec and also enable gl=on option for clients that
are connected via the network. In other words, with this option
enabled (and the below linked Spice series merged), it would be
possible to have Qemu share a dmabuf fd with Spice, which would
then forward it to a hardware or software based encoder and
eventually send the data associated with the fd to a client that
could be located on a different machine.

Tested with: -device virtio-vga,max_outputs=1,xres=1920,yres=1080
             -spice port=3001,gl=on,disable-ticketing=on,preferred-codec=gstreamer:h264

and remote-viewer --spice-debug spice://x.x.x.x:3001 on the client side.

---
Associated Spice server patches can be found here:
https://lists.freedesktop.org/archives/spice-devel/2023-December/053288.html

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>

Vivek Kasireddy (7):
  ui/spice: Add an option for users to provide a preferred codec
  ui/spice: Enable gl=on option for non-local or remote clients
  ui/spice: Submit the gl_draw requests at 60 FPS for remote clients
  ui/console-gl: Add an option to override a surface's glformat
  ui/spice: Override the surface's glformat when gl=on is enabled
  ui/console-gl: Add a helper to create a texture with linear memory
    layout
  ui/spice: Create another texture with linear layout when gl=on is
    enabled

 include/ui/console.h       |  2 +
 include/ui/spice-display.h |  1 +
 include/ui/surface.h       |  1 +
 qemu-options.hx            |  5 +++
 ui/console-gl.c            | 32 ++++++++++++++++
 ui/spice-core.c            | 16 ++++++++
 ui/spice-display.c         | 75 +++++++++++++++++++++++++++++++++-----
 7 files changed, 122 insertions(+), 10 deletions(-)

-- 
2.39.2


