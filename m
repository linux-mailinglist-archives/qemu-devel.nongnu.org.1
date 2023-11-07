Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E17DF7E48F8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 20:09:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RRF-0004Xx-O3; Tue, 07 Nov 2023 14:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r0RRA-0004XG-Uv
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:08:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r0RR9-0005pa-EI
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699384110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXuO0i8SoHDIuFTm9Ssk29bISFNyk+++0qvyee3CbjI=;
 b=X7KL8+i6TdUQGPCKjyNJ8E4XX0U31fybnSg/wfMpfbA6a2RgurBR3XH0i+oJJTITx+3eGa
 23sAflDgFNHHS3cK7tRWqricjgPy0a3JSqATan+wb+XUn4sXizfCS+d80EFSRUBlEhSIKY
 /I7SCPWpZ09N97oTJqqIB1j9f9vj0go=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-0Z2u_pGmPnWXDKYStLCJDg-1; Tue,
 07 Nov 2023 14:08:25 -0500
X-MC-Unique: 0Z2u_pGmPnWXDKYStLCJDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 431732801424;
 Tue,  7 Nov 2023 19:08:25 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02EEF25C0;
 Tue,  7 Nov 2023 19:08:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 5/5] scripts/cpu-x86-uarch-abi.py: Fix parameter error of cmd
Date: Tue,  7 Nov 2023 19:08:17 +0000
Message-ID: <20231107190817.1607710-6-berrange@redhat.com>
In-Reply-To: <20231107190817.1607710-1-berrange@redhat.com>
References: <20231107190817.1607710-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

When run this script, there's the error:

python3 scripts/cpu-x86-uarch-abi.py /tmp/qmp
Traceback (most recent call last):
  File "/path-to-qemu/qemu/scripts/cpu-x86-uarch-abi.py", line 96, in <module>
    cpu = shell.cmd("query-cpu-model-expansion",
TypeError: QEMUMonitorProtocol.cmd() takes 2 positional arguments but 3 were given

Commit 7f521b023bc28 ("scripts/cpu-x86-uarch-abi.py: use .command()
instead of .cmd()") converts the the original .cmd() to .command()
(which was later renamed to "cmd" to replace the original one).

But the new .cmd() only accepts typing.Mapping as the parameter instead
of typing.Dict (see _qmp.execute()).

Change the paremeters of "query-cpu-model-expansion" to typing.Mapping
format to fix this error.

Fixes: 7f521b023bc28 ("scripts/cpu-x86-uarch-abi.py: use .command() instead of .cmd()")

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/cpu-x86-uarch-abi.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/cpu-x86-uarch-abi.py b/scripts/cpu-x86-uarch-abi.py
index f6baeeff24..052ddd7514 100644
--- a/scripts/cpu-x86-uarch-abi.py
+++ b/scripts/cpu-x86-uarch-abi.py
@@ -94,8 +94,8 @@
 
 for name in sorted(names):
     cpu = shell.cmd("query-cpu-model-expansion",
-                    { "type": "static",
-                      "model": { "name": name }})
+                    type="static",
+                    model={ "name": name })
 
     got = {}
     for (feature, present) in cpu["model"]["props"].items():
-- 
2.41.0


