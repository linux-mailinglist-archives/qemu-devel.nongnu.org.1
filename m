Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F4774DCD2
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 19:54:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIv2y-000142-8x; Mon, 10 Jul 2023 13:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv2i-0000yK-Iy
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:26 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv2f-000070-Oc
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:24 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3159da54e95so1035829f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689011472; x=1691603472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3N6F5aMrOUR9NN4jQ1KnUxsit6lU8XCjQJ4gcKL1MRw=;
 b=V6m1EVPSeqCVWicO+/rHjnCcNpkhEL/iqv2RogAXrTB1U7YrydIjf4GrICKB95LUt6
 dmVndOyKeDp9ipw3v14498l33bPCm18TdAV8oJWPCi9dIma6Fzsmje4pWLuZ9RA1vUQt
 hoH80iBQYE48fJzeou89Wpv28rCzjlWI7V+affJwiV9sdxBF8Kwgr65ZBePTaUsXtzBS
 LFmTrOxCTe79GlNIc0732nFXNZHb7UYGoaE/nYjlBX40LNxDrsUfWx8rVPxy2s4nWbT+
 SqMREOy02GAhdeHXABjkj7SI84cNaYIKdV8iauriivt6oBlRo6k9VPxPBYym7qw2j8VF
 pzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689011472; x=1691603472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3N6F5aMrOUR9NN4jQ1KnUxsit6lU8XCjQJ4gcKL1MRw=;
 b=UQDpQMKu7TaEW5JjG7c4q75MsGZP2A9oDZZ/EtRMhbLNKIAKSN6ZFfUVQRA9PiSUCJ
 ArhIXB7i+Xih/T/23pWjwdcw2EVH1CeMKtqKqcnamQH2dEdxAgg9bmx3YGtUEs2sWzvF
 ++KVEJNsAza+Dr80HDn91mR4sWvOd/0gQJxgAwkiEFI4WXz2opNCP6VfpQSWuOf5CdvI
 2+hOZqMkPvvkPv12KfnRMGTLyCFfyXf5yEYbSTS7Z3/SOh1KwEhh2kARM4CFSI2XSCNP
 OVMowdY8Sa3zbBTdOSc2V5QNLTLJr90HEi838LB8NdC30vnEfz1UtG1TsgNJXsz1sHpb
 Iw+A==
X-Gm-Message-State: ABy/qLY/cFVxP9EKNGLpuHxMjLt5iFpLgZMksp59Rhi9nJLiCYtSkzIf
 9vov1LeEopwKGiFWBknFhvK9ReF/lskJTQgAsBECIw==
X-Google-Smtp-Source: APBJJlEMKhigl9zNVvFziIhj5wOws/JGU3Th/RSu6I2YRCeySmK5ZXEtsWfqvzp6SIW6Npv5GvbNFQ==
X-Received: by 2002:adf:f602:0:b0:314:34f3:10af with SMTP id
 t2-20020adff602000000b0031434f310afmr13287777wrp.14.1689011471834; 
 Mon, 10 Jul 2023 10:51:11 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 f14-20020adfe90e000000b0030647449730sm18811wrm.74.2023.07.10.10.51.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 10:51:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/11] hw/char/pl011: Restrict MemoryRegionOps
 implementation access sizes
Date: Mon, 10 Jul 2023 19:50:52 +0200
Message-Id: <20230710175102.32429-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710175102.32429-1-philmd@linaro.org>
References: <20230710175102.32429-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

The pl011_read() and pl011_write() handlers shift the offset
argument by 2, so are implemented on a 32-bit boundary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 77bbc2a982..73f1a3aea2 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -358,6 +358,8 @@ static const MemoryRegionOps pl011_ops = {
     .read = pl011_read,
     .write = pl011_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
 };
 
 static bool pl011_clock_needed(void *opaque)
-- 
2.38.1


