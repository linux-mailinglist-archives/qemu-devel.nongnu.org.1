Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A0B7AEA70
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:35:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5P0-0003LJ-1U; Tue, 26 Sep 2023 06:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5Oy-0003KO-BK
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:34:48 -0400
Received: from mr85p00im-zteg06021501.me.com ([17.58.23.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5Ow-00018d-T6
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1695724484; bh=FocdVLYDNArXFrLxDdBkQHs+kNLDBwoNVCRy8XpQ+dg=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=BLQHylQQdlsOiOLFQIQT9cFhr63vjTlIzNt6yt/h+uN6fMhW0m4CgiD2lATy2y5lo
 eUqISRjVuFNVZusXO1TSaDYUufG0c/a+Nbc33Q3D5XEtXKKGS5lZcHjA5te5hMn3Tk
 jXF4bJdWTAyAqi+o3vJozn9E0lwtb2XWzebyz/nZ4maxMIBuUCHsq3z0g+si9cFpFl
 wLcmC1s/I8skFYu5AO98d7YAZBPKHGJfxRID/4wo6eFLRv6o/URfMZam269a1LwdWs
 Z+gBQ3uBN9fo6KSqH3f7JGkeLLTtxMgMJX3gU61BT9LtMPw6rJ+3iMn3qj1ni/IxdQ
 /SGgq6/XaOGlA==
Received: from localhost.localdomain (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 36E052793EA9;
 Tue, 26 Sep 2023 10:34:43 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v5 02/14] simpletrace: annotate magic constants from QEMU code
Date: Tue, 26 Sep 2023 12:34:24 +0200
Message-Id: <20230926103436.25700-3-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926103436.25700-1-mads@ynddal.dk>
References: <20230926103436.25700-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Jy3CRewAFX9vp0Kz8Bql2usenv2YEMyZ
X-Proofpoint-GUID: Jy3CRewAFX9vp0Kz8Bql2usenv2YEMyZ
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0
 clxscore=1030 adultscore=0 mlxlogscore=450 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309260091
Received-SPF: pass client-ip=17.58.23.183; envelope-from=mads@ynddal.dk;
 helo=mr85p00im-zteg06021501.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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


