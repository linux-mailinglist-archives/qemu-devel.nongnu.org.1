Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC92739561
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 04:16:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC9rB-0000mT-5i; Wed, 21 Jun 2023 22:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qf-0008BQ-U4
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qd-0005Cg-Pu
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687400099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGM9oDrMA/Qp+v4phUutbR6uhjgyVuEbgqQHcYuNgHY=;
 b=dHwHkGw783MaNWOfRz5C/onGT23pP+4Vf1q/tl5Mqh8CDZ+ijk9ZcaD9unwo1p7SqOPMAR
 rZBvbdj7YtW3W1O3oqxJsmoT0fJtpqLX4s56wgzg37VJAsmS2tRHsb67rom0CAW/p1AErF
 LABb7GgMc386UVVtv2qZoDTI7jFSH3I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-Kk5Hplx-OaWuFTkuwfQ8_Q-1; Wed, 21 Jun 2023 22:14:52 -0400
X-MC-Unique: Kk5Hplx-OaWuFTkuwfQ8_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 316C63C025AD;
 Thu, 22 Jun 2023 02:14:52 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.193.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17263112132C;
 Thu, 22 Jun 2023 02:14:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/30] migration: Change qemu_file_transferred to noflush
Date: Thu, 22 Jun 2023 04:13:15 +0200
Message-Id: <20230622021320.66124-26-quintela@redhat.com>
In-Reply-To: <20230622021320.66124-1-quintela@redhat.com>
References: <20230622021320.66124-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We do a qemu_fclose() just after that, that also does a qemu_fflush(),
so remove one qemu_fflush().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230530183941.7223-3-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index f26b455764..b2199d1039 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2952,7 +2952,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
         goto the_end;
     }
     ret = qemu_savevm_state(f, errp);
-    vm_state_size = qemu_file_transferred(f);
+    vm_state_size = qemu_file_transferred_noflush(f);
     ret2 = qemu_fclose(f);
     if (ret < 0) {
         goto the_end;
-- 
2.40.1


