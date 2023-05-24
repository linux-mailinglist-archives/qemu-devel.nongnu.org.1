Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ABF70F4F6
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 13:20:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1mWV-00014h-1X; Wed, 24 May 2023 07:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q1mWT-00013n-2y; Wed, 24 May 2023 07:19:17 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q1mWR-0005Ud-JC; Wed, 24 May 2023 07:19:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 36EE33200CB3;
 Wed, 24 May 2023 07:19:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 24 May 2023 07:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1684927152; x=
 1685013552; bh=MPxNR/d+Be05qsqUSN3DCTwFXaX/ZTGQ2ty+dh5pFmI=; b=K
 Ui2qBN/SjB9B+3auCdo88/yHXq8LPcyVQbDzpVUhkqlTjT8PJTapNVPPJvkBNRpr
 VFqV/2nyfjjwnFz0I0kQfnNDCXQn94vg359AP8mbu6xMX4ciGCXLZG/q08f74Zp3
 6JyeDZ1f7EfcbgzT5ckJ9RoNuOVVwzd5rj5jpp4a48Wk60HQoEW+0j8ASuX4Fbgr
 lRnaTF1vXl8/7IMmIBqPHc3dChC0FJwB0ntAj1a1bibRctXbxvoZ0TeIKjMtEKx5
 qq1OizHx2UXWyQKlmje6pAz9mBBsgbw/kp9aQ1diZEZ4f91BTy6DLV9HBBcO4EcG
 jx/vz7EunoIE8FycGl49A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684927152; x=
 1685013552; bh=MPxNR/d+Be05qsqUSN3DCTwFXaX/ZTGQ2ty+dh5pFmI=; b=c
 VovPdn93wJfO163k+u3tzMiXCgAsNvG1gCFM7LOeZxBtNk/RjCLpQIUE7DXtK5+a
 xMIEJWcKAM6u6s4ItBCHgn36t+DYNwQST/DWWZgQxG+j94+vb6Rydk76OadpsDnt
 CZeAeJMofZ0LYIHDaeekdcHEIkHEs2+ie4JHZlK6PZCGRf1ESK6Vv0A+f2ZnKbdM
 bhKTlfhd4O0VNlmrGn4dsjqF4ka5BTEU78Y717xLVnyOOGMMKjnKIsBS2LIWYhSV
 1zlX4X0YzDzJi+MZYpIv+auvhKVej3ifOCl1vSGsOC8G+cJcAnxaOyKLN00fX4wj
 5NIu5KfQF1H4Wt1ybYzpw==
X-ME-Sender: <xms:sPJtZOuO-SLr8OTe2rA0_g7bHBGXY1a2VrliyI5yDXxZKEq7751MtA>
 <xme:sPJtZDcYQ-1u9Nhnjtq2OutPRnFJkjHbQc51aRG6gSCFhc4x1wyFFmlhKssjzeP4N
 Ykjb1LSwcXlXYF_PaQ>
X-ME-Received: <xmr:sPJtZJwRZ0klr8AB4LpyfljmnYjC-mtgq8L73XeHk1KgBiIm99cbyMI31wLXbPVonyW5m2PMkmR8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgfeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:sPJtZJMTaKM_dt4aipXRIbriKzbR_V0dj94O8RO3NretEmNVYR6HTw>
 <xmx:sPJtZO8rrtbyWBVDVfV_w4xKLfqaykBVlp15CH2tuIXZzMNqe_QnpQ>
 <xmx:sPJtZBUL3CYvOgaQyX6UpPvQMXWCBDqe3p1OJzn6si60UQdqrBOg_Q>
 <xmx:sPJtZCaOK5194PR49VAi3AFeutPYg1AF8GC95wvx8ke9RS1PlmPg8w>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 May 2023 07:19:11 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <j.devantier@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 2/4] hw/nvme: verify uniqueness of reclaim unit handle
 identifiers
Date: Wed, 24 May 2023 13:19:02 +0200
Message-Id: <20230524111904.91179-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230524111904.91179-1-its@irrelevant.dk>
References: <20230524111904.91179-1-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=k.jensen@samsung.com;
 h=from:subject; bh=QWGUVmkW2V21EYR2tjvALqDu+O3R+BdYoLEGmbgoPL0=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGRt8qhhDGpoUoHt5+oqDFnzManrrwazyP9hi
 TL1WniFbsenC4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkbfKoAAoJEE3hrzFt
 Tw3pRMIIAKuuDLnS1KJb5GY6wvL0fshBVAH/V/cTa3PhtHR06b7YgHBuxFqoN7HulGxaY/qnh52
 xYLwNRvgQNHakUlcsXvbErkYSiFim9pHChLdNAcz26oE0TV0bPPj+MQsu5VTMt5HaN3WKMjpDeH
 fOAwHOFdrNb1A9hroto0JXrPT+UCd39/ieJpMFmvFlG40lINCROuaWN5UJp2ZKnQYUuVjn3CkV0
 axuskkik6rg/wd75iuWBTaspLOW/X+LN2zs5N2f0mGMbVDPomatedYi8gPfEgZciczxIXU3Ivie
 aY1ytqBcHflQdja4z9KY5wneW/eDwni3Dj2wMPtO8Ut5tUE/DGcuRK9h
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.25; envelope-from=its@irrelevant.dk;
 helo=wout2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Verify that a reclaim unit handle identifier is only specified once in
fdp.ruhs.

Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 050fdaf50fcd..c4ea2033bb1c 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -453,6 +453,17 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
 
     free(r);
 
+    /* verify that the ruhids are unique */
+    for (unsigned int i = 0; i < ns->fdp.nphs; i++) {
+        for (unsigned int j = i + 1; j < ns->fdp.nphs; j++) {
+            if (ruhids[i] == ruhids[j]) {
+                error_setg(errp, "duplicate reclaim unit handle identifier: %u",
+                           ruhids[i]);
+                return false;
+            }
+        }
+    }
+
     ph = ns->fdp.phs = g_new(uint16_t, ns->fdp.nphs);
 
     ruhid = ruhids;
-- 
2.40.0


