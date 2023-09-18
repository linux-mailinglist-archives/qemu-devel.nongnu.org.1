Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E1A7A4E49
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:10:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGji-0000Zg-UK; Mon, 18 Sep 2023 12:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGja-0008Bo-BD
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:26 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGjU-0004Kj-87
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:26 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9a9f139cd94so635662166b.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695053058; x=1695657858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjaIM1Qc6nHbnxZLIT5jjyB717NwyoCy1EteOD4KAlE=;
 b=t0llDNmNfv8UG/Uz7Bv6Oz3tQavpDDy9Ti61u5vtH5yvyk3IOrlWWqvH94ZYYlU7xF
 EkwwbHMyCBq2p6TZax4+x4M56FfeV9AQA8kz3B8ZLLMYHRL32xp8LPLQ6OcFIm7XPWZQ
 HqXImbNEWR0a1vbL9/WKqKcVZRkB+cF30o8q7POkfy9/6dYevY8FDc/Q7Q6OtPT92kPO
 yoT3qkklnYcu70Q6TmvYboUPHlQklwyhLESAnTMgeO6oChdZJJiY/+wuj3kMZAWRZL4u
 z+D5xF+F1Vb+hj38/xOL2NobShGA6ogToBuI6Ie5UFQMP1XhhiMo5UBpWG7KkFq+Tbde
 8ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695053058; x=1695657858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NjaIM1Qc6nHbnxZLIT5jjyB717NwyoCy1EteOD4KAlE=;
 b=hnTs8YFehGUdk9oFiaokdOB4RA54iJIlkX9eMCP5DIakJJzoNunATJ1F93K1sbcHyP
 /fPEVRPccOWWGyAXh2BoplEvChRjV6A2rJ1mKMsU3IxTx5Aa/TAG7qMMZIIAG6Pj2ZzH
 KzktYXgSL9CqO66OQO4UCF93UyCZdlaNEnF9IvD8DJsOFNLuno1Yh70tOblXP6C8/Fuq
 Kmg1hUCtyKaZNBZhZFuB9k1UsCtfcpfo5dTQLKaeUWBW9BhXo6ixeBUjnUJQoo5JQ4LX
 l4cRG/ce0JsBfLlTi1cCIhjdV3MrSqlSVo3lZ3mgQ1weH3Pz920zErDuQ0e6nBSRoXKs
 wUDg==
X-Gm-Message-State: AOJu0Yzi8YCHq9L+B6a45cz8dEGYmuDl8I8gyg6XNgkh2Ozv5zpKFbki
 Q/yH3i1/yn/KFm2x4EQW9vaVLZSLFQTKWKcWg6/T6dbE
X-Google-Smtp-Source: AGHT+IH1BGqTiq3uZIcjIgDgFSn4hEE/bGsbSKhsdURXDBkyUNQTShuSyFgzOD2PM8QK12Z2NIlVUQ==
X-Received: by 2002:a17:907:75f1:b0:9a1:da9a:f1c2 with SMTP id
 jz17-20020a17090775f100b009a1da9af1c2mr7861010ejc.11.1695053058645; 
 Mon, 18 Sep 2023 09:04:18 -0700 (PDT)
Received: from localhost.localdomain
 (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a170906390d00b00982a92a849asm6628019eje.91.2023.09.18.09.04.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 09:04:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Marek Vasut <marex@denx.de>, David Gibson <david@gibson.dropbear.id.au>,
 Brian Cain <bcain@quicinc.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Claudio Fontana <cfontana@suse.de>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-ppc@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alessandro Di Federico <ale@rev.ng>, Song Gao <gaosong@loongson.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Chris Wulff <crwulff@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Luc Michel <luc@lmichel.fr>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>, Stafford Horne <shorne@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Michael Rolnik <mrolnik@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 15/22] exec/cpu: Introduce CPUClass::verify_accel_features()
Date: Mon, 18 Sep 2023 18:02:48 +0200
Message-ID: <20230918160257.30127-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918160257.30127-1-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Some CPUs need to check the requested features are compatible
with the requested accelerator. This has to be done *before*
the accelerator realizes a vCPU.
Introduce the verify_accel_features() handler and call it
just before accel_cpu_realizefn().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 4 ++++
 cpu.c                 | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c90cf3a162..1e940f6bb5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -103,6 +103,9 @@ struct SysemuCPUOps;
  * @class_by_name: Callback to map -cpu command line model name to an
  * instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
+ * @verify_accel_features: Callback to verify if all requested CPU are
+ *        compatible with the requested accelerator. Called before the
+ *        accelerator realize a vCPU.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @has_work: Callback for checking if there is work to do.
  * @memory_rw_debug: Callback for GDB memory access.
@@ -183,6 +186,7 @@ struct CPUClass {
      * class data that depends on the accelerator, see accel/accel-common.c.
      */
     void (*init_accel_cpu)(struct AccelCPUClass *accel_cpu, CPUClass *cc);
+    bool (*verify_accel_features)(CPUState *cs, Error **errp);
 
     /*
      * Keep non-pointer data at the end to minimize holes.
diff --git a/cpu.c b/cpu.c
index 0769b0b153..84b03c09ac 100644
--- a/cpu.c
+++ b/cpu.c
@@ -136,6 +136,11 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
     /* cache the cpu class for the hotpath */
     cpu->cc = CPU_GET_CLASS(cpu);
 
+    if (cpu->cc->verify_accel_features
+        && !cpu->cc->verify_accel_features(cpu, errp)) {
+        return false;
+    }
+
     if (!accel_cpu_realizefn(cpu, errp)) {
         return;
     }
-- 
2.41.0


