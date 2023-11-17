Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 392B17EEF58
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 10:55:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3vXm-0007uw-FR; Fri, 17 Nov 2023 04:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3vXj-0007rk-9B
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 04:53:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3vXh-0006fY-NZ
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 04:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700214820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WjYEVIlcBU2zRPVKViS4p1N+o9H6V20dTq/9NZQ5sYg=;
 b=PzApj7X0lOuOrymBTxR3ZmxxFjcXjk0V+5cvPM6ifNNng9137+I6HHchcBE/TFJB9N/CBh
 fqSMnM+DEFRto1AJ5qXiE6LylMQROZMmA5LYh4BftlKX2M36/Fh+dTcDGLNGygaUThRulE
 B9T/xfYDkryFp4xaxHrkKBkumun/8+c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-MjJEBVEONMSTDOXwpJRbJw-1; Fri,
 17 Nov 2023 04:53:36 -0500
X-MC-Unique: MjJEBVEONMSTDOXwpJRbJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04C903C0C109;
 Fri, 17 Nov 2023 09:53:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8384C12911;
 Fri, 17 Nov 2023 09:53:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE22F21E6A37; Fri, 17 Nov 2023 10:53:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/7] qga: Improve guest-exec-status error message
Date: Fri, 17 Nov 2023 10:53:30 +0100
Message-ID: <20231117095334.1819613-4-armbru@redhat.com>
In-Reply-To: <20231117095334.1819613-1-armbru@redhat.com>
References: <20231117095334.1819613-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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

When the PID passed to guest-exec-status does not exist, we report

    "Invalid parameter 'pid'"

Improve this to

    "PID 1234 does not exist"

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20231031111059.3407803-4-armbru@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qga/commands.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands.c b/qga/commands.c
index ce172edd2d..88c1c99fe5 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -154,7 +154,7 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **errp)
 
     gei = guest_exec_info_find(pid);
     if (gei == NULL) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "pid");
+        error_setg(errp, "PID " PRId64 " does not exist");
         return NULL;
     }
 
-- 
2.41.0


