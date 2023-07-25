Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 060AF7621BA
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:44:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMxC-0000VO-Lf; Tue, 25 Jul 2023 14:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qOMx0-0000TB-Im
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:40:03 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qOMwx-0000hT-JT
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:40:02 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20230725183957usoutp02992d3e7833220993797a76ffc7065698~1MFm_HMsM1493214932usoutp02K;
 Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20230725183957usoutp02992d3e7833220993797a76ffc7065698~1MFm_HMsM1493214932usoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1690310397;
 bh=C4aTzaNtGHKVgJ50XEww+sc4KO9zZq8bdfgSZbWIqXU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=qCWsGCcCps00iBHu+0uDI7lp9CdENBOf54X8Vz3bjQZSrZQzzjyAto1JA2TwPYKKt
 J3KcB84On9U6sm1lHeW0v7cNxQwWiXikUom5fMb1vx3YCT8TFWCqsOkSUSEqVoot0E
 tf13H0UoEOkq/ydkVWt/lTRULvt5B7BeecwnQiv0=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
 [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230725183957uscas1p24667bdb00d268b3f78f7e2be57002365~1MFm2bFYY1972119721uscas1p2r;
 Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges3new.samsung.com (USCPEMTA) with SMTP id C7.4E.62237.CF610C46; Tue,
 25 Jul 2023 14:39:56 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
 [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230725183956uscas1p17a64ec512cdf5b9348451926d6f0b224~1MFmdxFht0903609036uscas1p1u;
 Tue, 25 Jul 2023 18:39:56 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-90-64c016fc8161
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
 ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id A3.83.44215.CF610C46; Tue,
 25 Jul 2023 14:39:56 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Tue, 25 Jul 2023 11:39:55 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
 25 Jul 2023 11:39:55 -0700
From: Fan Ni <fan.ni@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
 "cbrowy@avery-design.com" <cbrowy@avery-design.com>, "ira.weiny@intel.com"
 <ira.weiny@intel.com>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, Adam Manzanares <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>, "nmtadam.samsung@gmail.com"
 <nmtadam.samsung@gmail.com>, "nifan@outlook.com" <nifan@outlook.com>, Fan Ni
 <fan.ni@samsung.com>
Subject: [Qemu PATCH v2 1/9] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size
 field to output payload of identify memory device command
Thread-Topic: [Qemu PATCH v2 1/9] hw/cxl/cxl-mailbox-utils: Add
 dc_event_log_size field to output payload of identify memory device command
Thread-Index: AQHZvydoRKWfeAB5G06EOZO9oxzjmQ==
Date: Tue, 25 Jul 2023 18:39:55 +0000
Message-ID: <20230725183939.2741025-2-fan.ni@samsung.com>
In-Reply-To: <20230725183939.2741025-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djX87p/xA6kGCzbbWHRfX4Do8X0qRcY
 LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
 YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
 WWqRvl0CV8b6Q7sYC27zVvT92s/ewNjL3cXIySEhYCKxY1kHaxcjF4eQwEpGiaX3prNDOK1M
 ElNb/rLBVE18P4MdxBYSWMsoMWlWFETRJ0aJrjN/WSCcZYwSra2nWUGq2AQUJfZ1bQfrFhEw
 ljh2eAkzSBGzwFsWiY9r3oB1CAt0MEoce/MVLCMi0MsosXDWG2aIFj2JeVPXs4DYLAKqEh0r
 dzCB2LwClhK/z20GO4RTwEri2ZfZYOsYBcQkvp9aA1bDLCAucevJfCaIwwUlFs3ewwxhi0n8
 2/UQ6iF5ick/ZkDZihL3v79kh+jVk7gxdQobhK0tsWzha2aIvYISJ2c+YYGol5Q4uOIG2AcS
 AtM5JSY2/INa5iLRsegJI4QtLfH37jKgOAeQnSyx6iMXRDhHYv6SLVBzrCUW/lnPNIFRZRaS
 s2chOWMWkjNmITljASPLKkbx0uLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMAUd/rf4YIdjLdu
 fdQ7xMjEwXiIUYKDWUmE1zBmX4oQb0piZVVqUX58UWlOavEhRmkOFiVxXkPbk8lCAumJJanZ
 qakFqUUwWSYOTqkGpqztsjPeZs1jVxCcpT/rzYzqzzc1HJodBVX2nlhnVRC0LfNyWVlZ18QA
 m5//fHUqmF0ObIxs9/bcJfXt3OkVSn8+ndLPiJcU5j3ZKebaemNr5tZJlvNW9rSsNfB0ncma
 9OXpfRlX1rdZhVwB1+d67E9cvW/xxm1lqwQdWPMOhC6fMPeLNwvbi9qImZPOXNx9rejAgYQJ
 1Q2ykb3tIa4ZtwL1F4lZ87H/O8B4ub1tpuQ57wafOX9XbxTq3B931XaGkPDbkNtMbadll/ml
 VrR23vZ9/GB64TxTFvFfp7lTXT1En/8WSvb0Z7e9sG/K+oLlZ1NO+iwvv7NqJn/czlof+Ssh
 bv78/0x7+LpLPv9+pcRSnJFoqMVcVJwIAEdHWNPgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWS2cA0UfeP2IEUg+nPZC26z29gtJg+9QKj
 xeqbaxgtGpoesVi07H7PZLH/6XMWi1ULr7FZnJ91isXi+cTnTBZLlzxitjjeu4PFgdvjwuQJ
 rB6LG1w9ds66y+7RcuQtkLfnJZPHxo//2T2eXNvM5LH59Qtmj6mz6z0+b5IL4IrisklJzcks
 Sy3St0vgylh/aBdjwW3eir5f+9kbGHu5uxg5OSQETCQmvp/B3sXIxSEksJpRou/vcijnE6PE
 9fM/mCGcZYwSiw8vYAdpYRNQlNjXtZ0NxBYRMJY4dngJM4jNLPCaReLbRW6QBmGBDkaJY2++
 MkMU9TJKNF4whbD1JOZNXc8CYrMIqEp0rNzBBGLzClhK/D63GWgBB9A2S4mtE+NAwpwCVhLP
 vsxmBbEZBcQkvp9awwSxS1zi1pP5TBAvCEgs2XOeGcIWlXj5+B8rhC0vMfnHDDYIW1Hi/veX
 7BC9ehI3pk5hg7C1JZYtfM0McYKgxMmZT1gg6iUlDq64wTKBUWIWknWzkLTPQtI+C0n7AkaW
 VYzipcXFuekVxUZ5qeV6xYm5xaV56XrJ+bmbGIGp4fS/w9E7GG/f+qh3iJGJg/EQowQHs5II
 r2HMvhQh3pTEyqrUovz4otKc1OJDjNIcLErivC+jJsYLCaQnlqRmp6YWpBbBZJk4OKUamHgm
 fd9z7/+NZcxrfwSsNd3eorZ9gessoW8SHK0vG6LnzbUWFtlu7nPWS1cs4Mj60/cz3/c5zPVr
 OhRteXmPs9L+7Q4aUd6T01bNm5OfupLNOIBxS/yau44TBcxVAmdViaZyrbGYxu//rYv74J1b
 jHHc37gyK3QmGC+dnlBw6fWcrcbX/3X1z3mq5SAU9oSlveF8Q81Xs5fZl+c46l6tY42ecPPG
 5kl+/w7PvdEVs+dP8dqS571XnYw2eUpOyVu+8zbvJO9+o6Zpl4w39Fjvf2Nvynnsw5zlE/zZ
 N1Qddym+N6cm6emWF+afrvpdlPHSLEgz8k6TO2C06RWH2Y/vLrbla18d+XVJznpdoti+3f+U
 WIozEg21mIuKEwF9Cw0WfAMAAA==
X-CMS-MailID: 20230725183956uscas1p17a64ec512cdf5b9348451926d6f0b224
CMS-TYPE: 301P
X-CMS-RootMailID: 20230725183956uscas1p17a64ec512cdf5b9348451926d6f0b224
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183956uscas1p17a64ec512cdf5b9348451926d6f0b224@uscas1p1.samsung.com>
Received-SPF: pass client-ip=211.189.100.12; envelope-from=fan.ni@samsung.com;
 helo=mailout2.w2.samsung.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fan Ni <nifan@outlook.com>

Based on CXL spec 3.0 Table 8-94 (Identify Memory Device Output
Payload), dynamic capacity event log size should be part of
output of the Identify command.
Add dc_event_log_size to the output payload for the host to get the info.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ad7a6116e4..b013e30314 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -21,6 +21,8 @@
 #include "sysemu/hostmem.h"
=20
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
+/* Experimental value: dynamic capacity event log size */
+#define CXL_DC_EVENT_LOG_SIZE 8
=20
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -519,8 +521,9 @@ static CXLRetCode cmd_identify_memory_device(struct cxl=
_cmd *cmd,
         uint16_t inject_poison_limit;
         uint8_t poison_caps;
         uint8_t qos_telemetry_caps;
+        uint16_t dc_event_log_size;
     } QEMU_PACKED *id;
-    QEMU_BUILD_BUG_ON(sizeof(*id) !=3D 0x43);
+    QEMU_BUILD_BUG_ON(sizeof(*id) !=3D 0x45);
=20
     CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dstate=
);
     CXLType3Class *cvc =3D CXL_TYPE3_GET_CLASS(ct3d);
@@ -543,6 +546,7 @@ static CXLRetCode cmd_identify_memory_device(struct cxl=
_cmd *cmd,
     st24_le_p(id->poison_list_max_mer, 256);
     /* No limit - so limited by main poison record limit */
     stw_le_p(&id->inject_poison_limit, 0);
+    stw_le_p(&id->dc_event_log_size, CXL_DC_EVENT_LOG_SIZE);
=20
     *len =3D sizeof(*id);
     return CXL_MBOX_SUCCESS;
--=20
2.25.1

