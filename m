Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 565CC720895
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58so-0008TB-Ok; Fri, 02 Jun 2023 13:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58sm-0008Sk-6f
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:48:12 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58sk-0005Ng-60
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:48:11 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30c4775d05bso1763385f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685728088; x=1688320088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OXWdo8tdmV17VZdpYHpu1FXvlXX+KMDvHPrv27XbKWU=;
 b=QdMHhuyqdiFG1FWEOXxmlxGS2/Gf+NIBIb1jSlI3VnaU/evA4qBuqwdh7lIbU7k4gF
 TcjJa6P+XLtwyNm1PPxPcgerLMNN172F5CJkjiHwbtDrApnTkmNNJ4fAPNF2MZo4TE68
 CkippNfv8OqeOoXT2cTDdZstc0cinDy7PPQUUqdr1R5vxnNX9PCgeoweD4j26xL5YIt1
 yDhIb5+A4URzC6DyzhMJxQ0JWh9+HGJK51h+SvHIv7Y3pxB5CIXgSF+Se8YcDu1g6Yyv
 WPQQQKxs+7kmc9jwMWUdSMCBKmNucoanuFyAUVJD2DoJJjHQEXrWj1hKY9nJw4QO46ZM
 p3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685728088; x=1688320088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OXWdo8tdmV17VZdpYHpu1FXvlXX+KMDvHPrv27XbKWU=;
 b=Z64ggybBpUwUiyUtF69kd4gLm/S/HmhLHvYSvFeTobIna3NSccYe8qdw60cvfo0WY+
 Q9gt1+nj+pInN84QHoYAYEYzY0+sa5z18GUfsekVYZGjX2JaLsgXJWc3pU9um7N91hYY
 8olMQ+CZraUqkm8F8WTwqx7Mm1MALbMYQJTeQkPhpXIQVP2CiAyFeE5fjO8wGTQ0527C
 KX/cRy+Yz42LpTNbqKZTtALe06gRtBzTU5FeBM2qYCZMSgLcpPnmsQiizjPlA+9ftusB
 /jPpkEic5NbW7C55517zF1akRkKklakCqjIi3dHe83GfqQhJFq5mwIixY6J6hI+aL9DR
 L3+A==
X-Gm-Message-State: AC+VfDzKtxXAnx6UgW16CgwYqMADnvAi9O43kyIEQfyuZ4CU8nK7Ov4Y
 lNfjOQ39ngP+xXyWLU9X9HaVTovAD0UX1FQVVoo=
X-Google-Smtp-Source: ACHHUZ7r6XKIFvafdGWicJ2f0oWSA0HXuFFDdVA2qtJqGYy4iWLewMwfg5rz3sr8qrkZ3v6SGHBiTA==
X-Received: by 2002:adf:fa4a:0:b0:306:2dc3:8b67 with SMTP id
 y10-20020adffa4a000000b003062dc38b67mr496352wrr.53.1685728088421; 
 Fri, 02 Jun 2023 10:48:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x14-20020adfec0e000000b003062d815fa6sm2284268wrn.85.2023.06.02.10.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 10:48:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: Return EINVAL for getgroups() with negative
 gidsetsize
Date: Fri,  2 Jun 2023 18:48:06 +0100
Message-Id: <20230602174806.2060683-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Coverity doesn't like the way we might end up calling getgroups()
with a NULL grouplist pointer. This is fine for the special case
of gidsetsize == 0, but we will also do it if the guest passes
us a negative gidsetsize. (CID 1512465)

Explicitly fail the negative gidsetsize with EINVAL, as the kernel
does. This means we definitely only call the libc getgroups()
with valid parameters.

Possibly Coverity may still complain about getgroups(0, NULL), but
that would be a false positive.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 89b58b386b1..29fdfdf18e4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11574,7 +11574,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             g_autofree gid_t *grouplist = NULL;
             int i;
 
-            if (gidsetsize > NGROUPS_MAX) {
+            if (gidsetsize > NGROUPS_MAX || gidsetsize < 0) {
                 return -TARGET_EINVAL;
             }
             if (gidsetsize > 0) {
-- 
2.34.1


