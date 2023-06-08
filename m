Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF39B72804D
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:43:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7EyS-000397-QY; Thu, 08 Jun 2023 08:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7EyQ-00038D-Cg
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:42 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7EyO-0000HV-NQ
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1686228149; bh=7qAcQKujX3iA3MQ+OMekIMYtdN+3noeO6v2+T7GlelE=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=bbmCR9cJFffonvm9+JBTBFeDqTxpj14smXQ0DcL4gqSDlZ9mdz3q9TCM1yA6Oxxrk
 vkIIj5gQ0MnhkO27zaLEnkIK19UAXKS+D081r4Og3LkuwXT4WdCImK8Ffhexyex1OJ
 hF7RVQlz+3znYDMWLhGirmL0Pe3qJjckcoKof/NPTvAh5i4Iyipmcvs1qO5j+bQnyE
 Lups/JbL5B2exGvz3Ov9hvg32Y0Y9vsU/T4lXlHdyQSLXhxEeXaV3L45PRamTimXVr
 ghrq/Ep4pNqFBLmVl6nOphDpSJI/WhYu8/py4RqkFtC2hc0Xmlj7bZRbrtseJSrMDp
 YQ6Bnun7wZ0DQ==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 62A164A0306;
 Thu,  8 Jun 2023 12:42:27 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v3 13/14] MAINTAINERS: add maintainer of simpletrace.py
Date: Thu,  8 Jun 2023 14:41:46 +0200
Message-Id: <20230608124147.51125-14-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608124147.51125-1-mads@ynddal.dk>
References: <20230608124147.51125-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TfhaSnd5w15HHPg71ya7ea49Ksx8bT-6
X-Proofpoint-ORIG-GUID: TfhaSnd5w15HHPg71ya7ea49Ksx8bT-6
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=889 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1030 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2306080110
Received-SPF: pass client-ip=17.58.6.42; envelope-from=mads@ynddal.dk;
 helo=pv50p00im-zteg10011501.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index 436b3f0afe..dd09bbdab6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3135,6 +3135,7 @@ F: stubs/
 
 Tracing
 M: Stefan Hajnoczi <stefanha@redhat.com>
+R: Mads Ynddal <mads@ynddal.dk>
 S: Maintained
 F: trace/
 F: trace-events
@@ -3147,6 +3148,11 @@ F: docs/tools/qemu-trace-stap.rst
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


