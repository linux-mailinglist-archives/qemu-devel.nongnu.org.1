Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8817C78533E
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:56:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjdX-0003rr-G5; Wed, 23 Aug 2023 04:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjdV-0003r5-FC
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:54:45 -0400
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjdU-00086t-1j
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1692780878; bh=0fJy1sjStRMrctTrd8eWHr4fZQUPa8Euy65mZZsWwKQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=QSD4RDUflQ0CRj05c4kiHavEzY74JPNDEbdpsj7F8MGp4PVYnIC6+Vp+/urJIUrXc
 oTuH0IATRAo6lOK2uDu430SJslR2gayssA6nmAN4SBjcodYdBAfl6XK/f0hO0+JHhl
 G14LvRzqNEeOwWclBT44hshNgPpqYIp1Xg6RZMckyKDi6zgubkXn83GAbeCvGXo3fs
 fMa+qHrZgSDpn7zfr+VkhJUQf6pT/gJz4EM79qxTYsAuDFS513bOJ/+8imNYDDCPps
 XUll+ecRcBmxa/UmLwW6alu4fV9qrDj3CcnV6f9a6Zp/FPGQJ9WRCJdJe1yaO/QTnn
 96bMlLXe8+hcg==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id DDDE13A0B0B;
 Wed, 23 Aug 2023 08:54:35 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v4 01/14] simpletrace: add __all__ to define public interface
Date: Wed, 23 Aug 2023 10:54:16 +0200
Message-Id: <20230823085429.20519-2-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230823085429.20519-1-mads@ynddal.dk>
References: <20230823085429.20519-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KB9SXGAJ9n3Oe4RRIGWykMgv4TZGwKWS
X-Proofpoint-GUID: KB9SXGAJ9n3Oe4RRIGWykMgv4TZGwKWS
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=489 clxscore=1030 bulkscore=0 adultscore=0 phishscore=0
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

It was unclear what was the supported public interface. I.e. when
refactoring the code, what functions/classes are important to retain.

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


