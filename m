Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD73182EA7F
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:59:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPeKl-0002m9-GF; Tue, 16 Jan 2024 02:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rPeKj-0002lp-GL
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:58:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rPeKh-00085r-Ib
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705391882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDiShQtiRmeC1rYzS1HKd/EJLQjy5jMcLyfiyzMwQDE=;
 b=R6WB7OmT1gTVyuk8zYan3qjXmsckzT3pYrc4T1ziNS/BLfQFYCCaYOB6KuY03iWxeI50Pp
 V2G1oVrkdOZ9p5cZLCOoxf79Zz0eYL/VgqRaRTRC/ry3cWQYRpn9vJEc1HZEFhHUhX9fDz
 WbBJDL9xKufqTRdnsLZk4d9OfpbhRLk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-Ei8UuMG5OJWXZxd76b6-1Q-1; Tue, 16 Jan 2024 02:57:53 -0500
X-MC-Unique: Ei8UuMG5OJWXZxd76b6-1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95B9C848C03;
 Tue, 16 Jan 2024 07:57:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81D0F3C25;
 Tue, 16 Jan 2024 07:57:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 5/5] meson: mitigate against use of uninitialize stack for
 exploits
Date: Tue, 16 Jan 2024 08:57:44 +0100
Message-ID: <20240116075744.219169-6-thuth@redhat.com>
In-Reply-To: <20240116075744.219169-1-thuth@redhat.com>
References: <20240116075744.219169-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

From: Daniel P. Berrangé <berrange@redhat.com>

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

Signed-off-by: "Daniel P. Berrangé" <berrange@redhat.com>
Message-ID: <20240103123414.2401208-3-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meson.build b/meson.build
index 1bda391de6..d0329966f1 100644
--- a/meson.build
+++ b/meson.build
@@ -559,6 +559,11 @@ hardening_flags = [
     # upon its return. This makes it harder to assemble
     # ROP gadgets into something usable
     '-fzero-call-used-regs=used-gpr',
+
+    # Initialize all stack variables to zero. This makes
+    # it harder to take advantage of uninitialized stack
+    # data to drive exploits
+    '-ftrivial-auto-var-init=zero',
 ]
 
 qemu_common_flags += cc.get_supported_arguments(hardening_flags)
-- 
2.43.0


