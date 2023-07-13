Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9410B7516F0
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 05:54:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJnOI-0005UJ-GV; Wed, 12 Jul 2023 23:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnO2-0005PO-1x
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:53:02 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnNu-0004cm-H0
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:53:01 -0400
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-666eec46206so294424b3a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 20:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689220371; x=1691812371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkzONzBBa/vTZkfLpZdZYgGpytXQ6tDBl07nMT21qDk=;
 b=lRfj8GzrG/Qgv567KtbOUThu7+yvc0uOxqlVCvxnxNrlyKjYIErfpqU51SbE9MWNF0
 526rNrfWxkGD2ku8yqtV+Ot9tWknGOKhI/c1GRnhc/XWCfand3iPz+p+M7iUp77wVfM8
 NN95VsfDADq+vIAclp7rvjiL4dt0KOU3KTwdvm4iXUf3DaNFWRNBKpj14ftSYzNfYesJ
 Hpc8E7BUIZNy2ZKW2LBJ83jk9ERPgZ5V22mKcXtgDiHzNcW02rJZzWh70I1AB8Pq73g7
 G1Lwfx8/WGNjnW77OwTtzgPYhVmqsiL0Y+XFBjBO4jDU6vaNMzn1DiSMEpaOhich5Wr+
 /0KQ==
X-Gm-Message-State: ABy/qLa33/pgoN9cr6weEBuFyN8MZE+I8snF9sG9sA0hnk1ahNxkyhgm
 YQNs0IlXB+POuKSWCBDTSFVhddwy5KNajQ==
X-Google-Smtp-Source: APBJJlGMYV+CQi2XYY1Y7MavDnjYOsTUgXizOZMkxFyk7WAMQic6VVrbW6hSR+99t7dMNLE4sQgvrw==
X-Received: by 2002:a05:6a20:160a:b0:130:44be:eca0 with SMTP id
 l10-20020a056a20160a00b0013044beeca0mr385911pzj.51.1689220371429; 
 Wed, 12 Jul 2023 20:52:51 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:8b82:587c:b800:84d:31b7:313d])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a1709027c0600b001b8a37ffb5asm4756199pll.4.2023.07.12.20.52.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Jul 2023 20:52:51 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 09/11] tpm_tis_sysbus: fix crash when PPI is enabled
Date: Wed, 12 Jul 2023 20:51:14 -0700
Message-ID: <20230713035232.48406-10-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713035232.48406-1-j@getutm.app>
References: <20230713035232.48406-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.171; envelope-from=osy86dev@gmail.com;
 helo=mail-pf1-f171.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

If 'ppi' property is set, then `tpm_ppi_reset` is called on reset
which SEGFAULTs because `tpmppi->buf` is not allocated.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/tpm/tpm_tis_sysbus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 45e63efd63..1014d5d993 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -124,6 +124,10 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
         error_setg(errp, "'tpmdev' property is required");
         return;
     }
+
+    if (s->ppi_enabled) {
+        sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->ppi.ram);
+    }
 }
 
 static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
-- 
2.39.2 (Apple Git-143)


