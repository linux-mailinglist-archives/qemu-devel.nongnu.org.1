Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA8AA396B3
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Feb 2025 10:16:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkJgm-0005zV-ID; Tue, 18 Feb 2025 04:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1tkJgk-0005zL-7i
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:14:46 -0500
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1tkJgh-0006i3-Gg
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:14:45 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250218091439epoutp028bdf84066a88c38abe13ff4a7f01192e~lQp5oHwTN0422904229epoutp023
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 09:14:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250218091439epoutp028bdf84066a88c38abe13ff4a7f01192e~lQp5oHwTN0422904229epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1739870079;
 bh=gHk47WkdjRMpnw9X1G6b5rg5LeOUBZ63AxW9kQQLUXs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bieSt+oKz5RM53uVw3fU05CSWVwrVR4mE5U3Q+c8u9iTHhkZDbb0tEWFep1Tojfyp
 nH6RONPG8Uar9GAXA9ALbogT3uGQXeid4bQDawmIeEvea6rVtqD8RmT/pQvxql4EWe
 407OnRQaUybofi0lvjKDdKoBgXj42LXAQEL/fzzg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20250218091438epcas5p2339b29e9e3ebcfc6c8225a9014fc42ef~lQp5TIdpr1780817808epcas5p26;
 Tue, 18 Feb 2025 09:14:38 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Yxv3w63dXz4x9Q5; Tue, 18 Feb
 2025 09:14:36 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 AF.EF.20052.A7F44B76; Tue, 18 Feb 2025 18:14:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20250218085814epcas5p384be512f40b0add05588d2242e2f0061~lQbkOv20p1166411664epcas5p3v;
 Tue, 18 Feb 2025 08:58:14 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250218085814epsmtrp1f598abc3712ed38a7ba98ac5f818d821~lQbkMi3Rz0197301973epsmtrp1h;
 Tue, 18 Feb 2025 08:58:14 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-1b-67b44f7a28b6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 1E.E6.23488.5AB44B76; Tue, 18 Feb 2025 17:58:13 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250218085812epsmtip1d927f54b63ac638f9f6c5add6d28ca93~lQbiutfID0756307563epsmtip1L;
 Tue, 18 Feb 2025 08:58:12 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
 <arpit1.kumar@samsung.com>
Subject: [PATCH v2 3/3] hw/cxl/cxl-mailbox-utils.c: Added support for
 Populate Log (Opcode 0404h)
Date: Tue, 18 Feb 2025 14:27:31 +0530
Message-Id: <20250218085731.550029-4-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218085731.550029-1-arpit1.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmum6V/5Z0g10z9SymH1a0+HJ6D5tF
 7+IlrBarb65htLh5YCeTxcKNy5gszs86xWLxd9teRovjvTtYgNw57A5cHjtn3WX3eHJtM5NH
 35ZVjB5TZ9d7fN4kF8AalW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
 aqvk4hOg65aZA3STkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQv
 XS8vtcTK0MDAyBSoMCE749mj38wF34UrunffYGlgPMvbxcjJISFgInHs8n3mLkYuDiGB3YwS
 K/6fY4FwPjFKvHqzkxXC+cYoMbvzHyNMy9LjJ5ggEnsZJRZ+3QzV0sAk0d66jQmkik1AR+L8
 7blsILaIgKTE767TYEuYBd4wSjy4uoAZJCEskCzR8noxO4jNIqAqcenLH6AVHBy8AnYSH7dm
 Q2yTl9h/8CxYOaeAvcTt99/BynkFBCVOznzCAmIzA9U0b50NNl9CoJFD4t72+8wQzS4Ss/a/
 ZoWwhSVeHd/CDmFLSbzsb4OysyX+zG9ng7ALJBb9nAkVt5doPdXPDHIPs4CmxPpd+hBhWYmp
 p9YxQezlk+j9/YQJIs4rsWMejK0m0b5jPtQYGYk3vxZDjfeQmHvvMNg5QgKTGCVmnC6cwKgw
 C8k7s5C8Mwth8wJG5lWMkqkFxbnpqcWmBYZ5qeXwWE7Oz93ECE6nWp47GO8++KB3iJGJg/EQ
 owQHs5II76GuDelCvCmJlVWpRfnxRaU5qcWHGE2BwT2RWUo0OR+Y0PNK4g1NLA1MzMzMTCyN
 zQyVxHmbd7akCwmkJ5akZqemFqQWwfQxcXBKNTAJColsVYta8PrslXOb5h/7/ny9dfG227p7
 5e5eV/gYNEvlUkytsLvTe7V5pnd+bYkTEHrO3RO2TZZJkfO0+7nCVcdUuSUnTNer2yi/2qam
 lmtZzEaLm9/qDv49UPt6a8ED5q3elxIatzpa70tiur12m3vnvHqxyEb5yO7KqGKBvzpHRIpW
 R5b62mxzW73G0PCt2VXdIhYjEyGBddntPCZvOl5wGgrEmi9Ycbf79ZUcs4Bmx6rXx12f9zYs
 rRY6vHaauM0B+/DV0SVOj2epnvwqel5rQVubg9jx87qf7OfMaL4buPfU/krLiW8CL93Mln7s
 vV3yVOqP1IuyPtosUxjt/jMV259pqFM9fabwYJESS3FGoqEWc1FxIgABLz4KMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSnO5S7y3pBjdOW1tMP6xo8eX0HjaL
 3sVLWC1W31zDaHHzwE4mi4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu8eTaZiaP
 vi2rGD2mzq73+LxJLoA1issmJTUnsyy1SN8ugSvj2aPfzAXfhSu6d99gaWA8y9vFyMkhIWAi
 sfT4CaYuRi4OIYHdjBIXF39ih0jISFyc+ZgFwhaWWPnvOTtE0T9GiXVNHxhBEmwCOhLnb89l
 A7FFBCQlfnedZgYpYhb4xigx59YL1i5GDg5hgUSJHbskQGpYBFQlLn35wwgS5hWwk/i4NRti
 vrzE/oNnmUFsTgF7idvvv4PdIARUsqHrL9gqXgFBiZMzn4DdwwxU37x1NvMERoFZSFKzkKQW
 MDKtYpRMLSjOTc9NNiwwzEst1ytOzC0uzUvXS87P3cQIDnctjR2M77416R9iZOJgPMQowcGs
 JMJ7qGtDuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHelYYR6UIC6YklqdmpqQWpRTBZJg5OqQYm
 n+DD599uLXOaOOmMce/J4uM/dT0T/quv2KaQO1/OKTE3o6PuVcbtSVY1C3kvH/4S1vFx2ox1
 F8/qXtptzdOXoLLc/K7eudkSG1+UqD64UiGUHO5t/KMhyjEpMy7Uo9rCnnU5u4Trnr0vXd88
 mNjLp7uklOXCujULM73nX1f/c/VC+1kL0xVJ9TUa/CZPO0xS4ryfqK1ev2HGvA+SZ/e3lnJV
 Wp3WUd7s7P7ha5pVf2Yjs3JQ/HFHq8dn5MuNpguaruB4elpt0++YXyarp6sX765Q5Ha4ENFW
 7MLx0J2XfUnfvImVO11N9lf6hLSxlEbY88aK6/VZlZd1HpMM/bi7fiGziuJRmfOPZi/ae0mJ
 pTgj0VCLuag4EQDCg5lr5gIAAA==
