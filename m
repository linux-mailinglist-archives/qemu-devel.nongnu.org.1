Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC575B1FE32
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Aug 2025 05:37:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulJJG-0004zv-Hl; Sun, 10 Aug 2025 23:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ulJJ0-0004xC-Ks
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 23:34:40 -0400
Received: from iguana.tulip.relay.mailchannels.net ([23.83.218.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ulJIw-00049u-F4
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 23:34:38 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 47E772C441A;
 Mon, 11 Aug 2025 03:34:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a236.dreamhost.com
 (100-96-2-147.trex-nlb.outbound.svc.cluster.local [100.96.2.147])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id E1E872C43FF;
 Mon, 11 Aug 2025 03:34:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754883268; a=rsa-sha256;
 cv=none;
 b=uBk70Hwa/GMG7rwNI7slmdquarO7iXm5kfpZWusiTJy3uEO6ndYkT3DHbK17Pp7TT9VNBB
 1p3ru5FieRpQ9shaWmsqySr+w5nhvglpqMvUhvJes3BeXILFz8ONhDsqHkK+76R5UYa6iP
 PhvfgaLKGwJ90aT7Uk4+kXTu+MTYnl/G5dYdaglz95DYBEqOX64pp9fjDIxk4nuAXkKV/E
 fRvGHjaOIZykJSMOpk8RP6vEvw3C8ZoCj+jIVgWzQ/xbIuy/Y3ymNnVAthBHXBMd6x080D
 PhAzKYzOuazoQ3NAOHtS23MwwC4Y4Nj9m3KTVlvbnEp+hz2UwACar8Qhlh6MoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1754883267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=m3zmudrbJi3rUAWruVPmWJ/JHGSWiiguedxKVAHxwYo=;
 b=RGvMpWNw/GPzedyAJ/BJ7DaZ8TtxUmHss8BU1ygVr5AvnKUtmCMU4UxiFc2MMqGOUOYmSh
 qxS34hEib2d4N1lz+RGNvvzi2okD/MCeqa4XtQ1xkQgtX0OfAj/+1/Jif8QUmYgEudfw0L
 NkB30lNGHgVCelcHi4BUZXflD17FGHVxOvUb06MfQmZHQQ3ly61uWWnctZ0/RcaUnT/aqH
 b4+yZyPkQrz3NIbN0WxHXrHGQMIlWz6BL3Y/jHcU6ToEAt+La5HBfeZy2E2+7ZZHcLgiD8
 83NT6gYK7mioW7kQgVamu4lAEv/WQhbZN0yqDnvU/7NbYWOFfsrlJKjmj8okEg==
ARC-Authentication-Results: i=1; rspamd-698857ffff-wx4gx;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Callous-Minister: 53ee5c2b28714c42_1754883268190_3530770340
X-MC-Loop-Signature: 1754883268190:2368623293
X-MC-Ingress-Time: 1754883268190
Received: from pdx1-sub0-mail-a236.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.2.147 (trex/7.1.3); Mon, 11 Aug 2025 03:34:28 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com
 [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a236.dreamhost.com (Postfix) with ESMTPSA id 4c0gH72FKBz6f; 
 Sun, 10 Aug 2025 20:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1754883267;
 bh=m3zmudrbJi3rUAWruVPmWJ/JHGSWiiguedxKVAHxwYo=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=l3s11WGt8CysfK3+GK9eCzpGtXV6v/BT+VatTyOhalcMkUm0/+t+8Ze2yTdqkYrCA
 ZP3g1ubzqVnDIX/WnG4g+NYCr1o1wUPbbGKYm6pDj8au0PDpLnTqXX5Oy2o9I+w9V6
 0FeADodAUOmQo2AqvGGwNnjJ5XgH7/taaHa+Nn/cQz4vCYUr7MEPcoVO59i+uYGGwy
 /mzXivf1pBbWdVAfHCwWJaWzwAdsBB/I1GLSZsGu3cl6mJN63zHOhIQ4J0vUKpaISP
 U0pQKsEwFfw+opfOJeisqkFMKDGoXCDu7gVhd0csBaTByGo4qBVvKGZtqundi7lmOO
 mmcGJMS1URe1w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 2/4] hw/cxl: Refactor component register initialization
Date: Sun, 10 Aug 2025 20:34:03 -0700
Message-Id: <20250811033405.332295-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811033405.332295-1-dave@stgolabs.net>
References: <20250811033405.332295-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.218.253; envelope-from=dave@stgolabs.net;
 helo=iguana.tulip.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Ira Weiny <ira.weiny@intel.com>

CXL 3.2 8.2.4 Table 8-22 defines which capabilities are mandatory, not
permitted, or optional for each type of device.

cxl_component_register_init_common() uses a rather odd 'fall through'
mechanism to define each component register set.  This assumes that any
device or capability being added builds on the previous devices
capabilities.  This is not true as there are mutually exclusive
capabilities defined.  For example, downstream ports can not have snoop
but it can have Back Invalidate capable decoders.

Refactor this code to make it easier to add individual capabilities as
defined by a device type.  Any capability which is not specified by the
type is left NULL'ed out which complies with the packed nature of the
register array.

Update all spec references to 3.2.

No functional changes should be seen with this patch.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
[rebased, no RAS for HBs, r3.2 references]
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-component-utils.c   | 75 +++++++++++-----------------------
 include/hw/cxl/cxl_component.h | 33 ++++++++++-----
 2 files changed, 46 insertions(+), 62 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index ce42fa4a2946..a43d227336ca 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -289,32 +289,6 @@ void cxl_component_register_init_common(uint32_t *reg_state,
 {
     int caps = 0;
 
-    /*
-     * In CXL 2.0 the capabilities required for each CXL component are such
-     * that, with the ordering chosen here, a single number can be used to
-     * define which capabilities should be provided.
-     */
-    switch (type) {
-    case CXL2_DOWNSTREAM_PORT:
-    case CXL2_DEVICE:
-        /* RAS, Link */
-        caps = 2;
-        break;
-    case CXL2_UPSTREAM_PORT:
-    case CXL2_TYPE3_DEVICE:
-    case CXL2_LOGICAL_DEVICE:
-        /* + HDM */
-        caps = 3;
-        break;
-    case CXL2_ROOT_PORT:
-    case CXL2_RC:
-        /* + Extended Security, + Snoop */
-        caps = 5;
-        break;
-    default:
-        abort();
-    }
-
     memset(reg_state, 0, CXL2_COMPONENT_CM_REGION_SIZE);
 
     /* CXL Capability Header Register */
@@ -322,11 +296,12 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, VERSION,
         CXL_CAPABILITY_VERSION);
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 1);
-    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 
 #define init_cap_reg(reg, id, version)                                        \
     do {                                                                      \
-        int which = R_CXL_##reg##_CAPABILITY_HEADER;                          \
+        int which = CXL_##reg##_CAP_HDR_IDX;                                  \
+        if (CXL_##reg##_CAP_HDR_IDX > caps)                                   \
+            caps = CXL_##reg##_CAP_HDR_IDX;                                   \
         reg_state[which] = FIELD_DP32(reg_state[which],                       \
                                       CXL_##reg##_CAPABILITY_HEADER, ID, id); \
         reg_state[which] =                                                    \
@@ -337,37 +312,35 @@ void cxl_component_register_init_common(uint32_t *reg_state,
                        CXL_##reg##_REGISTERS_OFFSET);                         \
     } while (0)
 
+    /* CXL r3.2 8.2.4 Table 8-22 */
     switch (type) {
-    case CXL2_DEVICE:
-    case CXL2_TYPE3_DEVICE:
-    case CXL2_LOGICAL_DEVICE:
     case CXL2_ROOT_PORT:
+    case CXL2_RC:
+        /* + Extended Security, + Snoop */
+        init_cap_reg(EXTSEC, 6, 1);
+        init_cap_reg(SNOOP, 8, 1);
+        /* fallthrough */
     case CXL2_UPSTREAM_PORT:
+    case CXL2_TYPE3_DEVICE:
+    case CXL2_LOGICAL_DEVICE:
+        /* + HDM */
+        init_cap_reg(HDM, 5, 1);
+        hdm_init_common(reg_state, write_msk, type);
+        /* fallthrough */
     case CXL2_DOWNSTREAM_PORT:
-    init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
-        ras_init_common(reg_state, write_msk);
+    case CXL2_DEVICE:
+        /* RAS, Link */
+        if (type != CXL2_RC) {
+            init_cap_reg(RAS, 2, 2);
+            ras_init_common(reg_state, write_msk);
+        }
+        init_cap_reg(LINK, 4, 2);
         break;
     default:
-        break;
-    }
-
-    init_cap_reg(LINK, 4, CXL_LINK_CAPABILITY_VERSION);
-
-    if (caps < 3) {
-        return;
-    }
-
-    if (type != CXL2_ROOT_PORT) {
-        init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
-        hdm_init_common(reg_state, write_msk, type);
-    }
-    if (caps < 5) {
-        return;
+        abort();
     }
 
-    init_cap_reg(EXTSEC, 6, CXL_EXTSEC_CAP_VERSION);
-    init_cap_reg(SNOOP, 8, CXL_SNOOP_CAP_VERSION);
-
+    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 #undef init_cap_reg
 }
 
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index b721333cb7aa..cd92cb02532a 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -32,10 +32,20 @@ enum reg_type {
 };
 
 /*
- * Capability registers are defined at the top of the CXL.cache/mem region and
- * are packed. For our purposes we will always define the caps in the same
- * order.
- * CXL r3.1 Table 8-22: CXL_CAPABILITY_ID Assignment for details.
+ * CXL r3.2 - 8.2.4 Table 8-22 and 8-23
+ *
+ * Capability registers are defined at the top of the CXL.cache/mem region.
+ * They are defined to be packed and at variable offsets.  However, NULL
+ * capabilities can be added to the packed array.  To facilitate easier access
+ * within the QEMU code, define these at specified offsets.  Then NULL out any
+ * capabilities for devices which don't (or can't) have a particular capability
+ * (see cxl_component_register_init_common).  NULL capabilities are to be
+ * ignored by software.
+ *
+ * 'offsets' are based on index's which can then be used to report the array
+ * size in CXL Capability Header Register (index/offset 0).
+ *
+ * See CXL r3.2 Table 8-25 for an example of allowing a 'NULL' header.
  */
 
 /* CXL r3.1 Section 8.2.4.1: CXL Capability Header Register */
@@ -46,16 +56,17 @@ REG32(CXL_CAPABILITY_HEADER, 0)
     FIELD(CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 20, 4)
     FIELD(CXL_CAPABILITY_HEADER, ARRAY_SIZE, 24, 8)
 
-#define CXLx_CAPABILITY_HEADER(type, offset)                  \
-    REG32(CXL_##type##_CAPABILITY_HEADER, offset)             \
+#define CXLx_CAPABILITY_HEADER(type, idx)                     \
+    enum { CXL_##type##_CAP_HDR_IDX = idx };                  \
+    REG32(CXL_##type##_CAPABILITY_HEADER, (idx * 0x4))        \
         FIELD(CXL_##type##_CAPABILITY_HEADER, ID, 0, 16)      \
         FIELD(CXL_##type##_CAPABILITY_HEADER, VERSION, 16, 4) \
         FIELD(CXL_##type##_CAPABILITY_HEADER, PTR, 20, 12)
-CXLx_CAPABILITY_HEADER(RAS, 0x4)
-CXLx_CAPABILITY_HEADER(LINK, 0x8)
-CXLx_CAPABILITY_HEADER(HDM, 0xc)
-CXLx_CAPABILITY_HEADER(EXTSEC, 0x10)
-CXLx_CAPABILITY_HEADER(SNOOP, 0x14)
+CXLx_CAPABILITY_HEADER(RAS, 1)
+CXLx_CAPABILITY_HEADER(LINK, 2)
+CXLx_CAPABILITY_HEADER(HDM, 3)
+CXLx_CAPABILITY_HEADER(EXTSEC, 4)
+CXLx_CAPABILITY_HEADER(SNOOP, 5)
 
 /*
  * Capability structures contain the actual registers that the CXL component
-- 
2.39.5


