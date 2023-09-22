Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5039E7AB42D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:54:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhXH-00055G-Ju; Fri, 22 Sep 2023 10:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjhX4-0004y1-VQ
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:53:29 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjhX2-00011k-Qg
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:53:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44CF71FF12;
 Fri, 22 Sep 2023 14:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695394403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bO84+GB049V83AMdeoktdGUV6DcpXHRWWJMXEA+Ho8w=;
 b=wB+10Zu58Dui4VOYu+Y0hz/GiZ6OwU4kZUP0jtCl0gf8EAKzKiPYuEmiCA1GRgMy1QuEm4
 q8BXyhqceAP7nMutpesh/U1TlOkn5YRYF9jRnswZwK1pbXGCVFMJziU7QtcP73fZPoDGNu
 Cw83vmW+/KzYrF/NDI3C+4Ngm8tzEeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695394403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bO84+GB049V83AMdeoktdGUV6DcpXHRWWJMXEA+Ho8w=;
 b=6lwihgFS/cfQv9pIsTmPjnIAdlru5aEfNybpgb6GqPZ2hlzMbaJRZqyGNU9IX5QxOQETWI
 P9CE0krcvp5ee/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1A3A13478;
 Fri, 22 Sep 2023 14:53:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zp3aGmGqDWUpDAAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 22 Sep 2023 14:53:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [RFC PATCH 0/3] migration/multifd: SYNC packet changes
Date: Fri, 22 Sep 2023 11:53:16 -0300
Message-Id: <20230922145319.27380-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

I'm putting this RFC out early so we can discuss the issues around the
SYNC packet of the multifd protocol. There's a related series posted
by Elena Ufimtseva:

https://lore.kernel.org/r/20230922065625.21848-1-elena.ufimtseva@oracle.com

My interest in this (aside from correctness) is that when doing the
(upcoming) fixed-ram[1] migration, I would like to have multifd ignore
the concept of packets altogether, since the file: migration is not
synchronous.

The main problem I hit is that multifd (ab)uses the knowledge that a
sync packet is sent after a batch of pages and relies (perhaps
inadvertently) on the last post to sem_sync to finish the
migration. Which means that without the sync, the main thread just
rushes and does cleanup while packets are still in flight.

I have add another patch to this series that introduces a
multifd-nopackets option (placeholder name), but it's probably too
early to discuss that so I'm leaving it out.

1- https://lore.kernel.org/r/20230330180336.2791-1-farosas@suse.de

Fabiano Rosas (3):
  migration/multifd: Move channels_ready semaphore
  migration/multifd: Decouple control flow from the SYNC packet
  migration/multifd: Extract sem_done waiting into a function

 migration/multifd.c    | 97 +++++++++++++++++++++++++-----------------
 migration/multifd.h    |  8 ++--
 migration/trace-events |  2 +-
 3 files changed, 63 insertions(+), 44 deletions(-)

-- 
2.35.3