X-CMS-MailID: 20250218085814epcas5p384be512f40b0add05588d2242e2f0061
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250218085814epcas5p384be512f40b0add05588d2242e2f0061
References: <20250218085731.550029-1-arpit1.kumar@samsung.com>
 <CGME20250218085814epcas5p384be512f40b0add05588d2242e2f0061@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

CXL spec 3.2 section 8.2.10.5.5 describes populate log.
It populates the contents of the specified log and can run
as a background operation.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1caee3f058..b41b70a790 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -78,6 +78,7 @@ enum {
         #define GET_LOG       0x1
         #define GET_LOG_CAPABILITIES   0x2
         #define CLEAR_LOG     0x3
+        #define POPULATE_LOG  0x4
     FEATURES    = 0x05,
         #define GET_SUPPORTED 0x0
         #define GET_FEATURE   0x1
@@ -1138,6 +1139,30 @@ static CXLRetCode cmd_logs_clear_log(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 Section 8.2.10.5.5: Populate log (Opcode 0404h) */
+static CXLRetCode cmd_logs_populate_log(const struct cxl_cmd *cmd,
+                                        uint8_t *payload_in,
+                                        size_t len_in,
+                                        uint8_t *payload_out,
+                                        size_t *len_out,
+                                        CXLCCI *cci)
+{
+    const CXLLogCapabilities *cap;
+    struct {
+        QemuUUID uuid;
+    } QEMU_PACKED QEMU_ALIGNED(8) * populate_log = (void *)payload_in;
+
+    cap = find_log_index(&populate_log->uuid, cci);
+    if (!cap) {
+        return CXL_MBOX_INVALID_LOG;
+    }
+
+    if (!(cap->param_flags & CXL_LOG_CAP_POPULATE_SUPPORTED)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    return CXL_MBOX_UNSUPPORTED;
+}
+
 /* CXL r3.1 section 8.2.9.6: Features */
 /*
  * Get Supported Features output payload
@@ -2907,6 +2932,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
                                      cmd_logs_get_log_capabilities, 0x10, 0 },
     [LOGS][CLEAR_LOG] = { "LOGS_CLEAR_LOG", cmd_logs_clear_log, 0x10,
                           CXL_MBOX_IMMEDIATE_LOG_CHANGE},
+    [LOGS][POPULATE_LOG] = { "LOGS_POPULATE_LOG", cmd_logs_populate_log, 0x10,
+                             (CXL_MBOX_IMMEDIATE_LOG_CHANGE |
+                              CXL_MBOX_BACKGROUND_OPERATION)},
     [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
                                   cmd_features_get_supported, 0x8, 0 },
     [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
-- 
2.34.1


