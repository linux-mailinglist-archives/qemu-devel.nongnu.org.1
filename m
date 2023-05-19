Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B72E4709AAE
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:57:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01RN-0000Dv-Cr; Fri, 19 May 2023 10:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01RF-0008LO-TU
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01RE-0003YY-1k
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qFEsG82wdcWBrLH5mCcaWx1bEyowhZDMRDdFEaHzCA8=;
 b=QPJ5HVCPq6mp7Dhkc2fQn39GoZJbGs0mxLnDJdcJlvY2CPrTOudcGpW0oqKxdLW4vHxi/c
 nEmQ1P0P1m/1htkEmdT70VzgP7astKHjFoQMoZzAb3kEzDoGqSgBuLAqstVyy1Om8sOwFJ
 ULdHYyAKeJ5NqQwA1GNYnKc9ieNUhBI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-v7qOT5QnMh2OcJAlmnqWYA-1; Fri, 19 May 2023 10:50:25 -0400
X-MC-Unique: v7qOT5QnMh2OcJAlmnqWYA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af27fa8bf2so2438261fa.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507824; x=1687099824;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFEsG82wdcWBrLH5mCcaWx1bEyowhZDMRDdFEaHzCA8=;
 b=W9yP66yQTJcJu8msiTbTknpMAzqHzBwHl39xdkB+uC+DeoE0iqu7lhq1r377StGFYI
 7nh+vlV85u1PBRyuK3vukcqUhoBaOn9NAaChy12UGjP9sm6vRLreP/xJg2mP5CHQhLTe
 p8gV0ityOzBpmggubjZyy6NpR8HZCtFbO1SkZw+pb8e3zah/wF+GVZxCios21MZltpqT
 0lgGB/fCfob7EGsJR5OXyNEEzed1fAWLVOlxON0Wg6rgjDOoxq0GG0u1CJm62i4+kamP
 eWKJUNZkX3hmZHeq/YcZTWLul/9dm/y2tC+z1JXr6USDfGsIvZmDo5jTNrTl+4ziraEm
 zngQ==
X-Gm-Message-State: AC+VfDxtHfsnWqt9JUeznXZF6FMqH24aTAcYmsqXufSV2Xe0wYEynGN6
 Qh9t6ozvBmWkVVH3H74iaCP5jOvDoSxMyfEdWIfr8VGCFC9Z3vEOOCDFpYfxNJPy9usm/4EmGvb
 S1/Qu++2xAY6f6MYx/SVUdV09/ZqEL5Zxb1KylKC/ylgE8fPnuj61aN+SULdd3tckJloZ
X-Received: by 2002:ac2:5991:0:b0:4f3:940d:abc with SMTP id
 w17-20020ac25991000000b004f3940d0abcmr869544lfn.0.1684507824022; 
 Fri, 19 May 2023 07:50:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5n78MbVsxkWFsyu5rNdlpOSNk1bhknnKewoxEIrWN4dnDxl/oXonOddY2S7c9OUSzSgFhd8A==
X-Received: by 2002:ac2:5991:0:b0:4f3:940d:abc with SMTP id
 w17-20020ac25991000000b004f3940d0abcmr869534lfn.0.1684507823752; 
 Fri, 19 May 2023 07:50:23 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 a6-20020a19f806000000b004f13bd73419sm631452lff.38.2023.05.19.07.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:50:23 -0700 (PDT)
Date: Fri, 19 May 2023 10:50:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Dave Jiang <dave.jiang@intel.com>
Subject: [PULL 09/40] hw/cxl: Fix incorrect reset of commit and associated
 clearing of committed.
Message-ID: <823371a630599346fd04d541f19b52e72ee84f7e.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The hardware clearing the commit bit is not spec compliant.
Clearing of committed bit when commit is cleared is not specifically
stated in the CXL spec, but is the expected (and simplest) permitted
behaviour so use that for QEMU emulation.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
v2: Picked up tags.
Message-Id: <20230421135906.3515-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-component-utils.c |  6 +++++-
 hw/mem/cxl_type3.c           | 21 ++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index a3e6cf75cf..378f1082ce 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -38,19 +38,23 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
     ComponentRegisters *cregs = &cxl_cstate->crb;
     uint32_t *cache_mem = cregs->cache_mem_registers;
     bool should_commit = false;
+    bool should_uncommit = false;
 
     switch (offset) {
     case A_CXL_HDM_DECODER0_CTRL:
         should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
+        should_uncommit = !should_commit;
         break;
     default:
         break;
     }
 
     if (should_commit) {
-        value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
         value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, ERR, 0);
         value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
+    } else if (should_uncommit) {
+        value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, ERR, 0);
+        value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
     }
     stl_le_p((uint8_t *)cache_mem + offset, value);
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a2a9b17dbb..1bd5963a3f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -320,13 +320,28 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
 
     ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
     /* TODO: Sanity checks that the decoder is possible */
-    ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
 
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
 }
 
+static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
+{
+    ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
+    uint32_t *cache_mem = cregs->cache_mem_registers;
+    uint32_t ctrl;
+
+    assert(which == 0);
+
+    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
+
+    ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
+    ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
+
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
+}
+
 static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
 {
     switch (qmp_err) {
@@ -395,6 +410,7 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     CXLType3Dev *ct3d = container_of(cxl_cstate, CXLType3Dev, cxl_cstate);
     uint32_t *cache_mem = cregs->cache_mem_registers;
     bool should_commit = false;
+    bool should_uncommit = false;
     int which_hdm = -1;
 
     assert(size == 4);
@@ -403,6 +419,7 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     switch (offset) {
     case A_CXL_HDM_DECODER0_CTRL:
         should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
+        should_uncommit = !should_commit;
         which_hdm = 0;
         break;
     case A_CXL_RAS_UNC_ERR_STATUS:
@@ -489,6 +506,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     stl_le_p((uint8_t *)cache_mem + offset, value);
     if (should_commit) {
         hdm_decoder_commit(ct3d, which_hdm);
+    } else if (should_uncommit) {
+        hdm_decoder_uncommit(ct3d, which_hdm);
     }
 }
 
-- 
MST


