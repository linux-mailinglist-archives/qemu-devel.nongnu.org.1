Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCF87B2E8B
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9EN-0006MR-Qv; Fri, 29 Sep 2023 04:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qm9EK-0006Lc-IM
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:12 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qm9E3-0005nI-HL
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:11 -0400
Received: from pasha-ThinkPad-X280.intra.ispras.ru (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 5E67040737C9;
 Fri, 29 Sep 2023 08:51:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5E67040737C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1695977500;
 bh=Zv6oVg+baY+TuqmEVbOAczcfwHiDqLo4H9msZx2klEE=;
 h=From:To:Cc:Subject:Date:From;
 b=VoF8+y7SQEkAgcpJf9CQA/K8xofC3XmO+htENaUfT9XvUGCWJiJvKJMCSCRRLRCDi
 tZQnGj88x91LNDv8wAO7mU1cVwVPextDCdccToc/rBRnVfgQ/NmkP24N3h5KXuodxu
 vsgw5N++mrjVFIFqJh990GedhQZJT940VSj8QeEw=
From: pavel.dovgalyuk@ispras.ru
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, crosa@redhat.com, wainersm@redhat.com, bleal@redhat.com,
 alex.bennee@linaro.org, mst@redhat.com, rafael.pizarrosolar@epfl.ch,
 jasowang@redhat.com, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: [PATCH 0/3] Record/replay patches
Date: Fri, 29 Sep 2023 11:51:18 +0300
Message-Id: <20230929085121.848482-1-pavel.dovgalyuk@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

The set of patches include the following modifications:
 - fix for allowing record/replay with virtio-net
 - fix for loading non-replay snapshots

Pavel Dovgalyuk (3):
  replay: improve determinism of virtio-net
  virtio-net: added replay blocker for guest_announce
  replay: fix for loading non-replay snapshots

 hw/net/virtio-net.c      | 13 +++++++++----
 replay/replay-snapshot.c |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.34.1


