Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8350C70AD6F
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 12:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0gEQ-0004G7-Gp; Sun, 21 May 2023 06:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0gEM-0004FN-NI
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:24:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0gEL-0003JI-33
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:24:02 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 906745C0106;
 Sun, 21 May 2023 06:23:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Sun, 21 May 2023 06:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1684664638; x=
 1684751038; bh=ZOLEDoNYnFMxx0AUhrzEwS73DT7TeurHf5uuRbwPBKk=; b=a
 lCFRlyoobGqu/NzQqdhWtgb3wbO5QiMIjz0e0ndjHCio1V/osoTQXLr3fcxMVw5F
 W+zxDabLEz84q36pOwvgtp56KN3o4dkmWGJhQ9tNXT7LvXy/qR6lpfOVaRoG0RXU
 NomPd9i3AY7wiQJ3Zo2oNzIGj2OdCUmkFnLLjctE1a+YlY8qRBK8dv2e1u1lJOTk
 HS4KqkfUGBZwexk1BKhOpCtZ6Zu2LlVOGjZNSzeJj8nTNCeRCjEJ6wV+IK4niDXh
 UQZjcvmQHF6DAxg5UlFmhomXOi/BTveBvuvO6vvxBSPAensyn0OKPntJkxhIyBp6
 jqOjYJRiLvEVuyiAwhW8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684664638; x=
 1684751038; bh=ZOLEDoNYnFMxx0AUhrzEwS73DT7TeurHf5uuRbwPBKk=; b=M
 6YrJ+Y1h3gQiF98zIJSQ9qEFQTMHo6netR89YGuSJ+5jQf6mFc7yJozxnSDEJm41
 hOR+KoRvc9A47/xDnZKQgK2AGalXkh+CmJqQ73CGZaCCfaCT05xYf1DcMVCsDQiC
 0Gsgw0kx2mUFS0Tj39xcLWfBvRt2Tqi/hkXVrmaAZzgblVEsNmJTbSct1XoFWK55
 6N71a6qyOitAw9aAGxApE1Zn2egnqQT4Z2Ag+07NJGhutLNQiF+XoObk6CayT57f
 WHAaIjaSkXgLpJMMGwbIs7MKD78/S1DWqSqAJUYLHyR3eF3Kc3CybofslfsVUcrj
 I/oKwvN5m4Fdc0iZM3eNQ==
X-ME-Sender: <xms:PvFpZGTTCJIcUZnXmsxuqtRnXbJhbHswGXLnD-5TFIkMEsrL8v_bmA>
 <xme:PvFpZLz10_tt4gOyRKd3xe3s7NDAjyl5cZo9xxyTY3FfVfJR9aLFoVVm2rkrFZK9n
 KEg46wZ9ar60rxCQl0>
X-ME-Received: <xmr:PvFpZD3htjCmx04ClXkaV1f1H_eTNTfCI0X0OiCVBaQlgnwAC9-rxXCvoQAa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiledgvdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
 ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
 dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomh
X-ME-Proxy: <xmx:PvFpZCAhWtsSuhDsTdVLcazOOCir19q9zTYCaotkMRxcBrfkjjaRAA>
 <xmx:PvFpZPie5uRB_5KsuXvejohAXSMoTtFSPLP4ygPe2bNq9VCb_ES_Tg>
 <xmx:PvFpZOobi8aLRsGH3BXst6QwgFrXGvhbO1KlgmeJO4L6yL4FMu3qNg>
 <xmx:PvFpZPhmVmRZnicwmeOeelXlvf-0t_tLyPC6IEM4K5p4k5ZNNsYYMg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 06:23:57 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, philmd@linaro.org,
 chenhuacai@kernel.org, crosa@redhat.com, wainersm@redhat.com,
 bleal@redhat.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/4] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
Date: Sun, 21 May 2023 11:23:04 +0100
Message-Id: <20230521102307.87081-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.25; envelope-from=jiaxun.yang@flygoat.com;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

As per "Loongson 3A5000/3B5000 Processor Reference Manual",
Loongson 3A5000's IPI implementation have 4 mailboxes per
core.

However, in 78464f023b54 ("hw/loongarch/virt: Modify ipi as
percpu device"), the number of IPI mailboxes was reduced to
one, which mismatches actual hardware.

It won't affect LoongArch based system as LoongArch boot code
only uses the first mailbox, however MIPS based Loongson boot
code uses all 4 mailboxes.

Fixes: 78464f023b54 ("hw/loongarch/virt: Modify ipi as percpu device")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/intc/loongarch_ipi.c         | 6 +++---
 include/hw/intc/loongarch_ipi.h | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index d6ab91721ea1..3e453816524e 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -238,14 +238,14 @@ static void loongarch_ipi_init(Object *obj)
 
 static const VMStateDescription vmstate_ipi_core = {
     .name = "ipi-single",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(status, IPICore),
         VMSTATE_UINT32(en, IPICore),
         VMSTATE_UINT32(set, IPICore),
         VMSTATE_UINT32(clear, IPICore),
-        VMSTATE_UINT32_ARRAY(buf, IPICore, 2),
+        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
index 664e050b926e..6c6194786e80 100644
--- a/include/hw/intc/loongarch_ipi.h
+++ b/include/hw/intc/loongarch_ipi.h
@@ -28,6 +28,8 @@
 #define MAIL_SEND_OFFSET      0
 #define ANY_SEND_OFFSET       (IOCSR_ANY_SEND - IOCSR_MAIL_SEND)
 
+#define IPI_MBX_NUM           4
+
 #define TYPE_LOONGARCH_IPI "loongarch_ipi"
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchIPI, LOONGARCH_IPI)
 
@@ -37,7 +39,7 @@ typedef struct IPICore {
     uint32_t set;
     uint32_t clear;
     /* 64bit buf divide into 2 32bit buf */
-    uint32_t buf[2];
+    uint32_t buf[IPI_MBX_NUM * 2];
     qemu_irq irq;
 } IPICore;
 
-- 
2.39.2 (Apple Git-143)


