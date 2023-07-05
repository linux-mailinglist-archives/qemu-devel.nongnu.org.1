Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5905749009
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 23:42:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAF7-0005JY-UX; Wed, 05 Jul 2023 17:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAF5-0005Er-38
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:40:55 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAF2-0001o3-3C
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:40:54 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1b3f281c4e1so140330fac.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 14:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688593249; x=1691185249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EtERhF/xfYQMjn+bEX8PIQ4lMIfhPOCNLObYIRjwmfo=;
 b=cENLwSmRS3VpDtMkgB40IrG+x6KQ/q3kZD4MbYX61fklecky3Se5D9d/aL45rFKhRz
 kTNQAn6luWRoJLQS7EqxPFwgA2+QTMo5RUlAZptOBTzMe8eOlSlC2+ySO/e0beOi02y9
 YTMtA15uRpG4jOIp/kBCpHAdkKOGBdoLtNwcJ4HT1ontGZT203D9H0TmsmfWsQWCDe6P
 7jTVVDjVdh0YqUqKvGJptcQwFO7XBlH0Pe7QZ0Itq5PVUy3XacNUIg3h19MGir2c5PWS
 Fxg6E0U5hwzTg15sQ4OLgGz5K+wlhy4Pp7qPI2rYHrDIQZ5SgThLZzRF7hL23ddVYWvI
 YLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688593249; x=1691185249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EtERhF/xfYQMjn+bEX8PIQ4lMIfhPOCNLObYIRjwmfo=;
 b=l9ixfg8/c7t515zM+66oxaarTA6tl8mH6mmrYT19yDBgzC4m2HPr2AWmy02QrVhaYk
 Ww15nnS0o70469f9EAO1c1FRN5RwQwdcKChGPpUpmDZS6RE2gnSHjKzGd624WFBFhPiP
 ZpnA+V5rIbRP2VKExlgyrFUFSfesB1AEYioYSjMT79Rf+ocZPaB3brmIpni9LtaSotSH
 0oZtBz0CkD0X0i0r1p5u0bQ+AiTFjL0bVpZk/mtwNVHAISa7lG8A0ZDOpEYmJ6flTrRW
 Y6VTIXb7Tu28fqB7eOU/vKC4coUF+9irK80eKYWN7c+TjGlmg3SZaCh4sOf3iacj/pJb
 2jLA==
X-Gm-Message-State: ABy/qLZCUag94pZrwC32p4x0fzcPYOlcDC0E4MX7T7HFVYIHrPDvAccL
 zFDJMjvORAKnxeShiRJovPaK23GIwoG9W4vjcPg=
X-Google-Smtp-Source: APBJJlEZlCh26AcMZPatpRbkO+mx9aEHPmcMYquUFK3uudc2pv8FDwYF1o8MR0nh5R6HEkUfES4Thw==
X-Received: by 2002:a05:6870:3453:b0:1a2:8f84:31ec with SMTP id
 i19-20020a056870345300b001a28f8431ecmr244187oah.31.1688593249624; 
 Wed, 05 Jul 2023 14:40:49 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a4add01000000b0056665a16536sm70764oou.30.2023.07.05.14.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 14:40:49 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 15/20] target/riscv/cpu.c: add satp_mode properties earlier
Date: Wed,  5 Jul 2023 18:39:50 -0300
Message-ID: <20230705213955.429895-16-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705213955.429895-1-dbarboza@ventanamicro.com>
References: <20230705213955.429895-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2e.google.com
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

riscv_cpu_add_user_properties() ended up with an excess of "#ifndef
CONFIG_USER_ONLY" blocks after changes that added KVM properties
handling.

KVM specific properties are required to be created earlier than their
TCG counterparts, but the remaining props can be created at any order.
Move riscv_add_satp_mode_properties() to the start of the function,
inside the !CONFIG_USER_ONLY block already present there, to remove the
last ifndef block.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 31e591a938..deb3c0f035 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1852,6 +1852,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
 #ifndef CONFIG_USER_ONLY
+    riscv_add_satp_mode_properties(obj);
+
     if (kvm_enabled()) {
         kvm_riscv_init_user_properties(obj);
     }
@@ -1870,10 +1872,6 @@ static void riscv_cpu_add_user_properties(Object *obj)
 #endif
         qdev_property_add_static(dev, prop);
     }
-
-#ifndef CONFIG_USER_ONLY
-    riscv_add_satp_mode_properties(obj);
-#endif
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0


