Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E26AB2646E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 13:38:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umWFP-00021t-OP; Thu, 14 Aug 2025 07:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fvogt@suse.de>) id 1umWFL-00021D-Jq
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 07:35:51 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fvogt@suse.de>) id 1umWFH-0000jv-J0
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 07:35:51 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7960B1F7CB;
 Thu, 14 Aug 2025 11:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755171342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HugyceA10g+uJM4lg/ZO2kFWXr4Q+pj+/yrfpJdEEHQ=;
 b=cgfY1RlX6HOR4pehoXxT7vP8UJlI9ZY8LM4g9lrwUeyZO5rEpo4b6mDtkOaiapZ/CPHr/S
 Mp2BEU/L7OL9R3eGD/+DKqWaZceZKmHHD8lG3zKvPQlLPdBTtgA8Px9dcCNHgD2SmR3rpC
 6eEA/pCs8mxMPGnKhRpAo0o/CM1Yf8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755171342;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HugyceA10g+uJM4lg/ZO2kFWXr4Q+pj+/yrfpJdEEHQ=;
 b=vUkrfQ+sOQ/IjqMPTcSWVdVqzM74NyoCYaM1GHJpS1pl/VFLmd12UgZFSp6nn/GlSal7KR
 bDE7n0X6ybk1GhCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cgfY1RlX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vUkrfQ+s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755171342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HugyceA10g+uJM4lg/ZO2kFWXr4Q+pj+/yrfpJdEEHQ=;
 b=cgfY1RlX6HOR4pehoXxT7vP8UJlI9ZY8LM4g9lrwUeyZO5rEpo4b6mDtkOaiapZ/CPHr/S
 Mp2BEU/L7OL9R3eGD/+DKqWaZceZKmHHD8lG3zKvPQlLPdBTtgA8Px9dcCNHgD2SmR3rpC
 6eEA/pCs8mxMPGnKhRpAo0o/CM1Yf8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755171342;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HugyceA10g+uJM4lg/ZO2kFWXr4Q+pj+/yrfpJdEEHQ=;
 b=vUkrfQ+sOQ/IjqMPTcSWVdVqzM74NyoCYaM1GHJpS1pl/VFLmd12UgZFSp6nn/GlSal7KR
 bDE7n0X6ybk1GhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B1CA136AE;
 Thu, 14 Aug 2025 11:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hKK3GQ7KnWjlRQAAD6G6ig
 (envelope-from <fvogt@suse.de>); Thu, 14 Aug 2025 11:35:42 +0000
From: Fabian Vogt <fvogt@suse.de>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/intc/xics: Add missing call to register vmstate_icp_server
Date: Thu, 14 Aug 2025 13:35:42 +0200
Message-ID: <6187781.lOV4Wx5bFT@fvogt-thinkpad>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-3.48 / 50.00]; BAYES_HAM(-2.97)[99.88%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[nongnu.org,gmail.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim]
X-Rspamd-Queue-Id: 7960B1F7CB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.48
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=fvogt@suse.de; helo=smtp-out2.suse.de
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

An obsolete wrapper function with a workaround was removed entirely,
without restoring the call it wrapped.

Without this, the guest is stuck after savevm/loadvm.

Fixes: 24ee9229fe31 ("ppc/spapr: remove deprecated machine pseries-2.9")
Signed-off-by: Fabian Vogt <fvogt@suse.de>
---
 hw/intc/xics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index d9a199e883..200710eb6c 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -335,6 +335,8 @@ static void icp_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+
+    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
 }
 
 static void icp_unrealize(DeviceState *dev)
-- 
2.50.1





