Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 866F7BCF719
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:26:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a77-00062M-6f; Sat, 11 Oct 2025 09:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a72-00061T-OW
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:58:20 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a6t-0004cL-69
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:58:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7846AC0195;
 Sat, 11 Oct 2025 16:57:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-7cVsqjmc; Sat, 11 Oct 2025 16:57:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191078;
 bh=GwUGObk/skOiLvkKNiWNa/3LsaS2Qb5Akmk/NJK1Uw0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=G/zNsj7+ZfX+WRwLAZwtTnglibCaJRUCNyKtFlMrL2sRN7xFzSceAS3RPL4olmO93
 IBhNjZJSfJBcMuUWgnqJGEtNs1nE71yMDHUiEcKxemTycTJqEtEjj7nCQ2ZIRRQU+k
 tKXPSfmr/vvwic5GDf1HQALa6vpRJTDHLdIusSVo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 02/33] qapi/acpi.json: reflow docs to width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 16:56:44 +0300
Message-ID: <20251011135754.294521-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/acpi.json | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/qapi/acpi.json b/qapi/acpi.json
index 906b3687a5..601271607b 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -116,10 +116,16 @@
 # .. qmp-example::
 #
 #     -> { "execute": "query-acpi-ospm-status" }
-#     <- { "return": [ { "device": "d1", "slot": "0", "slot-type": "DIMM", "source": 1, "status": 0},
-#                      { "slot": "1", "slot-type": "DIMM", "source": 0, "status": 0},
-#                      { "slot": "2", "slot-type": "DIMM", "source": 0, "status": 0},
-#                      { "slot": "3", "slot-type": "DIMM", "source": 0, "status": 0}
+#     <- { "return": [
+#          { "device": "d1", "slot": "0",
+#            "slot-type": "DIMM", "source": 1,
+#            "status": 0 },
+#          { "slot": "1", "slot-type": "DIMM", "source": 0,
+#            "status": 0 },
+#          { "slot": "2", "slot-type": "DIMM", "source": 0,
+#            "status": 0 },
+#          { "slot": "3", "slot-type": "DIMM", "source": 0,
+#            "status": 0 }
 #        ]}
 ##
 { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
@@ -137,8 +143,10 @@
 #
 #     <- { "event": "ACPI_DEVICE_OST",
 #          "data": { "info": { "device": "d1", "slot": "0",
-#                              "slot-type": "DIMM", "source": 1, "status": 0 } },
-#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#                              "slot-type": "DIMM", "source": 1,
+#                              "status": 0 } },
+#          "timestamp": { "seconds": 1265044230,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'ACPI_DEVICE_OST',
      'data': { 'info': 'ACPIOSTInfo' } }
-- 
2.48.1


