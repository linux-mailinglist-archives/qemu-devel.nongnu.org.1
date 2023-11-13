Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A2D7EA147
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 17:30:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Zoj-0000ZS-BY; Mon, 13 Nov 2023 11:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2Zog-0000Z2-CS
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:29:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2Zoe-0006Ri-Hd
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699892974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vGgybPJ+iHUFFtwNgOyMGMw7qVJDoU7xjqnoePoJmgQ=;
 b=HQSMC6uxgbSRS62asAWDnH7vyU4pCtZ8Q7gENMRD1McIqXIKm2Fqb8PVW9u1KwD33GQiZs
 ywfRmyYDQtrcrIUyD8MfzFT7VMarr788Se0wKUox2K0QD6wILHY7Z2uZ/uuL+2EE3KPmZI
 cNd9qumxetNdAMKrGY/MbKQiX51QaK0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-KNxr0bGxNruBZBY3tjLzDA-1; Mon, 13 Nov 2023 11:29:31 -0500
X-MC-Unique: KNxr0bGxNruBZBY3tjLzDA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27EBB811E7D;
 Mon, 13 Nov 2023 16:29:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBA8D492BE0;
 Mon, 13 Nov 2023 16:29:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] qapi/pragma.json: Improve the comment about the lists of QAPI
 rule exceptions
Date: Mon, 13 Nov 2023 17:29:28 +0100
Message-ID: <20231113162928.54551-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Let's use more inclusive language here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qapi/pragma.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/pragma.json b/qapi/pragma.json
index 7f810b0e97..0aa4eeddd3 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -3,8 +3,8 @@
 
 { 'pragma': { 'doc-required': true } }
 
-# Whitelists to permit QAPI rule violations; think twice before you
-# add to them!
+# Entries in these lists are allowed to violate the QAPI rules (for
+# historical reasons); think twice before you add to them!
 { 'pragma': {
     # Command names containing '_'
     'command-name-exceptions': [
-- 
2.41.0


