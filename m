Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5247879FD66
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgh12-00010N-Es; Thu, 14 Sep 2023 03:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgh0u-0000xK-FV
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:43:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgh0s-0007nG-4k
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:43:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9002721C32
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:43:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EEB9427F68;
 Thu, 14 Sep 2023 10:43:42 +0300 (MSK)
Received: (nullmailer pid 149918 invoked by uid 1000);
 Thu, 14 Sep 2023 07:43:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v3 0/3] linux-user/syscall.c: do_ppoll: eliminate large alloca
Date: Thu, 14 Sep 2023 10:43:34 +0300
Message-Id: <20230914074337.149897-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

This is a v3 patch (now patchset) which eliminates guest-controlled
alloca from linux-user:poll.  I now split out 2 unrelated preparational
changes into its own patches, for easy review.

The small optmization which were here in v1 is still there.  In huge
number of use cases, poll() et all are called with just one file
descriptor, there's no need to use heap allocation for this, and the
code to avoid this heap allocation is already there, is short and is
easy to read too (YMMV).

This patchset passes poll- and ppoll-related LTSP tests, except of
the ppoll_time64 case (tested on ppc64):

ppoll01.c:174: TCONF: syscall(414) __NR_ppoll_time64 not supported on your arch

which was here before.

Michael Tokarev (3):
  linux-user/syscall.c: do_ppoll: simplify time64 host<=>target
    conversion expressions
  linux-user/syscall.c: do_ppoll: consolidate and fix the forgotten
    unlock_user
  linux-user/syscall.c: do_ppoll: eliminate large alloca

 linux-user/syscall.c | 52 +++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

-- 
2.39.2


