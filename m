Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 409C87FBC56
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:11:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ymT-0002KT-NB; Tue, 28 Nov 2023 09:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7ymP-0002IR-GN
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:09:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7ymO-0006Tc-2I
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701180575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75VZKF3VpSA8jjuqtW2b0qAzr8b2di4P7awJi1iKmHk=;
 b=JVGT3OSSTrFwPEwGTpuJeoEEXhoUPt7mW0uQH7OdFNCqgr/rpiibsKYL3q0w3vyi7CWHpA
 H0NjuKjekaUDgY+KwDSdQDom3dWJ69F91eKbHiZYWHVPUEPrEt+p0nz5eGTuCCnIsHePyB
 DwRPHuzPEkzKZPZKteOyDRIV1+yG/Kw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-bK4SgX4xOG2bkaKJYq4Alw-1; Tue, 28 Nov 2023 09:09:32 -0500
X-MC-Unique: bK4SgX4xOG2bkaKJYq4Alw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEE7D811E88;
 Tue, 28 Nov 2023 14:09:31 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 212955038;
 Tue, 28 Nov 2023 14:09:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 1/4] iotests: fix default machine type detection
Date: Tue, 28 Nov 2023 15:09:23 +0100
Message-ID: <20231128140926.106077-2-kwolf@redhat.com>
In-Reply-To: <20231128140926.106077-1-kwolf@redhat.com>
References: <20231128140926.106077-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

The machine type is being detected based on "-M help" output, and we're
searching for the line ending with " (default)".  However, in downstream
one of the machine types s marked as deprecated might become the
default, in which case this logic breaks as the line would now end with
" (default) (deprecated)".  To fix potential issues here, let's relax
that requirement and detect the mere presence of " (default)" line
instead.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20231122121538.32903-1-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/testenv.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index e67ebd254b..3ff38f2661 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -40,7 +40,7 @@ def get_default_machine(qemu_prog: str) -> str:
 
     machines = outp.split('\n')
     try:
-        default_machine = next(m for m in machines if m.endswith(' (default)'))
+        default_machine = next(m for m in machines if ' (default)' in m)
     except StopIteration:
         return ''
     default_machine = default_machine.split(' ', 1)[0]
-- 
2.43.0


