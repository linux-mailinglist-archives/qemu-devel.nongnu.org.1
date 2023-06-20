Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3434F736685
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:41:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWuQ-0000mW-TK; Tue, 20 Jun 2023 04:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1qBWuJ-0000kX-KC; Tue, 20 Jun 2023 04:40:11 -0400
Received: from eastern.birch.relay.mailchannels.net ([23.83.209.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1qBWuE-0001LA-Av; Tue, 20 Jun 2023 04:40:10 -0400
X-Sender-Id: hostpapa|x-authuser|frederic@petrot.fr
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 856E1760EA9;
 Tue, 20 Jun 2023 08:39:57 +0000 (UTC)
Received: from hp220.hostpapa.com (unknown [127.0.0.6])
 (Authenticated sender: hostpapa)
 by relay.mailchannels.net (Postfix) with ESMTPA id 54B94760E8F;
 Tue, 20 Jun 2023 08:39:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687250396; a=rsa-sha256;
 cv=none;
 b=y2ReY+ivJuGFQyNkIzM7/xje3XYP55Uaoso7qnsj9U/7g1ti52Hsah+hIjrRACuSnF3bsY
 kvIOAck80PukVNxN6Qj+TOeBR/IYpYbgf7KenvA0HXcOIKPzarFnQB4zbcaCKvhLlBmMnR
 cnDYKyhogs7shLSQela9BTN1FCCg4+ELbcD8JMy6tVfMIbyNd0gQaumweUcAlvgEO9BAa5
 7WtMQOxO0/N+4OtXgqTAZ+vu5SSzjUevYwp89ODN9NAeg/xlu29rknCPwroVw/YkEBlVPZ
 bimDc9dUegFQt1d8Fn/hV6YuQrpGh92Cf1VUPFRiwIh/ue28sL1ZyM7o6u6dEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1687250396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=poaKJQvZweTmGOjc7UP6H0N83EddyRxebyZeNCKNK1I=;
 b=Lhq1xK/wnzuUyHhQoPjj/QY1VF+j9FOOSkTBF9QcLFeabwlPhgUJF/UoGwq0seuThiBiQO
 l4sDWcI5rXH7CYjgVjwO32mLtz/Bb228ke0MpbuwUAojRriDelT68NqpDcWubuCzCzZsrP
 akdOTE5vaAiY7TgSnSOAlfOx5IxaVJHaZl6KrjINVK8h7HUiNUG0HE8FVkNoB56Tm/yIBK
 QVv57rd8p6fO6skbylykLQyVWuzPkfRLpVfZY7JYoQ5zUPVFTXkExUcLb+5nR5hY7CMwHp
 x2p3yEZ7o4mDx1EeEsr5ixwveEvH1eZ0AigEUxJEiLGeUduZdS/nCIZGL35xeQ==
ARC-Authentication-Results: i=1; rspamd-9fcc56855-ktntx;
 auth=pass smtp.auth=hostpapa
 smtp.mailfrom=frederic.petrot@univ-grenoble-alpes.fr
X-Sender-Id: hostpapa|x-authuser|frederic@petrot.fr
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: hostpapa|x-authuser|frederic@petrot.fr
X-MailChannels-Auth-Id: hostpapa
X-Turn-Befitting: 121b16f136beff3a_1687250397111_3529346042
X-MC-Loop-Signature: 1687250397111:1168153802
X-MC-Ingress-Time: 1687250397110
Received: from hp220.hostpapa.com (hp220.hostpapa.com [69.90.161.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
 by 100.120.163.52 (trex/6.9.1); Tue, 20 Jun 2023 08:39:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=petrot.fr; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=poaKJQvZweTmGOjc7UP6H0N83EddyRxebyZeNCKNK1I=; b=lip2BVxjJlP5Qfc5zuFZje/pWM
 Mk8YSYF99YVcd/Ka1K8uSFrAQTJKsk4MlDv9vR9eybWx7+NL/WMal/u9HdqQ76FeGunlA1+Dm9hHK
 yMMxPPGy4VJlZXEU4iciv0s1bi25HhyUs42WbJyM2dQDuQ2T7pUg07xlRS9NwZ0GENrJV6a9etufo
 fRigPUD/skDFIWPe4/2Sr16cESibwff46WnoF3A5OVIQTzYW6a4B5v7TEzVm/QLH3WoC1vxpTCUV7
 HrJ3oUlEBRWGLXSsJ/QF93S9PcVVLpJAlXmxYvQR8D82OBlKo8T+go2+gKGNAQ0krM4YVjFUDrrOv
 purn0I0Q==;
Received: from 87-90-81-144.abo.bbox.fr ([87.90.81.144]:51802 helo=palmier.lan)
 by hp220.hostpapa.com with esmtpa (Exim 4.95)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1qBWu3-00Cwpw-JO; Tue, 20 Jun 2023 10:39:55 +0200
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
To: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, alex.bennee@linaro.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH] x86_64/atomic128-ldst.h: fix arch include guard
Date: Tue, 20 Jun 2023 10:39:18 +0200
Message-Id: <20230620083918.9134-1-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AuthUser: frederic@petrot.fr
Received-SPF: softfail client-ip=23.83.209.55;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=eastern.birch.relay.mailchannels.net
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Fix arch name in the define that prevents multiple inclusions.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 host/include/x86_64/host/atomic128-ldst.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/host/include/x86_64/host/atomic128-ldst.h b/host/include/x86_64/host/atomic128-ldst.h
index adc9332f91..d0240d4212 100644
--- a/host/include/x86_64/host/atomic128-ldst.h
+++ b/host/include/x86_64/host/atomic128-ldst.h
@@ -8,8 +8,8 @@
  * atomic primitive is meant to provide.
  */
 
-#ifndef AARCH64_ATOMIC128_LDST_H
-#define AARCH64_ATOMIC128_LDST_H
+#ifndef X86_64_ATOMIC128_LDST_H
+#define X86_64_ATOMIC128_LDST_H
 
 #ifdef CONFIG_INT128_TYPE
 #include "host/cpuinfo.h"
@@ -65,4 +65,4 @@ static inline void atomic16_set(Int128 *ptr, Int128 val)
 #include "host/include/generic/host/atomic128-ldst.h"
 #endif
 
-#endif /* AARCH64_ATOMIC128_LDST_H */
+#endif /* X86_64_ATOMIC128_LDST_H */
-- 
2.30.2


