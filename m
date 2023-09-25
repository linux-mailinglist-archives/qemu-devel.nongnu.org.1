Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B12747ACFD7
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 08:06:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkeiw-0002qG-Ai; Mon, 25 Sep 2023 02:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qkeiq-0002pc-CX; Mon, 25 Sep 2023 02:05:34 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qkeio-0001N8-8S; Mon, 25 Sep 2023 02:05:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id ACFFE32009DE;
 Mon, 25 Sep 2023 02:05:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Mon, 25 Sep 2023 02:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1695621924; x=
 1695708324; bh=0r8tve1K/c5ySObEpHIC5LsfICiV21V8gEnJh35CB7U=; b=N
 7cp5tKfl5oyovuGJ2Fh1JDrVklounA7Fale5pRM7oWQ1OVkoNT4WIIg+WW05RrDH
 ocLIIfqla5JTzvnLqIQWnvA2I84AKiPNxjdW54Ck05+apHmvkcHFJU0KMCJ5PozD
 P6WONtbnx8hEFChyn26tSlTqZO07M9bjNii5UDLs5iyXCr5odSlegAlVuocb+hdR
 jLhRpGKkzi4P7TjC12rrQ6GDDp5+/qHAeRWMkAGlkgGiSeeSLrKLp5EV7KI45HUO
 BVm0BxBcdum8+jKdN7mzBkklA1yFEqloMDlOFFy0ThBpUX0PaHyWNLjEEGaUh0C1
 hnq3Z05KEDJW0cZyLYvBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1695621924; x=1695708324; bh=0
 r8tve1K/c5ySObEpHIC5LsfICiV21V8gEnJh35CB7U=; b=eC0cLQidE6dp4C4Jh
 8Pj/sWyLN57p8lacPGi2gOijYHKIb07BIxUK1RP5AgzzVAn3UeBTuckrknowmB1P
 vzeHpoKV3o9ATUUNG2QBrDSfLunNEj+HS6LEJdf9XNUKTnVlIza8QgrdqO5Bxw+t
 QRBy2hTmg+bv33mrnGp64iUahit5DZ95MA/+oVya6mjvVIEn4k+8tW4rM1X6gn99
 VpA8HKzJNYrg//nrDmrQ5nS8j5JMvWAoxmenCYV6jNvfSG5nC7LESslLLeBeN8rS
 g3FMOe0zYcBMOeOyh6CS6KaJz6P6cX/RtzYT3e2EDwxvl1VO0PIaw86Qu3/uJWHX
 uzHSQ==
X-ME-Sender: <xms:IyMRZcZHFJMnd1sv5bGUSnS_ppeyppE6z3CFVXVXgxl4PJPDHdIFJw>
 <xme:IyMRZXaPnP7FyhaAYxhztpken1r078RO0o1T7G4aGU_TudZchA8dwY2lV3tj7pfci
 5vboHKEmzhEhK27F2s>
X-ME-Received: <xmr:IyMRZW9xtZ0rz9ObZPHU8PJVf3M5GZSid1Bgmt-dG-DhzeqozbOwe0BboiP9UFd3I1XLvGg6b_ocdkwAWC_BUTiQvSZPYJzM5743_LNlUQc5W2XWBjXDtgLpU-vttYs3XOzYfkPqTVNb6kM_Dt7fKVj48leHnqB7tZ4oz4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelfedguddthecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnheptdehveejiefhgfegiefhfeehueeigfeugfelhfdtffevheffkefhkeegteet
 ffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:IyMRZWpyYkO9YpqnLHKje3ZERqthyQ2BrnmhhryA5n6zoHs-gW3gMA>
 <xmx:IyMRZXq3scXqMYDfkm6wXW-ANwksrYEJv-qtXSBhHvdkplJJ340How>
 <xmx:IyMRZURX4UiO79HGANAzgK-fGn9dP7QsR48USrMRAjtNNIvQ3MnZ8g>
 <xmx:JCMRZYlVL4y3lzpd240kcGG8W5rQAFMQw1jxBx-Jxd2R_zuR119KXA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 02:05:21 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 25 Sep 2023 08:05:05 +0200
Subject: [PATCH] hw/nvme: Clean up local variable shadowing in nvme_ns_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230925-fix-local-shadowing-v1-1-3a1172132377@samsung.com>
X-B4-Tracking: v=1; b=H4sIABAjEWUC/x2MWwqAIBAArxL73YIpPewq0YfoVguioVBBePekz
 4GZeSFTYsowNy8kujhzDBW6tgF7mLATsqsMUkgltOxx4wd9tMZjPoyLN4cd9SCGUSuaDGmo5Zm
 oav91WUv5APMy+xplAAAA
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=a9jBSQLTvc2ZV7mNyWH72YnssWzy7k8X/3zi9hUYiE8=; 
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGURIyFptyj0FXtO5H/hZp6Ut1X/cjVZQ3PpT
 f/pjbK26n+Se4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJlESMhAAoJEE3hrzFt
 Tw3psIwIAJ/IBTP2lNHg/6edFbeUqFj8ZrmCtS1E+OBY7XFaNJ8F6FsOZM/0+D5MOu2nLFd6eoZ
 1xLRFdUwgzi8ri06B0mw8EjRNaICPHnF2cIAT1cgZa0f8uSMXnTfw4hwGchVYT7NLjoYQKPf4Nd
 Y0j7qphXUs5dYPmLi/lvWxacza9MDzZcHDEnD2T5wvnpok/S4aBdcBpHlt0iZrlvCu5xN5nOoZn
 WhUgPLJQuqjCxLpPcOF4f8JgviCq3DiuWx//wDYQ9Kd2U6PlIx2SgZLUD1WoGjmicFEspW6mFif
 o8DG9xub92eKwBDiU+hH8cbNrSU9Bo2k3MYM9MQB/JbCdmjcc+NYx7EZ
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=64.147.123.25; envelope-from=its@irrelevant.dk;
 helo=wout2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

Fix local variable shadowing in nvme_ns_init().

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 44aba8f4d9cf..0eabcf5cf500 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -107,7 +107,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
 
     ns->pif = ns->params.pif;
 
-    static const NvmeLBAF lbaf[16] = {
+    static const NvmeLBAF defaults[16] = {
         [0] = { .ds =  9           },
         [1] = { .ds =  9, .ms =  8 },
         [2] = { .ds =  9, .ms = 16 },
@@ -120,7 +120,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
 
     ns->nlbaf = 8;
 
-    memcpy(&id_ns->lbaf, &lbaf, sizeof(lbaf));
+    memcpy(&id_ns->lbaf, &defaults, sizeof(defaults));
 
     for (i = 0; i < ns->nlbaf; i++) {
         NvmeLBAF *lbaf = &id_ns->lbaf[i];

---
base-commit: b55e4b9c0525560577384adfc6d30eb0daa8d7be
change-id: 20230925-fix-local-shadowing-9606793e8ae9

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


