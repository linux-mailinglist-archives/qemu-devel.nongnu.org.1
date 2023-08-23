Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A1D78533B
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjdV-0003r4-MX; Wed, 23 Aug 2023 04:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjdT-0003qk-LE
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:54:43 -0400
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjdS-00087Q-7J
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1692780880; bh=LDRzB8NZ046ueAIigp31NIDUT523AGKGB/KGni40fIc=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=G/CYibv+LSvWZ96R0XtfVsV9nzVxzkuSkXU2roLKPapif2d41n5iGdj3zx8QSo+MU
 un4sNYKNUdWFV1m2iU3v38510U1k/qw1Pi9VCQXn+a6ovKiMewd/eJx9zYGZCJTCk5
 1MfCl0H8ehRGTs9PGoge/Eoe9CBwlf8clSF9C89eRk5qt08UHPpThtIe1ERy6BPC06
 9m0l+rdY9wrbAucn7/JJiB78LN7C+V7G2mJjRb/67eMwEAzMKBev7tkTu0zx4XMz5X
 B4soxsBusV5YDpqLBNVkMF7/EBlxFsvghnU8mXCZfT/KVqxoetO75WpauO6W36XTpv
 0nNVvI3ukUCNw==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 99B433A0B70;
 Wed, 23 Aug 2023 08:54:38 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v4 02/14] simpletrace: annotate magic constants from QEMU code
Date: Wed, 23 Aug 2023 10:54:17 +0200
Message-Id: <20230823085429.20519-3-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230823085429.20519-1-mads@ynddal.dk>
References: <20230823085429.20519-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4AZ2DnAWlEUY5XSzk-01RX3RYhcevmUw
X-Proofpoint-GUID: 4AZ2DnAWlEUY5XSzk-01RX3RYhcevmUw
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=298 clxscore=1030 bulkscore=0 adultscore=0 phishscore=0
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


