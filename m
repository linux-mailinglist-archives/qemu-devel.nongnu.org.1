Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EFA84D832
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Feb 2024 04:10:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulH-0008Be-IB; Wed, 07 Feb 2024 22:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXul2-0007XL-Rx
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXul0-0004TQ-Jm
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWjun7fHHlNrofZutKQfly3Mfgqa+fkpDUBVFGm51eQ=;
 b=ZkpBW/cydEovMwNDGv2SCtY8ZXUpMrZh3IqwXFzrRSXVzLCwpvNFJX+L+j06NYJkwGO1Ja
 7D1ZypqmJTTtp7eVDI31tYHaHfNpv4fV1vcz5/7vDWg3vmVGvw5njRmcG23LHu36wViRCx
 391tsIC+AURuuQTop6gza+ckDu7HiPg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-irj1cScEOiqdcrQhKn6TKw-1; Wed,
 07 Feb 2024 22:07:20 -0500
X-MC-Unique: irj1cScEOiqdcrQhKn6TKw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCDCD3C0F18A;
 Thu,  8 Feb 2024 03:07:19 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56F40492BC7;
 Thu,  8 Feb 2024 03:07:16 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 33/34] ci: Remove tag dependency for build-previous-qemu
Date: Thu,  8 Feb 2024 11:05:27 +0800
Message-ID: <20240208030528.368214-34-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
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

From: Peter Xu <peterx@redhat.com>

The new build-previous-qemu job relies on QEMU release tag being present,
while that may not be always true for personal git repositories since by
default tag is not pushed.  The job can fail on those CI kicks, as reported
by Peter Maydell.

Fix it by fetching the tags remotely from the official repository, as
suggested by Dan.

[1] https://lore.kernel.org/r/ZcC9ScKJ7VvqektA@redhat.com

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Link: https://lore.kernel.org/r/20240207005403.242235-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 79bbc8585b..cfe95c1b17 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -189,6 +189,8 @@ build-previous-qemu:
     TARGETS: x86_64-softmmu aarch64-softmmu
   before_script:
     - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
+    - git remote add upstream https://gitlab.com/qemu-project/qemu
+    - git fetch upstream $QEMU_PREV_VERSION
     - git checkout $QEMU_PREV_VERSION
   after_script:
     - mv build build-previous
-- 
2.43.0


