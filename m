Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4C27ADFB2
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:42:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrSH-0002eu-0n; Mon, 25 Sep 2023 15:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSF-0002eb-4Z
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:15 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSC-0004lD-Jx
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 7CB756372E;
 Mon, 25 Sep 2023 22:41:06 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6422::1:2a])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id geUBjG0OhCg0-sbg3qKAV; Mon, 25 Sep 2023 22:41:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695670866;
 bh=zxy14Bv7mL1z02pJku6T+D2jLSUiaEPPBHtXzl/C9Ns=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=WhzdkInuA758dTCvtw0mZicQpPi2hSZgdvoNqdAZjp0PCY1QCEV13kogK/FUOs0fD
 SrcI4cadBLGeOevh6YuIWXF6RLpCkXiMbWUJfGyxm/piM3a9uXSgQGzF8IEHuhlc3H
 D9PwwOvEe72nE5IQn2BHIgeoLUFmX4MxeThmkwkA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	vsementsov@yandex-team.ru
Subject: [PATCH 00/12] coverity fixes
Date: Mon, 25 Sep 2023 22:40:28 +0300
Message-Id: <20230925194040.68592-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi! Here are some improvements to handle issues found by Coverity (not
public Coverity site, so there are no CIDs).

Vladimir Sementsov-Ogievskiy (12):
  hw/core/loader: load_at(): check size
  hw/i386/intel_iommu: vtd_slpte_nonzero_rsvd(): reduce magic numbers
  util/filemonitor-inotify: qemu_file_monitor_watch(): avoid overflow
  libvhost-user.c: add assertion to vu_message_read_default
  device_tree: qmp_dumpdtb(): stronger assertion
  mc146818rtc: rtc_set_time(): initialize tm to zeroes
  pcie_sriov: unregister_vfs(): fix error path
  block/nvme: nvme_process_completion() fix bound for cid
  kvm-all: introduce limits for name_size and num_desc
  hw/core/loader: gunzip(): initialize z_stream
  hw/core/loader: read_targphys(): add upper bound
  io/channel-socket: qio_channel_socket_flush(): improve msg validation

 accel/kvm/kvm-all.c                       | 15 +++++++++++
 block/nvme.c                              |  6 ++---
 hw/core/loader.c                          | 32 +++++++++++++++++++----
 hw/i386/intel_iommu.c                     | 11 +++++---
 hw/pci/pcie_sriov.c                       |  9 +++----
 hw/rtc/mc146818rtc.c                      |  2 +-
 include/hw/loader.h                       |  2 --
 io/channel-socket.c                       |  5 ++++
 softmmu/device_tree.c                     |  2 +-
 subprojects/libvhost-user/libvhost-user.c |  1 +
 util/filemonitor-inotify.c                | 21 +++++++++------
 11 files changed, 77 insertions(+), 29 deletions(-)

-- 
2.34.1


