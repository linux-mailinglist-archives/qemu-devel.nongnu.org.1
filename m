Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF17978C983
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:19:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1Np-00055H-80; Tue, 29 Aug 2023 12:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1Na-0004pi-J1
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:47 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NR-0004SD-5Y
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:46 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso4118071f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693325735; x=1693930535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=641GYd2IB2M0B+j3IAYf6vUTBtf44JLc2SkA+xJFKp0=;
 b=oc+Q4mYZf9/YHUG03PttxTVHFvT1xT2vGYHyCh4rrs60RwD91QqzQqpgRs0TKgw2S6
 MnVaPRftVh87nHiwrwh1O2JUbaPkskurVoQ5cf8uELspi4IhL/Hi/p0jtV3JFFyOeFCf
 fVU5RMgkX1BbMRb6onmgbcF2K/sA6/JkavA/R0Ah3zuuncVYW84CV1viVUQBQmbVVTdI
 JvRRbia7XjmUJmyJZZ5gc95XBiJ/9X6prrmYXRUXoxYWLAVudGtEoBYwXZ/9xXNAkQct
 zKNhXpBGjmfzTLjszj6j8Bqz74MacONsd+rb84kM3+UFejMp/fdP5GLzTpFOIdRlqFAh
 MX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693325735; x=1693930535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=641GYd2IB2M0B+j3IAYf6vUTBtf44JLc2SkA+xJFKp0=;
 b=GCypZo3QfYMsAHyZoQ9MgVaBrL98NBa7OPNEyjZ1NoJmZay9xJwUIxo0Tg0ZI6omzN
 w+tbmmDsS915TAqP+8YL9wCk5VPSGW0W0wY5q/NGDvFl6XqGhlJytiTdIIfFtwCdgUrd
 DTdVVdaOwv2udZJr3zJaL2TVSv4HuTiiZsof4kjisvzacOkfpRwMd9fSdMsMkvENYBEs
 qPpVbCEqx124PYDvvE9DaKNuG0D1A069osSqEJ/rT5YR3GQSzHwzXn3Yu5cFSSdaoGi0
 +nZp+Y1WjWkqkkGBxAnimSox/8WeAiOw0py5BTMMedkND/qhWzZfZAlP4lseKjjpnuox
 qbmg==
X-Gm-Message-State: AOJu0Yztf31DWGdUtaF3Unl7OHJucWm8MxgZkebWyEaWhfIA2vEnu8Ez
 z6WPuk1xR6a9dXEfoUNjYjIzow==
X-Google-Smtp-Source: AGHT+IHCS4JuoVmcRH+JpF9nY2Q+pHEFCE0vYYOfX0y1ZYzZMkGZdTpqIm+kz5yrJcEhOjf7LKBRFQ==
X-Received: by 2002:adf:f9c4:0:b0:314:420c:5ef7 with SMTP id
 w4-20020adff9c4000000b00314420c5ef7mr21104043wrr.11.1693325734714; 
 Tue, 29 Aug 2023 09:15:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a5d538f000000b0031ae8d86af4sm14142002wrv.103.2023.08.29.09.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:15:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A8E3F1FFC5;
 Tue, 29 Aug 2023 17:15:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Juan Quintela <quintela@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 12/12] gdbstub: move comment for gdb_register_coprocessor
Date: Tue, 29 Aug 2023 17:15:28 +0100
Message-Id: <20230829161528.2707696-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829161528.2707696-1-alex.bennee@linaro.org>
References: <20230829161528.2707696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Message-Id: <20230824163910.1737079-13-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/gdbstub.h | 10 ++++++++++
 gdbstub/gdbstub.c      |  6 ------
 2 files changed, 10 insertions(+), 6 deletions(-)

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


