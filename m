Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0898BCD517
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Oct 2025 15:46:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DPq-0002Va-2e; Fri, 10 Oct 2025 09:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DPT-0002MN-4Y
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:43:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DOq-00084T-99
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:43:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso12155105e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760103782; x=1760708582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwAzvO9gvcfrUDpFLGxwbVJ7FPHxQaLieV6nfbJhlno=;
 b=q4MWCMfQNBPXg3A6nbpj0bJXV1rOdBextWwOtk0+a2sAw6O5N0YZPIkI8vtsRF1PN7
 nAShrmlT2CV7qEFDgU35JQXWLTjqmSfDxz+g7cy8AUcZCbSYKYXaxRD1GCk80Gu2d6VG
 v8oxDY+92mWisUZdyb6xj/GHdMpbufw/xON/FedHC543e+FYRpcM8wdSISDXpu8gvZdi
 NvLV786qi4xZiduSjIRD4IhMiE09bEkgKG7tfD+D3raMxGUfa9bHIEDMKolRIOIaqj1T
 eHxofA0UGtZYFoK6k2/NPy2hd2bttkB8+B0YeqX3+1+4KLaIRdTQn/rZdyJ9ySiMGOEk
 hkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760103782; x=1760708582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TwAzvO9gvcfrUDpFLGxwbVJ7FPHxQaLieV6nfbJhlno=;
 b=f4zDTKSEECS9qs0CPJ2wNjvkxXs9ZxuHLA8CeCJ5orviFM3dIiAEkBvkCDUh9qhkFJ
 /N8Ovn1uARvWASYTvLWvoFIWqclA8wfZYbgztzMNMLswDEpI7wrEcMtofYtYdA9DsC6r
 Wi9Pahqge2klcsLiB22+ixqtuZs5uRZnpHLtL7s3iXumSXh0w4hkeuW/4nG5HdH6qUfE
 NnOj/V1fFSgExKaXso97eGEtOEuKKqoLfNrjAZCZTlJsf2quiWLbnMzDpprej+IqmJcn
 ipcE0JR8z+LzWiYXpIRJZRCqJui84HRtpFooUN6X8IEc8dube3e1Y1sWyVe/vMIfM4Lz
 Ltmg==
X-Gm-Message-State: AOJu0YzkQ1br3IFCihDfVhz21KAKXmU5c9Td0r8HeTb1ncHewNY7lym5
 HrUS3EbgG/FF1LQkZjBP/1IxGlS+6spgzEfHmGRcTqEqA4VvVatQgD7SVRLUod35UPxthdaqiSc
 oO3V8V5DG/Q==
X-Gm-Gg: ASbGncsEtmoQnkkNn+MEm13z9X/gQmqZmkupWUE9ApCvK58abK/LDOOILti7jfsyCCj
 SAnQRmLweX3xzPT24CzGSDXbLNZonKo5tljkCsLUBPYlsZlshwDNoGRK7oe+OktYlQyK2dO9wB5
 IbcJyKmcel6t6hykx3eSeNz0kgvoTSa9SMUeBFuw3hA48b9l7G/DmrIX+Lb3WlZLJa7wPpIgIer
 yaKztEN6JWK+a6tC2qNSoNzckxV7j/lhQiqhGHdyfw/u4cddMiAoCgXDMUPE05sKXA+/2EHW95H
 1xKzH2NRh3HZ4jeelBd6Idp0xa6TrSaAslGC06G+LA0UMbWE6lpkdS67DvEtKUghUGRqy65gQxh
 7MPnY9mXhciFA9XdAtROQdDe8wGkwRHn6laXdD1qx+arkbCF1h57bC8CwRBtJagyvDNdGhxMqBe
 cQ78JN3L2eEDYB3qvyrzsh7cIhWiaiNg==
X-Google-Smtp-Source: AGHT+IHajMtSeTIEyh6n8MyR6pgrCZEB1nqfEHOw6v3cOEm9Bb6+kEevt48OwTYU3ThjT8h4iDk1yw==
X-Received: by 2002:a05:600c:1d18:b0:45f:2869:c3b2 with SMTP id
 5b1f17b1804b1-46fa9b1834dmr84819305e9.33.1760103782247; 
 Fri, 10 Oct 2025 06:43:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb497aec2sm48065605e9.1.2025.10.10.06.42.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 06:43:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/16] hw/core/loader: Replace HOST_BIG_ENDIAN #ifdef with
 runtime if() check
Date: Fri, 10 Oct 2025 15:42:15 +0200
Message-ID: <20251010134226.72221-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010134226.72221-1-philmd@linaro.org>
References: <20251010134226.72221-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SUSPICIOUS_RECIPS=2.51,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Replace compile-time #ifdef with a runtime check to ensure all code
paths are built and tested. This reduces build-time configuration
complexity and improves maintainability.

No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/loader.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 477661a0255..aef10cb3f2b 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -491,7 +491,9 @@ ssize_t load_elf_ram_sym(const char *filename,
 
 static void bswap_uboot_header(uboot_image_header_t *hdr)
 {
-#if !HOST_BIG_ENDIAN
+    if (HOST_BIG_ENDIAN) {
+        return;
+    }
     bswap32s(&hdr->ih_magic);
     bswap32s(&hdr->ih_hcrc);
     bswap32s(&hdr->ih_time);
@@ -499,7 +501,6 @@ static void bswap_uboot_header(uboot_image_header_t *hdr)
     bswap32s(&hdr->ih_load);
     bswap32s(&hdr->ih_ep);
     bswap32s(&hdr->ih_dcrc);
-#endif
 }
 
 
-- 
2.51.0


