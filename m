Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9C17690BE
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:49:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQOZI-0007kC-RW; Mon, 31 Jul 2023 04:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQOZA-0007U7-L1
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:47:51 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQOZ7-0005MC-UB
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:47:48 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686b9964ae2so2804997b3a.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690793263; x=1691398063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3o76KcQlFp/MuUPscQNwseGhYtySE7hW349U50r8SMs=;
 b=y7u6jP89IRQwFYemyUCc7xG0gnAOc6UdmwLMYKHPqhVV64B/3hHVL4MPPDtz7wqlA7
 10yZVU9H/4k+HA54IqVn54qBfdzJZBgZDG5Q/xylLQlBEQ067qih3SvSuJYzKTvcJmjc
 mrxi2zEuDLRUQdx80/tkyCb3ED+1QiEZws52SCZBk3yaVyIh5T5NQ5bhTTEAlGyGOrf3
 SGfvTJF9Cc5V3n7kDlhmbTcHZ1oApB3rUp6rNP919WOivk9EBpEDr9HJlAfw+sYJk0gm
 PDRE4rN7kgwMyNEgJFvdeJUd1lyD/ncCVmGusDXssoXlqcBDaRtCpwHb6+7lOCRKVef5
 hdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690793263; x=1691398063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3o76KcQlFp/MuUPscQNwseGhYtySE7hW349U50r8SMs=;
 b=Hq6mzbC7LJgXm7XVT4sJ3ewHdub6wqOzsOlZhO8fbKcIzPxWTixgBra/XXUsKrbLDo
 XmW7nAZhLsmPFsoe+PXFJ+oETBcRpzWQmcnwBmgQsG6RC2JIwqv7an4lyCfmg1b4TFTt
 s/vqRKzbsfDvsiD7zy4lzUiv+RLbKgnyyakK9tw7G8xf4RJ2wjQ2aVCIhve/ACNnIsX9
 KXBUY1fvgc73zpH7gkmpT2pTItJftZQDvb+54psdy3GFacPCkITGd9R+ebcnvpeHzjRV
 F8HNgbh0ispIDt/a+M1mhWHCNm0M3HyhEFRJNi3KyZebPBC+YW8lr6E+vv5qiUwxjePf
 dqhA==
X-Gm-Message-State: ABy/qLZqOc/iX4G5Tmvk89yTaGPlnlUNMM9pPVpxGwPBRX9fTQUhfXB+
 HZCvzKoEip1Qh8xsEswUKjlE4A==
X-Google-Smtp-Source: APBJJlEaUUZeLz9nI9U553gFiXbqNs1uGKfoHWk0vvfK5zSNsIuJ4De3cguOxUIvGNrmixpzNVrxxA==
X-Received: by 2002:a05:6a20:8e2a:b0:137:4bff:7c92 with SMTP id
 y42-20020a056a208e2a00b001374bff7c92mr9475935pzj.0.1690793263643; 
 Mon, 31 Jul 2023 01:47:43 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 u19-20020aa78493000000b00666e649ca46sm7075563pfn.101.2023.07.31.01.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 01:47:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Stafford Horne <shorne@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH 23/24] plugins: Support C++
Date: Mon, 31 Jul 2023 17:43:50 +0900
Message-ID: <20230731084354.115015-24-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731084354.115015-1-akihiko.odaki@daynix.com>
References: <20230731084354.115015-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

Make qemu-plugin.h consumable for C++ platform.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/qemu-plugin.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 214b12bfd6..8637e3d8cf 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -16,6 +16,8 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+G_BEGIN_DECLS
+
 /*
  * For best performance, build the plugin with -fvisibility=hidden so that
  * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
@@ -723,4 +725,6 @@ qemu_plugin_get_register_files(unsigned int vcpu_index, int *size);
  */
 int qemu_plugin_read_register(GByteArray *buf, int reg);
 
+G_END_DECLS
+
 #endif /* QEMU_QEMU_PLUGIN_H */
-- 
2.41.0


