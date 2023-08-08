Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F1E77382C
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 08:28:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTGBy-0004UO-Ij; Tue, 08 Aug 2023 02:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTGBu-0004ST-FS; Tue, 08 Aug 2023 02:27:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTGBs-00070F-P6; Tue, 08 Aug 2023 02:27:38 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id C38C85C00CB;
 Tue,  8 Aug 2023 02:27:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 08 Aug 2023 02:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691476054; x=
 1691562454; bh=73Q7o1MaFcuZdXvYSbd98bpNm+tM8IhFfhR4hxDxYoI=; b=c
 5iWQuleWSRMTaWgODWQlYkffG2mACOeHQJRCRn8hXnIUsguG5u90i+JV99R7fJQS
 wFokeB2/wcmVdAcv+j7evBgqV+pF28vhXz5zONuUi7xj8tm6MD0wYft8aTkDYdWj
 CjIf5OJ4tHOzEfOcYoQvzrQiV7ZdDrvgYGjfXHKnY8r5LvRt5B0RcsI47KSsMIzd
 yfRtWQWK4Lid/eDNp3ikaRxqbjyUfpoSMgjq29e4pK0N4DexQlUNo7K0h4lpqKQ3
 GTFRlL0C0QkfP3epngCE80VVMzU40lhpmJVCYaN0vlw9Gc5WvftgdHU8/xdfLmk/
 44YCViqp9lthtV7TnYJ9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1691476054; x=
 1691562454; bh=73Q7o1MaFcuZdXvYSbd98bpNm+tM8IhFfhR4hxDxYoI=; b=F
 u4mjEukogsrmLNXk299Sg2Uw37r8A3+GExnDYjftXk3w3Cnbc4i1rK07G+PgvhxG
 JFRSdfkBB1PLmX/OyeCA+6+UhmNY1dJXh9D17i8dgRDP/GzAfDlWKcEEU/ETRN4T
 /PqJ/StTNmgT3z2qxQYalLM8zInBQBwxjxVZmc7KiRH+u+WWOx9z78saWIYjHaBI
 kzKr/q/NiZFm21kfjmsnTFqu/rlWScOdrkOuCObti1sUMQy3uis++xr76YAuY1Nv
 9tsx2xmpa3GHXSSkVVRljo4Ft5Kf1OsMwe0h6wIaQlRplybR+f4QiMBGV1OyNFxL
 rdEJUd4dz2nhBe/UUiUdA==
X-ME-Sender: <xms:VuDRZFvbDFGoqodBRE7ouNFK9id4xr2NZxjTzX8PN6f4LXfCVIdB_A>
 <xme:VuDRZOdDZ3k_taJ6-6MKqzV92kEVQOfodO-wO12FZifAF1uIbQ64bpuy0KsskWCKV
 D6GPNEK-lfHotJ7kDY>
X-ME-Received: <xmr:VuDRZIzLTVrJmrZ4k6FlJufcNICGs7Et51l6QjgB6kebc1qFvESx5gZTDqlcj5dkwKuNQ8mW534jHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugddutdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:VuDRZMPe8qnzUyumwOdb9Zwqz69AthcWW4fbVZRbgqVOCWH7WrczRw>
 <xmx:VuDRZF_Pk0Lvn3v3bHiSVPzU4qtAmtC16g-iDY7fscrBJRXP1O-8xQ>
 <xmx:VuDRZMVBuTO27sLWJY4AdbsuwvXjl69_oMy3TB-byaemwI-9Y5IaNg>
 <xmx:VuDRZMVPZ4DQ6QuPWk30ibREQoqh3t6myFYxqGg7WJbW6i7EJZI6xQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 02:27:32 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ankit Kumar <ankit.kumar@samsung.com>, qemu-stable@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 1/2] hw/nvme: fix CRC64 for guard tag
Date: Tue,  8 Aug 2023 08:27:29 +0200
Message-ID: <20230808062727.19263-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808062727.19263-4-its@irrelevant.dk>
References: <20230808062727.19263-4-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=k.jensen@samsung.com;
 h=from:subject; bh=To/dsDByKFxvBS4IegB9nq00HrvzfWLQN9r3vfwNgkQ=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTR4FBCf1kovo80HvZ4CzJ2p2col/h5BQkm0
 ux2v0Mq43jTDIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk0eBQAAoJEE3hrzFt
 Tw3pw+0H/RqJopdxS1NA2QuaXG9XnNtu2cnJr4oW7wlq2DrD/xGwelRoimwzEaQ6zG/a96/JuKX
 iZy4KqESnEZlAJqj9JQoD3Zf2kTXApp8E1OPDirrYZf8FFyn3z/jenD4hzkgi8yuRazZ5pQlRW4
 CLlLRPzzLJ1wp/7pjjCOctj8LERv9YQ7cWd2fJbYFdillr9FP5otwlf6/zZWMr/ozw2D0oB1z9I
 rNADIfO75iGLq+D4G9CTOlokaP6dTYayG2eMYEJcEm6eyTn/o8Nlp7duAZFD9tuUj2sgZkZrpbw
 BKc3QSILkmWI82ITI+leY0jVPi58mypFbKg34VitwMNCf7vonb/LSaup
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

From: Ankit Kumar <ankit.kumar@samsung.com>

The nvme CRC64 generator expects the caller to pass inverted seed value.
Pass inverted crc value for metadata buffer.

Cc: qemu-stable@nongnu.org
Fixes: 44219b6029fc ("hw/nvme: 64-bit pi support")
Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/dif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
index 63c44c86ab55..01b19c33734e 100644
--- a/hw/nvme/dif.c
+++ b/hw/nvme/dif.c
@@ -115,7 +115,7 @@ static void nvme_dif_pract_generate_dif_crc64(NvmeNamespace *ns, uint8_t *buf,
         uint64_t crc = crc64_nvme(~0ULL, buf, ns->lbasz);
 
         if (pil) {
-            crc = crc64_nvme(crc, mbuf, pil);
+            crc = crc64_nvme(~crc, mbuf, pil);
         }
 
         dif->g64.guard = cpu_to_be64(crc);
@@ -246,7 +246,7 @@ static uint16_t nvme_dif_prchk_crc64(NvmeNamespace *ns, NvmeDifTuple *dif,
         uint64_t crc = crc64_nvme(~0ULL, buf, ns->lbasz);
 
         if (pil) {
-            crc = crc64_nvme(crc, mbuf, pil);
+            crc = crc64_nvme(~crc, mbuf, pil);
         }
 
         trace_pci_nvme_dif_prchk_guard_crc64(be64_to_cpu(dif->g64.guard), crc);
-- 
2.41.0


