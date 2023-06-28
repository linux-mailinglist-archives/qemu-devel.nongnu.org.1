Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2929740CB6
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:26:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERQJ-0006tx-27; Wed, 28 Jun 2023 05:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQG-0006ss-Bb; Wed, 28 Jun 2023 05:25:12 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQE-0001Kx-Nu; Wed, 28 Jun 2023 05:25:12 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id DC0CF5C0254;
 Wed, 28 Jun 2023 05:25:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Wed, 28 Jun 2023 05:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1687944309; x=
 1688030709; bh=fizn5INwmm2k1ZWTRHs1ql1YE1488B/2o6dkGpp88EI=; b=W
 rBHNLpcwg8ofdi+HWuNy1tzaW7XcvzwM7oJ2mopCQo5g6TD+HLiGwxVNndyw9add
 SCNkng0sUhwb5Ve0LkwXZhSfPaCdmHRdKKXuVW0b8+T/ZXz7Fhu3sQGIyYLFVinm
 NmeKDou4NPdSFYEgVNiIWp/ZewDuM534o0CUoVKg4Gd6IzcXu/8EmEiOf+IjPZ6v
 9KtchyGvHVvOIMxAfMXR6HKNd3XjTRre8cN/HrcsF9Z3ADFRZb8b8SJhWGntFv8C
 IzckopHFGvpqBocY+71AouXzeMFJXA5uYfDTbrxLMfJh4PR7raykBpqBe6kgcIK1
 NkA11AHc9PbpHq5jYVLgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687944309; x=
 1688030709; bh=fizn5INwmm2k1ZWTRHs1ql1YE1488B/2o6dkGpp88EI=; b=i
 dgc7OQGqcvAuL47s7y0F19dWStecPnAu1gLAo3DfYVTuyApSQr5qS2DLC4YCnDpT
 tTnho3ZaFhHQMFmFmPPO4w8Ux+klzuBBF4mujz85R1CP0Ptq5toegDt920METE23
 n9euwKt6b+cNKfXPyxzkpD7KOzVYHNFc/b9h8nKR39Q5IT6Z7kdqE/hvOTV1Zr1E
 dAlFqo8cdHMoJL/ebUiFRCDOBQyQNHrgROcSgohLUzvKQDM3qktXgEhDijHV9V2u
 UfrpL3g/JCY9nkOZ/y7MFcmeDudAogIYzajd01YoWu8nzWF3WLPcUyDDlmur153l
 Ielqmdwab45tWdACJf8pg==
X-ME-Sender: <xms:dfybZAL3r9lCL9bUSauMhcdongDYCDJcAtmgdiHSUXEx-l8cJJhMJA>
 <xme:dfybZAIUpoHOcTbytfRu-QhPa56qzZ3Tcgnf3R7EIJVtaSrwpaNetVqjgonh39kZK
 T6bxMWhupvSAVSpeJc>
X-ME-Received: <xmr:dfybZAup6I6DzvNGDGbY2kJ4we5tLR0SIeNBpCpm56-vjtPlDW4nPUQrahumMnNudd0wp7qeOcM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgddufecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeduheeuueeukeetuddttddvvddvfeehfeekleevteekfeefueeifeevudduhfeh
 teenucffohhmrghinheprhhuhhhsrdhtohenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:dfybZNZH94XguZ26EIrbDC5q9HXZ6ejXdco5z_ypvPYdt_8u7PoGag>
 <xmx:dfybZHaeXz43LRMbFU-xhVYnbgA-n-72Iw1Qld0-cqv2mCHHv2cdTw>
 <xmx:dfybZJAYw2BnH7FJh5OrIAzU66eH2XqRH3Y_YK_ls5JLUIr6v2o2oA>
 <xmx:dfybZES6YjN4ITtY7dqt0A2X2L_ju9cbF6xqx_uyXbPnVYMP3LZNJQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jun 2023 05:25:07 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <j.devantier@samsung.com>
Subject: [PULL 4/7] hw/nvme: fix verification of number of ruhis
Date: Wed, 28 Jun 2023 11:24:58 +0200
Message-ID: <20230628092453.39602-13-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628092453.39602-9-its@irrelevant.dk>
References: <20230628092453.39602-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=k.jensen@samsung.com;
 h=from:subject; bh=Qvn3h713z/xOqhjAUBNUyTzo7mDZgiguvvfFAjleIl4=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGSb/GaMvkceeJvBw/fdKZ8dz/zjbmy3RoaR2
 yoWrbhEB8YcWIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkm/xmAAoJEE3hrzFt
 Tw3p7zkIAKGimmqGF0vySYqo8AW3Z6wfzOrIpfhZKElKsBewf0OUYOECCEThXj7UXhQr+6YYcxl
 7WPBf/7TQjh3oPhdpdZPGvJYoAwCfYfFumQ1NzBamjuzqTFTOuuMM2R1Bs1wEKZwpgDiLSShP01
 e77yjTFfL1ooqacJQT8/mZ5jzw98Lg1hNTgnVp7iG4PfhyfqFedhj2Ua1ILMLsF8JXQ/izVyc2M
 TQNFfSe0tGp6r/EBrWTEamSsVvYX/B27VnYaueIjYU3WQNOy09TObJXinRIT2bXQJNYL9K2EsWA
 j1XRKigB5QFrxZ7wvjl7qqRg72Rf21Is0vV5IiGUcIgJPoY7RDd1zKqf
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

Fix a off-by-one error when verifying the number of reclaim unit handle
identifiers specified in fdp.ruhs. To make the fix nicer, move the
verification of the fdp.nruh parameter to an earlier point.

Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Reviewed-by: Jesper Wendel Devantier <j.devantier@samsung.com>
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
2.41.0


