Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E88E7577F6
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLgyk-0000wY-Gu; Tue, 18 Jul 2023 05:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLgyg-0000vW-7k
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLgye-0002GN-81
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689672399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePCdIpsVVJCIB1wW1N2U7yqgHWMTcQKvcJLOa3oaT+Q=;
 b=D26dKqHK5AWBXYTwf7VnTJixrBOYaDFRb/uSnUF3IZTbt7lMVsvlppTixrtmNdR81Yg8Hy
 s+cLJgqEkTUeBF3zApoHw9O3VZV1V6YY/eSUMc0R0iDFIyfiDhb12BaOqL1j8I/mm+tdia
 rCiS9uz6ee5BD8tjYBWkJq3C7DW2ohI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-AWwCsI-JNCiMyYiKMOyRuQ-1; Tue, 18 Jul 2023 05:26:37 -0400
X-MC-Unique: AWwCsI-JNCiMyYiKMOyRuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FB288D168B;
 Tue, 18 Jul 2023 09:26:37 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16CF51454142;
 Tue, 18 Jul 2023 09:26:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 3/3] docs: re-generate x86_64 ABI compatibility CSV
Date: Tue, 18 Jul 2023 10:26:31 +0100
Message-ID: <20230718092631.730255-4-berrange@redhat.com>
In-Reply-To: <20230718092631.730255-1-berrange@redhat.com>
References: <20230718092631.730255-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This picks up the new EPYC-Genoa, SapphireRapids & GraniteRapids CPUs,
removes the now deleted Icelake-Client CPU, and adds the newer versions
of many existing CPUs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/cpu-models-x86-abi.csv | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/docs/system/cpu-models-x86-abi.csv b/docs/system/cpu-models-x86-abi.csv
index f3f3b60be1..38b9bae310 100644
--- a/docs/system/cpu-models-x86-abi.csv
+++ b/docs/system/cpu-models-x86-abi.csv
@@ -8,27 +8,37 @@ Cascadelake-Server-v1,✅,✅,✅,✅
 Cascadelake-Server-v2,✅,✅,✅,✅
 Cascadelake-Server-v3,✅,✅,✅,✅
 Cascadelake-Server-v4,✅,✅,✅,✅
+Cascadelake-Server-v5,✅,✅,✅,✅
 Conroe-v1,✅,,,
 Cooperlake-v1,✅,✅,✅,✅
+Cooperlake-v2,✅,✅,✅,✅
 Denverton-v1,✅,✅,,
 Denverton-v2,✅,✅,,
+Denverton-v3,✅,✅,,
 Dhyana-v1,✅,✅,✅,
+Dhyana-v2,✅,✅,✅,
+EPYC-Genoa-v1,✅,✅,✅,✅
 EPYC-Milan-v1,✅,✅,✅,
+EPYC-Milan-v2,✅,✅,✅,
 EPYC-Rome-v1,✅,✅,✅,
 EPYC-Rome-v2,✅,✅,✅,
+EPYC-Rome-v3,✅,✅,✅,
+EPYC-Rome-v4,✅,✅,✅,
 EPYC-v1,✅,✅,✅,
 EPYC-v2,✅,✅,✅,
 EPYC-v3,✅,✅,✅,
+EPYC-v4,✅,✅,✅,
+GraniteRapids-v1,✅,✅,✅,✅
 Haswell-v1,✅,✅,✅,
 Haswell-v2,✅,✅,✅,
 Haswell-v3,✅,✅,✅,
 Haswell-v4,✅,✅,✅,
-Icelake-Client-v1,✅,✅,✅,
-Icelake-Client-v2,✅,✅,✅,
 Icelake-Server-v1,✅,✅,✅,✅
 Icelake-Server-v2,✅,✅,✅,✅
 Icelake-Server-v3,✅,✅,✅,✅
 Icelake-Server-v4,✅,✅,✅,✅
+Icelake-Server-v5,✅,✅,✅,✅
+Icelake-Server-v6,✅,✅,✅,✅
 IvyBridge-v1,✅,✅,,
 IvyBridge-v2,✅,✅,,
 KnightsMill-v1,✅,✅,✅,
@@ -42,15 +52,21 @@ Opteron_G5-v1,✅,✅,,
 Penryn-v1,✅,,,
 SandyBridge-v1,✅,✅,,
 SandyBridge-v2,✅,✅,,
+SapphireRapids-v1,✅,✅,✅,✅
+SapphireRapids-v2,✅,✅,✅,✅
 Skylake-Client-v1,✅,✅,✅,
 Skylake-Client-v2,✅,✅,✅,
 Skylake-Client-v3,✅,✅,✅,
+Skylake-Client-v4,✅,✅,✅,
 Skylake-Server-v1,✅,✅,✅,✅
 Skylake-Server-v2,✅,✅,✅,✅
 Skylake-Server-v3,✅,✅,✅,✅
 Skylake-Server-v4,✅,✅,✅,✅
+Skylake-Server-v5,✅,✅,✅,✅
 Snowridge-v1,✅,✅,,
 Snowridge-v2,✅,✅,,
+Snowridge-v3,✅,✅,,
+Snowridge-v4,✅,✅,,
 Westmere-v1,✅,✅,,
 Westmere-v2,✅,✅,,
 athlon-v1,,,,
-- 
2.41.0


