Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 719927B9C2C
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 11:31:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoKg9-0007y0-Cn; Thu, 05 Oct 2023 05:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoKg2-0007wb-IZ
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 05:29:50 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoKfz-0005PR-TS
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 05:29:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id D2A22635D8;
 Thu,  5 Oct 2023 12:29:40 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b584::1:2f])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RTUHmS4OouQ0-yVcPZxb2; Thu, 05 Oct 2023 12:29:40 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696498180;
 bh=qm2xz9ypOwzF+rogTCVOd8LojglwchTKDzxJGOZQxDM=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=qCfAWjt0rUmHvb/5J1F7x/AwMOv4swUeaNo2Dl1FKwh1j02K5RpJq1qXY3cK9G8il
 HKLPLdVFzJ7c7SDLhSOfXFRwqCuneWqLUx2hIj+pZWnoIIo17vCUC2TFRQ1IsiZRbE
 l0hnnO1+JPXAguKdd2boxKU7HRXIZ+hhDQhW7Oos=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, den-plotnikov@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v8 0/4] pci hotplug tracking
Date: Thu,  5 Oct 2023 12:29:22 +0300
Message-Id: <20231005092926.56231-1-vsementsov@yandex-team.ru>
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

Hi all!

Main thing this series does is DEVICE_ON event - a counter-part to
DEVICE_DELETED. A guest-driven event that device is powered-on.
Details are in patch 2. The new event is paried with corresponding
command query-hotplug.


v8:
 - improve naming, wording and style
 - make new QMP interface experimental


Vladimir Sementsov-Ogievskiy (4):
  qapi/qdev.json: unite DEVICE_* event data into single structure
  qapi: add DEVICE_ON and query-hotplug infrastructure
  shpc: implement DEVICE_ON event and query-hotplug
  pcie: implement DEVICE_ON event and query-hotplug

 hw/core/hotplug.c               |  12 +++
 hw/pci-bridge/pci_bridge_dev.c  |  14 +++
 hw/pci-bridge/pcie_pci_bridge.c |   1 +
 hw/pci/pcie.c                   |  83 +++++++++++++++
 hw/pci/pcie_port.c              |   1 +
 hw/pci/shpc.c                   |  86 +++++++++++++++
 include/hw/hotplug.h            |  11 ++
 include/hw/pci/pci_bridge.h     |   2 +
 include/hw/pci/pcie.h           |   2 +
 include/hw/pci/shpc.h           |   2 +
 include/hw/qdev-core.h          |   7 ++
 include/monitor/qdev.h          |   6 ++
 qapi/qdev.json                  | 178 +++++++++++++++++++++++++++++---
 softmmu/qdev-monitor.c          |  58 +++++++++++
 14 files changed, 451 insertions(+), 12 deletions(-)

-- 
2.34.1


