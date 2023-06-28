Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C72C740CB5
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:26:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERQN-0006xs-DJ; Wed, 28 Jun 2023 05:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQK-0006x3-QP; Wed, 28 Jun 2023 05:25:16 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQJ-0001MN-3O; Wed, 28 Jun 2023 05:25:16 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 4F90C5C0259;
 Wed, 28 Jun 2023 05:25:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 28 Jun 2023 05:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1687944314; x=
 1688030714; bh=lwkKKVXuR68xGTsUo5sThyDvbS0I2vTE0f77BW9RSM0=; b=d
 +XHhSB2gEaVjnm2W17t5/V9uun+A7Oocxg9wIpc854eDqBqaGXJZG5LtUFbjdLui
 zPWrjF3myfPjQ2vNgvlcDh8xxZvn7u+LQzcqU/JFv7npkcOh+oxk+nGiYedMqtwh
 BnmU7oHypViExvxw2mxXbJaPMvhkLL+8CULCvY7YMdweGrqywmp9clIOFQzuuXmr
 k2ixe4TjedieBAHZvsjk0G2Bm2rqWzZqMt5FVS/I26zT0v6p1/T3r8KVKODb1BBv
 r1bcPUdF9AOFoC1+98gmWjebj9ce7TzFTcVLnRLhWFwJPiq3JYTeHiyIM4pvPKNL
 pNzo7Tpn/3tLvpMCfUw7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687944314; x=
 1688030714; bh=lwkKKVXuR68xGTsUo5sThyDvbS0I2vTE0f77BW9RSM0=; b=R
 i/a3k9LVN9BCg1jj2mqD4Egm8nUyVWfKrvV4ukJBPsbIomiumgOATsLSocSpkzh3
 fX06Z5hxhVeKZ1iQO4F3vwmpD5FehsThZS/6vR7T/kQRvphzaT3a9q++y29cZcHw
 iZz26g/eFABIDBcTBDSPhGwzKdaO8/DeeKFv5DL2+km95MNoKYb4ADgYGkwhuYUD
 EjRgG0x+1nKxYw+UdARPYzcwUeZ1M8SbTHnzhhk5iMZH7ibX3176DNPbspvwvxue
 tQkn8NWeIeT/T/dx4nBzsFOQ27NB2K2PlGecwY4r2VcCi3yk0UWAMfg95YZWSlPB
 zpubP/A+OYpqlSXhYHQEA==
X-ME-Sender: <xms:evybZNDSBCEYvegbgPgsxtXYWAf9HcI5cdfxCmZsbXBuDYpOegMXvw>
 <xme:evybZLi-KmT5e5Du6GnYQkL83bw2TsUaK1P9h5I-cohbAEuQ7p6Thwrj8gqRKKrHS
 Q14EY059Jt9XlHZ50g>
X-ME-Received: <xmr:evybZIncjGYoYoF9xqrqVa-0UWz3qpLwincTVp0F4TSeHZN2TG9ko0y5mp-pq08M2TlE11MXKZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgddufecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfeilefgieevheekueevheehkeefveegiefgheefgfejjeehffefgedujedu
 geenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:evybZHxoTJnPiXwjxdeNywmY_zZLiwxC3w6lgOfmi0yW0V68pwHDXw>
 <xmx:evybZCSp-wGpiH3-_LcyUc1t7bnM9o8I2MBXBKd7r7owsPcM7kgz5A>
 <xmx:evybZKb4M5hy6tKJHPMUMgUb_TcdEeKeM0z334gVH2hbGdZqMc2s-w>
 <xmx:evybZHLM7iwhYt3fumYAFobP23fvCyL-DMr3SOTedjw3GabSRjv1ag>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jun 2023 05:25:12 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <j.devantier@samsung.com>
Subject: [PULL 6/7] hw/nvme: add placement handle list ranges
Date: Wed, 28 Jun 2023 11:25:00 +0200
Message-ID: <20230628092453.39602-15-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628092453.39602-9-its@irrelevant.dk>
References: <20230628092453.39602-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2398; i=k.jensen@samsung.com;
 h=from:subject; bh=AqujWSP59cGf2AINrUNyW8IaIl4bQuWfEv4pffOVtpY=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGSb/GaJM5TrJ+3KmUIWb6bCr48DMUnd3Bt3R
 8L/WtDS9S4g+4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkm/xmAAoJEE3hrzFt
 Tw3pTREH/0dUnxVPhZPXrb8qMlOmJIWtFRvXpryMXRtzaPtuc+el41sfNBrUQOjoBiZXsEPYgkk
 7JUbDmpLaUpTvWbQjn+nW2D3AL90HkYVSOswI44bSNVg8VDXhUnvJiSI6TPWFgBkkNWEanjLAFn
 Xs7d/hBK9uqP7xufH5h95fWY+Jx1cMeU7XtJSUb4oS0CP09gg/Lmz7LFtNKgeEZsNe3m+/hp6Hq
 bgkbkSi+55vYh8x5InuQsHHurFU7bvlKA/XqwC36j9pyH6fiwHQ+/OoB4dU2GafLrhNh1gIdmm8
 aCcyuAj7TY6RMr1lETsVpHPTjI2YzRtsXK9tz77Rh137j18IG9GlIqyL
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.29; envelope-from=its@irrelevant.dk;
 helo=out5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Klaus Jensen <k.jensen@samsung.com>

Allow the placement handles to be specified as ranges, i.e.
`fdp.ruhs=1:3-5` will attempt to assign ruh 1, 3, 4 and 5 to the
namespace.

Reviewed-by: Jesper Wendel Devantier <j.devantier@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index c4ea2033bb1c..44aba8f4d9cf 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -400,8 +400,9 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
     NvmeRuHandle *ruh;
     uint8_t lbafi = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     g_autofree unsigned int *ruhids = NULL;
-    unsigned int *ruhid;
-    char *r, *p, *token;
+    unsigned int n, m, *ruhid;
+    const char *endptr, *token;
+    char *r, *p;
     uint16_t *ph;
 
     if (!ns->params.fdp.ruhs) {
@@ -438,17 +439,40 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
 
     /* parse the placement handle identifiers */
     while ((token = qemu_strsep(&p, ";")) != NULL) {
-        if (ns->fdp.nphs++ == endgrp->fdp.nruh) {
-            error_setg(errp, "too many placement handles");
-            free(r);
-            return false;
-        }
-
-        if (qemu_strtoui(token, NULL, 0, ruhid++) < 0) {
+        if (qemu_strtoui(token, &endptr, 0, &n) < 0) {
             error_setg(errp, "cannot parse reclaim unit handle identifier");
             free(r);
             return false;
         }
+
+        m = n;
+
+        /* parse range */
+        if (*endptr == '-') {
+            token = endptr + 1;
+
+            if (qemu_strtoui(token, NULL, 0, &m) < 0) {
+                error_setg(errp, "cannot parse reclaim unit handle identifier");
+                free(r);
+                return false;
+            }
+
+            if (m < n) {
+                error_setg(errp, "invalid reclaim unit handle identifier range");
+                free(r);
+                return false;
+            }
+        }
+
+        for (; n <= m; n++) {
+            if (ns->fdp.nphs++ == endgrp->fdp.nruh) {
+                error_setg(errp, "too many placement handles");
+                free(r);
+                return false;
+            }
+
+            *ruhid++ = n;
+        }
     }
 
     free(r);
-- 
2.41.0


