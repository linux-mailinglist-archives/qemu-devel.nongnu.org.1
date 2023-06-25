Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FC673CDE6
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 03:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDF1T-0001WC-UL; Sat, 24 Jun 2023 21:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>)
 id 1qDF1R-0001Vu-U2; Sat, 24 Jun 2023 21:58:37 -0400
Received: from bg4.exmail.qq.com ([43.155.67.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>)
 id 1qDF1Q-0002je-5j; Sat, 24 Jun 2023 21:58:37 -0400
X-QQ-mid: bizesmtp75t1687658032t9nasj0i
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 25 Jun 2023 09:53:51 +0800 (CST)
X-QQ-SSF: 00200000000000E0G000000A0000000
X-QQ-FEAT: t8fpqlBPu6qJ8hXdfEjkkXfPawsLS015n2oeohl4nPjBP9iT21tn36OcqKjft
 xyGhKgQDd8mnKF+fZR0SYXnv9nWRZTfXczseblTS7f0V9HeNBDouLTXLPka4w6wcUPQomCU
 pRR6V58VxxdC/fLZAjgzYBK3kDcckuM5DPpkqZyQyWJXk/yI+cJIcDpLuhxkv9G2m5xlrrH
 iDjPYuuhxxLSBXEWSZwE4O6IUCiHfxc6CxQKrNiXkmvo0fzL5Toqmdrp0O0OOyArL0RjQ4y
 9jMdDzOHHTqfGBNCgUkum/U5R4DjE3E2sP8OUw8344WZAaIePf3n+vW4+0+3eTBkvaFANI4
 DgUMWNbA2/wajA+b6AI63qy023BLagAMggENcR8
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5247651207143805087
From: Bin Meng <bmeng@tinylab.org>
To: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org
Subject: [PATCH v7 9/9] hw/net: ftgmac100: Drop the small packet check in the
 receive path
Date: Sun, 25 Jun 2023 09:53:21 +0800
Message-Id: <20230625015321.77987-10-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625015321.77987-1-bmeng@tinylab.org>
References: <20230625015321.77987-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
QEMU networking codes, the small packet check logic in the receive
path is no longer needed.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Bin Meng <bmeng@tinylab.org>

---

Changes in v7:
- new patch: "hw/net: ftgmac100: Drop the small packet check in the receive path"

 hw/net/ftgmac100.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index d3bf14be53..702b001be2 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -968,14 +968,6 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
         return -1;
     }
 
-    /* TODO : Pad to minimum Ethernet frame length */
-    /* handle small packets.  */
-    if (size < 10) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: dropped frame of %zd bytes\n",
-                      __func__, size);
-        return size;
-    }
-
     if (!ftgmac100_filter(s, buf, size)) {
         return size;
     }
-- 
2.34.1


