Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D207ADACA
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:00:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkn3N-0000Fe-RN; Mon, 25 Sep 2023 10:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkn35-0008Kr-8E
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:59:00 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkn2q-0002D1-MD
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:58:52 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32172a50356so6225551f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695653922; x=1696258722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54vdWxoInkKQLiHeicKKqmeJW+RARqhkyr/iqwsF+dM=;
 b=N0JGQ1ACzErPhj5/RVKIZPU3P9/fhZ2N2vT87IdLax6i2mzk8syvv0taLKXvF84ZDu
 SrcEqRbxC1rwkKCeOsXeQlTWFka7FQTBT1R76QItknkjO35mghSpH9NkwBA3Qcd+bXGe
 hV5PV/kBtFtAry+toxYcD7SALKDPk9K16G4SxvrQeXwcuZD24vcFWWBgRMCFBCQcur0a
 a5tcJJQA7E7+hLOk3VglpARWZWP7LkaFRio8q2TSfUVIWk043vukSXxhg0zRU27x6i31
 cVrq1MLlI95v8pqp9uuVf3Io2oreMXlIfEim1eimN+zTKpuyPmTF1adKIsLB9JJd6ddo
 ej0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653922; x=1696258722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54vdWxoInkKQLiHeicKKqmeJW+RARqhkyr/iqwsF+dM=;
 b=KL2CB8d+V2RmvZrRnfXpaRjQjGPXyN6cHxA0P9EcC9T7xhOamMl5BWsizcog2hTATg
 eaAxvQtmvJrBhJvFTd0OrQasSPNlr+d9+4VXK9rjwRARdsSS2wQ600Ijqx8UGzsPIQ4C
 4VyOk2uTUbeb0gi7HwB2a0Y2ZzNJ3glY7l8qdctykwzzOL6dNdfROEWAIb5XGkp+QRrN
 QVHPFxGyIF27MMKYTCo/MCLObVCCnjPoNFWPo2WKsQOAjDm7ADFQjdM0NjA4MNAh1nWx
 68om7ZCXIwzAax4OM90PNX4fFtE4IIODpCegmk3oi/FrWJowUMa6fVo0h2boOrg4o9KI
 zL6A==
X-Gm-Message-State: AOJu0YwhHoLTOBXv5rkKW4du1H2T0v5Syku2XZ95bOnoH0Jd37XCna8v
 TcbPExXPVTBu+RqQGAlHs8esiQ==
X-Google-Smtp-Source: AGHT+IETYE8gGZUvi5YSKhCE7iA0Eg4AKr99jrnWwLoe6ct7K7zw2dvLkEWkX477WRraNOiMP25uTg==
X-Received: by 2002:adf:fe85:0:b0:319:f9d6:a769 with SMTP id
 l5-20020adffe85000000b00319f9d6a769mr5600388wrr.45.1695653922406; 
 Mon, 25 Sep 2023 07:58:42 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a5d6511000000b0031fd849e797sm12075216wru.105.2023.09.25.07.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:58:41 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3C22E1FFCA;
 Mon, 25 Sep 2023 15:48:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Nicholas Piggin <npiggin@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 18/31] target/ppc: Remove references to gdb_has_xml
Date: Mon, 25 Sep 2023 15:48:41 +0100
Message-Id: <20230925144854.1872513-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925144854.1872513-1-alex.bennee@linaro.org>
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

GDB has XML support since 6.7 which was released in 2007.
It's time to remove support for old GDB versions without XML support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230912224107.29669-11-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/ppc/gdbstub.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 778ef73bd7..ec5731e5d6 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -54,12 +54,6 @@ static int ppc_gdb_register_len(int n)
     case 0 ... 31:
         /* gprs */
         return sizeof(target_ulong);
-    case 32 ... 63:
-        /* fprs */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return 8;
     case 66:
         /* cr */
     case 69:
@@ -74,12 +68,6 @@ static int ppc_gdb_register_len(int n)
     case 68:
         /* ctr */
         return sizeof(target_ulong);
-    case 70:
-        /* fpscr */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return sizeof(target_ulong);
     default:
         return 0;
     }
@@ -132,9 +120,6 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
     if (n < 32) {
         /* gprs */
         gdb_get_regl(buf, env->gpr[n]);
-    } else if (n < 64) {
-        /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
     } else {
         switch (n) {
         case 64:
@@ -158,9 +143,6 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
         case 69:
             gdb_get_reg32(buf, cpu_read_xer(env));
             break;
-        case 70:
-            gdb_get_reg32(buf, env->fpscr);
-            break;
         }
     }
     mem_buf = buf->data + buf->len - r;
-- 
2.39.2


