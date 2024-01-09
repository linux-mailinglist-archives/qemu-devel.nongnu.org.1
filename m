Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F0D827DD7
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 05:31:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN3ky-00054b-11; Mon, 08 Jan 2024 23:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1rN1sX-0000mY-Hv
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 21:30:09 -0500
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1rN1sS-0007iF-Nl
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 21:30:09 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240109022955epoutp0309c61564a1af783d82bb760885ab3bd8~ojOnv1_0h2416524165epoutp031
 for <qemu-devel@nongnu.org>; Tue,  9 Jan 2024 02:29:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240109022955epoutp0309c61564a1af783d82bb760885ab3bd8~ojOnv1_0h2416524165epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1704767395;
 bh=a7/1URsyASyYPXK/mb9Do6V32dB33UOBZcMFHu65fnE=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=lGD5rI1RrSIiLoVG0hAlh01xgJRFr9QERkyeUZo8+A4ctUF4guBcIhhzl78KYD5wd
 H+eNJRE4bN7HnaJOjbwsHxgi1wZYCAdaipibE34arr2P4OLyvuoh9DTf6Tq7ynMJAR
 Ttl3Ozh8xsLH9No/8VOdgSrPoIQ/twozormHCr3I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20240109022955epcas2p4bd1312f484ae48fb49a8492a2aea1325~ojOnfPgIE2859528595epcas2p4K;
 Tue,  9 Jan 2024 02:29:55 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4T8FJL388Qz4x9Px; Tue,  9 Jan
 2024 02:29:54 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-ea-659cafa204af
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 C6.DA.10006.2AFAC956; Tue,  9 Jan 2024 11:29:54 +0900 (KST)
Mime-Version: 1.0
Subject: hw: nvme: Separate 'serial' property for VFs
From: Minwoo Im <minwoo.im@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>, Minwoo Im
 <minwoo.im@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240109022953epcms2p54550dcfc9f831a515206513ae98e7511@epcms2p5>
Date: Tue, 09 Jan 2024 11:29:53 +0900
X-CMS-MailID: 20240109022953epcms2p54550dcfc9f831a515206513ae98e7511
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmqe6i9XNSDa6sELT41clt8ez0AWaL
 4707WCzmL93J4sDisXPWXXaPJ9c2M3n0bVnFGMAclW2TkZqYklqkkJqXnJ+SmZduq+QdHO8c
 b2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKr
 lFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsexhTcElnopd+1exNDDe5exi5OSQEDCR
 6H7SwNLFyMUhJLCDUWLS3lmsXYwcHLwCghJ/dwiD1AgLmEp8mv+eBSQsJCAv8eOVAURYU+Ld
 7jOsIDabgLpEw9RXLCC2iICxxLHDS5hBRjILTGSU6OjsYIXYxSsxo/0pC4QtLbF9+VZGCFtD
 4seyXmYIW1Ti5uq37DD2+2PzoWpEJFrvnYWqEZR48HM3VFxKYv/8uVB2tUTD8WdMEHaFxK/3
 D6DqzSV+398NdgOvgK/EtbfrwX5hEVCVeDHdC6LERWL61TVsIDYz0Ivb385hBilhBvpx/S59
 EFNCQFniyC0WiAo+iY7Df9lhntox7wnUUmWJj4cOQS2VlFh+6TUbhO0hsXfefrC4kECgxJdl
 +9knMCrMQgTzLCR7ZyHsXcDIvIpRLLWgODc9tdiowBAescn5uZsYwYlOy3UH4+S3H/QOMTJx
 MB5ilOBgVhLhlZwxO1WINyWxsiq1KD++qDQntfgQoynQwxOZpUST84GpNq8k3tDE0sDEzMzQ
 3MjUwFxJnPde69wUIYH0xJLU7NTUgtQimD4mDk6pBqZVMZ6LTlp+F3BL3b/y8H/NNfZHT+9J
 /rUpeX/NAe2FCbkXqrjCrnn9vbQ+csFzrcM3owS4V6yW5Lt3dfofdkae3OuRdlE2VgFnNiXn
 fPupdC2Lq5t36+O8byb3RLdNVz7OFcSbP4NHwzFDY3nd9fDe7f8n1kxdq7h3eemnc383bDed
 wHNOk983cu6T9kJ3hy+1vivvtT4RfOB4/Mqj3YIqeyRqXExXGCiflhWbnLN81axtyjIvasxr
 rgVPOJXvsI7xqZXA1RuMJVe23Ole9vCzx72ZKwXM5TxdTOvfR515JPd2ltikBdILHr6SevGi
 0uLSrkvf7h9W51wVKeQ7meXVy5f72PcXM7dcUSnjiXk9TYmlOCPRUIu5qDgRAJTPZAD9AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240109022953epcms2p54550dcfc9f831a515206513ae98e7511
References: <CGME20240109022953epcms2p54550dcfc9f831a515206513ae98e7511@epcms2p5>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=minwoo.im@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 08 Jan 2024 23:30:25 -0500
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
Reply-To: minwoo.im@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Currently, when a VF is created, it uses the 'params' object of the PF
as it is. In other words, the 'params.serial' string memory area is
also shared. In this situation, if the VF is removed from the system,
the PF's 'params.serial' object is released with object_finalize()
followed by object_property_del_all() which release the memory for
'serial' property. If that happens, the next VF created will inherit
a serial from a corrupted memory area.

If this happens, an error will occur when comparing subsys->serial and
n->params.serial in the nvme_subsys_register_ctrl() function.

Cc: qemu-stable@nongnu.org
Fixes: 44c2c09488db ("hw/nvme: Add support for SR-IOV")
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/nvme/ctrl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e..a0ba3529cd 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8309,9 +8309,15 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     if (pci_is_vf(pci_dev)) {
         /*
          * VFs derive settings from the parent. PF's lifespan exceeds
-         * that of VF's, so it's safe to share params.serial.
+         * that of VF's.
          */
         memcpy(&n->params, &pn->params, sizeof(NvmeParams));
+
+        /*
+         * Set PF's serial value to a new string memory to prevent 'serial'
+         * property object release of PF when a VF is removed from the system.
+         */
+        n->params.serial = g_strdup(pn->params.serial);
         n->subsys = pn->subsys;
     }
 
-- 
2.34.1

