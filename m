Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 487F2712485
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 12:23:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Ub2-0008U6-EV; Fri, 26 May 2023 06:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2Uaz-0008TL-W4
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2Uax-0003VG-As
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685096569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbKa3MaT6SzJLkTfbD5WvUvPThBSG1t3pPk8V4WvJjA=;
 b=SHFad9kb+GwGlTUDy6LS6nSs7m4+XEWPHc7dU5c8nG7ZaXi0OHwqO4sNlsRjUfdz/3qBnB
 R7rMTdJuOLTbXGfV1jZpELF6wSVwCTrQUm4mwCIOihvW8G/2RfqI2W+oHgDTIyG1POnSqv
 /Jhv9zOm9HsHxDI3fkfkzT9Q4ZO9n14=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-Ed7eQ7ghMyKZDCS5Glkp_Q-1; Fri, 26 May 2023 06:22:48 -0400
X-MC-Unique: Ed7eQ7ghMyKZDCS5Glkp_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00FEF384708A;
 Fri, 26 May 2023 10:22:48 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08226140E95D;
 Fri, 26 May 2023 10:22:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/3] docs: fix highlighting of CPU ABI header rows
Date: Fri, 26 May 2023 11:22:40 +0100
Message-Id: <20230526102240.936998-4-berrange@redhat.com>
In-Reply-To: <20230526102240.936998-1-berrange@redhat.com>
References: <20230526102240.936998-1-berrange@redhat.com>
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

The 'header-rows' directive indicates how many rows in the generated
table are to be highlighted as headers. We only have one such row in
the CSV file included.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/cpu-models-x86.rst.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
index 7f6368f999..ba27b5683f 100644
--- a/docs/system/cpu-models-x86.rst.inc
+++ b/docs/system/cpu-models-x86.rst.inc
@@ -58,7 +58,7 @@ depending on the machine type is in use.
 .. csv-table:: x86-64 ABI compatibility levels
    :file: cpu-models-x86-abi.csv
    :widths: 40,15,15,15,15
-   :header-rows: 2
+   :header-rows: 1
 
 
 Preferred CPU models for Intel x86 hosts
-- 
2.40.1


