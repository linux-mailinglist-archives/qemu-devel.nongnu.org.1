Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB507D7C3F
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 07:32:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvsxs-00083o-Q7; Thu, 26 Oct 2023 01:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvsxo-00083T-Ad
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvsxl-0001OK-Fm
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698298281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVs8KLJu7imv5IbYSSSo/doD0lm3spqrnZtJXFxos/0=;
 b=Qx2rc6W9jpGKCw18Ju7nudW4vgU3y/BZcEgXDt7fTC+0WvO9MzqinEmSkUe4HkVxOhs6s8
 rFFJq4NnkIh4u6NHwoS8KBFLI44k2cW4+xWkGqlx12RD/RnRC7eGrnegv3bOb4y3AXt+sd
 QJO/LmHqVyY6iB2gtqo5GmJJOPbfcb8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-WPtLsxsTPPG-FZzWCgHHew-1; Thu, 26 Oct 2023 01:31:16 -0400
X-MC-Unique: WPtLsxsTPPG-FZzWCgHHew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69CD684AF80;
 Thu, 26 Oct 2023 05:31:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43FF8502D;
 Thu, 26 Oct 2023 05:31:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A5FA21E6A26; Thu, 26 Oct 2023 07:31:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, bcain@quicinc.com, imp@bsdimp.com,
 stefanha@redhat.com
Subject: [PATCH 1/1] meson: Enable -Wshadow=local
Date: Thu, 26 Oct 2023 07:31:15 +0200
Message-ID: <20231026053115.2066744-2-armbru@redhat.com>
In-Reply-To: <20231026053115.2066744-1-armbru@redhat.com>
References: <20231026053115.2066744-1-armbru@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Local variables shadowing other local variables or parameters make the
code needlessly hard to understand.  Bugs love to hide in such code.
Evidence: commit bbde656263d (migration/rdma: Fix save_page method to
fail on polling error).

Enable -Wshadow=local to prevent such issues.  Possible thanks to
recent cleanups.  Enabling -Wshadow would prevent more issues, but
we're not yet ready for that.

As usual, the warning is only enabled when the compiler recognizes it.
GCC does, Clang doesn't.

Some shadowed locals remain in bsd-user.  Since BSD prefers Clang,
let's not wait for its cleanup.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index dcef8b1e79..89220443b8 100644
--- a/meson.build
+++ b/meson.build
@@ -462,6 +462,7 @@ warn_flags = [
   '-Wno-tautological-type-limit-compare',
   '-Wno-psabi',
   '-Wno-gnu-variable-sized-type-not-at-end',
+  '-Wshadow=local',
 ]
 
 if targetos != 'darwin'
-- 
2.41.0


