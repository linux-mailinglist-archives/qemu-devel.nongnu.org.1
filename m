Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F1D85E0C1
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 16:16:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoKq-0002Cb-KL; Wed, 21 Feb 2024 10:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcoJi-0000wC-OV
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:15:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rci88-0004nj-Tl
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 03:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708504743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JzkBGVVeocauj1tHOu+yVsER9m+6l0bnVxg2pXsZP4U=;
 b=TKuZGpbD4UUILZ08JlFN27HLYIsxQQqaey89qVxamKoOFhjps6cDKZgTE6MxC2zL2/aq3f
 iENcd20fPg0LyNmIe9yZ//i370lbLNfNZ2qlBkPEYngsOeWIugFQyqZfoGyJoTRLwaLkst
 vpkL+Rqxd8me/eevU9BGd0libHhbLMM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-FLYYuSQpOAGrMhnX_jGNBg-1; Wed,
 21 Feb 2024 03:38:58 -0500
X-MC-Unique: FLYYuSQpOAGrMhnX_jGNBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A0683C23FC6
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 08:38:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 682752166B32;
 Wed, 21 Feb 2024 08:38:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [qemu-web PATCH] Replace deprecated "bundle install --path vendor"
Date: Wed, 21 Feb 2024 09:38:56 +0100
Message-ID: <20240221083856.117001-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When running "bundle install --path vendor", the command complains
that the --path parameter is deprecated nowadays and that
"bundle config set --local path 'vendor'" should be used instead.
So let's update our README accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 README | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 31be741..ee3119e 100644
--- a/README
+++ b/README
@@ -32,7 +32,8 @@ required Jekyll software should be installed locally:
 
 * Install Jekyll and its dependencies
 
-   # bundle install --path vendor
+   # bundle config set --local path 'vendor'
+   # bundle install
 
   NB this last command must be run from the qemu-web.git checkout
   root directory.
-- 
2.43.2


