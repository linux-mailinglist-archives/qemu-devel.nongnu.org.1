Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A49727A9862
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:42:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcQ-00022q-7Z; Thu, 21 Sep 2023 13:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcO-00021h-L1
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcI-0007fw-Es
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:34 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40528376459so12853815e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317849; x=1695922649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qQViptMVSdrRp9VfBJYI4Acm+qff4tHoiCsPi2XOdW4=;
 b=sOtS7RUwDcekYN4b2FEkx7Hyj0TbMkHcFTWhNAL0K1KUXiTNVBEBLAZZSWASajiMPj
 0DqP+PdhsLdEiaeTqke/OElkln3DgEMXLMDFY/j2mcw4JiqKc0fvXqmdtp4D0k5KH4yC
 RkafU5r17D1ktwVhrMQ7SIA6FqKsyWhL0SdqeQvkR65tq1p4i2K6moXttcFbeS5dLIoJ
 y+ur2HcEPkeT2wmuzWhz9I2TRZPi0j2SJObRBFkQAE46fd19L309LICO1CjiKNFSyQyH
 jQB9JBcQqrXOtMMOJw+eOcmNW9wF7KeiSkl9HzMmmKpomwItwJMWxKrAhP9EtQq43crk
 t7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317849; x=1695922649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQViptMVSdrRp9VfBJYI4Acm+qff4tHoiCsPi2XOdW4=;
 b=RDXykLfgiwmDC6qFWvYpqO7zEcIKzMdqK2nWX9vO+psFnxUMXvWw98R30+nYSXe4D4
 oaur64xIcGiWhDpzNVfs0whRLA4dGeTBH3+mdhEVlQE7mrCrnxITbYnkBB2MQ5NZusFk
 06mMGZtySUypdlc2ThrGBOVU8HU9y1w+zPio09cIatcj2So8bcR2Tb7NOF7wUJs0RUFa
 KQU0kc8ea9AETFB9QLvLZE1gCWUyroNjftmJvshFZnB3brKGlW4YDNwyrMLmxoheJUa8
 hgZZnRRBxtIAJAmPVMUL5nyyG/UwpQ2fnH8qZ99KQTMqfcKLiCGMK3unMvdkr0lSY7yl
 89Cg==
X-Gm-Message-State: AOJu0YwD4xzXDqlczLk1z7UFe7k/dyq7Uxbqy+eBp7sP2r3cRAGOhZjh
 N0m80dARHvgwjxmfsjAu75LNPTlsWm/y2moc48Y=
X-Google-Smtp-Source: AGHT+IEfd5bttzi0oyS3PZSghi65H8s3hH+Vpli+ry8RYk8WrnYd3zXif+BVVBlm0Pn6nBlqbnsS2A==
X-Received: by 2002:a05:600c:3b1d:b0:405:36d7:4581 with SMTP id
 m29-20020a05600c3b1d00b0040536d74581mr1738731wms.9.1695317849141; 
 Thu, 21 Sep 2023 10:37:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/30] target/arm: Define syndrome function for MOPS exceptions
Date: Thu, 21 Sep 2023 18:37:04 +0100
Message-Id: <20230921173720.3250581-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The FEAT_MOPS memory operations can raise a Memory Copy or Memory Set
exception if a copy or set instruction is executed when the CPU
register state is not correct for that instruction. Define the
usual syn_* function that constructs the syndrome register value
for these exceptions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230912140434.1333369-5-peter.maydell@linaro.org
---
 target/arm/syndrome.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 8a6b8f8162a..5d34755508d 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -58,6 +58,7 @@ enum arm_exception_class {
     EC_DATAABORT              = 0x24,
     EC_DATAABORT_SAME_EL      = 0x25,
     EC_SPALIGNMENT            = 0x26,
+    EC_MOP                    = 0x27,
     EC_AA32_FPTRAP            = 0x28,
     EC_AA64_FPTRAP            = 0x2c,
     EC_SERROR                 = 0x2f,
@@ -334,4 +335,15 @@ static inline uint32_t syn_serror(uint32_t extra)
     return (EC_SERROR << ARM_EL_EC_SHIFT) | ARM_EL_IL | extra;
 }
 
+static inline uint32_t syn_mop(bool is_set, bool is_setg, int options,
+                               bool epilogue, bool wrong_option, bool option_a,
+                               int destreg, int srcreg, int sizereg)
+{
+    return (EC_MOP << ARM_EL_EC_SHIFT) | ARM_EL_IL |
+        (is_set << 24) | (is_setg << 23) | (options << 19) |
+        (epilogue << 18) | (wrong_option << 17) | (option_a << 16) |
+        (destreg << 10) | (srcreg << 5) | sizereg;
+}
+
+
 #endif /* TARGET_ARM_SYNDROME_H */
-- 
2.34.1


