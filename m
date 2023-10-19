Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ADE7D0288
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 21:27:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtYcn-00064s-RP; Thu, 19 Oct 2023 15:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtYcl-00061g-Pm
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:24:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtYck-0004ry-3M
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:24:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CC5DE21A63;
 Thu, 19 Oct 2023 19:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697743438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mrGSzXr+Xw8NneZiJOrBrc+5keAbMKby0ZStEj+MOCI=;
 b=jYs4m16ONdizyGxzoWU/fGc6N8B6jfTFn9wy5LXCq9LvtwSpN/SOk9059W/tifQrpkTJ7B
 8aatKYi5479XoPDBiTS+fSAPKa7aEFQNDIt7C4b7hImVPU/ymnf2CQCGdKFQCYZ9Yii/1i
 3eJ412gHUYheJm+ZKn3gC3K+FtjmNBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697743438;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mrGSzXr+Xw8NneZiJOrBrc+5keAbMKby0ZStEj+MOCI=;
 b=Q1vH3WMOGnFs5GWQRAMhnhp/YyjstegofC0Ty5lV2AXkYmN8Bfn/CaHpE1As62DKQC7ANH
 kc8/OnkRcXA2DKCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C4EA1357F;
 Thu, 19 Oct 2023 19:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id G7MVFUuCMWWWEwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 19:23:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com,
 Het Gala <het.gala@nutanix.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v14 00/14] migration: Modify 'migrate' and 'migrate-incoming'
 QAPI commands for migration
Date: Thu, 19 Oct 2023 16:23:39 -0300
Message-Id: <20231019192353.31500-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -6.10
X-Spamd-Result: default: False [-6.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[13];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[99.99%]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

Hi,

I had to make this a new version because the file: tests are already
merged and Het's patches break them unless we also convert the file
transport to the new API.

I did the conversion and added separate patches as fixups so we can
review my additions separately.

Het's series untouched aside from conflict resolution.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1043006299

v13 by Het Gala:
https://lore.kernel.org/r/20231012151052.154106-1-het.gala@nutanix.com

Fabiano Rosas (4):
  fixup! migration: New QAPI type 'MigrateAddress'
  fixup! migration: convert migration 'uri' into 'MigrateAddress'
  migration: Convert the file backend the new QAPI syntax
  fixup! migration: New migrate and migrate-incoming argument 'channels'

Het Gala (10):
  migration: New QAPI type 'MigrateAddress'
  migration: convert migration 'uri' into 'MigrateAddress'
  migration: convert socket backend to accept MigrateAddress
  migration: convert rdma backend to accept MigrateAddress
  migration: convert exec backend to accept MigrateAddress.
  migration: New migrate and migrate-incoming argument 'channels'
  migration: modify migration_channels_and_uri_compatible() for new QAPI
    syntax
  migration: Implement MigrateChannelList to qmp migration flow.
  migration: Implement MigrateChannelList to hmp migration flow.
  migration: modify test_multifd_tcp_none() to use new QAPI syntax.

 migration/exec.c               |  74 ++++++++----
 migration/exec.h               |   8 +-
 migration/file.c               |  24 ++--
 migration/file.h               |  10 +-
 migration/migration-hmp-cmds.c |  27 ++++-
 migration/migration.c          | 203 ++++++++++++++++++++++++++-------
 migration/migration.h          |   3 +-
 migration/rdma.c               |  33 ++----
 migration/rdma.h               |   6 +-
 migration/socket.c             |  39 ++-----
 migration/socket.h             |   7 +-
 qapi/migration.json            | 174 +++++++++++++++++++++++++++-
 system/vl.c                    |   2 +-
 tests/qtest/migration-test.c   |   7 +-
 14 files changed, 467 insertions(+), 150 deletions(-)

-- 
2.35.3


