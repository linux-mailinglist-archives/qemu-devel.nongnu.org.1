Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A06776167
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 15:41:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTjPI-0002lT-26; Wed, 09 Aug 2023 09:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTjPF-0002je-Ai; Wed, 09 Aug 2023 09:39:21 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTjPD-0002hn-0h; Wed, 09 Aug 2023 09:39:21 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id A35195C0160;
 Wed,  9 Aug 2023 09:39:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Wed, 09 Aug 2023 09:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691588357; x=
 1691674757; bh=t5lxifavT4W3Y7H2EtCg2nTkexwbBa5nYqgEzRzCmHw=; b=W
 dOgD/JJwo6fu4NRWejFY0m5TzQ4J2MjA5T8IXWoxYRdUKgyLKDAQ+21qiQVL8Fv9
 FWSbAtTQ8OlB44VIK/rZXkmAwoV+Jqreayb6r1iVAqczKTcRp+T51hzWA5TB09lk
 PBiioR5qcZdrkESkuu/e/NZBZFywMaF4wX93MpZUFjTvdbDhf+v8FlEihtbKz3eP
 4ZXAnt8kJSB1/dVHeA/5aLWgeU6rrRkHWcH4NXD01B07VdIQqZB8JIKyAgA1nV5c
 VkwA+B7EmeN7iffYUKddgDcEu/objJteDxAH3r5Dr5SwlvRgosuoPINvwAW8OJFp
 mgk/2Q8sQSVVczT9KroWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1691588357; x=
 1691674757; bh=t5lxifavT4W3Y7H2EtCg2nTkexwbBa5nYqgEzRzCmHw=; b=d
 N7nmS43R/Qbx+n7+Vt6Bxjr+JCKyYc3dq9k8ZJZpEKP1oPaTIkEietS7T6eAGxQq
 wLl7hAt3Se1/DBI30ywKvFldG4JBlDdHx699m0OmyYbG3VXME+wsEKLnQePwnM2V
 L4ByQxT1lbN65ogsAMk19mX0RVopg8DjcymMx9IWQVgFWFPFvuKwaUja6tfNTET2
 ZEhLMc8uFmHUvcshSUN8E2P9265nbhFYJcbpEwvtiGhkhlBg8dOXckykwrkQs6I8
 bk8xpiN/PFAcTuWvhH6ubIEKP3FnzWcEu0QLy+f+slHxy/mdzhjQ8Q+I1tJ3BnlP
 BOrrVtoYLdP0PTgZVCtaw==
X-ME-Sender: <xms:BZfTZAC331aMdaB7jKpBRDqVJr3qBgk4_OGZ4husuUjkmhbzozhMBA>
 <xme:BZfTZCgHoffxz8ng3njm2vQ2PiIQwJtZHso0N2LOG9tiPApuz_gnbaTDICc5p27r0
 TsqbQ-hwWvpOYg1r9M>
X-ME-Received: <xmr:BZfTZDlUPlzTIzQVTXxHDXFBDrES-QjWBVvW1VvR8SQWX9Q-0b3D7Z8veND4p3-Sg1BCmHYKwvc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeggdeiiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfeilefgieevheekueevheehkeefveegiefgheefgfejjeehffefgedujedu
 geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:BZfTZGx-pJ12m4WUXZPZzKaW7NLSc7exDAviYvUl_fuWDKmk_RzxmQ>
 <xmx:BZfTZFSgclhYjGnJIpXSMdCs0H-45nbJzTl9sHM71hwSNR7-AXtfZw>
 <xmx:BZfTZBZYMMvP60qr_tzfirkuF11fW57-8VHbRUu18D79Uvhj9GzSkQ>
 <xmx:BZfTZEHcqGVeFJPXJR4fI0AXOCRw8AUt60fo8_Yr1uQ_d2rNUSJMVQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Aug 2023 09:39:16 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org, Jesper Wendel Devantier <j.devantier@samsung.com>
Subject: [PULL 2/2] hw/nvme: fix null pointer access in ruh update
Date: Wed,  9 Aug 2023 15:39:12 +0200
Message-ID: <20230809133909.45818-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809133909.45818-4-its@irrelevant.dk>
References: <20230809133909.45818-4-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=k.jensen@samsung.com;
 h=from:subject; bh=0dn3iSE2dXbkED8tHmgi5PAt78m2jCsPM0x9+q4HGJk=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTTlv4VZVewRYMf8XVHHIENJ3lH1CxEGCp2r
 Jv6ZNlAOYA3k4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk05b+AAoJEE3hrzFt
 Tw3pyKEH/3/1o2vfVooxQqmVrCCAtdWJxWgfU1PoOGxZvPyWtkSteUmNHjdFER5q4IgRd7WA0R9
 QOdUJuBf6Je0XcS6hOb7nu3Rf7pchjXGRkd2Sm0TFfKIgPL/Z+DNn/3ISqGSoZ5QVx5JJa9iSM+
 4bwQ1Nome2qsd9UmEsD6q6rVjqrIHgT2lZL3QQbUy3+1vCVdCum/BmI6mEOBqbb0XJQ1q+VQcOQ
 3Wgvw9JJnqO5+u4V7ZTpOzoR4thp3heDnk9oaSENxABAD6CMJU697p+Fmq5FRjOPsrakeWXy/dS
 Qz8JQ9dMyxkL/QQHWIgMe0ibef8ncLGUWP59tJDOK7wMw3RkVgBpbqTC
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
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Reclaim Unit Update operation in I/O Management Receive does not
verify the presence of a configured endurance group prior to accessing
it.

Fix this.

Cc: qemu-stable@nongnu.org
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Reviewed-by: Jesper Wendel Devantier <j.devantier@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e5b5c7034d2b..539d27355313 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4361,7 +4361,13 @@ static uint16_t nvme_io_mgmt_send_ruh_update(NvmeCtrl *n, NvmeRequest *req)
     uint32_t npid = (cdw10 >> 1) + 1;
     unsigned int i = 0;
     g_autofree uint16_t *pids = NULL;
-    uint32_t maxnpid = n->subsys->endgrp.fdp.nrg * n->subsys->endgrp.fdp.nruh;
+    uint32_t maxnpid;
+
+    if (!ns->endgrp || !ns->endgrp->fdp.enabled) {
+        return NVME_FDP_DISABLED | NVME_DNR;
+    }
+
+    maxnpid = n->subsys->endgrp.fdp.nrg * n->subsys->endgrp.fdp.nruh;
 
     if (unlikely(npid >= MIN(NVME_FDP_MAXPIDS, maxnpid))) {
         return NVME_INVALID_FIELD | NVME_DNR;
-- 
2.41.0


