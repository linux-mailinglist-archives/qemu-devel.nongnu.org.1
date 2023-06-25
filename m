Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1655D73CDEB
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 04:00:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDF18-0001TC-Qf; Sat, 24 Jun 2023 21:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qDF15-0001Rp-SS
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 21:58:15 -0400
Received: from bg4.exmail.qq.com ([43.155.67.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qDF10-0002eF-Kh
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 21:58:15 -0400
X-QQ-mid: bizesmtp75t1687658023tui1i2a8
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 25 Jun 2023 09:53:42 +0800 (CST)
X-QQ-SSF: 01200000000000E0G000000A0000000
X-QQ-FEAT: rZJGTgY0+YPdh+ED+dvTzIwAdVomRfxZ1+pumcmavxeU9lWeWyJYCROsDofXX
 FXdib1EXBaKJfHztIj7Uq+D/Pk8arqBL8S0d7jygKX45QL9D3CtZIsALqcxVOvxRpyb9Ekd
 RGenFGAYiHTe0TA6qPaNZsbOAz1psUIex0MtAXbe5dCw8RhDZA0LIOz67l+Ar2qWLNKF8oO
 i4Rn4Qa05hj/JoQyEbW0PDiDS6IIfaS6V5L6e/9Swc3Aecg1dIDKZG/ITDcTGOxlGe3oUmj
 nwaW7/RupULldtpv5n9yKTVIWYKY0NS5BLQNhnxB8rdZ/mf94QnWgMUFA7vVWz9b5Qq40kL
 TvhNu3VbSr5BXaDdJ3xiargAdNETRcc8BGyYmmP
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17948234834168450469
From: Bin Meng <bmeng@tinylab.org>
To: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH v7 6/9] hw/net: rtl8139: Remove the logic of padding short
 frames in the receive path
Date: Sun, 25 Jun 2023 09:53:18 +0800
Message-Id: <20230625015321.77987-7-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625015321.77987-1-bmeng@tinylab.org>
References: <20230625015321.77987-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.155.67.158; envelope-from=bmeng@tinylab.org;
 helo=bg4.exmail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL=0.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Now that we have implemented unified short frames padding in the
QEMU networking codes, remove the same logic in the NIC codes.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

(no changes since v1)

 hw/net/rtl8139.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 5f1a4d359b..b4df75b2c9 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -826,7 +826,6 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
 
     uint32_t packet_header = 0;
 
-    uint8_t buf1[MIN_BUF_SIZE + VLAN_HLEN];
     static const uint8_t broadcast_macaddr[6] =
         { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
@@ -938,17 +937,6 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
         }
     }
 
-    /* if too small buffer, then expand it
-     * Include some tailroom in case a vlan tag is later removed. */
-    if (size < MIN_BUF_SIZE + VLAN_HLEN) {
-        memcpy(buf1, buf, size);
-        memset(buf1 + size, 0, MIN_BUF_SIZE + VLAN_HLEN - size);
-        buf = buf1;
-        if (size < MIN_BUF_SIZE) {
-            size = MIN_BUF_SIZE;
-        }
-    }
-
     if (rtl8139_cp_receiver_enabled(s))
     {
         if (!rtl8139_cp_rx_valid(s)) {
-- 
2.34.1


