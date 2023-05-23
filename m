Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C5770D1A2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2v-00043k-Tl; Mon, 22 May 2023 22:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2j-0003Zm-2c
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:35 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2g-0004k5-1P
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:32 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2533d74895bso5041159a91.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809988; x=1687401988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8PBCE/lte5hGRxWi4SoYSPpkBFC7YmCtjmWhQPVD0g=;
 b=i3rpXUe79Ng6/fDolJ58ZxI/fw7ucOIQbkw8iM/qW9yfkgbXgWrteU01YJgJg6xovi
 4Ljjk44/5lzCP1+rScSGYMGvePkqQWGv27QPqKs3fR08rgtBPtMsWaHx+/TTqseyfVof
 Z/4nhKkeWq/AfH7PTmNGvfVMqDCmjl3Ke0/0nUmWjJwA5nQTMTQ4ajO1QRRFFqg6carA
 8KvpFknZMz+SHOSOMc7PIhPNJjjtkDCjgE331bHMhjIs1azlHTy2fK2UgH/Rvm6A2u+2
 gxMU2o/Xv6chn5eUl4sZVbWGrfEmXpmUcfav+lf2CBJVN/jeFT+QGo7m9y8wyuvn9Imf
 u2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809988; x=1687401988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8PBCE/lte5hGRxWi4SoYSPpkBFC7YmCtjmWhQPVD0g=;
 b=ItCMpvjRFMrdhNFgVQ3A5PPOI9tKJPQeYypACxw71dZFi0jdUbG32qqY/glL8UosOP
 wUilHy3hC6zAiaS+ubO9F5k3ZyiXmTza6/xVK5crXXx/tZUTNqP/8fuNIdhxc0YJztXL
 Lkw0DHggRzCwg11biTfRoQPs/HZezmE339jrEb3DxN0c6slJHd0w48WBliDUXPz7OeKK
 d4JfaLjZTj5jjgO2YwV5cKK2N/0tI0irmVb7cMkANJNE30FUqJ7oEBgWHXeqR42M4n/l
 hRNhWHUF5Tub6QS9DCtrLqaD4fS34BZ5G8etoKMyDKBeb76jTJXPqqUpySL6je5yGfM7
 B2MA==
X-Gm-Message-State: AC+VfDwp+9TfpU/6+hF7LKaSvkdrWkUCb6xTsDYewOfGXswFszmg4GqU
 EqscFet4/8/F+ZE66T0CROnlRw==
X-Google-Smtp-Source: ACHHUZ4YI1YHvBtvljHbep5qAWgBYrBBuLsbZXOwQgdgiJKdh1sfYwhfPz4RLTqqaYkKywQfBx3QMg==
X-Received: by 2002:a17:90a:eb8a:b0:253:32f7:e50b with SMTP id
 o10-20020a17090aeb8a00b0025332f7e50bmr11310506pjy.6.1684809988313; 
 Mon, 22 May 2023 19:46:28 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:46:28 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 46/48] vmxnet3: Do not depend on PC
Date: Tue, 23 May 2023 11:43:37 +0900
Message-Id: <20230523024339.50875-47-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

vmxnet3 has no dependency on PC, and VMware Fusion actually makes it
available on Apple Silicon according to:
https://kb.vmware.com/s/article/90364

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 18c7851efe..98e00be4f9 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -56,7 +56,7 @@ config RTL8139_PCI
 
 config VMXNET3_PCI
     bool
-    default y if PCI_DEVICES && PC_PCI
+    default y if PCI_DEVICES
     depends on PCI
 
 config SMC91C111
-- 
2.40.1


