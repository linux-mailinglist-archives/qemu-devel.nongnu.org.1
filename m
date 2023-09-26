Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C46917AEA71
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:35:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5Ov-0003Fm-QP; Tue, 26 Sep 2023 06:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5Ou-0003AS-5s
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:34:44 -0400
Received: from mr85p00im-zteg06021501.me.com ([17.58.23.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5Os-00018L-GJ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1695724480; bh=QK9mRa2C2+4VlN/UlOr2BVnn3RFH4/IH9BP32cUX6fg=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=YxnCmNDgRZCrR/ajYaeBjR/Dq+MbBQl3/PSOGmjE8YyuShZVcxC8SGFL8Ias1Ipfv
 X61mRwoDRkupofHZg7El19FUoDRsNv5Cl2kNDisTPllYrq/GPIWfSxKDTeU7q/R5rJ
 LyAbqXHiLFHFyKrOialdiPIOoMoehpstwH7p/2sD5uP5Cy9GnpCMTOle0Q0JBqRpeL
 /RRAnoPZ3pETrPVZbr6zZqQshCvM9oQLSnkmmrDrxjQYQ4syEKxv9050yJpNa5FkRk
 WebhGxyap5j/H4xphdkUeAj3eqt8ArrrhS/gPZiDviMQ/cuGtXtQgBKo7F6b+evHi6
 auVRoBtiW3EIQ==
Received: from localhost.localdomain (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id E421A2793E6B;
 Tue, 26 Sep 2023 10:34:38 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v5 00/14] simpletrace: refactor and general improvements
Date: Tue, 26 Sep 2023 12:34:22 +0200
Message-Id: <20230926103436.25700-1-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: d36-olybk7JTmRTcLZckrBJSQh-KJxvA
X-Proofpoint-GUID: d36-olybk7JTmRTcLZckrBJSQh-KJxvA
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0
 clxscore=1030 adultscore=0 mlxlogscore=295 phishscore=0 mlxscore=0
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

I wanted to use simpletrace.py for an internal project, so I tried to update
and polish the code. Some of the commits resolve specific issues, while some
are more subjective.

I've tried to divide it into commits so we can discuss the
individual changes, and I'm ready to pull things out, if it isn't needed.

v5:
 * Picked Formatter2 over Formatter, as to not use the deprecated class
 * simpletrace-benchmark.zip deleted
 * Rebased with master
v4:
 * Added missing Analyzer2 to __all__
 * Rebased with master
v3:
 * Added __all__ with public interface
 * Added comment about magic numbers and structs from Stefan Hajnoczi
 * Reintroduced old interface for process, run and Analyzer
 * Added comment about Python 3.6 in ref. to getfullargspec
 * process now accepts events as file-like objects
 * Updated context-manager code for Analyzer
 * Moved logic of event processing to Analyzer class
 * Moved logic of process into _process function
 * Added new Analyzer2 class with kwarg event-processing
 * Reverted changes to process-call in scripts/analyse-locks-simpletrace.py
v2:
 * Added myself as maintainer of simpletrace.py
 * Improve docstring on `process`
 * Changed call to `process` in scripts/analyse-locks-simpletrace.py to reflect new argument types
 * Replaced `iteritems()` with `items()` in scripts/analyse-locks-simpletrace.py to support Python 3

Mads Ynddal (14):
  simpletrace: add __all__ to define public interface
  simpletrace: annotate magic constants from QEMU code
  simpletrace: improve parsing of sys.argv; fix files never closed.
  simpletrace: changed naming of edict and idtoname to improve
    readability
  simpletrace: update code for Python 3.11
  simpletrace: improved error handling on struct unpack
  simpletrace: define exception and add handling
  simpletrace: made Analyzer into context-manager
  simpletrace: refactor to separate responsibilities
  simpletrace: move logic of process into internal function
  simpletrace: move event processing to Analyzer class
  simpletrace: added simplified Analyzer2 class
  MAINTAINERS: add maintainer of simpletrace.py
  scripts/analyse-locks-simpletrace.py: changed iteritems() to items()

 MAINTAINERS                          |   6 +
 scripts/analyse-locks-simpletrace.py |   2 +-
 scripts/simpletrace.py               | 382 +++++++++++++++++----------
 3 files changed, 246 insertions(+), 144 deletions(-)

-- 
2.38.1


