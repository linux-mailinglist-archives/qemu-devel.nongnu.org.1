Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A66BCF661
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:08:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aDn-0004MR-66; Sat, 11 Oct 2025 10:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDY-0004IU-0O
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:04 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDN-0005Ou-Ej
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6C51FC018A;
 Sat, 11 Oct 2025 17:04:48 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-vf470P58; Sat, 11 Oct 2025 17:04:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191488;
 bh=rFXBB96E86A3fQSXCMSSZzegEJGUuPqsnG2ic46PLlc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=lV8BURAuzzrPHqlJ/WDIUZtB3uHIwUvteg/5spJesYXR6YcpfAPqS/Ooyupe9NNef
 RyXvAjEXQuFpUmaOdlggkK+XSjBL4RyCnROQ69KQUECVcUaGrQA7bwJPgbl7tqlBM8
 9UMH+peSSZeFT3ggArnN/TTu33hqXUM4Q8STtbWg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 08/33] qapi/crypto.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 17:04:14 +0300
Message-ID: <20251011140441.297246-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011140441.297246-1-vsementsov@yandex-team.ru>
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/crypto.json | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index ab6eda4c2f..72ac718147 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -46,7 +46,8 @@
 #
 # @md5: MD5.  Should not be used in any new code, legacy compat only
 #
-# @sha1: SHA-1.  Should not be used in any new code, legacy compat only
+# @sha1: SHA-1.  Should not be used in any new code, legacy compat
+#     only
 #
 # @sha224: SHA-224.  (since 2.7)
 #
@@ -377,8 +378,8 @@
 #     deactivate all keyslots that match password located in
 #     QCryptoSecret with this ID
 #
-# @iter-time: Optional (for activation only).  Number of milliseconds to
-#     spend in PBKDF passphrase processing for the newly activated
+# @iter-time: Optional (for activation only).  Number of milliseconds
+#     to spend in PBKDF passphrase processing for the newly activated
 #     keyslot.  Currently defaults to 2000.
 #
 # @keyslot: Optional.  ID of the keyslot to activate/deactivate.  For
-- 
2.48.1


