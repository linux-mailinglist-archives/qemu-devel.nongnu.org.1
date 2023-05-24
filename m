Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E339470F4F5
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 13:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1mWT-00013l-F9; Wed, 24 May 2023 07:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q1mWR-000133-8p; Wed, 24 May 2023 07:19:15 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q1mWO-0005U0-UL; Wed, 24 May 2023 07:19:14 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 02C33320094B;
 Wed, 24 May 2023 07:19:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 24 May 2023 07:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1684927150; x=
 1685013550; bh=3bvbGpFH5nB/9p9vzminXpFAEYUzSqm0I9KkDrSD2rw=; b=c
 Wpees63T8upCEsBMnI9TiqyZShqAgJ/LicN7y3vHjNUQV2a+f5xXt7hFgGrjjCUM
 +VDsjfEOEPVYJyuV/0x85mJMkZIQOzKIg4bX6dYpNnWhAableCZuWvoia/nZK/Hg
 tnK7EgQWnVLwf55OW7NpfIAEz7cD8CMh4nJs9GdZjDXkmf7cz8ztRKjqD2gaVNVS
 UzOGIh0sOfx0Jnoc2tUnSJK4VWCK+b8ckFoqbwHmMK0cDwE4TkWnbF9DcgZ+1ecv
 lPAQY1Znu6JZcJ6uVq02rg/ospiKEPSv+2FG6bGRAYlQEHgX0dudT1Vd43N4JxBT
 cwvyiIfWreq/dvdCUHGFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684927150; x=
 1685013550; bh=3bvbGpFH5nB/9p9vzminXpFAEYUzSqm0I9KkDrSD2rw=; b=F
 UCjZgcZqyhJrNRYNYDTlYt3S/qtMJVxKSXIAN3N9ZyLAnOPDF5R4FR9Pnnv/RH4y
 9C1jMRlM6aznw+rFfeMp+TUn1BtQTT+8laHU82YG7K3FzCaNJmMhpT/j21UBOaxT
 nGe2DVBTKuR+wUU31JY+Pskxg0cf6Lvn84JoMz71+ZdUFwR/bKhoZzm3Oa/wXBXE
 blKmAn9VvCZwPU+GNQf5lkvLMxsVj2aR3Lh3pK8WEygF4RyWYFdtFV9qRUYFcw7W
 syZOuxSaJzQw/8RAgoFxYYWU7xH/PZHLVM3s1X2nHlIoiIFo64ibTYNMI09a1tMa
 v+Kgm21LTdv4pP/QWhSLw==
X-ME-Sender: <xms:rvJtZBuuBsHdQEabMB4vbd7na0gjvdO1tseXOqKkQ89DqB5NSkueKw>
 <xme:rvJtZKd_HmN92bpYVAcAwT6Dv15AgU8pwmPNFlfH4OBBC9zqZKHAPc7kfJQoeCeQO
 5VPkcMqiV-GITI52Pc>
X-ME-Received: <xmr:rvJtZEy8ABJalElRZ2AOvfsmaPoUpVjd3Qun_eLY82PDg1PPT0QOqZOKJPWdZJwYVujsaatBIBQq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgfeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepudehueeuueektedutddtvddvvdefheefkeelveetkeeffeeuieefveduudfh
 heetnecuffhomhgrihhnpehruhhhshdrthhonecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:rvJtZIPgbxZYOeEyJORPmxtvPLX852tcjwrmqbWQRe63a3Evjg7Orw>
 <xmx:rvJtZB8OYOAtApe0O-zH44QLmB4-dVZrHrHQtIL2ky6m6CIuGnOYsQ>
 <xmx:rvJtZIV5ED2F-hMCOSsR2rIPc8Vf9_Gwn8eK5j_sOCBzo_KgFl4Xag>
 <xmx:rvJtZNY5xLNvaFj-E3IlUq69-L7UyVkv52SvpiYEEdMey-qbWCZsqQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 May 2023 07:19:09 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <j.devantier@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 1/4] hw/nvme: fix verification of number of ruhis
Date: Wed, 24 May 2023 13:19:01 +0200
Message-Id: <20230524111904.91179-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230524111904.91179-1-its@irrelevant.dk>
References: <20230524111904.91179-1-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=k.jensen@samsung.com;
 h=from:subject; bh=ynMkYum9LI91n9UwJ7qIOfxthXLwXcu/Btdf/0Xz4Tg=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGRt8qhqc2W5WimuJybNSD77nQ3RuYtISuPjx
 xwtyAA6iBIzPYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkbfKoAAoJEE3hrzFt
 Tw3pELcH/2PpynuzwtYHXeaSf8OxxeYqU0szpzw4Sjg5NnJyX+x0sVPvY9+i3putGerpwbbUJgK
 chBeteNskJ4JlZByMDUQAPkbniUZAX+aQYWtvn5HpPN3N/GGk7yYogS40YRvhazM7gnvKR6s5oG
 8+lV01y2Q1XwEYl3+TEmJAFUVlUscAKeDs2D88gkM8DBZl+q+TUG7LJsKz2q4p4BOrkd9JMU/jn
 Ugh1QP6yYQpzAGxapdxwAlE0VAT7NQdfwA4oR0b5Xm6l4uf9Xoo5qUWzT5wQ05WaTBrKbxZzAqR
 SJxXN8scntlPW1OhVkSZPWbsAboUVBII7YTkzOhIkPihcyPRyUS+o6Ih
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

Fix a off-by-one error when verifying the number of reclaim unit handle
identifiers specified in fdp.ruhs. To make the fix nicer, move the
verification of the fdp.nruh parameter to an earlier point.

Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c     | 4 +---
 hw/nvme/subsys.c | 6 ++++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 547c0b154312..050fdaf50fcd 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -438,9 +438,7 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
 
     /* parse the placement handle identifiers */
     while ((token = qemu_strsep(&p, ";")) != NULL) {
-        ns->fdp.nphs += 1;
-        if (ns->fdp.nphs > NVME_FDP_MAXPIDS ||
-            ns->fdp.nphs == endgrp->fdp.nruh) {
+        if (ns->fdp.nphs++ == endgrp->fdp.nruh) {
             error_setg(errp, "too many placement handles");
             free(r);
             return false;
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 24ddec860e45..d30bb8bfd5b4 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -158,8 +158,10 @@ static bool nvme_subsys_setup_fdp(NvmeSubsystem *subsys, Error **errp)
 
     endgrp->fdp.nrg = subsys->params.fdp.nrg;
 
-    if (!subsys->params.fdp.nruh) {
-        error_setg(errp, "fdp.nruh must be non-zero");
+    if (!subsys->params.fdp.nruh ||
+        subsys->params.fdp.nruh > NVME_FDP_MAXPIDS) {
+        error_setg(errp, "fdp.nruh must be non-zero and less than %u",
+                   NVME_FDP_MAXPIDS);
         return false;
     }
 
-- 
2.40.0


