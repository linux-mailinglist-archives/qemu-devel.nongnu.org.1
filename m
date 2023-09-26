Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CD27AEA83
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:37:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5PW-0004GY-PU; Tue, 26 Sep 2023 06:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5PU-00040S-6U
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:35:20 -0400
Received: from mr85p00im-zteg06021501.me.com ([17.58.23.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5PS-0001OY-Oc
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1695724507; bh=it2JPuObXZmGZgZVYdTI0jT1RUlfQEJ/017blYBJFQ8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=DXn5w9dYUfSrWwtm8QPt21bPX3UpcFmtwD9a0xtRjSZ8njtF9WtKg2pKonNxDzjPC
 9PU1pykneVhq5zceKYVJdRRJr/GTPKX+V0xOjr0CferV2h+Js4iRZQ7i/cTBCMPgwm
 M41G+Sd6YvN/2gxWZeXS7d9N1lMUBVJ3oagimO4wPpi7JDrpV9tmzTFTScVSytqjwt
 7UvmLy+gVQQCTSIF4rwH84Dc8l22Vd/l8ghKLUz7j12yeWmXjGsuj/3xkcYdMud97G
 JDGFgQuKtFdKXw1LeRf/Q332onVPDLqCCQUfthkqoxA890Hmh9jgZuhpW4gvDg9Pmc
 ilvtz349hx6DA==
Received: from localhost.localdomain (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 328182793EA1;
 Tue, 26 Sep 2023 10:35:06 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 14/14] scripts/analyse-locks-simpletrace.py: changed
 iteritems() to items()
Date: Tue, 26 Sep 2023 12:34:36 +0200
Message-Id: <20230926103436.25700-15-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926103436.25700-1-mads@ynddal.dk>
References: <20230926103436.25700-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hRyUWhsoMu12t2hDP0Phz_zlkSstcxCi
X-Proofpoint-GUID: hRyUWhsoMu12t2hDP0Phz_zlkSstcxCi
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0
 clxscore=1030 adultscore=0 mlxlogscore=637 phishscore=0 mlxscore=0
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

Python 3 removed `dict.iteritems()` in favor of `dict.items()`. This
means the script currently doesn't work on Python 3.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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


