Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F0B1FE31
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Aug 2025 05:37:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulJJI-000501-3n; Sun, 10 Aug 2025 23:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ulJJ3-0004xO-5U
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 23:34:42 -0400
Received: from iguana.tulip.relay.mailchannels.net ([23.83.218.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ulJIw-00049i-Ex
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 23:34:40 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 0EBBC2C58B5;
 Mon, 11 Aug 2025 03:34:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a236.dreamhost.com
 (100-96-42-182.trex-nlb.outbound.svc.cluster.local [100.96.42.182])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 9E8042C5C57;
 Mon, 11 Aug 2025 03:34:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754883266; a=rsa-sha256;
 cv=none;
 b=0lL7Vboa99amW95g81C6FP2Ai04Sl4CDd4bF7mGtVY92Gy4vK/j/t0hvL0rRlyYUp57UCI
 9boYTiE/STN/a69HYFWd2h77QMUbiIOReqloaqsaw3XYz5Rr/M/kbnhRGJ5wXx2/Tcvu4V
 JvZFHeK0JSMDUPod8IdnM277a58/FRe2aTcGaLcp4Sy2I6iCjNCnZBChzUIchdrZwikTNN
 Z0X0T7mUuQNg+6Em3GWfce02Gp6BGpEglcmWjmPeF13amL6grd/lPkoO/W6QbwU0K3nc1H
 vUQYkycOESQklyvtFSoAqwuC1fpd0deSDPDDCaqEqotNqmadDo+kev81DEhmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1754883266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=0XWSHvmyXiq4ud4xYsKRJPgbRJy5sP9HaxHzqSo7Tso=;
 b=1ofwbbyu1Q2p/nZ3XHub3WN95edmUmo+jTjNGxw3Gl78kt21+ir++BFKsxwRviCNocKKPI
 eVF6pL9hFQx53Z1e/2VpzDWcta6zNXG/k6uZPGmmM80+Ly/HbtWBVw+skmwop7qMPrd0yP
 vgoQqDY8AN6Y/nO1/EAGOgpBnbj141wW2OA+buTplh/6p6auIF1h1RkWERT2yvA6C82X5j
 fx5FqcW9pDdlsqWq9K6mJ8/+8o9gUHTpqfgmcaGSzzSPArrJRCJZrBLWhjCzHDFvqm7IyQ
 awfoyV6MVSuV2qyUwQuPO/gQVF9R1hAbqxVUWaNkZzmmbEIndknW4D89pZA6PA==
ARC-Authentication-Results: i=1; rspamd-64567b6586-knbzh;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Army-Society: 309e33e878c7f21b_1754883266901_1252089449
X-MC-Loop-Signature: 1754883266901:355089586
X-MC-Ingress-Time: 1754883266901
Received: from pdx1-sub0-mail-a236.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.42.182 (trex/7.1.3); Mon, 11 Aug 2025 03:34:26 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com
 [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a236.dreamhost.com (Postfix) with ESMTPSA id 4c0gH60fn8z6f; 
 Sun, 10 Aug 2025 20:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1754883266;
 bh=0XWSHvmyXiq4ud4xYsKRJPgbRJy5sP9HaxHzqSo7Tso=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=Nz53jo4cqCsnVpYGkqflP7yiONm5gD1U0weIW/NAgqfLdTX/6DTRb+5uzlPwXEpxp
 PdHGj9CDWnLBXwmFEsJQ7BcrDU7QN2HM93g6Rlak5yyoIo11eGVzMWzVtE/Z0v+kUf
 Xt6Ofvr+/sO27wphzdg82EWG5MKxE5z7AhRcUadnujnd2LC4PnVwU5C+bLcpa+J+4j
 cmxlJViEDMz5Di/iNCBgjnG/GDLs4pDSSHfkIXAFTtNVDdj4p/VhTgvMtib1ouWHOW
 r1pqutERAvZJxTyY4bnUezgv3ZQ9iZ3Mcv6gUwxI0U9dYx0AzU7j4nQKnwJFEdeOlW
 1PHphUud8vBlg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v2 -qemu 0/4] hw/cxl: Support Back-Invalidate
Date: Sun, 10 Aug 2025 20:34:01 -0700
Message-Id: <20250811033405.332295-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.218.253; envelope-from=dave@stgolabs.net;
 helo=iguana.tulip.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following allows support for component basic back invalidation discovery
and config, by exposing the BI routing table and decoder registers. Instead
of going the type2[0] route, this series proposes adding support for type3
hdm-db, which allows a more direct way of supporting BI in qemu.

Changes from v1 (https://lore.kernel.org/qemu-devel/20250806055708.196851-1-dave@stgolabs.net/):
  o Further lnk training in patch 1. (Jonathan)
  o Flit parameter changed to bool in patch 1. (Jonathan)
  o Do not set 68B in component Flexbus Port when in flitmode in patch 1.
  o Doc build fixlet in patch 3.
  o Pass the exact type3 type in cxl_component_create_dvsec() - unused, but better
    for keeping track, in patch 4.
  o Change doc example to volatile device in patch 4.

Changes from rfc (https://lore.kernel.org/qemu-devel/20250729165441.1898150-1-dave@stgolabs.net/):
  o Added 256b-flit parameter, per Jonathan.
  o Added window restrictions changes.
  o Dropped rfc tag.

Patch 1 introduces the flit mode parameter.
Patch 2 is lifted from Ira's series with some small (but non-trivial) changes.
Patch 3 updates the cfmw restrictions option.
Patch 4 adds BI decoder/rt register support to enable type3 HDM-DB.

Testing wise, this has passed relevant kernel side BI register IO flows for
BI-ID setup and deallocation.

The next step for this would be to add UIO support to qemu.

Applies against branch 'origin/cxl-2025-07-03' from Jonathan's repository.

Thanks!

Davidlohr Bueso (3):
  hw/pcie: Support enabling flit mode
  hw/cxl: Allow BI by default in Window restrictions
  hw/cxl: Support type3 HDM-DB

Ira Weiny (1):
  hw/cxl: Refactor component register initialization

 docs/system/devices/cxl.rst               |  23 +++
 hw/cxl/cxl-component-utils.c              | 206 ++++++++++++++++------
 hw/cxl/cxl-host.c                         |   2 +-
 hw/mem/cxl_type3.c                        |  23 ++-
 hw/pci-bridge/cxl_downstream.c            |  11 +-
 hw/pci-bridge/cxl_root_port.c             |  11 +-
 hw/pci-bridge/cxl_upstream.c              |  19 +-
 hw/pci-bridge/gen_pcie_root_port.c        |   1 +
 hw/pci/pcie.c                             |  23 ++-
 include/hw/cxl/cxl_component.h            |  87 +++++++--
 include/hw/cxl/cxl_device.h               |   4 +
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 include/hw/pci/pcie.h                     |   2 +-
 include/hw/pci/pcie_port.h                |   1 +
 qapi/machine.json                         |   3 +-
 qemu-options.hx                           |   4 +-
 16 files changed, 322 insertions(+), 99 deletions(-)

-- 
2.39.5


