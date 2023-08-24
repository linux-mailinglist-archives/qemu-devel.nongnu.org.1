Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC887874A0
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:54:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCei-0000fG-BR; Thu, 24 Aug 2023 11:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZCeg-0000eV-Rn
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZCed-0007i1-J5
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692892430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bbkazce1e91WkY0/SddScTrwUww93aRQJUqIlV99Mtc=;
 b=Akhxl9lffXEEcu1WNRE9Yys/4puiuTh3lh5AUy+zLEf4K1E0Tdo1l9O+hMT+qWIm5dmuh8
 5r7FInM+zjUCmhxhWw6IkMJHerhMdvVyX7EsvS2ppTAxmC7691GxZuE23DJRAv5774FbZm
 Z/3MTFAKuPiwPDcadQY21nJ9XJl00ns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-695-Yk5HRO2JOs-vWKWaw3XIyg-1; Thu, 24 Aug 2023 11:53:47 -0400
X-MC-Unique: Yk5HRO2JOs-vWKWaw3XIyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFA18800CA6;
 Thu, 24 Aug 2023 15:53:46 +0000 (UTC)
Received: from localhost (unknown [10.39.193.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62B7DC1602E;
 Thu, 24 Aug 2023 15:53:46 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH 0/5] file-posix: Clean up and fix zoned checks
Date: Thu, 24 Aug 2023 17:53:39 +0200
Message-ID: <20230824155345.109765-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

As presented in [1] there is a bug in the zone code in raw_co_prw(),
specifically we don’t check whether there actually is zone information
before running code that assumes there is (and thus we run into a
division by zero).  This has now also been reported in [2].

I believe the solution [1] is incomplete, though, which is why I’m
sending this separate series: I don’t think checking bs->wps and/or
bs->bl.zone_size to determine whether there is zone information is
right; for example, we do not have raw_refresh_zoned_limits() clear
those values if on a refresh, zone information were to disappear.

It is also weird that we separate checking bs->wps and bs->bl.zone_size
at all; raw_refresh_zoned_limits() seems to intend to ensure that either
we have information with non-NULL bs->wps and non-zero bs->bl.zone_size,
or we don’t.

I think we should have a single flag that tells whether we have valid
information or not, and it looks to me like bs->bl.zoned != BLK_Z_NONE
is the condition that fits best.

Patch 1 ensures that raw_refresh_zoned_limits() will set bs->bl.zoned to
BLK_Z_NONE on error, so that we can actually be sure that this condition
tells us whether we have valid information or not.

Patch 2 unifies all conditional checks for zone information to use
bs->bl.zoned != BLK_Z_NONE.

Patch 3 is the I/O error path fix, which is not really different from
[1].

Patch 4 does a bit of clean-up.

Patch 5 adds a regression test.


[1] https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01742.html
[2] https://bugzilla.redhat.com/show_bug.cgi?id=2234374


Hanna Czenczek (5):
  file-posix: Clear bs->bl.zoned on error
  file-posix: Check bs->bl.zoned for zone info
  file-posix: Fix zone update in I/O error path
  file-posix: Simplify raw_co_prw's 'out' zone code
  tests/file-io-error: New test

 block/file-posix.c                         | 42 +++++----
 tests/qemu-iotests/tests/file-io-error     | 99 ++++++++++++++++++++++
 tests/qemu-iotests/tests/file-io-error.out | 31 +++++++
 3 files changed, 150 insertions(+), 22 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/file-io-error
 create mode 100644 tests/qemu-iotests/tests/file-io-error.out

-- 
2.41.0


