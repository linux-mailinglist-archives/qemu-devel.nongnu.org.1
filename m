Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A594B7D1449
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:42:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtsVc-0003QA-A4; Fri, 20 Oct 2023 12:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsVF-000361-DM
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:37:38 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsVB-0002Sy-2T
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:37:37 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9bf86b77a2aso158813466b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697819848; x=1698424648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUBi9PwmyHFRdVnHd5x4eIWhteYAhCTGnXhaAjecfzc=;
 b=JL89DZE6nD1bqHxo2SO65A91neSY2S6g8HgDvcpnhGdkztUjrbr/Eoj7vZb+3HCX7k
 C2m7j3vVPEYsfEWTFrqy5dsh5gvwsRRS703qnWaEBumfkPSqDr9j1PznHHhxl7W4tKKr
 /tKeL6zqRCT84HkFIFJMK5hRKOQoRQNlBILQFvI6fxZ9YNsnF938Of0NEACd3QNKiaRU
 ZnwHQYPmMrtALr9sBgoK+ssXwuD2kJgjDFrWPgPN/W9LiD+IFaDDJt31xed8Jf2VYj6l
 K7WLxkUYh5SJpDPt1TKNUratdGaqGdCn+DzxPVOJJgPP7w2sOJBeAcAV4phLM7VDmkAC
 ud3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697819848; x=1698424648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUBi9PwmyHFRdVnHd5x4eIWhteYAhCTGnXhaAjecfzc=;
 b=QNvp37fMzDuYIWotQ2g6HDku/BXye+1D2DXIzftLHi3f36Rz2CIG8HEDj9HJA7Qj94
 hc2iDB2iSBYcjGJ1qy7VzI3mphNlSgmHXy7iSvOyBc8b9MCyHQis/fmgEwZn3CUBtd7R
 94FLxIpLByhd8veqCh3WSZ3HBsuRTeauX2mlBIwKjoZtJPNtaMiC2y/VZKc7pk+yD+lH
 VZa+wF1LrwJzcMkHXOy2s9gyGIXgzErAzqXzJBqFScmCvNPFSJe+i+3yheXGhnj80CfQ
 bqRkwpGfDvfc19rcUzxelrMdXsCb0yupbiJq0l5JDhB5jFF4uCaTT9n3M49d20RobEkq
 8SEQ==
X-Gm-Message-State: AOJu0YwhE541f+7Zm0u+i+n1TZZA7n0KeyTBZ+cEUrJOrFtXbYNhoLrL
 dacVufdTbNM7G+pVIPU5JQRpjPbm0506bXX0ETA=
X-Google-Smtp-Source: AGHT+IHly4QZub59Ll2I4YbndNTZvqVJdsar+JhXYawd1k7qkul5/m3dgvxkbGUtuq6oLEHMDGA2sg==
X-Received: by 2002:a17:907:2d92:b0:9c3:cd12:1929 with SMTP id
 gt18-20020a1709072d9200b009c3cd121929mr1719344ejc.60.1697819848740; 
 Fri, 20 Oct 2023 09:37:28 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 m2-20020a17090607c200b009c6a4a5ac80sm1774732ejc.169.2023.10.20.09.37.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 09:37:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH 05/19] cpus: Filter for target specific CPU (mips)
Date: Fri, 20 Oct 2023 18:36:27 +0200
Message-ID: <20231020163643.86105-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020163643.86105-1-philmd@linaro.org>
References: <20231020163643.86105-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Enforce qemu_get_cpu() to return MIPS CPUs in MIPS specific files.

Mechanical change using the following coccinelle script:

  @@ expression index; @@
  -   qemu_get_cpu(index, NULL)
  +   qemu_get_cpu(index, TYPE_MIPS_CPU)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/sysemu/cp0_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index fcaba37c40..af0cd60829 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -126,7 +126,7 @@ static CPUMIPSState *mips_cpu_map_tc(CPUMIPSState *env, int *tc)
     cs = env_cpu(env);
     vpe_idx = tc_idx / cs->nr_threads;
     *tc = tc_idx % cs->nr_threads;
-    other_cs = qemu_get_cpu(vpe_idx, NULL);
+    other_cs = qemu_get_cpu(vpe_idx, TYPE_MIPS_CPU);
     if (other_cs == NULL) {
         return env;
     }
-- 
2.41.0


