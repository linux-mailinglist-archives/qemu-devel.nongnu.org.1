Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 132F579EDFA
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 18:10:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgSQt-0006R0-Aw; Wed, 13 Sep 2023 12:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgSQo-0006QM-0Z
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgSQl-0008Cd-To
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694621371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5QWLyW035RFUKHYcMnswSUQHfWu5ktuGNLt3WjX6m0=;
 b=Ak+zR8DP4Ccgp0Dfx5D+oXpH9UXgHJRujIWLmfQwLcmr2lcyc+McOXu4ZQYW0hrGrxCcmt
 mLwGE53prnkZ0AxqcLWAS8YGHUAt6dZJPpVxHIHTdgsN+Avv3i0336qjgkaQbTrSyazsqN
 ZoeeQmGt01Q7qJDcbgJ4zxIfHY++pXI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-Rz8MVcjNMtynb-ubGzJ0ew-1; Wed, 13 Sep 2023 12:09:27 -0400
X-MC-Unique: Rz8MVcjNMtynb-ubGzJ0ew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6151800159;
 Wed, 13 Sep 2023 16:09:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB8402026D4B;
 Wed, 13 Sep 2023 16:09:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 2/2] hw/mips/jazz: Simplify the NIC setup code
Date: Wed, 13 Sep 2023 18:09:22 +0200
Message-ID: <20230913160922.355640-3-thuth@redhat.com>
In-Reply-To: <20230913160922.355640-1-thuth@redhat.com>
References: <20230913160922.355640-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The for-loop does not make much sense here - it is always left after
the first iteration, so we can also check for nb_nics == 1 instead
which is way easier to understand.

Also, the checks for nd->model are superfluous since the code in
mips_jazz_init_net() calls qemu_check_nic_model() that already
takes care of this (i.e. initializing nd->model if it has not been
set yet, and checking whether it is the "help" option or the
supported NIC model).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/mips/jazz.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 829c9248e5..c32d2b0b0a 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -172,7 +172,6 @@ static void mips_jazz_init(MachineState *machine,
     MemoryRegion *rtc = g_new(MemoryRegion, 1);
     MemoryRegion *dma_dummy = g_new(MemoryRegion, 1);
     MemoryRegion *dp8393x_prom = g_new(MemoryRegion, 1);
-    NICInfo *nd;
     DeviceState *dev, *rc4030;
     MMIOKBDState *i8042;
     SysBusDevice *sysbus;
@@ -315,21 +314,11 @@ static void mips_jazz_init(MachineState *machine,
     }
 
     /* Network controller */
-    for (n = 0; n < nb_nics; n++) {
-        nd = &nd_table[n];
-        if (!nd->model) {
-            nd->model = g_strdup("dp83932");
-        }
-        if (strcmp(nd->model, "dp83932") == 0) {
-            mips_jazz_init_net(nd, rc4030_dma_mr, rc4030, dp8393x_prom);
-            break;
-        } else if (is_help_option(nd->model)) {
-            error_report("Supported NICs: dp83932");
-            exit(1);
-        } else {
-            error_report("Unsupported NIC: %s", nd->model);
-            exit(1);
-        }
+    if (nb_nics == 1) {
+        mips_jazz_init_net(&nd_table[0], rc4030_dma_mr, rc4030, dp8393x_prom);
+    } else if (nb_nics > 1) {
+        error_report("This machine only supports one NIC");
+        exit(1);
     }
 
     /* SCSI adapter */
-- 
2.41.0


