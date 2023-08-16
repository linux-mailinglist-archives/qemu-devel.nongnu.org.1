Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E45B077E8B5
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:29:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWLFs-0003nv-IR; Wed, 16 Aug 2023 14:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWLFq-0003na-Kg
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:28:26 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWLFm-0006nv-Nq
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:28:25 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CC8E21881;
 Wed, 16 Aug 2023 18:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692210501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=V41yHY+VhEzBJLgPRgImQeA8iZH1I9sjlnZoIOh/efw=;
 b=VwAtLgRE2n3NIMjqdJedhvSgPHb+LSCMckG/AG7ATwiVOnfE6bPU1DHzHCRIJNIAYOWAhC
 7khQFK/J+JjiGSc8G+39nxjKhflV1MrQlJuOIf37ScrGr1g6njCEFXNad3b7XOKAE9esvo
 W0DPeNGHL2olfgu0COj/uhh6mUJ7qsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692210501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=V41yHY+VhEzBJLgPRgImQeA8iZH1I9sjlnZoIOh/efw=;
 b=BUUEFVjC8emMtPwh23IgjpsJ/y46h0qaHC5KoU34ywKf2W+yqkTckqQLak5SIJUvvcX8jv
 0e8d0TO07TO+jnAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01174133F2;
 Wed, 16 Aug 2023 18:28:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MHc2L0MV3WTxbQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 16 Aug 2023 18:28:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 0/4] migration/ram: Merge zero page handling
Date: Wed, 16 Aug 2023 15:28:13 -0300
Message-Id: <20230816182817.17590-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

For v2 I fixed patch 3 which had a hunk belonging to patch 5.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/969706915

v1:
https://lore.kernel.org/r/20230815143828.15436-1-farosas@suse.de

Hi,

This is another small series that I extracted from my fixed-ram series
and that could be already considered for merging.

This is just code movement, no functional change. The objective is to
consolidate the zero page handling in the same routine that saves the
page header and does accounting. Then in the future I'll be able to
just return early because fixed-ram ignores zero pages.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/968300062

Fabiano Rosas (4):
  migration/ram: Remove RAMState from xbzrle_cache_zero_page
  migration/ram: Stop passing QEMUFile around in save_zero_page
  migration/ram: Move xbzrle zero page handling into save_zero_page
  migration/ram: Merge save_zero_page functions

 migration/ram.c | 75 ++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

-- 
2.35.3


