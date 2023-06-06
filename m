Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B07246AC
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xwm-0008EW-VQ; Tue, 06 Jun 2023 10:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6Xwk-00080J-CW
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:46:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6Xwi-0004S4-SV
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:46:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC83B1F8A8;
 Tue,  6 Jun 2023 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686062763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EqSJUiPJ3diyQ5Qjk3MR0/t7OAkSvn9VVVCIkeEHCxg=;
 b=PAz+GzegJ7TKTBNNpv6/sPVm7dlOMiC+xx/iQzhNrsgqB74KQHX14E/eC+sURI/vmsVkTW
 GmK6aSwhtWqNItl26uxlabp4t7kxKXXaFdjhJsVtZdzUd+sHaBOA6Ui8hJM/wgQ//wJvIW
 N62DqKHvFIbDyHGZrFYxrf/UERW77oc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686062763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EqSJUiPJ3diyQ5Qjk3MR0/t7OAkSvn9VVVCIkeEHCxg=;
 b=gPPHjDcFOl+GCYZb01mPoGFP51ecAZnYxvUnjxZIS9GRtBcFTRhCjGmePv0eQMjTMdFhwu
 CR7CorT1czS78EAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CBC213519;
 Tue,  6 Jun 2023 14:46:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WCa3OKhGf2SRCAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 06 Jun 2023 14:46:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/3] tests/qtest: Re-enable multifd cancel test
Date: Tue,  6 Jun 2023 11:45:51 -0300
Message-Id: <20230606144551.24367-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230606144551.24367-1-farosas@suse.de>
References: <20230606144551.24367-1-farosas@suse.de>
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

We've found the source of flakiness in this test, so re-enable it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b0c355bbd9..800ad23b75 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2778,14 +2778,8 @@ int main(int argc, char **argv)
     }
     qtest_add_func("/migration/multifd/tcp/plain/none",
                    test_multifd_tcp_none);
-    /*
-     * This test is flaky and sometimes fails in CI and otherwise:
-     * don't run unless user opts in via environment variable.
-     */
-    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-        qtest_add_func("/migration/multifd/tcp/plain/cancel",
-                       test_multifd_tcp_cancel);
-    }
+    qtest_add_func("/migration/multifd/tcp/plain/cancel",
+                   test_multifd_tcp_cancel);
     qtest_add_func("/migration/multifd/tcp/plain/zlib",
                    test_multifd_tcp_zlib);
 #ifdef CONFIG_ZSTD
-- 
2.35.3


