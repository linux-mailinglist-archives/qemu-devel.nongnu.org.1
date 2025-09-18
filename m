Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 395EBB2CDC9
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Aug 2025 22:28:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSwT-0004pz-MI; Tue, 19 Aug 2025 16:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSwR-0004ot-Kw
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSwP-0006XH-DO
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755635300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwEh8EsmV7I7QMOS9h3iHd5uvvEFeboGNn9HqfPy6jU=;
 b=KRaqa8z9g/3zjMM/1gyjxmqQ/X5IIRCyz43fX8L6YSe4uZWFKlsSduZBb0vKsCw7N7t0tJ
 IJV3/A4GSoAMcQToDeBmhDw53o9/rUW3GRaU61uvCkFx2mgZRzfFDn7I6vGpFXerC7loFK
 z8fTKQVGCWY90R8TnIVI/lIyxs+Gj6s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-XqSGshqEN1CvYjnWiLdj9Q-1; Tue,
 19 Aug 2025 16:28:16 -0400
X-MC-Unique: XqSGshqEN1CvYjnWiLdj9Q-1
X-Mimecast-MFC-AGG-ID: XqSGshqEN1CvYjnWiLdj9Q_1755635295
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27B8A1800359; Tue, 19 Aug 2025 20:28:15 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.237])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 089EF19560B0; Tue, 19 Aug 2025 20:28:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, devel@lists.libvirt.org,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 12/12] util: add brackets around guest name in message context
Date: Tue, 19 Aug 2025 21:27:08 +0100
Message-ID: <20250819202708.1185594-13-berrange@redhat.com>
In-Reply-To: <20250819202708.1185594-1-berrange@redhat.com>
References: <20250819202708.1185594-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

The message context can optionally include the guest name if the
argument '-msg guest-name=on' is given. The formatting, however,
does not look good if the guest name contains whitespace. Change
the output to include square brackets to demarcate the name.

Before:

  # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*' -msg guest-name=on -name "fish food"
  fish food qemu-system-x86_64(1146846:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55657e94e690 dir=fish
  fish food qemu-system-x86_64(1146846:main): qcrypto_tls_creds_get_path TLS creds path creds=0x55657e94e690 filename=ca-cert.pem path=<none>
  fish food qemu-system-x86_64(1146846:main): Unable to access credentials fish/ca-cert.pem: No such file or directory

After:

  # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*' -msg guest-name=on -name "fish food"
  [fish food] qemu-system-x86_64(1144713:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5604ada2c950 dir=fish
  [fish food] qemu-system-x86_64(1144713:main): qcrypto_tls_creds_get_path TLS creds path creds=0x5604ada2c950 filename=ca-cert.pem path=<none>
  [fish food] qemu-system-x86_64(1144713:main): Unable to access credentials fish/ca-cert.pem: No such file or directory

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/message.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/util/message.c b/util/message.c
index 300dc10a4f..9ce2e27f5b 100644
--- a/util/message.c
+++ b/util/message.c
@@ -48,19 +48,21 @@ char *qmessage_context(int flags)
         uint64_t thid = qemu_thread_get_id();
         const char *thname = qemu_thread_get_name();
 
-        return g_strdup_printf("%s%s%s%s%s(%" PRIu64 ":%s): ",
+        return g_strdup_printf("%s%s%s%s%s%s(%" PRIu64 ":%s): ",
                                timestr ? timestr : "",
                                timestr ? " " : "",
+                               wknamestr ? "[" : "",
                                wknamestr ? wknamestr : "",
-                               wknamestr ? " " : "",
+                               wknamestr ? "] " : "",
                                pgnamestr ? pgnamestr : "",
                                thid, thname);
     } else {
-        return g_strdup_printf("%s%s%s%s%s%s",
+        return g_strdup_printf("%s%s%s%s%s%s%s",
                                timestr ? timestr : "",
                                timestr ? " " : "",
+                               wknamestr ? "[" : "",
                                wknamestr ? wknamestr : "",
-                               wknamestr ? " " : "",
+                               wknamestr ? "] " : "",
                                pgnamestr ? pgnamestr : "",
                                pgnamestr ? ": " : "");
     }
-- 
2.50.1


