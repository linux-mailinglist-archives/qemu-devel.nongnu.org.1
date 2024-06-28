Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 190AB91B4D2
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 03:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN0no-0005Or-4S; Thu, 27 Jun 2024 21:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sN0nl-0005Oc-Vt
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 21:53:25 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sN0nk-0008Ny-Hq
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 21:53:25 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4W9JP81Vmtz8PbP;
 Thu, 27 Jun 2024 21:53:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=RerCnXeuqCG2cXWQLSB0LviMs1Y2HmwkEQuXTgpgS7w=; b=Pti1
 xhqhWNWsudG6OiNR86CckE9AP8f73tMym8ZYSUdOUUC+1tSE4xPEGzUnXG/UxW3L
 S6qqxR6l2QnoUlFVMOrJLe3KJAcyO/VehScJmgRxNrXzL82Ers7oZJbxibFFXf+h
 5rCgEpG2Dk2MLH2umlMksnbML+fms99DJdNfF9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=GPlPnMGia4hy+QGTFGjsnFGpwsQqTaWnIYdcC7xZmm7FbCcAiATrS
 xv9vSqa2UaxtRdelh8hLk6Fyal8hYzTkACgr2tye9SLfvp7foT4jLdU6IC+CrrzM
 0dRz+dS7X8eMSwQb09152tlSlXRDrOX13fTUieZQRJq1CfRBct4Wv4=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:6892:e4ed:172c:18e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4W9JP76HjFz8PbN;
 Thu, 27 Jun 2024 21:53:15 -0400 (EDT)
Date: Thu, 27 Jun 2024 21:53:14 -0400
From: Brad Smith <brad@comstyle.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] util/cpuinfo-ppc: Add FreeBSD support
Message-ID: <Zn4Xir2ADAxq3GNI@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

util/cpuinfo-ppc: Add FreeBSD support

Signed-off-by: default avatarBrad Smith <brad@comstyle.com>
---
 util/cpuinfo-ppc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
index 47af55aa0c..0ad634b46f 100644
--- a/util/cpuinfo-ppc.c
+++ b/util/cpuinfo-ppc.c
@@ -14,6 +14,11 @@
 #  include "elf.h"
 # endif
 #endif
+#ifdef __FreeBSD__
+# include <machine/cpu.h>
+# define PPC_FEATURE2_ARCH_3_1		0
+# define PPC_FEATURE2_VEC_CRYPTO	PPC_FEATURE2_HAS_VEC_CRYPTO
+#endif
 
 unsigned cpuinfo;
 
@@ -28,7 +33,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 
     info = CPUINFO_ALWAYS;
 
-#ifdef CONFIG_LINUX
+#if defined(CONFIG_LINUX) || defined(__FreeBSD__)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
 
-- 
2.45.2


