Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7DD7323F0
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 01:54:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9wmL-0002e1-49; Thu, 15 Jun 2023 19:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q9wm8-0002U0-5J
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 19:53:12 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q9wm6-0003qs-Lq
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 19:53:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1733D60A49;
 Thu, 15 Jun 2023 23:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5A4C433C9;
 Thu, 15 Jun 2023 23:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686873189;
 bh=sirEIIl6otJqKLK3fIB8RQ2gvm6l1N15xKFUdbKurpA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bh8ZV/xmihl/MLDJmbOXphDklalgw5oukUHIndtoknT+oVkHJ6tb3JmfOYBpzwqM3
 wSfX23kH0djHjZzWntlRf4P71NoiIOTOBq8Jl6J1vaJHEopfPXX5TTqX+KiUnsga/V
 FApjBECe5DaOHMwqZaYkdKObY8r6KwdLj4AqICZ4eE3aem6o/+MiVScO0htYXnPRt2
 d0MF10YgctcADFb5TwOwla8enS2HC9UyphA3JIuZFMho1DEJRIL96TNxkZ32HmdMmB
 gUepCHviOOzZWDribX5Im2O4eDdIoNulLIoAq2HFuc+QMGEAS417mDPOOxb65nRL1V
 OPs75ZpF9wgtw==
From: Stefano Stabellini <sstabellini@kernel.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: sstabellini@kernel.org, qemu-devel@nongnu.org, vikram.garhwal@amd.com,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v5 08/11] meson.build: do not set have_xen_pci_passthrough for
 aarch64 targets
Date: Thu, 15 Jun 2023 16:52:51 -0700
Message-Id: <20230615235254.1366267-8-sstabellini@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefano Stabellini <stefano.stabellini@amd.com>

have_xen_pci_passthrough is only used for Xen x86 VMs.

Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 34306a6205..481865bfa9 100644
--- a/meson.build
+++ b/meson.build
@@ -1726,6 +1726,8 @@ have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
            error_message: 'Xen PCI passthrough requested but Xen not enabled') \
   .require(targetos == 'linux',
            error_message: 'Xen PCI passthrough not available on this platform') \
+  .require(cpu == 'x86'  or cpu == 'x86_64',
+           error_message: 'Xen PCI passthrough not available on this platform') \
   .allowed()
 
 
-- 
2.25.1


