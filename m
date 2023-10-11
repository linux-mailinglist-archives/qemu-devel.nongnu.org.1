Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE67C5076
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:44:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWgk-0008Bx-Ts; Wed, 11 Oct 2023 06:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgi-0008AU-Jv
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgh-0007el-0k
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-405497850dbso61738135e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697021011; x=1697625811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NU8OZESOHGJQIdZ7oiM9dX/SvYUcS2a/CZ+IZrzLAg4=;
 b=duwdJd5IGk+YyczDbO8g4yxC01x/9ppHE7Jks5AdH7zA/M8/q7ElswUOeoj6zD1y/4
 KvYLdccZ2Uovum+WV/6OhmKliC94pVSdCBm3UvS6dv46yMNKlRejbyHNq2mPppRIzI17
 7F4K2gYO8DMlLzTrhPFZmGq51t9DE1Hk4qOpLn1aHFl8kGA7IlMM9/2WRMpjf0SEmdCA
 ryisZcoYTzygqZTTi3/IUCXHRhAg7D0Od3oFnLVk8d7l6kUvVVbqwgZcryL8diWOAoYd
 Qbsf5a21keD3d6ek1gMWtxpxwSqYYpC/RaTEo6KMXaxzLrsT4DrSuKREVac1xL8tpXkl
 asFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697021011; x=1697625811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NU8OZESOHGJQIdZ7oiM9dX/SvYUcS2a/CZ+IZrzLAg4=;
 b=MagrerC4mcr21SS2NeL4G6AxVHyf8QewYWglwbzzFoFKAhbPw1Rk2VKmFh9simLyoM
 PDtZTmqpU76pAfnNN/2O+mYPgKAZ9rBwbLpVG9dMzJkue0kXTEnxnEppXFHSBFPWCYUR
 GG8LUw0IJxkmG4FsfVPE9JnpGwNNodCKzurHYkknHz0Qyjraz1Hmx3FzQn8adob9IIoS
 xK43B7GaVUbuZpcbHt8zNw0uOJU34zofrsiC2IodZdPJ1FwOriRLAjV/IXGZbGjeJOI7
 Va/YfHUla7oQm1ks+frnwgnwIXOSsMPe0Z3dviY3i7IFPETU9708TKjqd63tusD3WrHb
 BAaw==
X-Gm-Message-State: AOJu0Yw8qLrzrNsUKm45/lchr8xqVLx8pBtnUQJwFWLRNJ2akfyx3NlJ
 H64vVbWW9lvAFjnQ+Z7kp9ngZQnr0jWy4JXmpqk=
X-Google-Smtp-Source: AGHT+IHd8d9eWCHtysl3i5nBfGjDAAmBjNUfzCQPGDksJ6m64mK7J4CB3TX97Yg2EjPhQSxXI54Xwg==
X-Received: by 2002:a7b:c40a:0:b0:401:23fc:1f92 with SMTP id
 k10-20020a7bc40a000000b0040123fc1f92mr18871691wmi.25.1697021011267; 
 Wed, 11 Oct 2023 03:43:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a1cf211000000b00405623e0186sm18844813wmc.26.2023.10.11.03.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:43:30 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0D1121FFC9;
 Wed, 11 Oct 2023 11:33:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PULL 17/25] target/ppc: Remove references to gdb_has_xml
Date: Wed, 11 Oct 2023 11:33:21 +0100
Message-Id: <20231011103329.670525-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

GDB has XML support since 6.7 which was released in 2007.
It's time to remove support for old GDB versions without XML support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230912224107.29669-11-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-18-alex.bennee@linaro.org>

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 778ef73bd7..ec5731e5d6 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -54,12 +54,6 @@ static int ppc_gdb_register_len(int n)
     case 0 ... 31:
         /* gprs */
         return sizeof(target_ulong);
-    case 32 ... 63:
-        /* fprs */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return 8;
     case 66:
         /* cr */
     case 69:
@@ -74,12 +68,6 @@ static int ppc_gdb_register_len(int n)
     case 68:
         /* ctr */
         return sizeof(target_ulong);
-    case 70:
-        /* fpscr */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return sizeof(target_ulong);
     default:
         return 0;
     }
@@ -132,9 +120,6 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
     if (n < 32) {
         /* gprs */
         gdb_get_regl(buf, env->gpr[n]);
-    } else if (n < 64) {
-        /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
     } else {
         switch (n) {
         case 64:
@@ -158,9 +143,6 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
         case 69:
             gdb_get_reg32(buf, cpu_read_xer(env));
             break;
-        case 70:
-            gdb_get_reg32(buf, env->fpscr);
-            break;
         }
     }
     mem_buf = buf->data + buf->len - r;
-- 
2.39.2


