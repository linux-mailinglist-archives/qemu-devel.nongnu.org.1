Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF27ADAD7
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:01:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkn3K-00006a-1u; Mon, 25 Sep 2023 10:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkn2u-0008GV-Nx
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:58:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkn2o-0002Bd-Ux
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:58:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40572aeb673so33363565e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695653921; x=1696258721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aeCFFwXCm+A4QdL8cQip0cKdXWBZunNX9KWO8pZi6hE=;
 b=wmBBpzmvlxnyPj3VQiJZH7Mb3RFKwuZJZo3hPp97bpXDGqOBR9F+W41j3SKzmPRiWA
 VH/OL9LL7/g9SVmHd1srLS0LzrgOfGDT0GbW8Eb4kiL1aRtetTkVEFCwmrtlvTgs5739
 33Thjx9IttZSIhd4XXZ1QlsaOCfDFsuyEl3TwTuvK8Dudhv1oubGVA2Jzzui2I87JzWV
 wM6uVxvJ8QkyDBqYfAUXHqNG/ksXx+7Z6ANFWLZE3XPKLNKJz3EkHjLuZc7a/L5xkDiP
 wo2Wmkb3W44DeP4WS3IO8lOzWwK8OBGgfgC9xlzBCBzgFSioCsyCPeACgjxu2mQ6Xghc
 gKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653921; x=1696258721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aeCFFwXCm+A4QdL8cQip0cKdXWBZunNX9KWO8pZi6hE=;
 b=h9WO4WF5Iucbds9gY9aZBaiVkZCJiQGviH//+aUDuu3j4hFxzocnhm5ZjDsKGAEo21
 wreJzNMaMzJGjqGaHro+QqA7U7s5LWFphfa87zBblT+9+AIFJoaBXe6YR+hoKDR4rc2w
 rXgIja/0KXHZQofAAUqFxD72zziCy1jcn1so1WO/xXKvPSTb+7Ns2nWnTye6TUW2pyQ9
 z9HwR4IHqwNbLjI7yyporrS4RDjFdx9pk2t+QDLCSZcKg4usD4Z/J35U6exvbTmbIav7
 yfAFE1JXp9A0KNrRcK7QmZRWn9I08v0hy0ellQM4djRjws0oIj2XDH2rwdW9cYJFP0zs
 GIEw==
X-Gm-Message-State: AOJu0YzyzLdCHIfDb7rJTzATL0r04ZXeMqPqTlcWuvkPnkZ/CY1f/MPC
 XpRcporS0kxQIEyWKMN4I1iO+Q==
X-Google-Smtp-Source: AGHT+IHFSwhv1ZDVTaQUicchew2LE/1enh8F7w94hdBqCcq21Z5zTqmrgbzfuabMJjszGdjEODPmGA==
X-Received: by 2002:adf:e4ce:0:b0:321:6414:5869 with SMTP id
 v14-20020adfe4ce000000b0032164145869mr7303953wrm.58.1695653920841; 
 Mon, 25 Sep 2023 07:58:40 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d29-20020adfa41d000000b003197869bcd7sm6970991wra.13.2023.09.25.07.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:58:40 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 99E231FFCC;
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
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 21/31] accel/tcg: Add plugin_enabled to DisasContextBase
Date: Mon, 25 Sep 2023 15:48:44 +0100
Message-Id: <20230925144854.1872513-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925144854.1872513-1-alex.bennee@linaro.org>
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230824181233.1568795-2-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/translator.h | 2 ++
 accel/tcg/translator.c    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 4e17c4f401..bf5bac260a 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -72,6 +72,7 @@ typedef enum DisasJumpType {
  * @num_insns: Number of translated instructions (including current).
  * @max_insns: Maximum number of instructions to be translated in this TB.
  * @singlestep_enabled: "Hardware" single stepping enabled.
+ * @plugin_enabled: TCG plugin enabled in this TB.
  *
  * Architecture-agnostic disassembly context.
  */
@@ -83,6 +84,7 @@ typedef struct DisasContextBase {
     int num_insns;
     int max_insns;
     bool singlestep_enabled;
+    bool plugin_enabled;
     void *host_addr[2];
 } DisasContextBase;
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 1a6a5448c8..37f8dadbbd 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -156,6 +156,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
     plugin_enabled = plugin_gen_tb_start(cpu, db, cflags & CF_MEMI_ONLY);
+    db->plugin_enabled = plugin_enabled;
 
     while (true) {
         *max_insns = ++db->num_insns;
-- 
2.39.2


