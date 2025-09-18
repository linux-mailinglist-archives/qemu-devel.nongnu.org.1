Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDFBB3CD99
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Aug 2025 19:00:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNaI-00017U-OP; Sat, 30 Aug 2025 11:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us3T0-0005aS-UZ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 14:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us3Sz-0005ca-IO
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 14:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756490688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/d1KbXp3NlbzRl97qpGniZuRtrRxyln2ywplCOuUaXM=;
 b=L432BJAiwxCgSNSnHtHyw+txycz8RutjuzV8Gv8g1sfasE5f0nz7BUZicH51EvjkioQr8N
 Dyq5falE9H1iQkKHdsbX/lp5oNDJD/xa7JhVzmTXzgE+9YYCrJNOfHY+NPw5eZ8BgQch3T
 6UopNOTofMTKxYb+CzqIaCtBV4hyzr0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-edvmDuEcMJuJZ6GrDQULTg-1; Fri,
 29 Aug 2025 14:04:44 -0400
X-MC-Unique: edvmDuEcMJuJZ6GrDQULTg-1
X-Mimecast-MFC-AGG-ID: edvmDuEcMJuJZ6GrDQULTg_1756490682
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF0EE180035D; Fri, 29 Aug 2025 18:04:42 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E389119560B4; Fri, 29 Aug 2025 18:04:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/14] log: avoid prefix on split qemu_log calls
Date: Fri, 29 Aug 2025 19:03:48 +0100
Message-ID: <20250829180354.2922145-9-berrange@redhat.com>
In-Reply-To: <20250829180354.2922145-1-berrange@redhat.com>
References: <20250829180354.2922145-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Some code makes multiple qemu_log calls to incrementally emit
a single message. Currently timestamps get prepended to all
qemu_log calls, even those continuing a previous incomplete
message.

This changes the qemu_log so it skips adding a new line prefix,
if the previous qemu_log call did NOT end with a newline.

Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/log.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/log.c b/util/log.c
index abdcb6b311..2642a55c59 100644
--- a/util/log.c
+++ b/util/log.c
@@ -143,6 +143,12 @@ void qemu_log_unlock(FILE *logfile)
     }
 }
 
+/*
+ * 'true' if the previous log message lacked a trailing '\n',
+ * and thus the subsequent call must skip any prefix
+ */
+static __thread bool incomplete;
+
 void qemu_log(const char *fmt, ...)
 {
     FILE *f;
@@ -154,7 +160,7 @@ void qemu_log(const char *fmt, ...)
      * was emitted if we are delayed acquiring the
      * mutex
      */
-    if (message_with_timestamp) {
+    if (message_with_timestamp && !incomplete) {
         g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
         timestr = g_date_time_format_iso8601(dt);
     }
@@ -170,6 +176,7 @@ void qemu_log(const char *fmt, ...)
         va_start(ap, fmt);
         vfprintf(f, fmt, ap);
         va_end(ap);
+        incomplete = fmt[strlen(fmt) - 1] != '\n';
         qemu_log_unlock(f);
     }
 }
-- 
2.50.1


