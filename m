Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC9F7A4E03
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:05:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGjg-00007j-OR; Mon, 18 Sep 2023 12:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGjS-0007PC-PS
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:19 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGjQ-0004I9-U4
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:18 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99c93638322so1017463666b.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695053053; x=1695657853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wbLvVhCdjkLoKVSI3XlIe8h3b/C8JwK6Lt4fUZyBeQw=;
 b=V0iqI4zgmbH3azcccW0GIBj6HlM8i22KIzHbm6K6rumEG0oY1GY87AlRETOl4XTytf
 OtiQvPsn9DhLapD6rn4emW4CQBu0fM3uc6pRvZjBoUOC0ruZsJvTH5nEGf/ovgajk1xS
 mMikm/hUbXwMWaN1G76D3zqkZd0GJOQw9R2mxRXXY93NIlpkIk0mTM8tPqAotly7HdSK
 GFeQtpnlb+ehlhJoTVRbCDPaTe2IDMyphu87WQlxwtu6+5b0zCLBUbwnqIJl9+rC2ST2
 YlBO9FvMdhUI0TTGqyJUSK+x79QQAS24DL+aN344kD7FB5t1EDPO5EJQ7yKuRCPCAcVV
 BjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695053053; x=1695657853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wbLvVhCdjkLoKVSI3XlIe8h3b/C8JwK6Lt4fUZyBeQw=;
 b=bxyiMwGsv7K0fAlr2g/BkZllruQD+2FfsfVwTx7zlBLL+xEF8ZI1cu+pRaiPdlgLgf
 gv4GRtNwb/1TJvwWEUTaY0ZvYcKkc3nOsv6/H+oS8rPK0zc1ZN8Vt1BbDeiwf7co0vtr
 VCysifFYoWyKxnNm1U9JAX2Iba6tebdA9Rugq758A49Fubx59mRLnk5ThKXCNjQUssa1
 tkdGbk9XrAgAqBYdkV2rVSagh7RWlWEC6S9hq9uNCyqIYIbEvhQkY5iUBL3ZkxOdx8kC
 rv9sbQ1EXsqqNmcZ6kMlNaZ5ZgKSHsc53j3U18UHfC7jyvxsEUMk2ZKAvv6AV8nY6wWW
 UAuw==
X-Gm-Message-State: AOJu0YyPmQMgGudU099IjDxGVR1Mc0j0KDFO8Yuuo7lhnoN/C4p/yltK
 J25Upn4vgcXzMXUX01vWxdDbEITp4H8xZv96alz7COfq
X-Google-Smtp-Source: AGHT+IGUIRL/Cj2QgpL/SWnZOOte/5aXBCe8PvtqKJ8rdHwjYW7XrtiQqR5SrkqTU7jQZeCu2Klurw==
X-Received: by 2002:a17:906:311a:b0:9a9:f0e6:904e with SMTP id
 26-20020a170906311a00b009a9f0e6904emr154241ejx.16.1695053053645; 
 Mon, 18 Sep 2023 09:04:13 -0700 (PDT)
Received: from localhost.localdomain
 (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a170906119a00b00997cce73cc7sm6586020eja.29.2023.09.18.09.04.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 09:04:13 -0700 (PDT)
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
Subject: [PATCH 14/22] target/sparc: Init CPU environment *after* accelerator
 vCPU is realized
Date: Mon, 18 Sep 2023 18:02:47 +0200
Message-ID: <20230918160257.30127-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918160257.30127-1-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

These fields from the environment don't affect how accelerators
create their vCPU thread. We can safely reorder them *after* the
cpu_exec_realizefn() call. Doing so allows further generic API
simplification (in the next commit).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 2fdc95eda9..88157fcd33 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -756,6 +756,12 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     SPARCCPU *cpu = SPARC_CPU(dev);
     CPUSPARCState *env = &cpu->env;
 
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
 #if defined(CONFIG_USER_ONLY)
     if ((env->def.features & CPU_FEATURE_FLOAT)) {
         env->def.features |= CPU_FEATURE_FLOAT128;
@@ -776,12 +782,6 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     env->version |= env->def.nwindows - 1;
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     scc->parent_realize(dev, errp);
 }
 
-- 
2.41.0


