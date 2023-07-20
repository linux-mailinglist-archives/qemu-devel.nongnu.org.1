Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9047475A46D
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 04:34:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMJTn-0005BF-FB; Wed, 19 Jul 2023 22:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1qMJTl-00057L-NZ
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 22:33:21 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1qMJTi-0002Je-4D
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 22:33:21 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-55ae51a45deso137595a12.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 19:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689820397; x=1690425197; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NeghM0A34kEgUXe/bR+GnKje+GvXgNn0M3LxD9DKRg=;
 b=J0OufbkHD6H0SrjFBtAlmKVL2dTWEwIqFIaRzjg5/3JDnuUa8o2h4pWaY6CAQhNvPY
 WHABpjcCUNnokWXAolfJmDK9c00vww3QF1TnGLCGmdiPfWRawWyowm5ihHfE6nonOObn
 Ou8K/L22AwYLF/JmnWzUftqZxCrIkC84fWNzMJEv0cobocJco7vDTe4P41sNjoaF/QaN
 kYfFXAR/vvlW79oSOXRu6fFVxNv21WjeqUWhqhHq6AZxflBy7f4qXiiooZXYYv8FKlpD
 lyWtVM2vuuL3yjuehoskTi/DobAzrjGzPNjZ4IimMW/wRGJVQ+VFosWtDPFOWKF7K71n
 cZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689820397; x=1690425197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NeghM0A34kEgUXe/bR+GnKje+GvXgNn0M3LxD9DKRg=;
 b=cj+YwtobJSVxnRKiJGIgyv7rub1nOc6PsK6qz6RP7hvsKnDVCfv9GPF4owUUwSIo3r
 tZkOh6KZJ5zRlyidiKbFkDmBBBRU7eF/D5FS5et4ePcKTobbhVM96m+lt6432XIdnIWU
 HtJcKr7dC8Grnul7UqGf0rpPtHRpFv/1MaFyrhsZVwFwDW3Suco41QJaigfJaBT3Yt+t
 CCmKU3CVSItQt52yuxZWkxqBJVqoNERbZW03DympIE8ZEnJtSogH6WuvMpUghMOLSOvs
 O/ImeZXgMQHZN9k82FHGSG6pA0Me4XoxPzdcKiNmoXu4xpNyQBeHbrGIoIA6ixt5Bdm9
 ON5g==
X-Gm-Message-State: ABy/qLYBcT7N+vasFFibCR+Ecqxw1MyvDjNizVLoe8ZvWpnNo9TZt/oN
 2+ox2PbkaiRrfcqWsjoScXpYyw==
X-Google-Smtp-Source: APBJJlF6YgA0O7Ebiqk77QlSMqV6he5DlyVhy/dT4Y5EfsvKSxHgcjpwzR/01BPxePDs5BWkI5QV1A==
X-Received: by 2002:a05:6a20:414:b0:125:4d74:ac77 with SMTP id
 a20-20020a056a20041400b001254d74ac77mr2949234pza.42.1689820396962; 
 Wed, 19 Jul 2023 19:33:16 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a1709029a8500b001b9e9f191f2sm4692032plp.15.2023.07.19.19.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 19:33:16 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, linux@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH 2/5] MAINTAINERS: Add RISC-V IOMMU maintainers
Date: Wed, 19 Jul 2023 19:32:55 -0700
Message-Id: <06e15a936b62fca4c8bf232e17bb7e040a9cf17e.1689819031.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689819031.git.tjeznach@rivosinc.com>
References: <cover.1689819031.git.tjeznach@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=tjeznach@rivosinc.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43bd9afc19..ed8f65d879 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1971,6 +1971,12 @@ F: include/hw/i2c/ppc4xx_i2c.h
 F: hw/intc/ppc-uic.c
 F: include/hw/intc/ppc-uic.h
 
+RISC-V IOMMU
+M: Tomasz Jeznach <tjeznach@rivosinc.com>
+L: qemu-riscv@nongnu.org
+S: Maintained
+F: hw/riscv/riscv-iommu*
+
 Character devices
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
-- 
2.34.1


