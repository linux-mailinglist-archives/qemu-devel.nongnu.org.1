Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD7472804B
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:43:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Exo-0002nY-Kf; Thu, 08 Jun 2023 08:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Exm-0002n9-Jt
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:02 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Exl-00009D-22
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1686228119; bh=LDRzB8NZ046ueAIigp31NIDUT523AGKGB/KGni40fIc=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=AzHk3s4LQkkUbK59q7onxOjYQCVpT2XFXFq++QtFVR3vivKfTxkVbN1gmTstSO1Sq
 sKVeL/1J2jHb/0SEHfi9T5fAi2q0yVAp67sQT8MU0XL9aSYdySyVd92d14EFFRos6x
 XchaPAjSV0aLu65yfD5SlkxpexubKicQMxz+fzl+Q+4xF40ss7bOC6YZgo5Dn2DfF9
 xMNfcKuYkB6mw9PsWR/2ogRs6nL+4Z5FNbIS8CDS32GY8RK4Eozgp0idKw/LxillbY
 TI/ET/9vvyujyEgSIXgMI9v80d8t522b6F0XOPaI77YPouYzh9ggtwR9A2BpuHl/px
 goyCM9J/65MVQ==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 9CB464A03A3;
 Thu,  8 Jun 2023 12:41:57 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v3 02/14] simpletrace: annotate magic constants from QEMU code
Date: Thu,  8 Jun 2023 14:41:35 +0200
Message-Id: <20230608124147.51125-3-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608124147.51125-1-mads@ynddal.dk>
References: <20230608124147.51125-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: w4o9l7lFX98ayaPerg3GkWTMmMOFLID0
X-Proofpoint-ORIG-GUID: w4o9l7lFX98ayaPerg3GkWTMmMOFLID0
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=330 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
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

It wasn't clear where the constants and structs came from, so I added
comments to help.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 scripts/simpletrace.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index b221d9a241..5c230a1b74 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -16,6 +16,11 @@
 
 __all__ = ['Analyzer', 'process', 'run']
 
+# This is the binary format that the QEMU "simple" trace backend
+# emits. There is no specification documentation because the format is
+# not guaranteed to be stable. Trace files must be parsed with the
+# same trace-events-all file and the same simpletrace.py file that
+# QEMU was built with.
 header_event_id = 0xffffffffffffffff
 header_magic    = 0xf2b177cb0aa429b4
 dropped_event_id = 0xfffffffffffffffe
-- 
2.38.1


