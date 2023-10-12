Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72F7C63E5
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn5C-0008OB-RI; Thu, 12 Oct 2023 00:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn5A-00089O-6d
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:56 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn58-0002qk-IX
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:55 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c7373cff01so13559195ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084033; x=1697688833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGvUUwVKrID/gEcvjtCzVgtH+tZ51VhpFUnyUmkkEzg=;
 b=LHBzOIY15lPDHSYSkhcSlvzllIJ/CxvrNuTYlV8deWOzVaJ0+T492z7WFnihhWWEiG
 HO1zs3Bago5D0nYobM9cLmk3dZvy/0quLsovhpVznXtZR/Gvl4RHYogXWA02fCwscI7I
 ag0VaNnereMaGSV6sJybUi3afHcbPxC03TcyHvUMEkiHi3gfkYj8TGDfohwvVdFz71G2
 Qfasm6fADLwiLQWNDXn2paTdbDJMETG3vVjdodJWyj0ec+N/iDYTFSOMSyqTtLdkMm64
 Vot7cejsfS0i2gFztUqwMiZ8gUhVrCKmiTzxCUvwaAtA23DX7lmcn7tHDnV2xrA9K/6t
 7ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084033; x=1697688833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RGvUUwVKrID/gEcvjtCzVgtH+tZ51VhpFUnyUmkkEzg=;
 b=hi82OJAqIkeFYfhHUxmdWBvNeHqZ/YggC2vzlPL64acBBnUJHOIgwX/+E0dGifSduZ
 ZsBJpxSa/PcpmzStAIB67nkKm39YxKarrMt+8x0GdwW80XUCsN1JLeY3R0RyL+xjV8a3
 GvK2BqIyxnH8XsJMxVDXiMVZUkRuTUBU+EeNDmpx0tJu6itzwzMKbYAhaIrvvXGTCkWl
 5zD89kepakkNeMdsz8jhNcCenAA9TLNNXEPyDBcMFJu59DIuf8Hmmmdwh5Rukk0zHrdX
 0qwaNnfkG+3kEsQefX7Az/CBwnedd3NGDaa/URp9hgNRCcZ6T+A4XihjzkuLImNdESNt
 y7Mw==
X-Gm-Message-State: AOJu0YwAeDJyu+WxWprVsJPEcHeW0Foh0xVe16IrpwFBhNKafP+IBJR/
 7RltGBqolTipyyRjDqTToh2f3gQ1H7xweg==
X-Google-Smtp-Source: AGHT+IEwyFf6TBlUpupbE5/sG8DH/8UqEClN6f0Ka0DX5H9u2yALSKN7hrjMz0WwwCyLDbbo/HqimQ==
X-Received: by 2002:a17:902:fb8f:b0:1c9:dac0:fbc2 with SMTP id
 lg15-20020a170902fb8f00b001c9dac0fbc2mr2136285plb.13.1697084032932; 
 Wed, 11 Oct 2023 21:13:52 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:52 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 49/54] target/riscv/kvm: improve 'init_multiext_cfg' error msg
Date: Thu, 12 Oct 2023 14:10:46 +1000
Message-ID: <20231012041051.2572507-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Our error message is returning the value of 'ret', which will be always
-1 in case of error, and will not be that useful:

qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error -1

Improve the error message by outputting 'errno' instead of 'ret'. Use
strerrorname_np() to output the error name instead of the error code.
This will give us what we need to know right away:

qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error code: ENOENT

Given that we're going to exit(1) in this condition instead of
attempting to recover, remove the 'kvm_riscv_destroy_scratch_vcpu()'
call.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231003132148.797921-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c6615cb807..c3daf74fe9 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -792,8 +792,8 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
                 val = false;
             } else {
                 error_report("Unable to read ISA_EXT KVM register %s, "
-                             "error %d", multi_ext_cfg->name, ret);
-                kvm_riscv_destroy_scratch_vcpu(kvmcpu);
+                             "error code: %s", multi_ext_cfg->name,
+                             strerrorname_np(errno));
                 exit(EXIT_FAILURE);
             }
         } else {
-- 
2.41.0


