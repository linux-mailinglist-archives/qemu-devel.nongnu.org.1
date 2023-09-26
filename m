Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ECF7AF4E7
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:18:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlETZ-0000X8-FW; Tue, 26 Sep 2023 16:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETW-0000WZ-3s
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:16:06 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETR-0002ge-Rh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:16:05 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 741DD6074D;
 Tue, 26 Sep 2023 23:15:54 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZFWwvr0Oc0U0-LCkScbuD; Tue, 26 Sep 2023 23:15:53 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695759353;
 bh=1nMgYsNvM1OqDhdkfoVoZZFIstSCHbx1+aPEJnSsF98=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=B0b4MeZxYQTL+ZmevnYWgrfQ2NL/fR2wXGWwaXWeaob8IF2lVOm1A0jO/QMrsnt3m
 vMr0lrxR8zKwozRO2sk3znl6f2H/gZ1Z5PWporGEwvwCEnedxP7pAMQgOrFxvN34v1
 kg030fcLy42SkOrlDi8Z3fat6U21YoXtD/ebXkYk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru, peter.maydell@linaro.org,
 yc-core@yandex-team.ru, davydov-max@yandex-team.ru
Subject: [PATCH v2 0/8] coverity fixes
Date: Tue, 26 Sep 2023 23:15:24 +0300
Message-Id: <20230926201532.221152-1-vsementsov@yandex-team.ru>
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

v2:
01: add explanations, new assert and avoid extra assignment
    add CIDs [thx to Paolo]
02: add explanation, improve wording
04,07: s/{0}/{}
06,08: improve wording

Hi! Here are some improvements to handle issues found by Coverity (not
public Coverity site, so there are no CIDs).

Vladimir Sementsov-Ogievskiy (8):
  hw/i386/intel_iommu: vtd_slpte_nonzero_rsvd(): assert no overflow
  util/filemonitor-inotify: qemu_file_monitor_watch(): assert no
    overflow
  libvhost-user.c: add assertion to vu_message_read_default
  mc146818rtc: rtc_set_time(): initialize tm to zeroes
  pcie_sriov: unregister_vfs(): fix error path
  block/nvme: nvme_process_completion() fix bound for cid
  hw/core/loader: gunzip(): initialize z_stream
  io/channel-socket: qio_channel_socket_flush(): improve msg validation

 block/nvme.c                              |  7 ++++---
 hw/core/loader.c                          |  2 +-
 hw/i386/intel_iommu.c                     | 23 ++++++++++++++++++---
 hw/pci/pcie_sriov.c                       |  9 +++-----
 hw/rtc/mc146818rtc.c                      |  2 +-
 io/channel-socket.c                       |  5 +++++
 subprojects/libvhost-user/libvhost-user.c |  1 +
 util/filemonitor-inotify.c                | 25 +++++++++++++++--------
 8 files changed, 52 insertions(+), 22 deletions(-)

-- 
2.34.1


