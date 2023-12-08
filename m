Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8F780A262
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 12:37:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBZ9H-0004CP-59; Fri, 08 Dec 2023 06:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBZ9E-00048Q-CD
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:36:00 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBZ9B-0004A0-Ln
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:36:00 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3331752d2b9so1451381f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 03:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702035356; x=1702640156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OW+X1QC8WatkMetvJ6Ywtj3P4pbS5e79ta84qcwdOpI=;
 b=MOo0wKrIV2oBZEcjZdCO2bTFejsZ+zzJNlHu/oeGs1tfZtjOTJ2evCCqGbzUJYfddf
 m0rN4MVlAqBpLMv1Ya1/fLIA4DTbOwcqqF9ppQET4C6LbHKHgx+IZRrsFk3WZYkopgvI
 5VwF/nJ2hXrN91NUfxviAUV9nhk18hi2KxXq1E/YRfq8Euh/XWFc/NpDOJ2Vyk4zV1Cf
 EhWjBZErq5f67cFDfFWW71Kno2RPOEbuRvAEVJyrGSk33olkyDe0T8kOUxvHbRLdtx69
 Mbp81UI+ccPB92R8dGQPQFV2vqqEIRkWzjN7hZG/WshcrjkDcqTfZwmKY4pG9aGST5IJ
 PFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702035356; x=1702640156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OW+X1QC8WatkMetvJ6Ywtj3P4pbS5e79ta84qcwdOpI=;
 b=SGYVPngntPY4CvFsQy53od2H5U2B9uBy2iphmwgXipBeFrvxwQXyZmfMoxGnSk2e3q
 ECAAoCCiY5XpfojKFjams4MRcCcC6ZaKEwfqjC97St514TzxP2fKFn1ymkoBeJyPtTn1
 D7LM2ZRcxolv22iU8iR/VW/vblLQopcKVijeN8eyN3ibKFNUteglVCldIwO5WCk4IW4X
 9VISrHeuhMTk4abZ+56+CyG3FwEndhrlmhmiFv490ornakUGYr8mzz+pDz0zfnCvZTuQ
 mPP5eWA5V/YnZCdEkecoALPBkzCT9LxoPWkt6XHGu/FVGOKYXAra1CQ3GAinDppWgTx4
 vQiA==
X-Gm-Message-State: AOJu0YxznlNIHlD+V02nekUsTNBYaknHc7BHOkeDY7+wLnti0vdcvoOD
 33PUFYw79EUKI/IveQFPY+3up8Eid5FzNbbd03s=
X-Google-Smtp-Source: AGHT+IFjNbv1Y1o8ZfQUkSg5XeXPa+GVIftwfMJwequq8QK7XqtUDO3wUovD8gFNkcLWn+cNxuwW0A==
X-Received: by 2002:a5d:6311:0:b0:333:2fd2:813d with SMTP id
 i17-20020a5d6311000000b003332fd2813dmr2679405wru.90.1702035356092; 
 Fri, 08 Dec 2023 03:35:56 -0800 (PST)
Received: from m1x-phil.lan ([176.176.146.181])
 by smtp.gmail.com with ESMTPSA id
 b5-20020adff245000000b003332ef77db4sm1840624wrp.44.2023.12.08.03.35.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Dec 2023 03:35:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/6] target/arm: Ensure icount is enabled when emulating
 INST_RETIRED
Date: Fri,  8 Dec 2023 12:35:26 +0100
Message-ID: <20231208113529.74067-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208113529.74067-1-philmd@linaro.org>
References: <20231208113529.74067-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

pmu_init() register its event checking the pm_event::supported()
handler. For INST_RETIRED, the event is only registered and the
bit enabled in the PMU Common Event Identification register when
icount is enabled as ICOUNT_PRECISE.

PMU events are TCG-only, hardware accelerators handle them
directly. Unfortunately we register the events in non-TCG builds,
leading to linking error such:

  ld: Undefined symbols:
    _icount_to_ns, referenced from:
      _instructions_ns_per in target_arm_helper.c.o
  clang: error: linker command failed with exit code 1 (use -v to see invocation)

As a kludge, give a hint to the compiler by asserting the
pm_event::get_count() and pm_event::ns_per_count() handler will
only be called under this icount mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
As discussed in
https://lore.kernel.org/qemu-devel/CAFEAcA-HVf8vWLzmdStEo2NrSKQdZV612rBjiaj-gLW4vXyvpA@mail.gmail.com/
better would be to restrict the PMU events to TCG, but this is
out of the scope of this series.
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index adb0960bba..333fd5f4bf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -940,11 +940,13 @@ static bool instructions_supported(CPUARMState *env)
 
 static uint64_t instructions_get_count(CPUARMState *env)
 {
+    assert(icount_enabled() == ICOUNT_PRECISE);
     return (uint64_t)icount_get_raw();
 }
 
 static int64_t instructions_ns_per(uint64_t icount)
 {
+    assert(icount_enabled() == ICOUNT_PRECISE);
     return icount_to_ns((int64_t)icount);
 }
 #endif
-- 
2.41.0


