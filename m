Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5AD728051
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:44:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7EyU-00039l-ED; Thu, 08 Jun 2023 08:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7EyS-00039N-TI
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:44 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7EyR-0000Hu-D5
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1686228151; bh=0TM9Xz67OYngDEuTQ62kPsInUQpx3kaf2lzF824GJ1Y=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=jdDiXPAHeWEpoalnaKvHbaw9pcV7ldv17oaGEScegPsffjI0QkcOu0Lfobt5rVaek
 c1rGQd5SfucCWVcnPbfhQmROPfozVfb7u7aj6Wtxag8dXyilQlTdtmD6m63dAN0AEo
 bng5VlMB0WURVAJkJheDMQ4E2SQ/drR+amSnxcrJ9OIxHx0cbIsO7Yks2LQZgdE3/A
 VEWMJCI6ic8nNYlAJVvjo7qQFXHDaqmHYFXvqndPKicoRKdTrl753nZpIoJUWxcNNz
 hPl4GNdFyI0HYZ0kwohC+psmsnZaqaXi+1aZJZXQ+y6p75SVd/gRGO6tbrHjWkMx46
 bmZ2LJU67Ly2g==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id D43C44A02A7;
 Thu,  8 Jun 2023 12:42:29 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v3 14/14] scripts/analyse-locks-simpletrace.py: changed
 iteritems() to items()
Date: Thu,  8 Jun 2023 14:41:47 +0200
Message-Id: <20230608124147.51125-15-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608124147.51125-1-mads@ynddal.dk>
References: <20230608124147.51125-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rphsyfcdkeMrvi2AEm-N83sH4Ze5GpPa
X-Proofpoint-ORIG-GUID: rphsyfcdkeMrvi2AEm-N83sH4Ze5GpPa
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=570 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
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


