Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A99D879E921
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:23:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPpe-0005Ex-88; Wed, 13 Sep 2023 09:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1qgPpb-00057i-Ob
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:23:00 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1qgPpX-0005mX-5R
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:22:59 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1694611369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ywQJtUlH8vKeRQ5g541hph1HbS0nWnjbE1RNdp4U24k=;
 b=thLJH0ygofOR0Aoy9FTV/J+3WfVqEztr+zUAJ+62eJGDRwKBFSlRW6mQ+7m45wa3Z06+BT
 3VlrByCNnNvzi0L5yM1JQWVintMLdGVEqE14koiKCdWmM/CAGvwvbW+VrUURI/5l8aQTkB
 Pp+63+E4O6K64ZiU+IigRc8e5CcXFsE=
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com,
	qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org,
	Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH v2] hw/cxl: Fix out of bound array access
Date: Wed, 13 Sep 2023 16:22:28 +0300
Message-Id: <20230913132227.823336-1-frolov@swemel.ru>
In-Reply-To: <057bee7c-92e0-1cf2-bcdd-ef7eeb223db4@linaro.org>
References: <057bee7c-92e0-1cf2-bcdd-ef7eeb223db4@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

According to cxl_interleave_ways_enc(),
fw->num_targets is allowed to be up to 16.
This also corresponds to CXL specs.
So, the fw->target_hbs[] array is iterated from 0 to 15.
But it is staticaly declared of length 8.
Thus, out of bound array access may occur.

Fixes: c28db9e000 ("hw/pci-bridge: Make PCIe and CXL PXB Devices inherit from TYPE_PXB_DEV")

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
v2: assert added
---
 hw/cxl/cxl-host.c    | 1 +
 include/hw/cxl/cxl.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 034c7805b3..fe9143409b 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -33,6 +33,7 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
     for (target = object->targets; target; target = target->next) {
         fw->num_targets++;
     }
+    assert(fw->num_targets <= ARRAY_SIZE(fw->target_hbs));
 
     fw->enc_int_ways = cxl_interleave_ways_enc(fw->num_targets, errp);
     if (*errp) {
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 56c9e7676e..4944725849 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -29,7 +29,7 @@ typedef struct PXBCXLDev PXBCXLDev;
 typedef struct CXLFixedWindow {
     uint64_t size;
     char **targets;
-    PXBCXLDev *target_hbs[8];
+    PXBCXLDev *target_hbs[16];
     uint8_t num_targets;
     uint8_t enc_int_ways;
     uint8_t enc_int_gran;
-- 
2.34.1


