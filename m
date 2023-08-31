Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B44D78EAF4
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfB8-0003RR-0C; Thu, 31 Aug 2023 06:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfAy-0003Ho-O9
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:27 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfAw-00042E-Dq
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:24 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31c6d17aec4so487578f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478721; x=1694083521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7ncdZHIDdNC6GVeCDPftwbMq1HmKWTmiwY6qY4VZq8U=;
 b=aEvjt0u0Bu6u3bYYHxPJJn4Mq9Vk5hPMg7Q/IQy88XaTlVheJqDtif572k7XE44xWs
 uKWlF7D2MqfiDcxvJbo44bFzmpXp0+rg5klS6AMTarO3m2qM8jgGp8tisoAf1gLBP8cS
 9kYPk8wQtT5BI2lFA1GxIErlI8NOGlpNYYXpxRWuMDuqWKhT/vxYPNYW33dnepOUWUzA
 mILHAyMN+Yqx5m4BW3smIoZgy4EoWjOSF0WlUSI54I6xNGQ1Nv1GXvsh+hBUlXPmEWM2
 Hd79IOT+UmxOrSLUPU6JZoCtXT+bf0X9QU3S5qChFyjCZgE5KENHvuD4IUP3NOR2l7Xk
 M0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478721; x=1694083521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ncdZHIDdNC6GVeCDPftwbMq1HmKWTmiwY6qY4VZq8U=;
 b=FmU85lPQRWpBpsXF7byGKtKT1IZNrxLbq++1AwCEWtBr24hJD8G5bCdeIoXZg3cNUk
 7VtBGDo45J9PINo2sDCaZ/Ryz2auJfqdjMH7NlSdXNn7IqrGUQQK+YpPbUBHUaq+pmvR
 A2Z+47niT16RWJk5pPqKXZIHdzfOfELsCW61ZEC0KOl+HwbaoA+UGVrUlwXxvoeb+Xk6
 Zo9UuCnh2wsmpaJedzRc6yKIxywnY5pHi5FlF32naT8pR5WXRd0TM2HJ8fwXPjYR1ceP
 +D79XKUhWpFGE5iQhQaEZ34YrwsrYu5fS9jq/ZXJGTSeKhGbqUEwdXpfz0ZYwa/tjVR8
 kUuw==
X-Gm-Message-State: AOJu0Yy+XkLRzaEe3fIvMnaxvpIOy+9eqh+jT6ICY4lzSd6g3eJgVvvQ
 9T7PBLMIIJUAiFFkDZvCq9sXE7Bva8ShsgGSvbo=
X-Google-Smtp-Source: AGHT+IHIc6YiAhKIEl2ogus9sOmjc1ncuOZtndBaMXMUAZUJ8zPWj4+7BWGHRi7fIpVLAtG9k1FpBQ==
X-Received: by 2002:adf:e704:0:b0:31a:d6cf:7709 with SMTP id
 c4-20020adfe704000000b0031ad6cf7709mr3552676wrm.22.1693478720977; 
 Thu, 31 Aug 2023 03:45:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/24] target/arm: Reduce dcz_blocksize to uint8_t
Date: Thu, 31 Aug 2023 11:44:56 +0100
Message-Id: <20230831104519.3520658-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

This value is only 4 bits wide.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230811214031.171020-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cdf8600b96a..a1e604366b2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1074,7 +1074,8 @@ struct ArchCPU {
     bool prop_lpa2;
 
     /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
-    uint32_t dcz_blocksize;
+    uint8_t dcz_blocksize;
+
     uint64_t rvbar_prop; /* Property/input signals.  */
 
     /* Configurable aspects of GIC cpu interface (which is part of the CPU) */
-- 
2.34.1


