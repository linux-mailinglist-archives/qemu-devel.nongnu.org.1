Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BC7577EF
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:27:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLgyj-0000vd-SG; Tue, 18 Jul 2023 05:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLgyf-0000ur-Iy
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLgyd-0002G2-BN
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689672397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSifammePlI0N9ocPDhift7Ey79hYNo/iASg3St5IYM=;
 b=hhp8XKeJabup51owoZr8XLPXl7r0VkTXmIRxM9w/Pei3XMiFTr3I6NSAu2JUN5gmDNehUe
 rP9umubpwwsPkmPbCnWk5lfNuK5E1g9nCapAXxfP5/EQvde+AeGz8Cy0/ceQIpEutzU2ai
 Wbxn8Lk2VE4S0DsSoFA9cf7zVliC17E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-feshOsnWNdKkGGGD3s07Pw-1; Tue, 18 Jul 2023 05:26:36 -0400
X-MC-Unique: feshOsnWNdKkGGGD3s07Pw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D99A98D168A;
 Tue, 18 Jul 2023 09:26:35 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B44411454143;
 Tue, 18 Jul 2023 09:26:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/3] docs: fix highlighting of CPU ABI header rows
Date: Tue, 18 Jul 2023 10:26:30 +0100
Message-ID: <20230718092631.730255-3-berrange@redhat.com>
In-Reply-To: <20230718092631.730255-1-berrange@redhat.com>
References: <20230718092631.730255-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

The 'header-rows' directive indicates how many rows in the generated
table are to be highlighted as headers. We only have one such row in
the CSV file included. This removes the accident bold highlighting
of the 'i486' CPU model.

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
2.41.0


