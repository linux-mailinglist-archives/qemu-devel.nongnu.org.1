Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C55B79223F
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 13:52:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdUZs-00080x-2a; Tue, 05 Sep 2023 07:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdUZZ-0007w6-Ma
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdUZT-0001od-Ly
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693914614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E3+EVss63FxnaQjz2jzumJlXEwKyIyNdXSt4OgImTbw=;
 b=HWcijWc/NMJFP6eUVn6yGdPR9CaY8GqSeApbQsLTt13xkCDQZ7jB10/zYTbIz3jD2oyzFu
 +vKBdZ4hdU6xzfPSx0BGXdiLx1a2SwMpgzL9DPi8PiY+qfebWXaMEEp+ves/5+PWOXcLvC
 ra8FeHg71KRuDKdviERDRjDy1GsL3xk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-gAxQxsS_M0-7xjbP7QH-HA-1; Tue, 05 Sep 2023 07:50:12 -0400
X-MC-Unique: gAxQxsS_M0-7xjbP7QH-HA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02E49101A529;
 Tue,  5 Sep 2023 11:50:12 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 806C840F2D26;
 Tue,  5 Sep 2023 11:50:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [risu PATCH v2 4/4] s390x: Update the configure script for s390x
 support
Date: Tue,  5 Sep 2023 13:50:00 +0200
Message-Id: <20230905115000.53587-5-thuth@redhat.com>
In-Reply-To: <20230905115000.53587-1-thuth@redhat.com>
References: <20230905115000.53587-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Auto-detect s390x hosts and add s390x information to the help text.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index ca2d7db..2f7c580 100755
--- a/configure
+++ b/configure
@@ -58,6 +58,8 @@ guess_arch() {
         ARCH="m68k"
     elif check_define __powerpc64__ ; then
         ARCH="ppc64"
+    elif check_define __s390x__ ; then
+        ARCH="s390x"
     else
         echo "This cpu is not supported by risu. Try -h. " >&2
         exit 1
@@ -139,7 +141,7 @@ Some influential environment variables:
                prefixed with the given string.
 
   ARCH         force target architecture instead of trying to detect it.
-               Valid values=[arm|aarch64|ppc64|ppc64le|m68k]
+               Valid values=[arm|aarch64|m68k|ppc64|ppc64le|s390x]
 
   CC           C compiler command
   CFLAGS       C compiler flags
-- 
2.39.3


