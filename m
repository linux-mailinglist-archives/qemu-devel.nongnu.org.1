Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A997118F5
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 23:22:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2IOV-000186-7Q; Thu, 25 May 2023 17:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q2IOJ-00017J-Ns
 for qemu-devel@nongnu.org; Thu, 25 May 2023 17:21:00 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q2IOI-0001lC-3P
 for qemu-devel@nongnu.org; Thu, 25 May 2023 17:20:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A9A621C31;
 Thu, 25 May 2023 21:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685049652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YshmVS/nJh7Yg3ikVyObqrwt1xPQ6peGpZpry3DnKmM=;
 b=SlXhE0pYbsymlw2wvY/Sa0WGYKYDIJXVZtXElhDbntfhWx4AqAKNWZ0Ix0MQfn6I7/dr23
 EzvzYW0wPqHqK816vNczSKqiS4gMzqlrj/hkAazIA2H9zIXhBoK0+hNBYEIJjhukq6ocH1
 Pkf26XRJLGf3d3VF7nDCeJEnEXhjUzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685049652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YshmVS/nJh7Yg3ikVyObqrwt1xPQ6peGpZpry3DnKmM=;
 b=qxbcrX7szKYTnULzpziodfuyQ4LC4txoK1ANs0MrdaAByW2l1QWU8oFFA6HIFlWIvtae3h
 pi+WoRe+CSoRgbDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D48DC134B2;
 Thu, 25 May 2023 21:20:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QDcMJzLRb2SNKgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 25 May 2023 21:20:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 2/2] meson: Add static glib dependency for initrd-stress.img
Date: Thu, 25 May 2023 18:20:44 -0300
Message-Id: <20230525212044.30222-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230525212044.30222-1-farosas@suse.de>
References: <20230525212044.30222-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

We recently moved glib detection code to meson but the static libs
were left out. Add a specific dependency for stress.c which is linked
statically.

$ make V=1 tests/migration/initrd-stress.img

before:
 cc -m64 -mcx16 -o tests/migration/stress ... -static -Wl,--start-group
 /usr/lib64/libglib-2.0.so -Wl,--end-group
 ...
 bin/ld: attempted static link of dynamic object `/usr/lib64/libglib-2.0.so'

after:
 cc -m64 -mcx16 -o tests/migration/stress ... -static -pthread
 -Wl,--start-group -lm /usr/lib64/libpcre.a -lglib-2.0 -Wl,--end-group

Fixes: fc9a809e0d ("build: move glib detection and workarounds to meson")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/migration/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/migration/meson.build b/tests/migration/meson.build
index dd562355a1..ac71f13290 100644
--- a/tests/migration/meson.build
+++ b/tests/migration/meson.build
@@ -1,9 +1,11 @@
 sysprof = dependency('sysprof-capture-4', required: false)
+glib_static = dependency('glib-2.0', version: glib_req_ver, required: false,
+                         method: 'pkg-config', static: true)
 
 stress = executable(
   'stress',
   files('stress.c'),
-  dependencies: [glib, sysprof],
+  dependencies: [glib_static, sysprof],
   link_args: ['-static'],
   build_by_default: false,
 )
-- 
2.35.3


