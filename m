Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 612829283F7
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jul 2024 10:43:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVn-0001YG-Ag; Fri, 05 Jul 2024 04:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVB-00007M-Em
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:12 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV4-0003Fq-Fn
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:08 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58c2e5e8649so3656238a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168861; x=1720773661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPz1sDK1Ip6ndIJH7eYfvSbU6ynrUeNTFBfJ1fhzt4s=;
 b=tTTiI2Qe5Ei0RcGFPJBZKxn9ZL/3vqCK969cHYKwywt4P1V1VOVwj+Ed7r0wQ+mIA+
 wTAM6WzItd9GLLsVu2PHfjTvEruqUBafAXG0oQWYG80p68EasTyED2Mzd1e2J7Yu+c2R
 O4ys++ZL3um5d5z0gy8eu3CL82wMNuFXjbqlCKPZTvUuUncytZGDE5RY6q21tdaHAnVk
 MTsb9/FgBqCumn9JP4AH33v0RWztO4qDHDstjMyQReqAcRmMvD3nMfvOorJQcveTEqj7
 fQ2H/NTPPRWkS0V75KFkW/goPMKx+R+DHgvi7LtXOHVYBglUf5U8EmKTa2EWrguCMQJv
 P2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168861; x=1720773661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPz1sDK1Ip6ndIJH7eYfvSbU6ynrUeNTFBfJ1fhzt4s=;
 b=lwznhT51wP0Eqz4xsXux4pvNNmUby09BypB2kB7PeXQyGj9BoOVThP8z0eMWHAqoPA
 QcBXzrn5FeNeIbxswMWg6ysoM9bVQBrJTLDgtezy6Kbkn2QN3eR+czMQNSmkQXVSsgFb
 jlR6ck+dHBMSTqRNI0u5Knh/AJ0nH4oRH6w+/0K8LJUOg9aMBnw3X260NLvKX2CKPGN/
 34GgYDQ1OosAnorjg4ZzIdSrInMFEMyAx7kVEu0+198yJRpIqM6riNgvwRu0MpXlqe5U
 nb8O1tdTcBSISk6kYuvYH2TvawMC6sZDG2yMzFHrN7lgBZU3RwZHlmldhllXa+RXtK+t
 dIWw==
X-Gm-Message-State: AOJu0YzIJ1LhjBpP98vgw9dMMoRaMr4hxwMh3OP+8hPjxkQl5Qi9zAfm
 gqR4zSi2GMxnU7JNx8RA4zM809Q0uyHRFTSEBYrrOg4YhfbuzAAs9rFXXNYRhKE=
X-Google-Smtp-Source: AGHT+IG+gK34PRVmXxXuvJXX6hUVJeUTLz/+JVXjEdbBuXKrw5q60Zft0qHevKaHEiOXw3ndjp/Qyg==
X-Received: by 2002:a05:6402:50cd:b0:58c:77b4:404b with SMTP id
 4fb4d7f45d1cf-58e7b6efab1mr2899517a12.15.1720168860829; 
 Fri, 05 Jul 2024 01:41:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59017354272sm192488a12.95.2024.07.05.01.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 760E95F8AF;
 Fri,  5 Jul 2024 09:40:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 18/40] tests/tcg/arm: Use vmrs/vmsr instead of mcr/mrc
Date: Fri,  5 Jul 2024 09:40:25 +0100
Message-Id: <20240705084047.857176-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Clang 14 generates

/home/rth/qemu/src/tests/tcg/arm/fcvt.c:431:9: error: invalid operand for instruction
    asm("mrc p10, 7, r1, cr1, cr0, 0\n\t"
        ^
<inline asm>:1:6: note: instantiated into assembly here
        mrc p10, 7, r1, cr1, cr0, 0
            ^
/home/rth/qemu/src/tests/tcg/arm/fcvt.c:432:32: error: invalid operand for instruction
        "orr r1, r1, %[flags]\n\t"
                               ^
<inline asm>:3:6: note: instantiated into assembly here
        mcr p10, 7, r1, cr1, cr0, 0
            ^

This is perhaps a clang bug, but using the neon mnemonic is clearer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-14-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/fcvt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index d8c61cd29f..ecebbb0247 100644
--- a/tests/tcg/arm/fcvt.c
+++ b/tests/tcg/arm/fcvt.c
@@ -427,10 +427,9 @@ int main(int argc, char *argv[argc])
 
     /* And now with ARM alternative FP16 */
 #if defined(__arm__)
-    /* See glibc sysdeps/arm/fpu_control.h */
-    asm("mrc p10, 7, r1, cr1, cr0, 0\n\t"
+    asm("vmrs r1, fpscr\n\t"
         "orr r1, r1, %[flags]\n\t"
-        "mcr p10, 7, r1, cr1, cr0, 0\n\t"
+        "vmsr fpscr, r1"
         : /* no output */ : [flags] "n" (1 << 26) : "r1" );
 #else
     asm("mrs x1, fpcr\n\t"
-- 
2.39.2


