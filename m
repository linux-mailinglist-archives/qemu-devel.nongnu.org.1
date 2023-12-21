Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3CA81B45A
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:50:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGar-0004t2-EI; Thu, 21 Dec 2023 05:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGae-0004XV-7e
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:47:44 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGa7-0007Om-SY
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:47:43 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33664b4e038so538142f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155629; x=1703760429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUTepCaXuSvQff7RpqKHmtGuMDeLUnEdp+0FVQ8ed3M=;
 b=aN2WHN92FcXVpT41qPo6o7oMzsb2KtSPBnOTZnzroCVfsfZNWVM8AeQrNdlmeweVqQ
 6X87tZphYy1T/1LF1JkHt0IGNKicRO+qbcnFW1inxrt5YHhwlis49o++7fyY/YqS7HO+
 MHUiHy+rxTVKUl1PhT3cMxuJWI6DGuo5LCGsC/YCo8zYuLVxIaqyDkp/9JwNPRlq20Tj
 bp54v4h8gAW80JbDCcSIuSJR9D+dIw/6wbzlNtJCIIFNNk69J35tSLoVIqTgOrKU/7q0
 jFyiGMltlNOkT2RAp4VJm4s5jQgpsR7S870RUwI6xSnGH6PwvjZgeEyMFq+zakjh4pd2
 3m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155629; x=1703760429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUTepCaXuSvQff7RpqKHmtGuMDeLUnEdp+0FVQ8ed3M=;
 b=J55yP9qkcnSBoDWKyl9xGxHgSWAM4if5ZDON+n3Bf64s1FntYIIWqO9W++rGOPBTHb
 n3i6CwrfShBstUNwuigmeE0HXyE67zE4LYp8UaGcDvb49scYufjdoaoMEgKWBLlKUTsY
 56BOlsJX5jaJdYahtcSGOkKk+rHtp8Br/GeEV5zYUXwbTl8rzY43dyoJHEIB3FojSD/v
 MiZDLO0sACBtKBrzahFkra6pN2O0bxTAu/h0vcTHYeN2JXV923GZVUTh7AKbQk4TAvym
 AxZHbbFbhzk23XTCQPbBONtRjqfc2iJYIc1uMy6gH5EypCapXoTY13w2HZ0vOcEKMpGM
 30bw==
X-Gm-Message-State: AOJu0YxdvEpGhDY0m/Xl3VVJ+fDahzZ0PTzOFDEMe9O+ZdY+hwfrjNa4
 D3cUDEJMBzJI+pnA0GlpY9EwlQ==
X-Google-Smtp-Source: AGHT+IEE4PAyT0ppKhyWQR8C/CCDf6gD5uddgw77/sGyjUuzJA78iyT8JScfYrBXoIsKBK7do/LM6A==
X-Received: by 2002:adf:f6d2:0:b0:336:763c:c3e5 with SMTP id
 y18-20020adff6d2000000b00336763cc3e5mr603684wrp.93.1703155629711; 
 Thu, 21 Dec 2023 02:47:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w11-20020adfcd0b000000b003367e35abd4sm1742637wrm.71.2023.12.21.02.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:47:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E5B975F8E5;
 Thu, 21 Dec 2023 10:38:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Brian Cain <bcain@quicinc.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 21/40] hw/riscv: Use misa_mxl instead of misa_mxl_max
Date: Thu, 21 Dec 2023 10:37:59 +0000
Message-Id: <20231221103818.1633766-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221103818.1633766-1-alex.bennee@linaro.org>
References: <20231221103818.1633766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The effective MXL value matters when booting.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20231213-riscv-v7-1-a760156a337f@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/riscv/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 0ffca05189f..bc67c0bd189 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -36,7 +36,7 @@
 
 bool riscv_is_32bit(RISCVHartArrayState *harts)
 {
-    return harts->harts[0].env.misa_mxl_max == MXL_RV32;
+    return harts->harts[0].env.misa_mxl == MXL_RV32;
 }
 
 /*
-- 
2.39.2


