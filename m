Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7307B5211D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 21:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwQXT-0000pl-ON; Wed, 10 Sep 2025 15:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwQXN-0000or-By
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 15:31:26 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwQXJ-0003pz-8j
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 15:31:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:999c:0:640:51a7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4B82EC00A7;
 Wed, 10 Sep 2025 22:31:15 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b48::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EVQIl30GrmI0-fHIawtKw; Wed, 10 Sep 2025 22:31:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757532674;
 bh=akj3B13+HdfxGTW4p6P0RHXWOFc+U/tO6dN7hf1z4xQ=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=QvQaF3+cuhNU5+xcvan89XkneanYQNYimC9YRjiHuJplQgbebFThwl8bMtGxLvqIg
 +wBdCOW4a8tveGH3RzhK+Mi3fEcAoDuvxxBSHgzG2c4z0DG+kwiGNWrcdNJxUln1op
 qu2heRpnsS41xYNiYHdTlaT6e2NhYZsnMBKVVXzU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] save qemu-file incoming non-blocking fds
Date: Wed, 10 Sep 2025 22:31:10 +0300
Message-ID: <20250910193112.1220763-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi all!

That's a new version for
[PATCH v3] migration/qemu-file: don't make incoming fds blocking again
Supersedes: <20250910143156.1053779-1-vsementsov@yandex-team.ru>

, adding small changes suggested by Peter.

Also, I've added here documentation patch from 

[PATCH 00/10] io: deal with blocking/non-blocking fds

, because I have to change it anyway after this new flag.

Vladimir Sementsov-Ogievskiy (2):
  migration/qemu-file: don't make incoming fds blocking again
  io/channel: document how qio_channel_readv_full() handles fds

 include/io/channel.h  | 18 ++++++++++++++++++
 io/channel-socket.c   | 13 +++++++++----
 migration/qemu-file.c |  3 ++-
 3 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.48.1


