Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF6E7875A3
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:40:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDMx-0006YJ-Tj; Thu, 24 Aug 2023 12:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMv-0006Vt-Sn
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:37 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMd-00089P-Uy
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:37 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31c65820134so2221647f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692895158; x=1693499958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZtZNNftqxouq3vcCk2anHCZag5V3OF0JED6K9SHy/Wo=;
 b=gwUhgCa1VF1Og5meDbr9JW6XInhdB9HBvcSNdVBuI7t+pzf34nRyG4AsBDpPJB491u
 4hQJK01sUrpbiUlE1Zan+5hODTXGwi2b47Zp0nZjK6l7/BVOXlKo+0riqDsp1O566zGW
 Oot+ybvueMBlfMU4XlNPS2uQQ9K0n9UFhqjVRyqfSV7yp/XEb8MVWOU0t7BsWeR9NJil
 nHyzhmdjQw4qBAk9F/9+mR3C755/x8jy2p+hhRxaHivkkaqv0hDW57cMdygoYPFrgwvg
 KkvwEm4tYAyj8fACCWrSxA4FQrEdtO2NG/wDbhakbsNTKjnx7qgYV6O/RK0bS4iFSfdA
 alVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692895158; x=1693499958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtZNNftqxouq3vcCk2anHCZag5V3OF0JED6K9SHy/Wo=;
 b=FxUCY9vdqEX93SMKtZuXBI247mrylO7GrdSJeDhRUYuoPbq3hne2IbugBhqaZXBG9o
 3nCoLvlyIp95a25A7s7Fl+u5nY/pGqutbZ76N3c9d+P2z3/k8tfG+1WoHsXBfyf7Iwbr
 jtog2YFLTwTNL4/LVSVqGRRW6ynpaNileoIFDOCMSq0emm7PrhNyjQA7TN8NjdbM+BR+
 fZB2HYUkr4oYL/7fMyPno7KBAH5E3mk80NDjhB4N4YHfhREshHxE6R9kFeby2HdEmPrC
 ECHdoOesa4fxQ9oyaQ1y3uLq3KCb+9ui2CCMkcUC+XaPBbN1O6//LoMNW7CXjP9IaoG4
 CaaA==
X-Gm-Message-State: AOJu0Ywg3Rd6CylLxLrykDQNWs95ZFFLLuNG53NIZ34nkVZgiGvcbKW2
 a3kF7d4Exzrkt8FxkjjY9CCCMQ==
X-Google-Smtp-Source: AGHT+IFI88wWhZetg3g46CInqaOelhuB20TMO+uWEkk1Txw5i5Cg2+MoeL88bgqiQzzKcFuArCCmhw==
X-Received: by 2002:adf:de03:0:b0:313:f1c8:a968 with SMTP id
 b3-20020adfde03000000b00313f1c8a968mr13880453wrm.2.1692895158589; 
 Thu, 24 Aug 2023 09:39:18 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e1-20020adff341000000b003177f57e79esm22618406wrp.88.2023.08.24.09.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:39:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A84281FFC7;
 Thu, 24 Aug 2023 17:39:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 12/12] gdbstub: move comment for gdb_register_coprocessor
Date: Thu, 24 Aug 2023 17:39:10 +0100
Message-Id: <20230824163910.1737079-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824163910.1737079-1-alex.bennee@linaro.org>
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Use proper kdoc style comments for this API function.

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
index 10fb755390..1fb0db747f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -450,12 +450,6 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
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


