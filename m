Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC2B1C02D
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Aug 2025 07:59:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujX9u-0003RU-DH; Wed, 06 Aug 2025 01:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ujX9V-0003H8-VH
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 01:57:33 -0400
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ujX9T-00036c-2r
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 01:57:29 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 0FCD42C52E0;
 Wed,  6 Aug 2025 05:57:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com
 (100-96-62-154.trex-nlb.outbound.svc.cluster.local [100.96.62.154])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 902C12C5729;
 Wed,  6 Aug 2025 05:57:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754459842; a=rsa-sha256;
 cv=none;
 b=1pKDjTTnEBiv+a/tuK8mrGV/s6IVShWrbkaZwADayBJN00fwGffMfFNuDbqI1UTjpV2ye4
 evx8i+9cuc7WjgJX+4+NdZie1gOMeYRCL34Lg3hap6ejZ1S68bEcc1dL9rneH+1bVZjitn
 OF3fFCVcHSMGycRWsXnPm1Zz2DNcj2mWn08KGZzTGhvYlIyq2CUUn8HQ9mUCpV60ORo4sF
 +p32jgG0ZMeEoWImAEmiKNfn41BFTxFRPKz4MIUm/FvInaLLXIXo5fDm9CMX4Waolv3Et/
 /oltm11bITTpclACUqJm5MC3PmtV4Z09gSeqXz/p3qN87r2NTI/QBSjlk8mukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1754459842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=tOTCu7C4nH+IyqgjZuWVDSAUB7nD7x08rBpJFAqxeBs=;
 b=uMrW6hMhPOgBR7sCuUPfV/GDDhlvyfT0cY++z4zr1Tnl9QI4nzvH04kbSRdQoT5qRQNm5E
 Ab+mzHzJw9DJBurRwoYrYxEc62T/084/pG30IfNpRGzRI+66BC7YbtHPTxF7pt1rDxF5Ba
 a21AL6wZmg0ya9cUZBq9+9xqD0qJHv3q85/TZ51R4E4qNLe9i0TFHs9AoRYIcR8ZTvSmZ1
 Jz95cn4f1hhUgFvCef0F9keAF0gd3nDJ2LQ/oIu3v9USHgl+xF4foLTEWudiS31R/Oiq+N
 AYPQh7n/1sUPkxqlUvCuaHlc66rZBHIRhZeEs1w4AXTpPQuKuNsFL/zrjyINAQ==
ARC-Authentication-Results: i=1; rspamd-648c9d5b94-xdgrc;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Zesty-Hysterical: 3f3a9c1d7b2b8c61_1754459842898_2538573281
X-MC-Loop-Signature: 1754459842898:284292450
X-MC-Ingress-Time: 1754459842898
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.62.154 (trex/7.1.3); Wed, 06 Aug 2025 05:57:22 +0000
Received: from localhost.localdomain (syn-076-167-199-067.res.spectrum.com
 [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4bxfhK6YkyzHr; 
 Tue,  5 Aug 2025 22:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1754459842;
 bh=tOTCu7C4nH+IyqgjZuWVDSAUB7nD7x08rBpJFAqxeBs=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=XdtgiJ2Qi73KzIEoilBBfh+g+C7jl+6kHFTDtQpqAEL523DPFyDknvM5FHqXBvQo7
 dE7IzfgkKvxWKnrjY4RcxlCPG41v4J0MDKT6oMhXDvU62DQIzXvKVldMUYZlY/GYMb
 7CQ6VlGoUHfWLRdulNMwZ6G62V/NUrCx2k0z6IRBNeEhIRI5HhZPuW5QSNdY24gRAe
 fb06kSS1iwKEFJFRtrEVvdS0rD6LJuHMwZF6XCRdenlqnpx5Dg/xQKqKsc/3u6oATs
 OcfwLeeYrAnvkcwGBzvvXAVcjvyNieTNQZdRa9HwqLnyjE/PguExIZdWC4zqw9tZvB
 H7Gkc+RKkNOgA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH -qemu 0/4] hw/cxl: Support Back-Invalidate
Date: Tue,  5 Aug 2025 22:57:04 -0700
Message-Id: <20250806055708.196851-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.222.61; envelope-from=dave@stgolabs.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello,

The following allows support for component basic back invalidation discovery
and config, by exposing the BI routing table and decoder registers. Instead
of going the type2[0] route, this series proposes adding support for type3
hdm-db, which allows a more direct way of supporting BI in qemu.

Changes from rfc (https://lore.kernel.org/qemu-devel/20250729165441.1898150-1-dave@stgolabs.net/)
  o Added 256b-flit parameter, per Jonathan.
  o Added window restrictions changes.
  o Dropped rfc tag.

Patch 1 introduces the flit mode parameter.
Patch 2 is lifted from Ira's series with some small (but non-trivial) changes.
Patch 3 updates the cfmw restrictions option.
Patch 4 adds BI decoder/rt register support.

Testing wise, this has passed relevant kernel side BI register IO flows for
BI-ID setup and deallocation.

The next step for this would be to add UIO support to qemu.

Applies against branch 'origin/cxl-2025-07-03' from Jonathan's repository.

Thanks!

[0] https://lore.kernel.org/linux-cxl/20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com/

Davidlohr Bueso (3):
  hw/pcie: Support enabling flit mode
  hw/cxl: Allow BI by default in Window restrictions
  hw/cxl: Support Type3 HDM-DB

Ira Weiny (1):
  hw/cxl: Refactor component register initialization

 docs/system/devices/cxl.rst               |  26 +++
 hw/core/qdev-properties-system.c          |  11 ++
 hw/cxl/cxl-component-utils.c              | 206 ++++++++++++++++------
 hw/cxl/cxl-host.c                         |   2 +-
 hw/mem/cxl_type3.c                        |  13 +-
 hw/pci-bridge/cxl_downstream.c            |   1 +
 hw/pci-bridge/cxl_root_port.c             |   1 +
 hw/pci-bridge/cxl_upstream.c              |   3 +-
 hw/pci-bridge/gen_pcie_root_port.c        |   1 +
 hw/pci/pcie.c                             |  13 +-
 include/hw/cxl/cxl_component.h            |  87 +++++++--
 include/hw/cxl/cxl_device.h               |   4 +
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 include/hw/pci/pcie.h                     |   2 +-
 include/hw/pci/pcie_port.h                |   1 +
 include/hw/qdev-properties-system.h       |   3 +
 qapi/common.json                          |  14 ++
 qapi/machine.json                         |   3 +-
 qemu-options.hx                           |   4 +-
 19 files changed, 317 insertions(+), 79 deletions(-)

--
2.39.5


