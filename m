Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F37CC3F0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:07:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjg5-0005mj-7U; Tue, 17 Oct 2023 09:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsjg0-0005k5-05
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:00:00 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsjfx-0003Vo-9j
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:59:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id ED2E860EEA;
 Tue, 17 Oct 2023 15:59:52 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8006::1:24])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gxjRqEIOdGk0-TkHH3HS3; Tue, 17 Oct 2023 15:59:52 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697547592;
 bh=BgSVWyAjqtuj7+692l32cxHuYz7I2Hl+gOoeKBfKJ/k=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=BwzWGJl4aVKBSJU4uPwn+7MmSwnC992Tss3zj+QGA3p6egzc9ZzdapBl60kH/i3dQ
 f6Ksq9SD9xOxvuY3cl+jMZ0xSAzdglkMUZgMPvWlilNK4zxd3tWUG4NDl4q86DDmUU
 36ZhTJEduBBDMpDcGOOOc97Q+s8u8iEaNVgxVtHU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, davydov-max@yandex-team.ru
Subject: [PATCH v3 0/6] coverity fixes
Date: Tue, 17 Oct 2023 15:59:35 +0300
Message-Id: <20231017125941.810461-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
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

v3: rebase on master (two patches dropped, as already merged)
    add r-b marks

v2:
01: add explanations, new assert and avoid extra assignment
    add CIDs [thx to Paolo]
02: add explanation, improve wording
04,07: s/{0}/{}
06,08: improve wording

Hi! Here are some improvements to handle issues found by Coverity (not
public Coverity site, so there are no CIDs).


Vladimir Sementsov-Ogievskiy (6):
  hw/i386/intel_iommu: vtd_slpte_nonzero_rsvd(): assert no overflow
  util/filemonitor-inotify: qemu_file_monitor_watch(): assert no
    overflow
  mc146818rtc: rtc_set_time(): initialize tm to zeroes
  block/nvme: nvme_process_completion() fix bound for cid
  hw/core/loader: gunzip(): initialize z_stream
  io/channel-socket: qio_channel_socket_flush(): improve msg validation

 block/nvme.c               |  7 ++++---
 hw/core/loader.c           |  2 +-
 hw/i386/intel_iommu.c      | 23 ++++++++++++++++++++---
 hw/rtc/mc146818rtc.c       |  2 +-
 io/channel-socket.c        |  5 +++++
 util/filemonitor-inotify.c | 25 +++++++++++++++++--------
 6 files changed, 48 insertions(+), 16 deletions(-)

-- 
2.34.1


