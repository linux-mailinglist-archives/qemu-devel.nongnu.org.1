Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B4728052
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:44:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Exx-0002sn-Gw; Thu, 08 Jun 2023 08:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Exv-0002qw-AJ
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:11 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Exs-0000Af-QE
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1686228127; bh=2eo6M7Po98p7txvfneyaWrztwzb3AvIPCmOUr/Bqc1k=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=Gnq6IA8XdQk4ng3MzcW9AtCfgKW0bm7aJ6Y4D+25Ph8tu17EH6ko4nvhp6ytqwZrC
 TYIZ8pYcqrMhcVn749Tch+zuli8DugdbrKnjanRs3srOPkQPn7BpO7KIlwoHI1SrAB
 ksZ+c8vWs7OhWlZ9Biy2tMXXLvFU6grypylsJYnuhngyaEcBAnMCGErN7ubMdXKSeq
 ZBR0pJrhYPrV96U/GmG6f0SCX0oseuAXeHokGl/E7EhaaaHT1EiwohW5tX9lNEIjhv
 Km87ean/9G0s+0dQvfkuM6J1E6KO8DEK3SoJTNSmPKcJTrvnikvekgane9p8Iu7Xj5
 9xcP5VqKdHU5Q==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id D60074A0388;
 Thu,  8 Jun 2023 12:42:05 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v3 05/14] simpletrace: update code for Python 3.11
Date: Thu,  8 Jun 2023 14:41:38 +0200
Message-Id: <20230608124147.51125-6-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608124147.51125-1-mads@ynddal.dk>
References: <20230608124147.51125-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UmUVgFTI6PUzJP7VIxxnwT-Z3Ksj4nUr
X-Proofpoint-ORIG-GUID: UmUVgFTI6PUzJP7VIxxnwT-Z3Ksj4nUr
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=894 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
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


