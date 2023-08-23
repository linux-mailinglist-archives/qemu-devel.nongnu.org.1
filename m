Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E717978533F
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:56:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjeN-0005LC-JP; Wed, 23 Aug 2023 04:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYje8-0004t7-0A
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:55:26 -0400
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYje6-0000DF-IR
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1692780911; bh=0TM9Xz67OYngDEuTQ62kPsInUQpx3kaf2lzF824GJ1Y=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=RWtipdC1lk21Q/Zh+3FDVEe3H1V+TXayzAccMFEJcodylzygVFi5Re02veD9zBGOt
 V935lQv2rjn4/hGqKAi/E/CeZTbx94m5duZx8kOeM5ZyQ8qMdnWdAkxLYgSrIKARRq
 AwTrm5d/R62+cAMqDWql0BrefnbJmW86/mbH7GVCH78XcW2IibZeTGPsJ3VXwJU0jb
 N8uWeZY6NB6dv/tR6xsqcfskbNF7eEcHqJggDDwQaHgLzHb9tVXkc24VlYvGpluG+i
 bI2aNCcb+Sbjd1EXoJ8Xscqs8mX7669Cx4LWDoeGTdsk56bX3ITzhZebnazWeY3lxF
 3hRaIg43KPnRA==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 790D33A0BB3;
 Wed, 23 Aug 2023 08:55:09 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v4 14/14] scripts/analyse-locks-simpletrace.py: changed
 iteritems() to items()
Date: Wed, 23 Aug 2023 10:54:29 +0200
Message-Id: <20230823085429.20519-15-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230823085429.20519-1-mads@ynddal.dk>
References: <20230823085429.20519-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: r3A3Wdx7tdfGdOFPyKmoQsz50lmSAhq_
X-Proofpoint-GUID: r3A3Wdx7tdfGdOFPyKmoQsz50lmSAhq_
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=562 clxscore=1030 bulkscore=0 adultscore=0 phishscore=0
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

Python 3 removed `dict.iteritems()` in favor of `dict.items()`. This
means the script curerntly doesn't work on Python 3.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 scripts/analyse-locks-simpletrace.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/analyse-locks-simpletrace.py b/scripts/analyse-locks-simpletrace.py
index 63c11f4fce..d650dd7140 100755
--- a/scripts/analyse-locks-simpletrace.py
+++ b/scripts/analyse-locks-simpletrace.py
@@ -75,7 +75,7 @@ def get_args():
            (analyser.locks, analyser.locked, analyser.unlocks))
 
     # Now dump the individual lock stats
-    for key, val in sorted(analyser.mutex_records.iteritems(),
+    for key, val in sorted(analyser.mutex_records.items(),
                            key=lambda k_v: k_v[1]["locks"]):
         print ("Lock: %#x locks: %d, locked: %d, unlocked: %d" %
                (key, val["locks"], val["locked"], val["unlocked"]))
-- 
2.38.1


