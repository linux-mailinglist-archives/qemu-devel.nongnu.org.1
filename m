Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C8E7E1B0C
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:24:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztxa-0001dA-E1; Mon, 06 Nov 2023 02:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qztxY-0001cz-2c
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:23:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qztxW-0006Kl-OO
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699255422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I9D+WsgQUn58hPq9Nowxn6qP6OypiJidZorSMGCHn4E=;
 b=CKyx20JmHSd+Y4iTljtnNpED+W81E7WV+7P3dUAbt/2SXmjemlBE1eso4PD9xQNOJhIyY2
 TTR1eYOLuXL6j4uxKO34r5pbMxZPA7baQrARZXPU36epXMDV/Ma2WUGzG/yYL0w6KuMR1f
 xWQD/seL5cw6X3SqnBZhxuiZhSRTfAk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-4j4XAnyjOM2f9tFglato2A-1; Mon, 06 Nov 2023 02:23:39 -0500
X-MC-Unique: 4j4XAnyjOM2f9tFglato2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80C30185A787;
 Mon,  6 Nov 2023 07:23:38 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C442340C6EB9;
 Mon,  6 Nov 2023 07:23:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 05/23] vl: drop needless -spice checks
Date: Mon,  6 Nov 2023 11:22:54 +0400
Message-ID: <20231106072313.1742543-6-marcandre.lureau@redhat.com>
In-Reply-To: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
References: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since commit 5324e3e958e ("qemu-options: define -spice only #ifdef
CONFIG_SPICE"), it is unnecessary to check at runtime for "-spice"
option.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 system/vl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 3fb569254a..fb0389e4d0 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3475,12 +3475,7 @@ void qemu_init(int argc, char **argv)
                 break;
 #ifdef CONFIG_SPICE
             case QEMU_OPTION_spice:
-                olist = qemu_find_opts_err("spice", NULL);
-                if (!olist) {
-                    error_report("spice support is disabled");
-                    exit(1);
-                }
-                opts = qemu_opts_parse_noisily(olist, optarg, false);
+                opts = qemu_opts_parse_noisily(qemu_find_opts("spice"), optarg, false);
                 if (!opts) {
                     exit(1);
                 }
-- 
2.41.0


