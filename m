Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8AF7DFF51
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 08:03:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyoCE-00069J-R5; Fri, 03 Nov 2023 03:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoCD-000697-OD
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoCC-00016c-6f
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698994939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akNyN4V+1gMYlC6Efl/CruHSEw0A6BWGqFLyhXEs/fI=;
 b=TwrnS2VMBfYDEN3OtMKVnyWUk+ZuRTq2aziMCeyYsXPbQtekSKYjNa/Fw2jovobKE6kqQq
 a9vVZOJRWDF5TX/lEDDSQ1HbchyWc+GahME7zvtXCslZXpVK+bORM28PHoacvJAX71pvif
 jS15fbLwSjaECFo2PUbiLou7LZucWm8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-nByS8oPRMfq2EPEW4CCGTA-1; Fri, 03 Nov 2023 03:02:15 -0400
X-MC-Unique: nByS8oPRMfq2EPEW4CCGTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40A11185A780;
 Fri,  3 Nov 2023 07:02:15 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36C2F40C6EBC;
 Fri,  3 Nov 2023 07:02:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 richard.henderson@linaro.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PULL 8/8] dump: Drop redundant check for empty dump
Date: Fri,  3 Nov 2023 11:01:36 +0400
Message-ID: <20231103070136.437557-9-marcandre.lureau@redhat.com>
In-Reply-To: <20231103070136.437557-1-marcandre.lureau@redhat.com>
References: <20231103070136.437557-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

dump_init() first computes the size of the dump, taking the filter
area into account, and fails if its zero.  It then looks for memory in
the filter area, and fails if there is none.

This is redundant: if the size of the dump is zero, there is no
memory, and vice versa.  Delete this check.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231031104531.3169721-6-armbru@redhat.com>
---
 dump/dump.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index ec2cfcf9f7..1c304cadfd 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1688,26 +1688,6 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
     }
 }
 
-static int validate_start_block(DumpState *s)
-{
-    GuestPhysBlock *block;
-
-    if (!dump_has_filter(s)) {
-        return 0;
-    }
-
-    QTAILQ_FOREACH(block, &s->guest_phys_blocks.head, next) {
-        /* This block is out of the range */
-        if (block->target_start >= s->filter_area_begin + s->filter_area_length ||
-            block->target_end <= s->filter_area_begin) {
-            continue;
-        }
-        return 0;
-   }
-
-    return -1;
-}
-
 static void get_max_mapnr(DumpState *s)
 {
     GuestPhysBlock *last_block;
@@ -1857,12 +1837,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
         goto cleanup;
     }
 
-    /* Is the filter filtering everything? */
-    if (validate_start_block(s) == -1) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "begin");
-        goto cleanup;
-    }
-
     /* get dump info: endian, class and architecture.
      * If the target architecture is not supported, cpu_get_dump_info() will
      * return -1.
-- 
2.41.0


