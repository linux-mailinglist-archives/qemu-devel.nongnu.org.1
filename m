Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 042C8AC027C
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 04:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHvkc-0003L3-MR; Wed, 21 May 2025 22:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uHvkF-0003J0-QG; Wed, 21 May 2025 22:33:21 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uHvkD-00010W-Gl; Wed, 21 May 2025 22:33:19 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 22 May
 2025 10:33:05 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 22 May 2025 10:33:05 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 1/3] hw/intc/aspeed: Set impl.min_access_size to 4
Date: Thu, 22 May 2025 10:33:02 +0800
Message-ID: <20250522023305.2486536-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522023305.2486536-1-jamin_lin@aspeedtech.com>
References: <20250522023305.2486536-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patch explicitly sets ".impl.min_access_size = 4" to match the
declared ".valid.min_access_size = 4", enforcing stricter access size
checking and preventing inconsistent partial accesses to the interrupt
controller registers.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/aspeed_intc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 33fcbe729c..19f88853d8 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -737,6 +737,7 @@ static const MemoryRegionOps aspeed_intc_ops = {
     .read = aspeed_intc_read,
     .write = aspeed_intc_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -747,6 +748,7 @@ static const MemoryRegionOps aspeed_intcio_ops = {
     .read = aspeed_intcio_read,
     .write = aspeed_intcio_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -757,6 +759,7 @@ static const MemoryRegionOps aspeed_ssp_intc_ops = {
     .read = aspeed_intc_read,
     .write = aspeed_ssp_intc_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -767,6 +770,7 @@ static const MemoryRegionOps aspeed_ssp_intcio_ops = {
     .read = aspeed_intcio_read,
     .write = aspeed_ssp_intcio_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -777,6 +781,7 @@ static const MemoryRegionOps aspeed_tsp_intc_ops = {
     .read = aspeed_intc_read,
     .write = aspeed_tsp_intc_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -787,6 +792,7 @@ static const MemoryRegionOps aspeed_tsp_intcio_ops = {
     .read = aspeed_intcio_read,
     .write = aspeed_tsp_intcio_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
-- 
2.43.0


