Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C2A728050
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:43:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Exm-0002mt-0b; Thu, 08 Jun 2023 08:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Exj-0002mL-R3
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:41:59 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Exh-00008J-Tl
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1686228114; bh=XKB8IurCgmZTWrkBZPHNDmN950cjNx0jZYJLi4QfE/Y=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=SQFIdcp21NR/OaME25bnFt4PUGqolASm/rznj2BeY1ogDAfEVfkxwVo7npofaNRNn
 Id1xQ55ZHp6pxlIlfYe4OK+51heFRMPvM1b0LzrPspS0J8PtTRsxC98Mc7xY5XyQV7
 1JdcrNayH3dkwNdrjdEY851MzZWUxOivIcPjGWN88WqZpdgFH6T0kySSpT+k0e63Zh
 5EXFFysN+qnAQO90cfKDRyKFHX4a9K8AAGXrX29Sbf1oFcoHkIFRvLnnz+tlFgQ7NZ
 1Ect9EX38wMgv9RrGkzZiYktgLEJofNl9U5RCUxbytr3S93gVjooadgwTP0M/XLmhX
 ps0RnK1H2jimw==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 7A3074A02AB;
 Thu,  8 Jun 2023 12:41:51 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v3 00/14] simpletrace: refactor and general improvements
Date: Thu,  8 Jun 2023 14:41:33 +0200
Message-Id: <20230608124147.51125-1-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jIRrawKWLwX-Nxaotfwohhy_fY2DUimY
X-Proofpoint-ORIG-GUID: jIRrawKWLwX-Nxaotfwohhy_fY2DUimY
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=251 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
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

I wanted to use simpletrace.py for an internal project, so I tried to update
and polish the code. Some of the commits resolve specific issues, while some
are more subjective.

I've tried to divide it into commits so we can discuss the
individual changes, and I'm ready to pull things out, if it isn't needed.

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
 scripts/simpletrace.py               | 358 ++++++++++++++++++---------
 3 files changed, 244 insertions(+), 122 deletions(-)

-- 
2.38.1


