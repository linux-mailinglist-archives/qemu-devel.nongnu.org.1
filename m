Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2032A7CEA93
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESg-0001me-NB; Wed, 18 Oct 2023 17:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESR-00019x-IL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:05 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESQ-0004Rq-3M
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:03 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6cd1918afb2so459275a34.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665919; x=1698270719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOt4L4RU9DBVWKbMxLcMk3VZCZC7MfUNBnEhx3kY+Fc=;
 b=SHniBY42fKvkFZkXlqSSDnyFbnOI1oRYeApv7cMj5QslXTWlZ6u757kcceMPj8qcBQ
 34dVaAKN0cLSRtq8Mmc0B0jygMsapQUIXiJ9MfVfD9WASmMYzpDQGVCPc111zpiXErYt
 +9e2a4KVn7ehfMikwaZIYoI9+orAcEBKwcpjtnDDeKBMCGBDLzw10a0UnNg1QikPN+hr
 /bkmulezy7KurS02gVUkGyTcy5/Q42TISAqG+kwlsDPFcmGRYMpYsEdlciZkq9fDajFO
 NyqhdmAv2qqN19yZrnC9U1HH0vR0az3EhaiJdDd33Jk9or/1k0AtCQr3BUx3wK/kEwk+
 K8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665919; x=1698270719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yOt4L4RU9DBVWKbMxLcMk3VZCZC7MfUNBnEhx3kY+Fc=;
 b=Ke8Z0/imzeLHp6i43kkKpt2TgXlccGi3tzLXAYY9sxNZUF/OZcM8fxEE2rtMMjrGlm
 oJ2/3rd/+77pofFFr3T0aSgaWW4aW5JP3kXXB+UGApHNhkbeDVAipBwMhOwkwXhvlA0h
 eNzWEo8efygk6hK074zr8hV/i7cxgBzdMPnqoTXqNqxJjIx6JclbW84fjFVNdK89E3DN
 xzb1sD803c02VuTKR1+gt1HR2bd0yRpLRVu0wP/JnO6PDlB/hc+S8eUG0nW+tywPSGeH
 OuSZSYBuEvRYeyPt0KEjfHzzfuJykfJDAG7ilBFb2ouYuN1y+b7SFOXf5W36astWwODA
 Q2pA==
X-Gm-Message-State: AOJu0Yyy434UgniAjoga0Syft67Lx0130Lwk70kCCi0ucthQiiN8ZR3D
 cA4zKzE1hHKch4jrY6lF+HMb2VZ/+feNi/xlPcA=
X-Google-Smtp-Source: AGHT+IHRF1clxXTp2U3f5YzyVIN4Dsxlz7k9YQy4L0f5OctGtXtu11YpRUqVX8CX7sTg3fb+aKWdGw==
X-Received: by 2002:a05:6870:b406:b0:1e9:b496:ce2d with SMTP id
 x6-20020a056870b40600b001e9b496ce2dmr862259oap.12.1697665919588; 
 Wed, 18 Oct 2023 14:51:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 27/61] linux-user/hppa: Fixes for TARGET_ABI32
Date: Wed, 18 Oct 2023 14:51:01 -0700
Message-Id: <20231018215135.1561375-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Avoid target_ulong and use abi_* types.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index ec5f5412d1..4400ce4df4 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -72,7 +72,7 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPUArchState *env)
 
 static void restore_sigcontext(CPUArchState *env, struct target_sigcontext *sc)
 {
-    target_ulong psw;
+    abi_ulong psw;
     int i;
 
     __get_user(psw, &sc->sc_gr[0]);
@@ -146,10 +146,10 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     haddr = ka->_sa_handler;
     if (haddr & 2) {
         /* Function descriptor.  */
-        target_ulong *fdesc, dest;
+        abi_ptr *fdesc, dest;
 
         haddr &= -4;
-        fdesc = lock_user(VERIFY_READ, haddr, 2 * sizeof(target_ulong), 1);
+        fdesc = lock_user(VERIFY_READ, haddr, 2 * sizeof(abi_ptr), 1);
         if (!fdesc) {
             goto give_sigsegv;
         }
-- 
2.34.1


