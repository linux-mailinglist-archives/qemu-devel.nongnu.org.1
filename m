Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D95C7AEA75
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:35:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5PX-0004Ld-Gl; Tue, 26 Sep 2023 06:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5PS-0003wZ-Fp
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:35:18 -0400
Received: from mr85p00im-zteg06021501.me.com ([17.58.23.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5PQ-0001OC-Uh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1695724505; bh=EXTVgrsCo7pbRmkSb7Wom7gNlLXkp7KqE9K6uvSiPFE=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=RLE03LCw8v+wIJKFcUEXtHsSlWY4D64kw1eFAhkSCRnFaUw8DNsBQFF8sYeVi3viD
 M3EpUcj7jZictfNKxxR8Tvb174qJYcL/pxX72gpGkNUfSW5sX6GfS3Lm3L4wUbBQMq
 kjyZXa5D928C8AIs8pwHO8GKakn8aZkHOuVDsmiT90Gb4DFOOBh/bb+V+MRx3ijhus
 taGYU4lYu0aZs7rXFJZyEf+ga5QtSPeG/Quu2aRYCOwYdpcGZtkSG9S0OOIBiuZhzB
 Chey8Km0AlEvQag46xQ/C2ZqWLDWcRlflUsyWN77tEuU4QgfD9m0WLBw/dYV56DORo
 mrBzxKtzrJVFA==
Received: from localhost.localdomain (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 5CCF32793E9D;
 Tue, 26 Sep 2023 10:35:04 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 13/14] MAINTAINERS: add maintainer of simpletrace.py
Date: Tue, 26 Sep 2023 12:34:35 +0200
Message-Id: <20230926103436.25700-14-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926103436.25700-1-mads@ynddal.dk>
References: <20230926103436.25700-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NZvlN8ggkSbcnZQ4aiJlQV95-ZoZl2oW
X-Proofpoint-GUID: NZvlN8ggkSbcnZQ4aiJlQV95-ZoZl2oW
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0
 clxscore=1030 adultscore=0 mlxlogscore=887 phishscore=0 mlxscore=0
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

In my work to refactor simpletrace.py, I noticed that there's no
maintainer of it, and has the status of "odd fixes". I'm using it from
time to time, so I'd like to maintain the script.

I've added myself as reviewer under "Tracing" to be informed of changes
that might affect simpletrace.py.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 355b1960ce..81625f036b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3170,6 +3170,7 @@ F: stubs/
 
 Tracing
 M: Stefan Hajnoczi <stefanha@redhat.com>
+R: Mads Ynddal <mads@ynddal.dk>
 S: Maintained
 F: trace/
 F: trace-events
@@ -3182,6 +3183,11 @@ F: docs/tools/qemu-trace-stap.rst
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


