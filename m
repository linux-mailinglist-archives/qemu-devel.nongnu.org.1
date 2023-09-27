Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B35C77B09B3
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 18:13:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlX8d-0005od-0K; Wed, 27 Sep 2023 12:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlX8b-0005oF-7i
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 12:11:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlX8Z-000407-NC
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 12:11:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F2ACE21872;
 Wed, 27 Sep 2023 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695831101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qjUN3inDL8Kti/wqBK8S6V4fVpWfDVAB8Ym7h3Na7eI=;
 b=P20goTrwTHbxD3XhWutTXRuJZpxhFWVBsgeFsC/CbOSPZY1u8+luNqgpsJtsgoltg1EK8S
 dVLuw9dT7FT52VhnAcrJo0lspC7MJ8JwVQ9QV+/KdhJE4xOuzY+HbD2/b4l6KZzEBCBIZ/
 HL4F6qcFPhLpjAtxuefOZUB89dWuCdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695831101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qjUN3inDL8Kti/wqBK8S6V4fVpWfDVAB8Ym7h3Na7eI=;
 b=XXqP3ziVxGv6WGrupLOXQ0/+rIkgkt95+WGReKoJVgQdr66SE8vMVYs4l4hPrGpDGEjvCd
 RByEvGPuwHavGWCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A994E1338F;
 Wed, 27 Sep 2023 16:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id l/MlHTxUFGVAAQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 27 Sep 2023 16:11:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH] MAINTAINERS: Add myself as a migration reviewer
Date: Wed, 27 Sep 2023 13:11:38 -0300
Message-Id: <20230927161138.30361-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

I've been dedicating time to reviewing migration patches already for a
while. I'll continue to do so for the foreseeable future.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 355b1960ce..2f2fa60311 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3203,6 +3203,7 @@ Migration
 M: Juan Quintela <quintela@redhat.com>
 R: Peter Xu <peterx@redhat.com>
 R: Leonardo Bras <leobras@redhat.com>
+R: Fabiano Rosas <farosas@suse.de>
 S: Maintained
 F: hw/core/vmstate-if.c
 F: include/hw/vmstate-if.h
-- 
2.35.3


