Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BCC71F583
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:04:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qOA-0007zj-Up; Thu, 01 Jun 2023 18:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qO7-0007z7-R2
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qO4-0003zW-HV
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685656994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dh1WAnICC19i2Hq2jRJuF9K4xcQCInEJRvDYJ1ntc9A=;
 b=X3/FugGwuzivm4Vjg3rHZTp+wzGWZ12KUNcpkmzpGRjVRMSa42uFjb3Az8R3qccDCzoYaF
 rj/BFTtzZ1Brc8HqyQo/3+iCchpkm/ZVCjSwafixr8nmxgkpBD8rLbY3ifIIytlGpf0I84
 hyPP5oz6ovEIf72OT0bt+Zb7Mz7xp/o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-suPUrokcMe2ZAndt3IMZeA-1; Thu, 01 Jun 2023 18:03:11 -0400
X-MC-Unique: suPUrokcMe2ZAndt3IMZeA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DAD21C05AB6;
 Thu,  1 Jun 2023 22:03:11 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A323D492B0A;
 Thu,  1 Jun 2023 22:03:10 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:qcow2)
Subject: [PULL 02/21] qcow2: Explicit mention of padding bytes
Date: Thu,  1 Jun 2023 17:02:46 -0500
Message-Id: <20230601220305.2130121-3-eblake@redhat.com>
In-Reply-To: <20230601220305.2130121-1-eblake@redhat.com>
References: <20230601220305.2130121-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Message-Id: <20230522184631.47211-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
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


