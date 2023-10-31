Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C977DCB7D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:11:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmeS-0004Re-74; Tue, 31 Oct 2023 07:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmeQ-0004Nd-6T
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmeN-0006zR-GU
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698750670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQCgrIYKTPXGuFD9c+YZAZ+xUtgJlLfCEQiQ9SuG0BE=;
 b=bKhZUgP7g995PSd8ueLsJ4YpbWhl7K7QKs/9zmJQ/81VHbat7kbOaagJLt3ExiP/N77rvu
 e/PQKVxM8KXQEgQ5Sur/qWHHb37IIvPzRQSUsgr5ef8N/nzzdwfz2/xp2YLATMcrvv8bbT
 bBos/zUbi13LHR/52h5rzPZ8NpFtXpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-J0pcYw20NYmtXiSd8psJbw-1; Tue, 31 Oct 2023 07:11:02 -0400
X-MC-Unique: J0pcYw20NYmtXiSd8psJbw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B14A816F27;
 Tue, 31 Oct 2023 11:11:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1FCD2026D4C;
 Tue, 31 Oct 2023 11:11:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EABB121E691F; Tue, 31 Oct 2023 12:10:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, dave@treblig.org,
 jasowang@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 mst@redhat.com, david@redhat.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
Subject: [PATCH 4/7] ui/qmp-cmds: Improve two error messages
Date: Tue, 31 Oct 2023 12:10:56 +0100
Message-ID: <20231031111059.3407803-5-armbru@redhat.com>
In-Reply-To: <20231031111059.3407803-1-armbru@redhat.com>
References: <20231031111059.3407803-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

set_password with "protocol": "vnc" supports only "connected": "keep".
Any other value is rejected with

    Invalid parameter 'connected'

Improve this to

    parameter 'connected' must be 'keep' when 'protocol' is 'vnc'

client_migrate_info requires "port" or "tls-port".  When both are
missing, it fails with

    Parameter 'port/tls-port' is missing

Improve this to

    parameter 'port' or 'tls-port' is required

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 ui/ui-qmp-cmds.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index debc07d678..8880691f92 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -44,7 +44,8 @@ void qmp_set_password(SetPasswordOptions *opts, Error **errp)
         assert(opts->protocol == DISPLAY_PROTOCOL_VNC);
         if (opts->connected != SET_PASSWORD_ACTION_KEEP) {
             /* vnc supports "connected=keep" only */
-            error_setg(errp, QERR_INVALID_PARAMETER, "connected");
+            error_setg(errp, "parameter 'connected' must be 'keep'"
+                       " when 'protocol' is 'vnc'");
             return;
         }
         /*
@@ -195,7 +196,7 @@ void qmp_client_migrate_info(const char *protocol, const char *hostname,
         }
 
         if (!has_port && !has_tls_port) {
-            error_setg(errp, QERR_MISSING_PARAMETER, "port/tls-port");
+            error_setg(errp, "parameter 'port' or 'tls-port' is required");
             return;
         }
 
-- 
2.41.0


