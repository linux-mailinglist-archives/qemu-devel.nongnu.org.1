Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4395B710022
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:40:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1wC3-00081v-CL; Wed, 24 May 2023 17:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1q1wBm-000811-W5
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:38:35 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1q1wBi-0001Ko-Ht
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:38:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:286:0:640:8489:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 187A060C08;
 Thu, 25 May 2023 00:38:21 +0300 (MSK)
Received: from davydov-max-nux.yandex-team.ru (unknown
 [2a02:6b8:b081:b42e::1:1f])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id mbOCj30OrKo0-Gxw8ht4E; Thu, 25 May 2023 00:38:20 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1684964300; bh=AUO90UBe71SkpZIfWV8EzkIO+rLdrI0LhpU1LRLk90Q=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=QOtlW9uxZLaVOoGdQtqJDT9hsagyVZnq7twWwlGYP6GqAESe2WqymNKmJpnQ6IZMZ
 2koIrmN3Z8i2lOKxTE84XKuqPDUpCv6jnf7K8dSV1njInK+izbbXrWGl1ZVxsBboyZ
 1LXwKFXv8AGLZBWy0sTF32HgQ+VOQ6K1ZnQKFd7A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: davydov-max@yandex-team.ru, yc-core@yandex-team.ru, babu.moger@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, xiaoyao.li@intel.com,
 mst@redhat.com
Subject: [PATCH] target/i386: EPYC-Rome model without XSAVES
Date: Thu, 25 May 2023 00:37:48 +0300
Message-Id: <20230524213748.8918-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Based on the kernel commit "b0563468ee x86/CPU/AMD: Disable XSAVES on
AMD family 0x17", host system with EPYC-Rome can clear XSAVES capability
bit. In another words, EPYC-Rome host without XSAVES can occur. Thus, we
need an EPYC-Rome cpu model (without this feature) that matches the
solution of fixing this erratum

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a61cd6d99d1f..1242bd541a53 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4466,6 +4466,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_rome_v3_cache_info
             },
+            {
+                .version = 4,
+                .props = (PropValue[]) {
+                    /* Erratum 1386 */
+                    { "model-id",
+                      "AMD EPYC-Rome-v4 Processor (no XSAVES)" },
+                    { "xsaves", "off" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
-- 
2.25.1


