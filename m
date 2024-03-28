Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A12EF8795DD
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Mar 2024 15:16:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2u7-0001GF-C1; Tue, 12 Mar 2024 10:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2tK-0000fE-6b
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2t6-0002Bn-3u
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710252831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYHFCmgJJWnJymuPOM0Fiymm9aw+gWR/Ejg103QqNto=;
 b=Fm2Hvbvrv3Bm/jizPgXwZ98Xdofsm6Owb5i1a+j+8WZdcjxl4IJ4JTY/7K1ozhAAAglW92
 yKP73+xupxV/TkavapJ58Wa241oMb6EQE/2iCX4aJmhn0o+rFvvqRR68/ygqNqCSOwNEzs
 o6B5nu1oaao90P02LAaKnStpaOrYJNQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-XI1gPPs_O9OCQJEbt6DXQw-1; Tue, 12 Mar 2024 10:13:46 -0400
X-MC-Unique: XI1gPPs_O9OCQJEbt6DXQw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE451100DE81;
 Tue, 12 Mar 2024 14:13:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99E133C85;
 Tue, 12 Mar 2024 14:13:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3E68021E68B2; Tue, 12 Mar 2024 15:13:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, philmd@linaro.org,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH 08/10] qapi: Correct error message for 'vcpu_dirty_limit'
 parameter
Date: Tue, 12 Mar 2024 15:13:41 +0100
Message-ID: <20240312141343.3168265-9-armbru@redhat.com>
In-Reply-To: <20240312141343.3168265-1-armbru@redhat.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

QERR_INVALID_PARAMETER_VALUE is defined as:

  #define QERR_INVALID_PARAMETER_VALUE \
      "Parameter '%s' expects %s"

The current error is formatted as:

  "Parameter 'vcpu_dirty_limit' expects is invalid, it must greater then 1 MB/s"

Replace by:

  "Parameter 'vcpu_dirty_limit' is invalid, it must greater than 1 MB/s"

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/options.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 40eb930940..c5115f1b5c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1264,9 +1264,8 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->has_vcpu_dirty_limit &&
         (params->vcpu_dirty_limit < 1)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "vcpu_dirty_limit",
-                   "is invalid, it must greater then 1 MB/s");
+        error_setg(errp, "Parameter 'vcpu_dirty_limit' is invalid,"
+                         " it must greater than 1 MB/s");
         return false;
     }
 
-- 
2.44.0


