Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA80E78D6B6
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:56:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMaM-0001FN-SD; Wed, 30 Aug 2023 10:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaK-0001Dr-K0
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:20 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaF-0000lV-Ia
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:20 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31c8321c48fso631075f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407254; x=1694012054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKjAgQoj2FFsH6qRrmv8SNeV5ivWp4tXeZ8rykfRKz0=;
 b=swZJNEGXqnTMvy1jFN8vxOx1D/68V5iyROcHqkELnQqZIWK052mHjALCX06QsWBnT7
 0238cPdGWQtl6G9ocsB9p0w22FaqhRfOhLS+4yOy838PJWlksxbmdqdRHMZ2TEpLESQ7
 ZTfCEQf8XFc7RRMS5uoiorUtvyDt6j7hF9W3y/2Q7lHC1Bf6dj5tGqhxvJVgYnWDG9ER
 P0/eAMTv4jzuCVp/TRIysjO6kiQyCOoizUrh/TN5zH1g4hC5TrJTtEqMpeqSWH5dbBWd
 b6FPIjWWTdwLy+xrjCGsu3JcY2TRKUCbmIjtyZJwMIzXHI1Y1IixeoswZtvqDhedt7/U
 ml9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407254; x=1694012054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKjAgQoj2FFsH6qRrmv8SNeV5ivWp4tXeZ8rykfRKz0=;
 b=Qpri+AkHJgdTa+EEcoofeEzlTweKW5pHX/6ZXA72r+i3oULb6GwRhPEUX3VYRv8tYI
 NljGK/+dBr6pPfn/n7genJYCWhbkGOgIoTHAMIs4zwL0XUp2uvz3ZnKZyyFNhxk0YMAl
 +RxgYR9y0xZL8ICeG2bsZWtzG/BwQbRkx5jlSyiMjolNHpki9kQB/zlxRL9hV8fmrrdW
 WHzoB1Q3EjpqzjHRAw6e3VsiyBTKVZhnzhEome8DIj1Uy2eZoDyLvE9kOyLS2aLlgOwE
 8it0HqWpB+ICK8QzRD8TZ0LqLs5h5dNSnSiJAaGcgz8jv8g0ZRPzZYtPqDSE/BlwNMyF
 UVYQ==
X-Gm-Message-State: AOJu0YxvkP8CtzF2pJqMct6jzjYHxSLcxgAymD5+778mCwo2EWcvjGKx
 erk/59CpTJgxadbU/m3Q4SxeHQ==
X-Google-Smtp-Source: AGHT+IFQi+JSrDVqEeN60MsRe7UVIdJns3aQBSrxm+N1qgNV+VRNVJpzuBtuQmObro1Nzwf5dxllIw==
X-Received: by 2002:adf:f7c1:0:b0:317:6734:c2ae with SMTP id
 a1-20020adff7c1000000b003176734c2aemr4673187wrq.11.1693407254211; 
 Wed, 30 Aug 2023 07:54:14 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a5d6a88000000b0031431fb40fasm16810212wru.89.2023.08.30.07.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:54:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0305A1FFC4;
 Wed, 30 Aug 2023 15:54:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/12] gdbstub: move comment for gdb_register_coprocessor
Date: Wed, 30 Aug 2023 15:54:07 +0100
Message-Id: <20230830145407.3064249-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830145407.3064249-1-alex.bennee@linaro.org>
References: <20230830145407.3064249-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Use proper kdoc style comments for this API function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230829161528.2707696-13-alex.bennee@linaro.org>

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 0ee39cfdd1..16a139043f 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -14,6 +14,16 @@
 /* Get or set a register.  Returns the size of the register.  */
 typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int reg);
 typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
+
+/**
+ * gdb_register_coprocessor() - register a supplemental set of registers
+ * @cpu - the CPU associated with registers
+ * @get_reg - get function (gdb reading)
+ * @set_reg - set function (gdb modifying)
+ * @num_regs - number of registers in set
+ * @xml - xml name of set
+ * @gpos - non-zero to append to "general" register set at @gpos
+ */
 void gdb_register_coprocessor(CPUState *cpu,
                               gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                               int num_regs, const char *xml, int g_pos);
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index fdebfe25ea..349d348c7b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -456,12 +456,6 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
     return 0;
 }
 
-/* Register a supplemental set of CPU registers.  If g_pos is nonzero it
-   specifies the first register number and these registers are included in
-   a standard "g" packet.  Direction is relative to gdb, i.e. get_reg is
-   gdb reading a CPU register, and set_reg is gdb modifying a CPU register.
- */
-
 void gdb_register_coprocessor(CPUState *cpu,
                               gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                               int num_regs, const char *xml, int g_pos)
-- 
2.39.2


