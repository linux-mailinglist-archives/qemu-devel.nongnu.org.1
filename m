Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B578533C
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:56:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjeN-0005Eo-7y; Wed, 23 Aug 2023 04:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYje6-0004t4-Sd
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:55:24 -0400
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYje3-0000CH-Te
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1692780908; bh=GO5SwThOEmujCtZHTQiwWv3gNgM24dsJJCUk62NRIOE=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=KDTEWFLgTc4L9unBjPIJw6qRjzHUdz0/SULCZIzwUzJBkyaNryy8V5nXDzWZX4blZ
 uKjACb13iMJahRzlzklMbUNZkPJJrJ/J/HBs9uX9LUawaIbQaH+fZRzt5KiAcAN9sK
 RLxo7ViNbD/dfTwWbflgZYLMUu/P2pb51XSzyeRF1RI1ctMJLltIpYOzwZsnPWgEVA
 f8FCIO1POpYqSjQ3xXrdMjRwsxHgLa9lXavwM0wXzkSKt0KshGI9pi/Pkn77w8YPqU
 udx8HhexdqwNXZn38IkADk3OuRGDIIpb/MdlLN44++VP21rScsIyAtqxXBm92ZbuHp
 yUaSSD/7fan2g==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 01D923A0A27;
 Wed, 23 Aug 2023 08:55:06 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v4 13/14] MAINTAINERS: add maintainer of simpletrace.py
Date: Wed, 23 Aug 2023 10:54:28 +0200
Message-Id: <20230823085429.20519-14-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230823085429.20519-1-mads@ynddal.dk>
References: <20230823085429.20519-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Kjx1VVzRcwp7ClD0nIZKR-b_OnO2CUra
X-Proofpoint-GUID: Kjx1VVzRcwp7ClD0nIZKR-b_OnO2CUra
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=875 clxscore=1030 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2308230080
Received-SPF: pass client-ip=17.58.6.54; envelope-from=mads@ynddal.dk;
 helo=pv50p00im-tydg10021701.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

From: Mads Ynddal <m.ynddal@samsung.com>

In my work to refactor simpletrace.py, I noticed that there's no
maintainer of it, and has the status of "odd fixes". I'm using it from
time to time, so I'd like to maintain the script.

I've added myself as reviewer under "Tracing" to be informed of changes
that might affect simpletrace.py.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6111b6b4d9..2ffb608dec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3162,6 +3162,7 @@ F: stubs/
 
 Tracing
 M: Stefan Hajnoczi <stefanha@redhat.com>
+R: Mads Ynddal <mads@ynddal.dk>
 S: Maintained
 F: trace/
 F: trace-events
@@ -3174,6 +3175,11 @@ F: docs/tools/qemu-trace-stap.rst
 F: docs/devel/tracing.rst
 T: git https://github.com/stefanha/qemu.git tracing
 
+Simpletrace
+M: Mads Ynddal <mads@ynddal.dk>
+S: Maintained
+F: scripts/simpletrace.py
+
 TPM
 M: Stefan Berger <stefanb@linux.ibm.com>
 S: Maintained
-- 
2.38.1


