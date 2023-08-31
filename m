Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AB378EE29
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:10:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhKW-0006y7-Rn; Thu, 31 Aug 2023 09:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhGI-00046X-AV
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:59:07 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhGA-0005l1-F6
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:58:57 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-76df3d8fb4eso43065985a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486733; x=1694091533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5bbQfYGZZhyRdQ+SvkDiLWY1Nv20tz8tbv49oHFS9o=;
 b=M9Kat/cjpOlQ4+vKeehxL0ZEAhBnTWjoAVq2lrBsC41Cv76EbGJqlK0c41PF1KA9oe
 zT5iegc6BRHpyKo0C15n4FFT+uavz+/xeYTohsNFKqn7pSukA/wg4ltULf4aRu4qY3ub
 76VgYQa+nFm62a0dEtAFIE9yreLgWhQ5/rQyyTWOOUsAzMDOBVqNNtTs8Tgse9peZS87
 Zo/I89VYStVcc3RNL9Wqbf5JPwwIRlmxyN+GFzuC8qs9069O6vbxKUAEj5KgivXpQiT2
 IB96Ow6jzI00aloAeg1ml0paT7kyV6/FSV2ss42whd5C2JWH1jCrqDuuuwKkeFCqg+3X
 fZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486733; x=1694091533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5bbQfYGZZhyRdQ+SvkDiLWY1Nv20tz8tbv49oHFS9o=;
 b=Fzfx5yxcAGS78p2l4n+3HoLcoWHmMhyB3bzXrEV06+lxNdIimiBANjVk+6p37olWnp
 0GaCovtuTjKfpfl+ElNmxE4NhK11T8B7t+bJ3wWjWkFIkYnv28JSuWp8towQ4rGy9QCl
 qLgBx9TBzbiv6DMf36a6YJTjt85unjuTqmRR5zMLhGNLJr/VZk/SlbOVmZ7kLiXjHbGa
 jZx0Yfsg9E3hcd4/6IsLca8hUoGurSze+25QnTweEWi2oIq4TPOunSnRBSyjcqguCesE
 MC+KDMSks1L61x/+xYRGHcPTqv5x8LS0Tgzim1u80AKU9dVdyd6GZcfkLCtik95aHTQd
 3o8w==
X-Gm-Message-State: AOJu0YzbLWTJmvVuUMqwHVasn76fxMOSRsbXIKzjfAqxAVZ+HBzKN8tq
 LwGnU0sK2NWsMloMKbr15/uPHa0Y9haoMwf5BG0=
X-Google-Smtp-Source: AGHT+IHSW+yUN1e3QEfwoIt7a85zO9JIx6I4sMjkHWm5PSwgA+H4gEM/01+PRHRrH/VU13UgKf//Qw==
X-Received: by 2002:a05:620a:17ac:b0:76c:aff9:9f27 with SMTP id
 ay44-20020a05620a17ac00b0076caff99f27mr2915897qkb.59.1693486732897; 
 Thu, 31 Aug 2023 05:58:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 r4-20020a05620a03c400b0076cd2591629sm576981qkm.6.2023.08.31.05.58.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 05:58:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 21/41] hw/char/pl011: Restrict MemoryRegionOps implementation
 access sizes
Date: Thu, 31 Aug 2023 14:56:23 +0200
Message-ID: <20230831125646.67855-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x734.google.com
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

The pl011_read() and pl011_write() handlers shift the offset
argument by 2, so are implemented on a 32-bit boundary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230710175102.32429-2-philmd@linaro.org>
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
2.41.0


