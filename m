Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47328737890
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 03:05:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBmGD-0007n3-9l; Tue, 20 Jun 2023 21:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGA-0007mK-PG
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:46 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmG8-0001Fp-L7
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687309424; x=1718845424;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=//c0lBpZZwemGiayLaWux3MVAxcw1l5Lxpf8+u6eebU=;
 b=QIVTLyjc7jHev+upn9iBeA4cYl1+k0FA1TVI5xQM1egtu482URH3Euu7
 qo5yFlg9aLF2CK+azUyXCg9mksejlhdOQVxgn5cQjDEadQoDwpo+qeS96
 rxo6PtQRu9zwSu2q0RRjAVgkGVZDM22oF2jfCRZm5nI+ynySIlu7/yOKJ
 7bL43QvzJWgr1oEXyt2YXOk7aiImjXYeaXPjQDohy8vA2ofUilddyNAh4
 MOrPT6/BnQIvygy2ccxsV1UWPuVB2DhLO67VeRXVKs4Pxqtd0OMqVH9gP
 32LzEiqFEkq8c7hGjJ3oI7buODLZWiR9pqhT/Kd2cYLSUxXg8xcdjnORu A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357522799"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="357522799"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 18:03:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838429546"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="838429546"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 18:03:37 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, armbru@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, vivek.kasireddy@intel.com,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [RFC PATCH 0/9] ui: guest displays multiple connectors suppport and
 hotplug in
Date: Tue, 20 Jun 2023 17:43:46 -0700
Message-Id: <20230621004355.19920-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
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

(This series replace two patch series,
[PATCH v2 0/6] ui/gtk: Add a new parameter to assign connectors/monitors (v2)
https://lists.gnu.org/archive/html/qemu-devel/2022-11/msg03098.html and
[RFC PATCH 0/3] ui/gtk: no render event when vc is invisible
https://lists.gnu.org/archive/html/qemu-devel/2022-10/msg04926.html) 

There is a need (expressed by several customers/users) to assign
ownership of one or more physical monitors/connectors to individual
Guests such that there is a clear notion of which Guest's contents
are being displayed on any given monitor. Given that there is always
a Display Server/Compositor running on the Host, monitor ownership
can never truly be transferred to Guests. However, the closest we
can come to realizing this concept is to request the Host compositor
to fullscreen the Guest's windows on individual monitors. This way,
it would become possible to have 4 different Guests' windows be
displayed on 4 different monitors or a single Guest's windows (or
virtual consoles/outputs) be displayed on 4 monitors or any such
combination.

This patch series attempts to accomplish this by introducing a new
parameter named "connector" to assign the monitors to the GFX VCs
associated with a Guest. If the assigned monitor is not connected,
then the Guest's window would not be displayed anywhere similar to
how a Host compositor would behave when the connectors are not
connected. Once the monitor is hotplugged, the Guest's window(s)
would be positioned on the assigned monitor.

The first 4 patches (0000~0004) are for some prep work that adds a flag
called 'visible' for VC that indicates the visibility of the associated
GTK window and making drawing operation skipped for invisible VCs.

0005 and 0006 are actual implementation of monitors/connectors mapping
to the guests. 0007 through 0009 are additional code changes for preventing
deadlock situation due to asynchronous display hot plug in event when guest
scanout is shared as blobs (zero copy display sharing)

Example Usage: -device virtio-gpu-pci,max_outputs=2,blob=true......
               -display gtk,gl=on,connector.0=eDP-1,connector.1=DP-1.....

Dongwon Kim (6):
  ui/gtk: skip drawing guest scanout when associated VC is invisible
  ui/gtk: set the ui size to 0 when invisible
  ui/gtk: reset visible flag when window is minimized
  ui/gtk: unblock gl if draw submitted already or fence is not yet
    signaled
  ui/gtk: skip drawing if any of ctx/surface/image don't exist
  ui/gtk: skip refresh/rendering if VC is invisible

Vivek Kasireddy (3):
  ui/gtk: Disable the scanout when a detached tab is closed
  ui/gtk: Factor out tab window creation into a separate function
  ui/gtk: Add a new parameter to assign connectors/monitors to GFX VCs

 include/ui/gtk.h |   2 +
 qapi/ui.json     |  11 +-
 qemu-options.hx  |   5 +-
 ui/gtk-egl.c     |  20 +++
 ui/gtk-gl-area.c |  14 ++
 ui/gtk.c         | 362 +++++++++++++++++++++++++++++++++++++++++++----
 6 files changed, 384 insertions(+), 30 deletions(-)

-- 
2.34.1


