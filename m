Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3F57E5017
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 06:38:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0bG2-0003eQ-LB; Wed, 08 Nov 2023 00:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0bG0-0003eE-KZ
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 00:37:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0bFy-0004J2-01
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 00:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699421856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ma7sJgMajcUHrBURFDSFfTUzDQODc8FTm2dLMKIT5nM=;
 b=D5HY47wt2djmy32UdolzMayt9xx98/XLOmpD3S0JEQ9ye5CFNxbWG9D1kNL0KicS2XICwc
 94kM1GxnBu0dQBed3pO0yszdSE3EpW0fmhH985J/4Ov4Kc4BaeCIA/sSgnS9dB7uhr9gf0
 mWYfHIzZt/2O83kCnmz2HDVQgp4h+7I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-KiKnbdnCM2KMqMTODK-s0g-1; Wed,
 08 Nov 2023 00:37:32 -0500
X-MC-Unique: KiKnbdnCM2KMqMTODK-s0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E21C1C294A3;
 Wed,  8 Nov 2023 05:37:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DAD9502A;
 Wed,  8 Nov 2023 05:37:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 161B421E6A26; Wed,  8 Nov 2023 06:37:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stephen.s.brennan@oracle.com, marcandre.lureau@redhat.com,
 berrange@redhat.com
Subject: [PATCH 1/2] dump: Plug file descriptor leak on non-seekable file
Date: Wed,  8 Nov 2023 06:37:30 +0100
Message-ID: <20231108053731.112043-2-armbru@redhat.com>
In-Reply-To: <20231108053731.112043-1-armbru@redhat.com>
References: <20231108053731.112043-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Fixes: e6549197f7ed (dump: Add command interface for kdump-raw formats)
Fixes: CID 1523842
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 dump/dump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dump/dump.c b/dump/dump.c
index 1c304cadfd..ad5294e853 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -2160,6 +2160,7 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
         return;
     }
     if (kdump_raw && lseek(fd, 0, SEEK_CUR) == (off_t) -1) {
+        close(fd);
         error_setg(errp, "kdump-raw formats require a seekable file");
         return;
     }
-- 
2.41.0


