Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FCE73B75D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:33:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxG-0001vt-Nd; Fri, 23 Jun 2023 08:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx4-0001WJ-4k
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx1-0000fi-3M
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fa74d06d72so6674525e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523501; x=1690115501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oH/1se8THkldllw4yz/aforBBXVCoR9Bd4zvIWdIZeo=;
 b=C04G+uKfBQzFmlQDSHD6xPvFhfOQsDdK727vMGaE3wNsedI4lH3srX80OZmLw2veZg
 rdD09MhfmjHeSdTcTjJpd4cyNBUrbOLI9FvpPiMc9NjETUEvRMFEHgpBUQ+BjjdHVtwC
 axvjP3v9LHt3IQ6o5AAh/0Kb67wcM4NW2M4g8OweL8oOlfqgNzeD/Nrzv8HTnzO/kEt+
 kgcEdljIgdc4oJwDmBmk/hSZLTBLN2ixMQzWEQ7FwBW529MvVipN+E6gb+0NFTDiHTdi
 JTPoMDZX2K+VyAfpHsPETdf9Ez3VD+7bGCA5fEdB6ilDg7n6JezWWdD+pc7RjeF1DVik
 1kwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523501; x=1690115501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oH/1se8THkldllw4yz/aforBBXVCoR9Bd4zvIWdIZeo=;
 b=kV8sdsns+eLyj8omci2HraSBWoYz8un/8Q6sVyfi/xHrg2MZAxGxDE8U05RadnGlvT
 gl8jFl3XWJxgrjeaJSg8ODY2ejA+nezW9m4Nee5ucidPRowdCgjq14Ips1Qren84COpb
 V2WsQbNg6WNvcIzgfFSIQ1DiQTabiq+9bhGqPFX7oJicMNOkuDqejDGPkcDBhaysDxKd
 ++0KAecv7HBLGTAm1AIMR4lfN1oGE6lRDBbl074XY9o0BwjMRXrx2NkfzlMbHspJjZlJ
 +tCBLNHGA/7lsgXIlrEwWsyaUoPEOrAxONEK8AplZYtuDX6e7KU474kRFoJgzjd89ond
 sBXw==
X-Gm-Message-State: AC+VfDyWBIWhljbbCA3KYIJjW6o5CoQr/qBvllwLeP/vk5rgBA8Vm4KT
 faUeowqErm+Ok6fYseEuwfMjbIy+7puyKqg19Vk=
X-Google-Smtp-Source: ACHHUZ5WXvfrM7MNjGCu1Nix/xkiQ31GugG4TBUNdP0In+ZWGgCO5bK1ErMVXrE2Mq39/8y2Q2B+5g==
X-Received: by 2002:a7b:c3d0:0:b0:3f9:897:6a8f with SMTP id
 t16-20020a7bc3d0000000b003f908976a8fmr12426763wmj.17.1687523501741; 
 Fri, 23 Jun 2023 05:31:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/26] target/arm: Remove __attribute__((nonnull)) from ptw.c
Date: Fri, 23 Jun 2023 13:31:18 +0100
Message-Id: <20230623123135.1788191-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This was added in 7e98e21c098 as part of a reorg in which
one of the argument had been legally NULL, and this caught
actual instances.  Now that the reorg is complete, this
serves little purpose.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a742bc18263..f7cbb984f93 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -34,15 +34,13 @@ typedef struct S1Translate {
 static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                uint64_t address,
                                MMUAccessType access_type, bool s1_is_el0,
-                               GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
-    __attribute__((nonnull));
+                               GetPhysAddrResult *result, ARMMMUFaultInfo *fi);
 
 static bool get_phys_addr_with_struct(CPUARMState *env, S1Translate *ptw,
                                       target_ulong address,
                                       MMUAccessType access_type,
                                       GetPhysAddrResult *result,
-                                      ARMMMUFaultInfo *fi)
-    __attribute__((nonnull));
+                                      ARMMMUFaultInfo *fi);
 
 /* This mapping is common between ID_AA64MMFR0.PARANGE and TCR_ELx.{I}PS. */
 static const uint8_t pamax_map[] = {
-- 
2.34.1


