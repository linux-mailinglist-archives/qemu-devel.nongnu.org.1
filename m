Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F627BA834
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 19:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSJ2-0001Le-Qk; Thu, 05 Oct 2023 13:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qoSIu-00013N-TX
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qoSIs-00039m-AI
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696527505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcHPM7M/4ZJp7mm+BUX+SXLoPxjf+QOV+TW04XDdcrg=;
 b=SZY31qmUIAFjvvIiTUlSR91s1GDqP5yv1/NXkdFctQdVmWuRY04Fu9TgiKBXUpi47kfV4z
 yjzFKh0hAJ0y9Y/y96XAmflVBzWLYw2cPwgBt75itEyJ/w8nN+bH9wyiLW5ea3lmOF08Iw
 k4RF6UdN2dTcWzoan8juCjNgEBnH8GQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-6DVU2UZDO6O9LoIcSeqPhw-1; Thu, 05 Oct 2023 13:38:22 -0400
X-MC-Unique: 6DVU2UZDO6O9LoIcSeqPhw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D10C83857B77;
 Thu,  5 Oct 2023 17:38:21 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0368215670B;
 Thu,  5 Oct 2023 17:38:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] meson: mitigate against use of uninitialize stack for
 exploits
Date: Thu,  5 Oct 2023 18:38:12 +0100
Message-ID: <20231005173812.966264-3-berrange@redhat.com>
In-Reply-To: <20231005173812.966264-1-berrange@redhat.com>
References: <20231005173812.966264-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

When variables are used without being initialized, there is potential
to take advantage of data that was pre-existing on the stack from an
earlier call, to drive an exploit.

It is good practice to always initialize variables, and the compiler
can warn about flaws when -Wuninitialized is present. This warning,
however, is by no means foolproof with its output varying depending
on compiler version and which optimizations are enabled.

The -ftrivial-auto-var-init option can be used to tell the compiler
to always initialize all variables. This increases the security and
predictability of the program, closing off certain attack vectors,
reducing the risk of unsafe memory disclosure.

While the option takes several possible values, using 'zero' is
considered to be the  option that is likely to lead to semantically
correct or safe behaviour[1]. eg sizes/indexes are not likely to
lead to out-of-bounds accesses when initialized to zero. Pointers
are less likely to point something useful if initialized to zero.

Even with -ftrivial-auto-var-init=zero set, GCC will still issue
warnings with -Wuninitialized if it discovers a problem, so we are
not loosing diagnostics for developers, just hardening runtime
behaviour and making QEMU behave more predictably in case of hitting
bad codepaths.

[1] https://lists.llvm.org/pipermail/cfe-dev/2020-April/065221.html
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meson.build b/meson.build
index 2003ca1ba4..19faea8d30 100644
--- a/meson.build
+++ b/meson.build
@@ -442,6 +442,11 @@ hardening_flags = [
     # upon its return. This makes it harder to assemble
     # ROP gadgets into something usable
     '-fzero-call-used-regs=used-gpr',
+
+    # Initialize all stack variables to zero. This makes
+    # it harder to take advantage of uninitialized stack
+    # data to drive exploits
+    '-ftrivial-var-auto-init=zero',
 ]
 
 qemu_common_flags += cc.get_supported_arguments(hardening_flags)
-- 
2.41.0


