Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A9ABCF6A9
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:13:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a7V-0006E8-OZ; Sat, 11 Oct 2025 09:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7K-00067w-Vd
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:58:39 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a77-0004i8-KG
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:58:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 00A3AC0150;
 Sat, 11 Oct 2025 16:58:06 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-pZJw0ZO2; Sat, 11 Oct 2025 16:58:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191085;
 bh=1uUca7a6+MkNXsTvw98aS79VCYXTlBA27mbsctANXQw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ghfqPefw+C9Ck8roNWU7TlC8OkkXx3ewZi05pdgLZ/1jo0mnuaT1Y+7qt6L0Y5ft9
 supR+riU1JWQyeHKOxGt9c4SLbgniN4xHy2ZhfZgjV4FwIYd/FlQ1ep7jrQcp5wOTe
 BXEy/QZojZ4l6NjbSrz5SbER0umowexZX7T15p98=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru,
	eblake@redhat.com
Subject: [PATCH 10/33] qapi/introspect.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 16:56:59 +0300
Message-ID: <20251011135754.294521-19-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qapi/introspect.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index 53100714a8..c8432c8ed8 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -22,10 +22,10 @@
 # `SchemaInfo`.  This lets QMP clients figure out what commands and
 # events are available in this QEMU, and their parameters and results.
 #
-# However, the `SchemaInfo` can't reflect all the rules and restrictions
-# that apply to QMP.  It's interface introspection (figuring out
-# what's there), not interface specification.  The specification is in
-# the QAPI schema.
+# However, the `SchemaInfo` can't reflect all the rules and
+# restrictions that apply to QMP.  It's interface introspection
+# (figuring out what's there), not interface specification.  The
+# specification is in the QAPI schema.
 #
 # Furthermore, while we strive to keep the QMP wire format
 # backwards-compatible across QEMU versions, the introspection output
-- 
2.48.1


