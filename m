Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 444BD7118F6
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 23:22:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2IOZ-00018N-60; Thu, 25 May 2023 17:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q2IOM-00017Z-9E
 for qemu-devel@nongnu.org; Thu, 25 May 2023 17:21:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q2IOI-0001jA-3Y
 for qemu-devel@nongnu.org; Thu, 25 May 2023 17:21:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 375CD1FDE2;
 Thu, 25 May 2023 21:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685049648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=leOmqE673cmTtQzPOWqzf87sEvLsc51m59Leg3i8wsg=;
 b=E0byoY/u8plJxemQDOs4YEAzzCXv4XEt8Ty225fk5k0P1UFi+NgIFrCU6Rp2yQQP1aCjws
 M24cQ8YT8l7qTimEWUw32xdNOwThc3DekvYQU00DqSMKsvAHn84cGHlpzNmPfjkg8tNeQ7
 9pt7dlElaM91kj9IF/jADrgC7ISJg5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685049648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=leOmqE673cmTtQzPOWqzf87sEvLsc51m59Leg3i8wsg=;
 b=aJ+Ss07y4DwQwzbbRSsVaFHVlNyrc3Sb5au/RlBsQiuLqnRpwQ+GdJtODwl0U9pwnwS72/
 /C44L4CjMppkCgAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BDA7134B2;
 Thu, 25 May 2023 21:20:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8LbIBS/Rb2SNKgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 25 May 2023 21:20:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/2] meson: Fix initrd-stress.img build
Date: Thu, 25 May 2023 18:20:42 -0300
Message-Id: <20230525212044.30222-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Just a small fix to the build of the initrd used by the migration
guestperf.py script.

$ cd build
$ make tests/migration/initrd-stress.img   <-- BROKEN
$ ./tests/migration/guestperf.py --binary /path/to/qemu-system-x86_64 \
--initrd ./tests/migration/initrd-stress.img --debug

Fabiano Rosas (2):
  meson: Remove leftover comment
  meson: Add static glib dependency for initrd-stress.img

 meson.build                 | 2 --
 tests/migration/meson.build | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.35.3


