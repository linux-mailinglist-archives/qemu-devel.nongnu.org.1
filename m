Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF97CCAA1
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:27:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsolo-0006GZ-3G; Tue, 17 Oct 2023 14:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+e442e50539a6073fd887+7359+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qsolT-0006EG-Ge
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:26:03 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+e442e50539a6073fd887+7359+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qsolQ-0001UC-H5
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=NhekjLfYAXI/NswduTKtqNt6rro27mlB+ofHaT2pumE=; b=B54+8xbjN1/D65brxO5gvxQ/+T
 BriBIf5aZLrtEU81d1kSwxCW/2Q3v3Lm07bwmbgF3SCQH8JSxQmJKe5uGO79WY9e17xke6XBjjdug
 5JeG2ysM8oz9d5Gh1rP3rYRl5P74ainBs3yT5G5gthMXGADJTxMAEXPvN+uAvHvF6R4zwYb/AS9Gf
 Cz3UH+oaZQFcSOb2gFv/lXdjJAR36Chk/aNPxjE6H3aijnuu9hYbb4ShIkb/Fkral4HJdgGYifV2n
 jMd/JJwseJX+XdSnaIEPMqA4DDn7AruHt8gpN98o1fSI3bEa9k+BVu+66Reaw/Kf5dh/gqJK5/1UB
 SW5sUDdg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qsolL-00DrCr-Or; Tue, 17 Oct 2023 18:25:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qsolI-000Pai-1v; Tue, 17 Oct 2023 19:25:48 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Jason Wang <jasowang@redhat.com>, xen-devel@lists.xenproject.org
Subject: [PATCH 0/4] Update QEMU qnic driver to "new" XenDevice model
Date: Tue, 17 Oct 2023 19:25:41 +0100
Message-Id: <20231017182545.97973-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+e442e50539a6073fd887+7359+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This has been on my TODO list for a while, and Paul's since 2019. Having 
converted the console driver just to get PV guests booting, I figured I 
should do this one while I still remember how.

The fact that net_cleanup() frees my NIC from underneath me confused
me for a while. Not entirely sure what's going on there. Other devices
seem to survive just because they aren't cleaned up at exit. But XenBus
devices really should be properly cleaned up on exit, because in some
cases they leave detritus in XenStore, which outlives QEMU. So "Don't
Do That Then" doesn't seem like it's the answer.

The default NIC handling is horrid (I mean, before I even looked at it)
but that isn't today's yak to shave...

David Woodhouse (4):
      hw/xen: only remove peers of PCI NICs on unplug
      hw/xen: update Xen PV NIC to XenDevice model
      [WTF] avoid qemu_del_nic() in xen_netdev_unrealize() on shutdown
      hw/i386/pc: support '-nic' for xen-net-device

 hw/i386/pc.c               |  11 ++-
 hw/i386/pc_piix.c          |   2 +-
 hw/i386/pc_q35.c           |   2 +-
 hw/i386/xen/xen_platform.c |   9 ++-
 hw/net/meson.build         |   2 +-
 hw/net/trace-events        |   9 +++
 hw/net/xen_nic.c           | 434 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
 hw/xen/xen-bus.c           |   4 +-
 hw/xenpv/xen_machine_pv.c  |   1 -
 include/hw/i386/pc.h       |   4 +-
 include/hw/xen/xen-bus.h   |   2 +-
 11 files changed, 373 insertions(+), 107 deletions(-)



