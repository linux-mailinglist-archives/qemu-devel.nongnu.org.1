Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D66DFA36B2D
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Feb 2025 02:40:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj74z-00046w-El; Fri, 14 Feb 2025 20:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2NB-0006u5-BV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:33:17 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2N8-0002HL-C4
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:33:16 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 20D691F396;
 Fri, 14 Feb 2025 20:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qnRmTpqEz9W0jk8SFq8GULbSb3BMSZ6PsYBIUv+wpnU=;
 b=tcr/gkD7kWy2fZ6PGCmpeZ5queSm7gtJw1EY/XOtTIcA0+4oRbxmgOCmxuCThxmhT+jU4b
 aWiJhlHQaGhCRh/YHN4B+Eor+eSz6tluhFjpwyQnA4kwMRHbBydFCyb5HuM7myi1VCpJKc
 zJ0iVoMv5O9x9sby0jEjhuqLSi47Ykg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565155;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qnRmTpqEz9W0jk8SFq8GULbSb3BMSZ6PsYBIUv+wpnU=;
 b=TNFgvfCBvOZGdxwFG/BXVlbZLtyBGug10zhP4zcNvct8TlFcCK9tSqCik02scv13+Imw0/
 yG8AjKKNOaIC8vBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qnRmTpqEz9W0jk8SFq8GULbSb3BMSZ6PsYBIUv+wpnU=;
 b=tcr/gkD7kWy2fZ6PGCmpeZ5queSm7gtJw1EY/XOtTIcA0+4oRbxmgOCmxuCThxmhT+jU4b
 aWiJhlHQaGhCRh/YHN4B+Eor+eSz6tluhFjpwyQnA4kwMRHbBydFCyb5HuM7myi1VCpJKc
 zJ0iVoMv5O9x9sby0jEjhuqLSi47Ykg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565155;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qnRmTpqEz9W0jk8SFq8GULbSb3BMSZ6PsYBIUv+wpnU=;
 b=TNFgvfCBvOZGdxwFG/BXVlbZLtyBGug10zhP4zcNvct8TlFcCK9tSqCik02scv13+Imw0/
 yG8AjKKNOaIC8vBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CB3113285;
 Fri, 14 Feb 2025 20:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UOGhDmGor2cgEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Feb 2025 20:32:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 18/22] migration: use parameters.mode in cpr_state_save
Date: Fri, 14 Feb 2025 17:31:55 -0300
Message-Id: <20250214203159.30168-19-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250214203159.30168-1-farosas@suse.de>
References: <20250214203159.30168-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:email,suse.de:mid,oracle.com:email];
 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Steve Sistare <steven.sistare@oracle.com>

qmp_migrate guarantees that cpr_channel is not null for
MIG_MODE_CPR_TRANSFER when cpr_state_save is called:

    qmp_migrate()
        if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
            return;
        }
        cpr_state_save(cpr_channel)

but cpr_state_save checks for mode differently before using channel,
and Coverity cannot infer that they are equivalent in outgoing QEMU,
and warns that channel may be NULL:

    cpr_state_save(channel)
        MigMode mode = migrate_mode();
        if (mode == MIG_MODE_CPR_TRANSFER) {
            f = cpr_transfer_output(channel, errp);

To make Coverity happy, assert that channel != NULL in cpr_state_save.

Resolves: Coverity CID 1590980
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Message-ID: <1738788841-211843-1-git-send-email-steven.sistare@oracle.com>
[assert instead of using parameters.mode in cpr_state_save]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/cpr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/cpr.c b/migration/cpr.c
index 584b0b98f7..180faab247 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -137,6 +137,7 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     trace_cpr_state_save(MigMode_str(mode));
 
     if (mode == MIG_MODE_CPR_TRANSFER) {
+        g_assert(channel);
         f = cpr_transfer_output(channel, errp);
     } else {
         return 0;
-- 
2.35.3


