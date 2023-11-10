Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 655E37E834F
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 21:03:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1XiS-00021r-1k; Fri, 10 Nov 2023 15:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r1XiM-0001yK-0n
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:02:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r1XiK-0004cS-Bm
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:02:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0197C1F8C0;
 Fri, 10 Nov 2023 20:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699646567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmwd7iHU0NMBiDqCHDKHLq00DyPOwq8NnlmxuEjsLMc=;
 b=c0+KaYSBTbP0WIPIdh8/fSjGJONOiF92amDY0rFZNXMrS0dQT5lb/Yj7Q4EfZvWKl8bZGW
 f/MjBhXAHb2gUXOTJAg2TYjt9XgtBCBrFugbSzORVUQyI9tgf0/TOxwkZGfWb/MsshHMoP
 PHkxfi/TIqpwZSDSrNOh7SksaOVy2C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699646567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmwd7iHU0NMBiDqCHDKHLq00DyPOwq8NnlmxuEjsLMc=;
 b=DWgoLPswpP577C0T1kGrAMwC4spNHL62cOEtHeSm5aVQeYFODcr5VUTWbLgsnyBeylskGM
 w54tCF+EZdR/naCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74481138FC;
 Fri, 10 Nov 2023 20:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ACsBEGWMTmWiaQAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 10 Nov 2023 20:02:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 1/4] migration/multifd: Stop setting p->ioc before
 connecting
Date: Fri, 10 Nov 2023 17:02:38 -0300
Message-Id: <20231110200241.20679-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231110200241.20679-1-farosas@suse.de>
References: <20231110200241.20679-1-farosas@suse.de>
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

This is being shadowed but the assignments at
multifd_channel_connect() and multifd_tls_channel_connect() .

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ec58c58082..409460684f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -883,8 +883,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 
     trace_multifd_new_send_channel_async(p->id);
     if (!qio_task_propagate_error(task, &local_err)) {
-        p->c = ioc;
-        qio_channel_set_delay(p->c, false);
+        qio_channel_set_delay(ioc, false);
         p->running = true;
         if (multifd_channel_connect(p, ioc, &local_err)) {
             return;
-- 
2.35.3


