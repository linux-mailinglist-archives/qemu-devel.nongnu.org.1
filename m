Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D0777CE42
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:39:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvBw-0008Oa-Cx; Tue, 15 Aug 2023 10:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qVvBt-0008Ls-R5
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:38:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qVvBp-0002u8-AP
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:38:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F3CDA1F38D;
 Tue, 15 Aug 2023 14:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692110312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wU3iikXi5BZk2SJFQ/Xa736YjUj5DqWRqBwuYPdPLFo=;
 b=dOMQHTsqgfMtz4SvCvQqI+UJMNlIFY8bI/8GgfGqF8Zfi+X3Q5f2pJnPLz3Xb4wIjBFyzy
 +pKeyQOnHuRmFFbj9fdT15qFKSSG15o01m8/lHBPnEByWtceuj0i7SyVwJlkI2Igog73qz
 KzLtphKw1aBvS7CLN7JiJj2EGC+dc0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692110312;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wU3iikXi5BZk2SJFQ/Xa736YjUj5DqWRqBwuYPdPLFo=;
 b=gYlZ7S28Ms0qanT2mTLPhu6f+rpRRc9D/QR6CLDFj79Gh3rbdFeFBDElRbwyFUK3X27UEt
 na6XbR+XFFVxahDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7B7813909;
 Tue, 15 Aug 2023 14:38:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +ZMeHOaN22T0WQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 15 Aug 2023 14:38:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 0/5] migration/ram: Merge zero page handling
Date: Tue, 15 Aug 2023 11:38:23 -0300
Message-Id: <20230815143828.15436-1-farosas@suse.de>
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

Hi,

This is another small series that I extracted from my fixed-ram series
and that could be already considered for merging.

This is just code movement, no functional change. The objective is to
consolidate the zero page handling in the same routine that saves the
page header and does accounting. Then in the future I'll be able to
just return early because fixed-ram ignores zero pages.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/968300062

Fabiano Rosas (5):
  migration/ram: Remove RAMState from xbzrle_cache_zero_page
  migration/ram: Stop passing QEMUFile around in save_zero_page
  migration/ram: Move xbzrle zero page handling into save_zero_page
  migration/ram: Return early from save_zero_page
  migration/ram: Merge save_zero_page functions

 migration/ram.c | 75 ++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

-- 
2.35.3


