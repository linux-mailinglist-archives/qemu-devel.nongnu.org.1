Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 313FF7118F4
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 23:22:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2IOZ-00019A-Ny; Thu, 25 May 2023 17:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q2IOL-00017Q-9Y
 for qemu-devel@nongnu.org; Thu, 25 May 2023 17:21:01 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q2IOI-0001kM-5C
 for qemu-devel@nongnu.org; Thu, 25 May 2023 17:21:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6902B21972;
 Thu, 25 May 2023 21:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685049650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2iRwSuEcxRdCDJUgTwUbDOrXAWdGURsmoQxRwS9ji3o=;
 b=QBY5AQqalfD2dPBFRnnGRJ4CqO/U1+5PhV3duKaPSkelID6L0rJHiz/lkejCbuGIp4e2Ex
 dmB3Q05+OKPjGh7kAMspEZOdlx0cGjJjVM0RKx1li4PuEsR2tUNTo3jBLWxRefJP/9o23N
 o0BFkp28OizDXPm9ZWX870c2LJIGwoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685049650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2iRwSuEcxRdCDJUgTwUbDOrXAWdGURsmoQxRwS9ji3o=;
 b=t4wKsluViYNOxngQVORKTecLpn8DchjJ6UiQvUODHTSBiPQO5xoRTfxfea8o1FSFET06Lq
 FfdIL7YqDwGel3Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A18DC134B2;
 Thu, 25 May 2023 21:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eG/aGjDRb2SNKgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 25 May 2023 21:20:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] meson: Remove leftover comment
Date: Thu, 25 May 2023 18:20:43 -0300
Message-Id: <20230525212044.30222-2-farosas@suse.de>
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

Commit d2e6f9272d ("fuzz: remove fork-fuzzing scaffolding") removed
the linker script and forgot to remove the comment.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/meson.build b/meson.build
index ef181ff2df..ba1b7012cd 100644
--- a/meson.build
+++ b/meson.build
@@ -395,8 +395,6 @@ if targetos != 'sunos' and not get_option('tsan')
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--warn-common')
 endif
 
-# Specify linker-script with add_project_link_arguments so that it is not placed
-# within a linker --start-group/--end-group pair
 if get_option('fuzzing')
   # Specify a filter to only instrument code that is directly related to
   # virtual-devices.
-- 
2.35.3


