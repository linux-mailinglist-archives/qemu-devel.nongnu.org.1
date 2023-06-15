Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DDA7323EE
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 01:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9wmL-0002df-1S; Thu, 15 Jun 2023 19:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q9wmB-0002Xl-Bp
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 19:53:16 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q9wm9-0003tH-VI
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 19:53:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 30D1E61D54;
 Thu, 15 Jun 2023 23:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8485C433C0;
 Thu, 15 Jun 2023 23:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686873192;
 bh=ysAbOlGUVkZXsgCen0WpFTxZFN79eCQ5A7XTdxnHcbY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BhQ4+nnH1iTTPuW05FQ1GqFiahUCnp4eUrRIETndPEuOAXUWM3ecLMuWtWM4vnEWI
 QwJu2yezSCAaJMkxTNc0OXj3oLu54TohZbB4ybCp93EmTmeUDgTtyttiNhhvAW5OqP
 ro4lN/mGALS/6ijDGd/D1dSu5/1e8rZhH+PV0TqEIVR6XlBpg0EDA0CCa/VR7WX05x
 KlUcd9aMWt05N9i11a/Vf04LiNDr/ApmhpFMS9QINwOfPz8KVSoS72LSFPIziU3HhC
 mxJ9jaZ6i7KmyWLRiQ1Jz2F83VsHHaKVW3WmvlXEV2EAxmX5Jggcb0kDTudnpf2f/V
 DXojNF9AlB+mw==
From: Stefano Stabellini <sstabellini@kernel.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: sstabellini@kernel.org,
	qemu-devel@nongnu.org,
	vikram.garhwal@amd.com
Subject: [PULL v5 11/11] test/qtest: add xepvh to skip list for qtest
Date: Thu, 15 Jun 2023 16:52:54 -0700
Message-Id: <20230615235254.1366267-11-sstabellini@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
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

From: Vikram Garhwal <vikram.garhwal@amd.com>

Like existing xen machines, xenpvh also cannot be used for qtest.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 tests/qtest/libqtest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 77de16227f..de03ef5f60 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1465,7 +1465,8 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
     for (i = 0; machines[i].name != NULL; i++) {
         /* Ignore machines that cannot be used for qtests */
         if (!strncmp("xenfv", machines[i].name, 5) ||
-            g_str_equal("xenpv", machines[i].name)) {
+            g_str_equal("xenpv", machines[i].name) ||
+            g_str_equal("xenpvh", machines[i].name)) {
             continue;
         }
         if (!skip_old_versioned ||
-- 
2.25.1


