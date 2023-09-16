Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C53687A3327
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 00:03:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhdMa-0006JN-1r; Sat, 16 Sep 2023 18:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMW-0006IJ-T7
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:02:00 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMV-00047x-Dy
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:02:00 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf7a6509deso25186255ad.3
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694901718; x=1695506518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jdzasvr+k+5oAv9xFjyZ26RftQbu3lpg5mgMZXI/UhQ=;
 b=UGkr14dwICRJwTKlGiWX8AETDqAIB3Asuw2k479+woMfYKTxPdD4udJqPPET/Y8duB
 C4seXoEgP34tkejlM6AhUGIzJy+yA73JHeY/Mw29+8ME5jbVzCKeyyq4ptmorOVikQNE
 Mt+eVHNYfSKR5zWxVjCnaQ9QnwWZN+km86lu7swOy8I0LFrx7DafU08NQ7tqbYCP0XuJ
 uDjlKkzHwmRnVerJCCeX12HRVfVYLk3CNQUPhcJrhfQddUgBx9td7HNUrStCat8GDFQw
 aPIN51UieEBJCTZWZyTIAJkgJhbCKC00YSg9O+CHWTOVdiMbZDJKu3SwQV7WCgehyatX
 0C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694901718; x=1695506518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jdzasvr+k+5oAv9xFjyZ26RftQbu3lpg5mgMZXI/UhQ=;
 b=KacdHQdMLLjSZPoDZSnNF+/73LG/mWUCobaaulV5OFXpd7EGQgiBD76l0GWo0z1QDq
 xcOq5Voy6ABljsbhYSAfppJhz0MNbK7gMlOANEUMQjentxbxLmAbgO5d4iCXcJyWxwvH
 4qPjfjyq1UzoKLHZn+VPGH6VfIG2UvvSDxbcusC+b2653pD9iW8sFwrWEsLca0Ah/fyY
 vO2mLewDuZ4G78ZTWwlrNWJT+awreEDfMSMuT6YK8ulKNpfVgsOICYZNYZiXoycYKtjM
 6vrued3ex+TlkkAovjOjq6nSgqsk/meF9E8qwGZcNPsNk+MnKQZyI8NIWTS8zX51nERX
 6IfA==
X-Gm-Message-State: AOJu0YzdH3YqA8JlES+4Wmkv+NucVx6JSdl2/qsHIV/pZ7SXlULHK4hd
 g6eyBStUK8tuPKGCWmFBoECsIfEIYQcHgPOXHkY=
X-Google-Smtp-Source: AGHT+IGM+3t1KNf1TOeiX5qg2VNDM6ulLlPt9B6A18u8CNK25uubUtms4KGaKfLL9YLMDSmylwMPAg==
X-Received: by 2002:a17:90a:6482:b0:26b:4ce1:9705 with SMTP id
 h2-20020a17090a648200b0026b4ce19705mr4412709pjj.38.1694901718183; 
 Sat, 16 Sep 2023 15:01:58 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 q3-20020a170902788300b001b531e8a000sm5707763pll.157.2023.09.16.15.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 15:01:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name, c@jia.je, gaosong@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH 6/7] accel/tcg: Remove redundant case in store_atom_16
Date: Sat, 16 Sep 2023 15:01:50 -0700
Message-Id: <20230916220151.526140-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916220151.526140-1-richard.henderson@linaro.org>
References: <20230916220151.526140-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We handled the HAVE_ATOMIC128_RW case with atomic16_set at the top of
the function; the only thing left for a host without that support is
to fall through to cpu_loop_exit_atomic.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/ldst_atomicity.c.inc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 1b793e6935..23d43f62a2 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -1103,10 +1103,6 @@ static void store_atom_16(CPUArchState *env, uintptr_t ra,
         }
         break;
     case MO_128:
-        if (HAVE_ATOMIC128_RW) {
-            atomic16_set(pv, val);
-            return;
-        }
         break;
     default:
         g_assert_not_reached();
-- 
2.34.1


