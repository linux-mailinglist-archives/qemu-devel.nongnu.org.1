Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64847B9E800
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Sep 2025 11:51:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iZJ-00022t-Un; Thu, 25 Sep 2025 05:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iYu-0001Xo-O0
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iYc-0001lP-PR
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VCiJbepTzAS/un2RtpHR4Hvplf9c95e2auSHQriyqk4=;
 b=VW3UILIXzmiwAY4zqR6lN1RGNDPo8bBBT9sJ9+eKpZLRWYozYm6N2+Z3uEOzVMA0gLw+b5
 ag6uvwFpws2fR0lB8qEW75yYVelWAeMoeSi/oPDKehbOguXQ8WR7rxAAJigTPOkN9sYUFk
 uHuqY8p+ddQOzCqSGqR5rx7g/Iso70o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-DE_8BKf3NRuGZdH2N0NOYg-1; Thu,
 25 Sep 2025 05:46:29 -0400
X-MC-Unique: DE_8BKf3NRuGZdH2N0NOYg-1
X-Mimecast-MFC-AGG-ID: DE_8BKf3NRuGZdH2N0NOYg_1758793588
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C7031800343; Thu, 25 Sep 2025 09:46:28 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E0F7300021A; Thu, 25 Sep 2025 09:46:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 17/23] util: fix interleaving of error prefixes
Date: Thu, 25 Sep 2025 10:44:35 +0100
Message-ID: <20250925094441.1651372-18-berrange@redhat.com>
In-Reply-To: <20250925094441.1651372-1-berrange@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The vreport() function will optionally emit an prefix for error
messages which is output to stderr incrementally. In the event
that two vreport() calls execute concurrently, there is a risk
that the prefix output will interleave. To address this it is
required to take a lock on 'stderr' when outputting errors.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/error-report.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/util/error-report.c b/util/error-report.c
index 222c40d0d1..b6aa20dbae 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -226,6 +226,8 @@ static void vreport(report_type type, const char *fmt, va_list ap)
 
     if (monitor_cur_is_hmp()) {
         cur = monitor_cur();
+    } else {
+        flockfile(stderr);
     }
 
     if (message_with_timestamp && !cur) {
@@ -254,6 +256,10 @@ static void vreport(report_type type, const char *fmt, va_list ap)
 
     error_vprintf_mon(cur, fmt, ap);
     error_printf_mon(cur, "\n");
+
+    if (!cur) {
+        funlockfile(stderr);
+    }
 }
 
 /*
-- 
2.50.1


