Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D7672370D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 08:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6PgR-0004o7-8E; Tue, 06 Jun 2023 01:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgN-0004mq-BH
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgL-00047K-Qe
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686030997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yryagvf81PRjf69L7mQKMOEyrJPFFx37Qy2oK85oHGo=;
 b=UWQAHDgpkcrUIHIydZDKZ1S+gsY+LAIzFqj2SQFxEypT1Ee9EjWd2eSNkGviv1GC87nERA
 2ZskwxRp/b+x/qhRQCVyWi7ludmjQfifRj1Nl5X5/QSpaZwArp7i9RE8oMPm8VZzafeHm2
 EySnu7/nzPcpTfF/38Qku54XNypAnns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-Pp79o_4vMjCCj8wQCOi1Ow-1; Tue, 06 Jun 2023 01:56:35 -0400
X-MC-Unique: Pp79o_4vMjCCj8wQCOi1Ow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B408800BFF;
 Tue,  6 Jun 2023 05:56:35 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5390F2166B25;
 Tue,  6 Jun 2023 05:56:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Max Fritz <antischmock@googlemail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/18] Add conditional dependency for libkeyutils
Date: Tue,  6 Jun 2023 07:56:10 +0200
Message-Id: <20230606055621.523175-8-thuth@redhat.com>
In-Reply-To: <20230606055621.523175-1-thuth@redhat.com>
References: <20230606055621.523175-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Max Fritz <antischmock@googlemail.com>

This modification enables better control over the inclusion of libkeyutils
based on the configuration, enhancing the flexibility of the build system.

Signed-off-by: Max Fritz <antischmock@googlemail.com>
Message-Id: <168471463402.18155.3575359027429939965-1@git.sr.ht>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[thuth: Remove the "kwargs: static_kwargs" part - it's not necessary anymore]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index a61d3e9b06..576bc2fdbd 100644
--- a/meson.build
+++ b/meson.build
@@ -1781,8 +1781,10 @@ if gnutls.found()
   tasn1 = dependency('libtasn1',
                      method: 'pkg-config')
 endif
-keyutils = dependency('libkeyutils', required: false,
-                      method: 'pkg-config')
+keyutils = not_found
+if get_option('keyring').enabled()
+  keyutils = dependency('libkeyutils', required: false, method: 'pkg-config')
+endif
 
 has_gettid = cc.has_function('gettid')
 
-- 
2.31.1


