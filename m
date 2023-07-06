Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7B8749ABB
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:34:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHNFo-0002wu-My; Thu, 06 Jul 2023 07:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1qHNFf-0002wa-WA
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:34:24 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1qHNFe-0004SI-7D
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:34:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C6EA81FDA0;
 Thu,  6 Jul 2023 11:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688643259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=exsdSDuNag7GKLYR2OTq5/q/dnMJTTdzKeqZl7R3N64=;
 b=SqzB095fSw6YoIAr3jJbVaGmLK27HAVpsUsodtfwdHxrGn6vOKjCnkdfafpgUrBTB1J0kw
 GecB0mL5X99a8tr2N4fOFAI8weXtr+u+V/0ifycF/+ojqS9uXde5EEkfLq0lG8Qgb0ojWC
 PU384xOFFg0Foy/guqg+rypejA8BpdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688643259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=exsdSDuNag7GKLYR2OTq5/q/dnMJTTdzKeqZl7R3N64=;
 b=L0RyOS/r7jfTUfruQ06C8Isy4rwH6wqnxDotzV5gAzJrF3SP7o4IKkcZ5WdkXo6TCskkSO
 xgzSShXDLbW6ojCg==
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by relay2.suse.de (Postfix) with ESMTP id 7FD4F2C142;
 Thu,  6 Jul 2023 11:34:19 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 6FD294A03CA; Thu,  6 Jul 2023 13:34:19 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Subject: [PATCH] linux-user: make sure brk(0) returns a page-aligned value
X-Yow: I LIKE Aisle 7a.
Date: Thu, 06 Jul 2023 13:34:19 +0200
Message-ID: <mvmpm55qnno.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=schwab@suse.de;
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

Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 08162cc966..e8a17377f5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -805,7 +805,7 @@ static abi_ulong brk_page;
 
 void target_set_brk(abi_ulong new_brk)
 {
-    target_brk = new_brk;
+    target_brk = TARGET_PAGE_ALIGN(new_brk);
     brk_page = HOST_PAGE_ALIGN(target_brk);
 }
 
-- 
2.41.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

