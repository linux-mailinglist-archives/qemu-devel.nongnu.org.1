Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16A87CBFF
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Mar 2024 12:13:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5TU-00012v-Vi; Fri, 15 Mar 2024 07:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5TC-0000yQ-Ja
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5TA-0006w7-5Q
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710501083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRWAmIUfoSdpoR0C99EKIAmjCjdtTAOA7tR36NKh9Dg=;
 b=jFP5FvlZpSJJPwatI+py3JRjKanrcZumD1FaNCVPZdoDPOVjD57ARDgA9EdvHG/xNl1cNF
 fSVQBqBL8Vcu6io5fbxz/Nepkr9fKPQWuTV6bDvfezH8SeFGNd5WcIJW0/FsiywcRFRTtv
 QPow1CxKqz66qopNq8Rko+DG10iaSjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-SlNmIMZ_P6KbtD3uAoxU-A-1; Fri, 15 Mar 2024 07:11:20 -0400
X-MC-Unique: SlNmIMZ_P6KbtD3uAoxU-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09035101A523;
 Fri, 15 Mar 2024 11:11:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACCEC202451F;
 Fri, 15 Mar 2024 11:11:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH 6/9] tests/qemu-iotests: Restrict test 156 to the 'file'
 protocol
Date: Fri, 15 Mar 2024 12:11:05 +0100
Message-ID: <20240315111108.153201-7-thuth@redhat.com>
In-Reply-To: <20240315111108.153201-1-thuth@redhat.com>
References: <20240315111108.153201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The test fails completely when you try to use it with a different
protocol, e.g. with "./check -ssh -qcow2 156".
The test uses some hand-crafted JSON statements which cannot work with other
protocols, thus let's change this test to only support the 'file' protocol.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/156 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index a9540bd80d..97c2d86ce5 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -50,7 +50,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt qcow2 qed
-_supported_proto generic
+_supported_proto file
 # Copying files around with cp does not work with external data files
 _unsupported_imgopts data_file
 
-- 
2.44.0


