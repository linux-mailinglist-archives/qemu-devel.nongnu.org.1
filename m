Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FBF790AE7
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 07:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcfJ0-0004gG-Or; Sun, 03 Sep 2023 01:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfHp-0002ro-QI
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:04:37 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfHn-0001pE-1Y
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:04:37 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68bed8de5b9so216982b3a.3
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 22:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693717474; x=1694322274;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3d8Rn7YrPkdQ8hR1Ca8PXPrYAXVQCwfLeUFNqMqw4Q=;
 b=nRa0H7LSa9kUnLVjfoC0TTVGJcCS42uhEkv80ntpxPaUAN1Ks6mBIXMmdJO6F+WS+e
 BPVrKrhPSEhN4xBeGNqdNztaKS+pUjJuclEhzP6hXBlBFrqqTzNbTh0uUA1un6szItJe
 L+vqg1H/GzHzgGic1o51DhEah2j8NQrNn0eQHL8a0Mu33qoVZsPULtBkVzRiKC81i4sn
 mDMunD9LeWBzTQiUBfpexrZD0PUS5x7VmU/lzrfaRcJEm2efrErJFu3BMeW3BY47l4Wv
 0i43n9oHXRLxPtSZMyE0iUgFvu/q4C5+zWKt/Dqt7inGe5fFuQPKSSx81cltslQ4r19L
 DwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693717474; x=1694322274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3d8Rn7YrPkdQ8hR1Ca8PXPrYAXVQCwfLeUFNqMqw4Q=;
 b=T43XjykX1KSHyTRVmqWW7a5/GKd2Jzkafkckf1iPvCqfwVXV2FHMsV4NktkMp6ytyg
 ojn+zA5bROEFr01FhuIatZPRq4mrgs2iaOVATBuuyw8WZcIbPPtU4q+tt5P2j61OlQV+
 UrRRfxuMKaonAVJDa/W6edqIVChp6ynTR2UrOy1oyHrMD/ECnrjcXL1YGa5UvRWZK7tl
 FMNfpcPuO1PcjkAhDRHiR/rWZHnC6lTbw55pFPaFdetvQgOkkU/ucnwu0dWuwOKqqNP6
 NSvFCtNCir8r4ob6+bfmgBJe9VFRQ/b/Wa5zTUOV8nVJcMGgGLmjILGSHdMP8IWefhBT
 sSCQ==
X-Gm-Message-State: AOJu0Yy9y2LfCCCQVPKQWxUGLsgC18Kr2SKGRsXn8ENEYq+RfdcJnNte
 qrSJF4XbeVnOfjM2V0AjIU2B+Q==
X-Google-Smtp-Source: AGHT+IFkcQpqSSAch4B5laBt0EMbEjn5GS6hTuhfe2v+rDK5vZK8hH9LI9ghdKbGM4y/Xbx+vmEegw==
X-Received: by 2002:a05:6a21:272f:b0:14c:4deb:7120 with SMTP id
 rm47-20020a056a21272f00b0014c4deb7120mr5282943pzb.62.1693717473853; 
 Sat, 02 Sep 2023 22:04:33 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170902f68b00b001b8af7f632asm5324835plg.176.2023.09.02.22.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 22:04:33 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 17/18] plugins: Support C++
Date: Sun,  3 Sep 2023 14:03:25 +0900
Message-ID: <20230903050338.35256-18-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230903050338.35256-1-akihiko.odaki@daynix.com>
References: <20230903050338.35256-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
2.42.0


