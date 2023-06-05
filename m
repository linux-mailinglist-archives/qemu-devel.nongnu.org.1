Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40157723321
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 00:25:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6IdP-000082-JA; Mon, 05 Jun 2023 18:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6IdN-00006i-ML
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:25:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6IdK-0006Gi-NU
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:25:05 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f60e536250so46682455e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 15:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686003901; x=1688595901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/yeEo8qtcLgCzk258mXNxS4jpNAyf78Se0yUyTwITA=;
 b=IXGS5EQDSW3808Se6L7djkPCjpMBU0yz0J0tibv5nfuGEPKypRoe74aFoHg7Ra27v+
 iNDo0zeIaNGoJS59PjKqX+fb904E4zinxGzyDgNxy0O0IBqqci8Wn2B6OthMJ3xJK18N
 qZQUZNNoGLRGoHG/pgU4bDJ8lbsLUzp5Mdv2XUSBH3kIqyA5GJLSKUMFBSzdQO/MXvHi
 oWhuCHSSKLZkQDPvbArBqCt2k1DP9w9qZyzV1+oWWriT13MoBaZQgsE0pnlZ/bsbOtIT
 bqYx+fFXVhAEbfLLDcTbgBWnu7Q/aZuXB4YIBFAqv3NgsSCEUM0zR0ENq6gdy81uC8Uk
 ZX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686003901; x=1688595901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/yeEo8qtcLgCzk258mXNxS4jpNAyf78Se0yUyTwITA=;
 b=IFekvFskLk/DeBNlkXKOb/8SlIBuVWfdfXrs728A37G/EuDeWBlGa4tdF0VkwpueEj
 GLIrsSwl2/MIItDYBBg9gtLMKz5k/vpadR8sBDRn2bFDN20U20xcsWZuEaN/3j7J5lgu
 VCmgaN9LzKqwO2ieDth3TVRMjaxSFGV/R+dAN9ccQTOZktCfCwQcgP0x5tynk6UZRJXf
 iSf9+TQPjvbVrZryENdUeJR0B9OksmURQvHQSr9/TsVkbg444Qvdsp7BJNsM+HmTlBSS
 zfUKef9+XAMstkQiIhemsv23vPtKdDBKEJ+Y33cgZV9djWkgXSb+mhNkESI6uQGz/ooE
 310Q==
X-Gm-Message-State: AC+VfDyac1HDGd9512P4OeAmqedl4Uxbdl3Tg4d6r9iInU/l6xN+vuw1
 qEu5GoeZmswejxFgKCTRxN5Y82SM1UKh2tIqbFM=
X-Google-Smtp-Source: ACHHUZ7P/7l/L+eXD9rbfw8DoVBuEBVgz2TsR88IBvgp7OTxbwP9DeuWwN2cYIddKdVm3QNnZwJuCQ==
X-Received: by 2002:a5d:52c8:0:b0:30c:84d3:f5a with SMTP id
 r8-20020a5d52c8000000b0030c84d30f5amr7080393wrv.4.1686003901271; 
 Mon, 05 Jun 2023 15:25:01 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a056000108800b002ff2c39d072sm10635434wrw.104.2023.06.05.15.25.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 15:25:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 7/9] meson: Alias CONFIG_SOFTMMU -> CONFIG_SYSTEM_ONLY
Date: Tue,  6 Jun 2023 00:24:18 +0200
Message-Id: <20230605222420.14776-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230605222420.14776-1-philmd@linaro.org>
References: <20230605222420.14776-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

We use the CONFIG_USER_ONLY key to describe user emulation,
and the CONFIG_SOFTMMU key to describe system emulation. Alias
it as 'CONFIG_SYSTEM_ONLY' for parity with user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index a61d3e9b06..ce3fec7276 100644
--- a/meson.build
+++ b/meson.build
@@ -2888,6 +2888,7 @@ foreach target : target_dirs
     endif
     config_target += { 'CONFIG_BSD_USER': 'y' }
   elif target.endswith('softmmu')
+    config_target += { 'CONFIG_SYSTEM_ONLY': 'y' }
     config_target += { 'CONFIG_SOFTMMU': 'y' }
   endif
   if target.endswith('-user')
-- 
2.38.1


