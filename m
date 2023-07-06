Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6AE74A492
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 21:53:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHV1P-0003xg-EQ; Thu, 06 Jul 2023 15:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHV1N-0003xD-Pq
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:52:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHV1M-0005eq-87
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:52:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9CEFA227AC;
 Thu,  6 Jul 2023 19:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688673126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCr1IPzYZWOCvRrCRoSjXxnCWgFiXvGOjaJY6KZPbCU=;
 b=laalwQkns0pn95Xtf4hFkpRResAG3Pq44QyvCHA3cEMlOGeupqCoAPpw1609uY3y2lsA3B
 pHq3dakwb5aAI7kUDYZm9yTkmBsZxeDU8SkXC4tOrVkZjNAMHmqP0DcilfmhGJ4uye3vpc
 IpRm7OJthRC0o17LHGqfg1At1ia2M3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688673126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCr1IPzYZWOCvRrCRoSjXxnCWgFiXvGOjaJY6KZPbCU=;
 b=TiVcMaULLEQtnt1kWOso2O3ohwj1nAWnUCaHBAGuvtwBP8QH616jIl+ejEmyIjrZQV62M1
 3N1UxgavDk64j6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B57B138FC;
 Thu,  6 Jul 2023 19:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GKZOEWUbp2STDQAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 06 Jul 2023 19:52:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/2] target/arm: Return negative value on power state
 migration error
Date: Thu,  6 Jul 2023 16:52:00 -0300
Message-Id: <20230706195201.18595-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230706195201.18595-1-farosas@suse.de>
References: <20230706195201.18595-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

All migration hooks, except this one, return -1 on error and 0 on
success.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 target/arm/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index fc4a4a4064..db3fcd5ae4 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -702,7 +702,7 @@ static int put_power(QEMUFile *f, void *opaque, size_t size,
         qemu_put_byte(f, powered_off);
         return 0;
     } else {
-        return 1;
+        return -1;
     }
 }
 
-- 
2.35.3


