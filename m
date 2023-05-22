Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB44270C583
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 20:48:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1AYR-0008AY-Ic; Mon, 22 May 2023 14:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1AYP-00089G-1m
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1AYN-0008JC-3q
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684781201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9wxyHHmtNJw/tCA3q+lIV5qOOTS+hWiwLY3VPrMUxm8=;
 b=NMCATKFhp6eYjP4N8kX1kU8183LGuVhkCPJ9sAErAczltKDSIjb5SamB/OGlBMTGPWIZ4i
 iK2x2XtXO9ELGlogv8xPc42ox0kbtIx3VR2oiKvsdtZ+dhv1yBwtfzY1xlJwWQMJGJsk0j
 RE/0Hz+LVtKAtb0+mNo6KkaPrrK0X04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-mvw270KPPl-QS2NgDy2C6w-1; Mon, 22 May 2023 14:46:39 -0400
X-MC-Unique: mvw270KPPl-QS2NgDy2C6w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D443185A78B;
 Mon, 22 May 2023 18:46:39 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DB39401026;
 Mon, 22 May 2023 18:46:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:qcow2)
Subject: [PATCH] qcow2: Explicit mention of padding bytes
Date: Mon, 22 May 2023 13:46:31 -0500
Message-Id: <20230522184631.47211-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Although we already covered the need for padding bytes with our
changes in commit 3ae3fcfa, commit 66fcbca5 (both v5.0.0) added one
byte and relied on the rest of the text for implicitly covering 7
padding bytes.  For consistency with other parts of the header (such
as the header extension format listing padding from n - m, or the
snapshot table entry listing variable padding), we might as well call
out the remaining 7 bytes as padding until such time (as any) as they
gain another meaning.

Signed-off-by: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Spring cleaning my old branches.

v3: reviving an old patch; v2 was:
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg00687.html
---
 docs/interop/qcow2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index e7f036c286b..2c4618375ad 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -226,6 +226,7 @@ version 2.
                     <https://www.zlib.net/> in QEMU. However, clusters with the
                     deflate compression type do not have zlib headers.

+        105 - 111:  Padding, contents defined below.

 === Header padding ===

-- 
2.40.1


