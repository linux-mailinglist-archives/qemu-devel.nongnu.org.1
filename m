Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 147B7A99D8C
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 03:00:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kri-0005Wk-JG; Wed, 23 Apr 2025 20:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015i-Sq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqI-0004kd-EL
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:32 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7376dd56f60so275547b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456009; x=1746060809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KE33KBayr4dnRr7Xrs3VkN2rsoJvmDMI/IpM1PhpEq8=;
 b=xN2OSvEVAV/z7xu9BY3nBawjjwEHjsmq04rNCInWlClAa9mSmJxZS3m6N63Al8q3HA
 LKtINAnp83M7f2kbIGdJFYiIXAesw0DAfkZeh+Gy1icIDVUV7gyACdxXPuj4j47/PdMF
 /ANWNGK6X//j+6XE4yI94gP/vyRPDlJgUlB5qzaoIu4oXNUzKccYG9q0yWS5CnTO6zbr
 phLqp3Ef7XbGDQ96lO9K38NG7LdKjKMX8z3trQlj+MLhgmxGKYYj5RDpNJOWSGquJDAa
 SLYKTVSWzXpXxwO2qXbBeLk4lOM59nr/uI9hVTQ+L4BEGB3Ym74domg1YSNNta6QS+Kl
 L37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456009; x=1746060809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KE33KBayr4dnRr7Xrs3VkN2rsoJvmDMI/IpM1PhpEq8=;
 b=L0/Zewm6L8rWUhoeaBZ/JPUkfOa+ATRwF2aqh2J7S2yl+/5BCDuSSXKtsbVyx2Oqd7
 vYmVenIVsivRO0+ISgrJ3UpNrtyMK2/8iUmjEqsvKUnOl9ECOjG/pf8VL+NNd+iexpt2
 y6GTA3LSzzhB5zodtvlzzyqg32H12b2tukPn1J9MudB2PClD0xGC2Zbwn6RLwSssPDlm
 vOCB+jVfUr8JKrVYrCgPNJrVhrIctJ6FGBlhdHCYoy3d3zuHWO68JXbpqpxUwZpZpfyr
 7i9yTwZUG/B7wQMrpQMBfTmUnF6MX7DHxyuBD34cLgYyO/wzhX1ndWC5yQZMhO7k0uR3
 DvOw==
X-Gm-Message-State: AOJu0YzOweSqHKNU4RbHXP0D+WUtO2GbI7LYWbXYwhYNi8+WySCxROJi
 PpNZX/c9OGo/oN930kCxGs21+w8/YLmK2fx00Trpb41gb38CZ1mZNqpA93LyBcPtrIq3furiHQx
 E
X-Gm-Gg: ASbGncul6lgvKJ1yPYOUeDSqZj3/o7r5u8KK5oFK5fl1ZgqEqM6qOuG8XLo2Rg164zT
 LnmGw+uoHpaY449XNgUekhWfsZdqYrJhKPkQ6v/gvyF8OtmdKxRZvFvWg24or2fdVRF5aS5eiW/
 Mp1QxkNjPPyvZ8jWMb4KwNt8/g/beUo00qR/whUiarCK5hh8HjvARGldVbl2JMPoK37uNPJC18m
 7xVh03uN2iFeayYFKTe6SQKQXLZI/kH56/nOI15uY1v6pQ/IowIjuOKy090sR5RAdawWL80HD3A
 SxOA7x3X93sNFcK+n7Qi8XZGSmjEp+jI6sxoSsVv0/z1UE4o/Tio8ImfsA7w981p8C6XYhNwFIz
 EQdLoBiHcgw==
X-Google-Smtp-Source: AGHT+IE2J1FSNEpylV080Uh6x4Ts6ePpDVOHTSZGcy9QV2H4hWSb05rBYGjQQ4VR7bDWZGiklpnEFw==
X-Received: by 2002:a05:6300:6681:b0:1f5:8126:8a5d with SMTP id
 adf61e73a8af0-20444f08482mr784006637.17.1745456008949; 
 Wed, 23 Apr 2025 17:53:28 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 072/148] hw/core/cpu: Update CPUClass::mmu_index docstring
Date: Wed, 23 Apr 2025 17:48:17 -0700
Message-ID: <20250424004934.598783-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commits 32a8ea12fab..90b7022e698 (target: "Split out
TARGET_env_mmu_index"), target's memory_rw_debug() callbacks
use the target's TARGET_env_mmu_index(), not the generic
CPUClass::mmu_index() callback. Update the documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-2-philmd@linaro.org>
---
 include/hw/core/cpu.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6dcee5d0ba..29f6419050 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -104,8 +104,7 @@ struct SysemuCPUOps;
  *                 instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @mmu_index: Callback for choosing softmmu mmu index;
- *       may be used internally by memory_rw_debug without TCG.
+ * @mmu_index: Callback for choosing softmmu mmu index.
  * @memory_rw_debug: Callback for GDB memory access.
  * @dump_state: Callback for dumping state.
  * @query_cpu_fast:
-- 
2.43.0


