Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF8D741605
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:05:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXWu-00039c-32; Wed, 28 Jun 2023 11:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXWV-0002oU-27
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:56:05 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXW8-0001nv-8p
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:41 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fb5bcb9a28so5903238e87.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967738; x=1690559738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZPYp3VLZeraZ7kAA283/V2ksX5guNAeZdMB4i4D/xw=;
 b=D2q6V5oV2b6utGwiKObbkSM0lWmZeQlqDT7JVt3yJ+zWi88HYKtLr7fjAatAEs9Hvi
 0GjVO226sTOtxcVFchXpjMnwvFHZH/5Lu8RfR8IJDaZmnqPpl/BvZfwgmTF7QNAi1pvM
 LoPO6LjGGqMRnhLdjwWdKiQI35uguV0A49tuoxww3SO7AOn6OWFS5mFz7/cBRNj6MI5c
 i3/zS6c6Sn3Ejaa4UdjFZN/VG5B7qNBp4SPcRooNUt/C4xTVu9BOaPoUJnZwD/Iql4+u
 Dsz4LLoNAGgCdKa6KgT5ubsSvng6D03/9PG4qy9oQJ9Xq6QWwwj90aa474olrwP1Uje7
 Fpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967738; x=1690559738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZPYp3VLZeraZ7kAA283/V2ksX5guNAeZdMB4i4D/xw=;
 b=NC6jwe9Jsq+sM9W/6tAd0FbzSV/mclJZCnawTxvDKugKI9eXc6+lMQnAUtQUV07Xdg
 k3SfzVfz69E0yaRim1eGEoxzOmG2rvuJXZnrHSUX9MLNqY6cmZZaYCGt/WNrh4CnWMs2
 AZVlUYzj2aX2qW4ezSZl3hg/y7A7BF2bivpEKR1MsRI/ews/I7LE+Uj/8djpWtVbljhi
 +EdN9XF4N12iwrJjBDUuk8OtFqRKWCWpU30GoJIqTguFuMRGa8Jxf7DBEoQyo4VcTtbs
 q23T59XxQBYQ9PF0ALg3bhiWC5mARm1pT5F7lAaRjSRaGXh6c/G/mB1AY2kZcG5OyOFX
 lGAg==
X-Gm-Message-State: AC+VfDwmwDuhPW43Q85YevEPXsKNMH/zlKyRsLCh0u8mCvJStBgegr+l
 YsXRca5UxwaPbIRTxxV+DX/v5Tw3J7rId3ViqNs=
X-Google-Smtp-Source: ACHHUZ4TIe2l9gPXbtl06dhkYnZhpxSPqRPTjstjCr+vW0ueM4tLHZMTm+cawtsmZGAvyx+L8jix5w==
X-Received: by 2002:a05:6512:39d1:b0:4fb:8afa:4dc9 with SMTP id
 k17-20020a05651239d100b004fb8afa4dc9mr3724565lfu.49.1687967738189; 
 Wed, 28 Jun 2023 08:55:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 14-20020a05600c020e00b003fba92fad35sm1811324wmi.26.2023.06.28.08.55.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:55:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 24/30] target/arm: Restrict KVM-specific fields from ArchCPU
Date: Wed, 28 Jun 2023 17:53:07 +0200
Message-Id: <20230628155313.71594-25-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

These fields shouldn't be accessed when KVM is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230405160454.97436-8-philmd@linaro.org>
---
 target/arm/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 00e675f58f..4d6c0f95d5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -961,6 +961,7 @@ struct ArchCPU {
      */
     uint32_t kvm_target;
 
+#ifdef CONFIG_KVM
     /* KVM init features for this CPU */
     uint32_t kvm_init_features[7];
 
@@ -973,6 +974,7 @@ struct ArchCPU {
 
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
+#endif /* CONFIG_KVM */
 
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
-- 
2.38.1


