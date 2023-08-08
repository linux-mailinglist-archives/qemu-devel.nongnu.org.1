Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7C3773673
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 04:22:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCLf-0005el-PL; Mon, 07 Aug 2023 22:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qTCLd-0005dg-Gm
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:21:25 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qTCLb-0001ZU-96
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:21:24 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 9A5E911EE8C;
 Tue,  8 Aug 2023 02:21:21 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Tue, 08 Aug 2023 02:21:21 +0000
MIME-Version: 1.0
Subject: [PATCH QEMU v3 0/3] migration: enrich the dirty-limit test case
Message-ID: <169146128144.15119.10176158487539386358-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Maintainers: Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman <yong.huang@smartx.com>;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-To: ~hyman <yong.huang@smartx.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Ping

This version is a copy of version 2 and is rebased
on the master. No functional changes.

The dirty-limit migration test involves many passes
and takes about 1 minute on average, so put it in
the slow mode of migration-test. Inspired by Peter.

V2:
- put the dirty-limit migration test in slow mode and
  enrich the test case comment

Dirty-limit feature was introduced in 8.1, and the test
case could be enriched to make sure the behavior and
the performance of dirty-limit is exactly what we want.

This series adds 2 test cases, the first commit aims
for the functional test and the others aim for the
performance test.

Please review, thanks.

Yong.

Hyman Huang(=E9=BB=84=E5=8B=87) (3):
  tests: Add migration dirty-limit capability test
  tests/migration: Introduce dirty-ring-size option into guestperf
  tests/migration: Introduce dirty-limit into guestperf

 tests/migration/guestperf/comparison.py |  23 ++++
 tests/migration/guestperf/engine.py     |  23 +++-
 tests/migration/guestperf/hardware.py   |   8 +-
 tests/migration/guestperf/progress.py   |  16 ++-
 tests/migration/guestperf/scenario.py   |  11 +-
 tests/migration/guestperf/shell.py      |  24 +++-
 tests/qtest/migration-test.c            | 164 ++++++++++++++++++++++++
 7 files changed, 261 insertions(+), 8 deletions(-)

--=20
2.38.5

