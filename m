Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F002397CA60
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Sep 2024 15:47:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srHUk-00083d-BF; Thu, 19 Sep 2024 09:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHUg-0007qE-KW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:46:50 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHUQ-0005zl-UM
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=KrajGmYAtlRM8qcr9rCRYTxgOyGTlHDlDTPA25yNl6M=; b=DyyNixIh7Mwcpt9I
 exQIvCDteWktIf5tSe8suM5xApvyfo3h7WXidD4FokOUzOIMLX3fDhOT4662exP+QUMgqsLYxJXVK
 ugoGwprSI3Mp5IqkSkuOg/wibPK1CHN9mGzG7RBz0ybFTXFZ99nEWj1/2iTrHxf24ynlyZF7sAarq
 /dW3j1xbl1NLFHluMhuykV/KDGXgHrcXbFP8ubQCDiXteqZX9jiEEx/Xjw6quuPtOFBkQxIfTpf0i
 QO/mlOm6xPkrvmQvbLEysomQmtyqGNl5j15eYhtL09BQFsYhLVprdocSTzm6rAAJ+3K+lmagoOOqS
 sDB222UoXxZubOupZg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1srHUJ-006QOJ-2y;
 Thu, 19 Sep 2024 13:46:27 +0000
From: dave@treblig.org
To: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 0/7] Migration deadcode removal
Date: Thu, 19 Sep 2024 14:46:19 +0100
Message-ID: <20240919134626.166183-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

  This is a set of deadcode removal around migration
found by looking for unused symbols.

v2
   Don't remove the zero-blocks capability yet
   add Fabiano's deprecation text patch.
   Use the uffd helpers in postcopy rather than
     removing most of them.
   Remove one.

Dave

Dr. David Alan Gilbert (6):
  migration: Remove migrate_cap_set
  migration: Remove unused migrate_zero_blocks
  migration: Remove unused socket_send_channel_create_sync
  util/userfaultfd: Return -errno on error
  migration/postcopy: Use uffd helpers
  util/userfaultfd: Remove unused uffd_poll_events

Fabiano Rosas (1):
  migration: Deprecate zero-blocks capability

 docs/about/deprecated.rst  |  6 +++++
 include/qemu/userfaultfd.h |  1 -
 migration/options.c        | 31 ++++--------------------
 migration/options.h        |  2 --
 migration/postcopy-ram.c   | 47 ++++++++++--------------------------
 migration/socket.c         | 18 --------------
 migration/socket.h         |  1 -
 qapi/migration.json        |  5 +++-
 util/userfaultfd.c         | 49 ++++++++++----------------------------
 9 files changed, 39 insertions(+), 121 deletions(-)

-- 
2.46.1


