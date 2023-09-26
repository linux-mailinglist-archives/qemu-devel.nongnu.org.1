Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA86E7AEA82
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5Ox-0003IN-G4; Tue, 26 Sep 2023 06:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5Ov-0003HS-Mb
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:34:45 -0400
Received: from mr85p00im-zteg06021501.me.com ([17.58.23.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5Ot-00018Q-R5
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1695724482; bh=Opjt7pYA8x+4U2fdQc7QHtuH5ZIs1E+6mhQKfPDHwuA=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=J0h5DpgGMybprBGXzxwIOgWrTjZMxiSHOku4BD9Yiq+NDk/Wflp7WcG/6eZnzh3O9
 06Lq0x/ZznhiXNQP5cruQ4hdp7J1+0Y2uzsHiwzdN/nOxPgIOFJyicP9AJiVF2yvrF
 uTboccOHJrH0F02CkR6En2snUgFweEbv1xk4zC5sZwDqeAM9fftp40hOTaFzOCElUx
 HXMU0ipfSXbKV8gfYcNWhYC3IT86R0r0rs4Okk4dqrLtwOuqJlKAfMe6MyWscZkD67
 BGgj91utSjdqCISpPRqigp0NPmOCpsNrXUGYZwnOEZUkCCftpLXOWZ4CryMVTHKLjv
 U1sIKs3f7GDdg==
Received: from localhost.localdomain (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 43F482793D78;
 Tue, 26 Sep 2023 10:34:41 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v5 01/14] simpletrace: add __all__ to define public interface
Date: Tue, 26 Sep 2023 12:34:23 +0200
Message-Id: <20230926103436.25700-2-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926103436.25700-1-mads@ynddal.dk>
References: <20230926103436.25700-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pa3OACmjxq2opi5AXScJdp5pO9SQc8TX
X-Proofpoint-GUID: pa3OACmjxq2opi5AXScJdp5pO9SQc8TX
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0
 clxscore=1030 adultscore=0 mlxlogscore=598 phishscore=0 mlxscore=0
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

It was unclear what was the supported public interface. I.e. when
refactoring the code, what functions/classes are important to retain.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 scripts/simpletrace.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 1f6d1ae1f3..b221d9a241 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -14,6 +14,8 @@
 from tracetool import read_events, Event
 from tracetool.backend.simple import is_string
 
+__all__ = ['Analyzer', 'process', 'run']
+
 header_event_id = 0xffffffffffffffff
 header_magic    = 0xf2b177cb0aa429b4
 dropped_event_id = 0xfffffffffffffffe
-- 
2.38.1


