Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA707BE6DD
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 18:46:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptM3-00011Q-JX; Mon, 09 Oct 2023 12:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptK5-0005QI-Nx
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:41:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptJi-0001Ym-5G
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:41:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40566f89f6eso47858485e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696869671; x=1697474471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afBvhFP6609M8IIBIfYpGDboWuF4PMsRTHYI59b4V3Q=;
 b=rErH+6+0l/ISFuO0OexmgT1kCYMLzyk65gpd9n3pBI2bxbkWccpqEpVWDYZ2Z66eCM
 DeJS4iv3CwGTaPrlLICCVZp+7wky0ghFr/JoqMQmbIjIsv4gcDeHP4ZhWvMhNSyZ7P3n
 4DPadmPvsxlVnAY7BDQ5EpHlgEgmfJBaaxu397FHI8yaRYoeIZjqbwRL0KteRr25/vMw
 TgFEgeTwceDmGtIxlyyllNt5li2bxObLvWYAzQlktW2K2JZLkawQ2Z++cFPZFDgjP1hH
 KTH4qg0+7H4MJs1d3dHCXHbPZkbM1qRQYa+TDuy5CO7RShUMl27qjVRsTqu8YXM3ZytX
 XizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696869671; x=1697474471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=afBvhFP6609M8IIBIfYpGDboWuF4PMsRTHYI59b4V3Q=;
 b=TYGL2NThFMp34Vay3hhckFzxNc26+hBXcz2YmzpJ+VHkgbsrMZXQQC7vg4Mc0n472j
 pXXNfWEqnneQOVNQrwemIjh5xGWvB7OnR5D3CVpLyWhZFuln0CEk30FNyMFNtVg3Iawd
 U9EV7EwXvDPV1z2i7SI+lvCRM7D0klZ2n5NfUjgBoC76ArKgYRz0U+5ftwIDsHNXL/Zj
 dmbHqW8X+fz3q2ZLUQBh1+bzeyLVLQfjjNKoB7LjoaCSL+2Dwt1jrKizNewW6zL1LUwa
 Ozi/JuiyZpLuwfMu8l4sJ3+gXTWmPO5AH3x2qSQHBG5+yEZvUEMNypZPR6+6elZRQNaH
 RhRw==
X-Gm-Message-State: AOJu0YxFnCbKkn8WLCp7RUCni+UMEXiuYosZvM17iXl/+O0kb0Q5yjry
 G4s1qj1dIS3rxuL7dS+B7z/Wsg==
X-Google-Smtp-Source: AGHT+IFgxGrx+X4uoHTxWDjGTegwrSLm6y12Mg63MWId7xQUDVdFnzrgoqqSoNFfwsvsNzZRFelteQ==
X-Received: by 2002:a5d:4d8c:0:b0:323:36a3:8ca with SMTP id
 b12-20020a5d4d8c000000b0032336a308camr14258615wru.28.1696869671541; 
 Mon, 09 Oct 2023 09:41:11 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n20-20020adf8b14000000b003296b62d413sm9694532wra.82.2023.10.09.09.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 09:41:07 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 446EA1FFBC;
 Mon,  9 Oct 2023 17:41:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Brad Smith <brad@comstyle.com>, Radoslaw Biernacki <rad@semihalf.com>,
 David Hildenbrand <david@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Nicholas Piggin <npiggin@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 10/25] plugins: Check if vCPU is realized
Date: Mon,  9 Oct 2023 17:40:49 +0100
Message-Id: <20231009164104.369749-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164104.369749-1-alex.bennee@linaro.org>
References: <20231009164104.369749-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

The created member of CPUState tells if the vCPU thread is started, and
will be always false for the user space emulation that manages threads
independently. Use the realized member of DeviceState, which is valid
for both of the system and user space emulation.

Fixes: 54cb65d858 ("plugin: add core code")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230912224107.29669-4-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/core.c b/plugins/core.c
index 3c4e26c7ed..fcd33a2bff 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -64,7 +64,7 @@ static void plugin_cpu_update__locked(gpointer k, gpointer v, gpointer udata)
     CPUState *cpu = container_of(k, CPUState, cpu_index);
     run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
 
-    if (cpu->created) {
+    if (DEVICE(cpu)->realized) {
         async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
     } else {
         plugin_cpu_update__async(cpu, mask);
-- 
2.39.2


