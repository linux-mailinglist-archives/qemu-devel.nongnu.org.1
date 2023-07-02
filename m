Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D32DF744D0E
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 11:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFtfV-0003og-IG; Sun, 02 Jul 2023 05:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFtfT-0003n1-1V
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:46:55 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFtfO-0007jT-QO
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:46:53 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b87d505e28so2977919a34.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688291209; x=1690883209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viqv5Rw5CshESJTyQPgOsxciBoe2+ZUBIm03boeiAVY=;
 b=ZyPCwZ9c/sOP95jqAEWMRMj2S4CmzWswcD9HPWN/zggISrnmt6E/9qDitkWb3X9HX2
 2eUfWYIbQS6cgrKbLyBvo9bslqsyIPwMBp0nHzDOfIVYFZEwJUvegrWPkgBz4J1D6fdO
 0qj7A+H/8vWyvIqZg3wCFZkL6eHBgU9pvD5I54nbMrYkIQ3Nfp4W0g80Mfo6PePPmR3G
 BFHww7Lqoj27t0tdf/N+fDQ7NzuhNOmq96H88VAToWaWvrHxEqiVYQI/1IRVual5w5ow
 TJb7EAFbUOFXFhshM5GXQJQhbf+9acvfYJPo6U6kQ9fpsu/4q+hI+YTZ69IMku+Ha/yN
 gNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688291209; x=1690883209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=viqv5Rw5CshESJTyQPgOsxciBoe2+ZUBIm03boeiAVY=;
 b=aDeVIqEMpXD8zarX9vG7t6YxF8e5kMvOQHKjyULbIojLkzvcwIdqbJl4Y2+HQ8KNK+
 NNCU9pJc8RTbZqy7L7aQUhozSty4QvhDekdMcHftDgfz7sTtPaPcGLnMtc5s0gtsIt11
 qZOQZaGHsqcNCUL9Q9y0nXZkEs0L2Vr15hL4vAUAIe+ux+PGaTPoBV8VPajuVQLn3Ois
 rx9K+n0A32m2LNQx8DC4z3NBH1rrTRD/8tkq4PJAYVsYqewhML9B+OWSOgVsl7jv2D4U
 hdS4lwTp0uAI8w35eEst24JtLKTrzUsvnphp3rf0PpVCONb+dgeWSZ8GYdgOX5OWzFAS
 6Bdg==
X-Gm-Message-State: AC+VfDyGh82V53+rRhiU4d5ZLxVygENNW8BdKpIcqVL98m5f/87fmZI+
 ymxy5a578YLH8p5dHmIrk1okQO0aga8pWKOkW9A=
X-Google-Smtp-Source: ACHHUZ7UK8af6Znd9yRF4FNpy1/pBcz6dGZfz3EKFABp7uPG/anYgSv2CjB3YIvEfuYMlNAJagf53g==
X-Received: by 2002:a9d:7ad5:0:b0:6b8:969f:df31 with SMTP id
 m21-20020a9d7ad5000000b006b8969fdf31mr8959079otn.9.1688291208760; 
 Sun, 02 Jul 2023 02:46:48 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 i1-20020a635841000000b005348af1b84csm12934067pgm.74.2023.07.02.02.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 02:46:48 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 4/4] pcie: Note a caveat regarding ARI next function number
Date: Sun,  2 Jul 2023 18:46:28 +0900
Message-ID: <20230702094631.39111-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702094631.39111-1-akihiko.odaki@daynix.com>
References: <20230702094631.39111-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pcie.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 3cc2b15957..16860e2216 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -134,7 +134,14 @@ void pcie_sync_bridge_lnk(PCIDevice *dev);
 void pcie_acs_init(PCIDevice *dev, uint16_t offset);
 void pcie_acs_reset(PCIDevice *dev);
 
+/*
+ * Note: for non-VFs, nextfn must be the Function Number of the next higher
+ * numbered Function in the Device, or 00h if there are no higher numbered
+ * Functions.
+ * TODO: validate this.
+ */
 void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
+
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
 
-- 
2.41.0


