Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAFF8B039E
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 09:59:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXWM-0004sq-PA; Wed, 24 Apr 2024 03:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXWJ-0004lK-NG
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXWI-00033U-Aj
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoaWtNsCKSLRYqbbuYslzNbDypTwqGYuH1hIZaUzZcM=;
 b=DP8lTeTe/akVHhR//DK0okwbVO08N4Xp3w+PgN1ZLRSyuQ1VbRJq8MIpvJVS80XqLzFCFt
 XFr/FZinDf1aLROTe+mbC7+/VMVNhazFhRTRR4T08EeqGeLURplRnfGy5NdnfiKE+lXu0A
 qEeyrj1Nw0F2aDMR4AK9/5mJPiK89nQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-AivA7ysUMfyAIDkgK2Gciw-1; Wed,
 24 Apr 2024 03:58:18 -0400
X-MC-Unique: AivA7ysUMfyAIDkgK2Gciw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE83338143A2;
 Wed, 24 Apr 2024 07:58:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6940E3543A;
 Wed, 24 Apr 2024 07:58:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 15/17] docs/devel: fix minor typo in submitting-a-patch.rst
Date: Wed, 24 Apr 2024 09:57:33 +0200
Message-ID: <20240424075735.248041-16-thuth@redhat.com>
In-Reply-To: <20240424075735.248041-1-thuth@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

s/Resolved:/Resolves:/

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240422124128.4034482-1-manos.pitsidianakis@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/submitting-a-patch.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index c641d948f1..83e9092b8c 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -177,7 +177,7 @@ add an additional line with "Fixes: <at-least-12-digits-of-SHA-commit-id>
 
 If your patch fixes a bug in the gitlab bug tracker, please add a line
 with "Resolves: <URL-of-the-bug>" to the commit message, too. Gitlab can
-close bugs automatically once commits with the "Resolved:" keyword get
+close bugs automatically once commits with the "Resolves:" keyword get
 merged into the master branch of the project. And if your patch addresses
 a bug in another public bug tracker, you can also use a line with
 "Buglink: <URL-of-the-bug>" for reference here, too.
-- 
2.44.0


