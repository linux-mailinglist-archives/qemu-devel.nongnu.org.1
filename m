Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BFD785335
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjdc-0003tD-MD; Wed, 23 Aug 2023 04:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjdb-0003t0-27
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:54:51 -0400
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjdZ-0008CD-Ja
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1692780888; bh=2eo6M7Po98p7txvfneyaWrztwzb3AvIPCmOUr/Bqc1k=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=CS57kwG5jna64i8qoPa6jwntKUD+E4JlxBOvkRvYWJtZk9hbvrE8L/MutmaR4bsSJ
 ROUBBsU7A0z7z/rdOLaOWuxyxv8deMVdxLiKWCZNiIcQ415idXWXX4IDUciH1JFp4V
 gwp4SwrmiI0bGwP9qGyHsocOFJwvBOcia0S0H1KLekQuqchC5F7AI52xR8t2e4iCge
 boZSr0A2MTVe5fL+Q7zNxkuBH3hxOmT/PJAXOFwoZ4f8stLDoRI1QZu4rIDoji3CcU
 BphIIw+Hwl7vf3QP9KpySsCUXPmt1NazSwbg+3kq7EDWJbTR+IBVZfGEEd1xDoKmbN
 1NvmdjcWVhvYg==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 9C3F43A0AF2;
 Wed, 23 Aug 2023 08:54:46 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v4 05/14] simpletrace: update code for Python 3.11
Date: Wed, 23 Aug 2023 10:54:20 +0200
Message-Id: <20230823085429.20519-6-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230823085429.20519-1-mads@ynddal.dk>
References: <20230823085429.20519-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: j9D0rmyqpV-B1m3S0Q05juaIEVHGsuBZ
X-Proofpoint-GUID: j9D0rmyqpV-B1m3S0Q05juaIEVHGsuBZ
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=904 clxscore=1030 bulkscore=0 adultscore=0 phishscore=0
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

The call to `getargspec` was deprecated and in Python 3.11 it has been
removed in favor of `getfullargspec`. `getfullargspec` is compatible
with QEMU's requirement of at least Python version 3.6.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/simpletrace.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 09511f624d..971b2a0f6a 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -221,7 +221,7 @@ def build_fn(analyzer, event):
             return analyzer.catchall
 
         event_argcount = len(event.args)
-        fn_argcount = len(inspect.getargspec(fn)[0]) - 1
+        fn_argcount = len(inspect.getfullargspec(fn)[0]) - 1
         if fn_argcount == event_argcount + 1:
             # Include timestamp as first argument
             return lambda _, rec: fn(*(rec[1:2] + rec[3:3 + event_argcount]))
-- 
2.38.1


