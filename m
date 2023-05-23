Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD38270D194
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:46:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I15-0003Pa-4s; Mon, 22 May 2023 22:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0r-0003L3-6q
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:40 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0p-00048z-Jg
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:36 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-53474b0c494so4819949a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809874; x=1687401874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CeVsobWOhSlBWPSbbREEQPU9WpPBCVkSPXBmdodJB0g=;
 b=5rCAgW7cAkWPtxvoNm7RFgTI5r+en7NWwq+kF7mesC6G2LkwQyGOXOpmXWuOhCRajr
 vrNm9i/wcRRjBGl/dHGsT40Wt2JsxISALZK8xIks1UrWnnaU7Poy4944otfsdrz84ssF
 Ll4iq3Yq6J2Eb2259/eLTt2Pd4h6A76W4swv/lT0euiaVo0Yv7TTgWVS4DFxDeSPweQH
 Pi3u9q/A4eLiPyPf0pU8jRLJ6JSmbMPoSiuKGRf+90sWIHSXqDwhT0XAP2/xn3AdzLgV
 EaqEbqfaFKhIqP7byOV3j8N0gbyHVesKw7a8C+LnHe4+JtYUgWjvbPgjykjPfOqROadD
 G+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809874; x=1687401874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CeVsobWOhSlBWPSbbREEQPU9WpPBCVkSPXBmdodJB0g=;
 b=aFKMlsKU0qraZ+ViphwpklL6gonrElSkIuxCt7Zk6hDIchquMgAwk8neFdkHg822E7
 w1JuBidYxS7A/++hX2r3/83vDFz0TUGR5xAMNXoNcgh5ZH2Zuc95lXmPDweN6DT6r0qK
 QsomjIC2TMIWEFcHDmcPXn/rdSJIgHoKfqpDusrV6KQm9h8rNM4XDbIIe38jWsEBSLT9
 4U4r3nHv+7PLf8NpCPR9y6mX80JyPDKjnM3Ag8l9629jKXXzXAy5IQgTMU8YjyAVkDAb
 UcD9/zSz9gW4cTcuOTgxwR4EfBs1mJxZfG1Z8SZj2uVFAJuwPfpLAxgCIJZv+R2CIBrA
 fihA==
X-Gm-Message-State: AC+VfDyYU7pheud1TNXHgpeNtSvTaJW9DAh3BQPdTA7d0sQO2pccpvK9
 rXH+BGb3qHrpXWLKraesaMtveg==
X-Google-Smtp-Source: ACHHUZ6b7GYCIPMC5VK4uHm+IukzoAWCLKvz8f3eV9KJMEBz2XwC2+M5W+FghdKVwFZaGRH6ZcPzHA==
X-Received: by 2002:a05:6a21:3293:b0:10b:7b64:706 with SMTP id
 yt19-20020a056a21329300b0010b7b640706mr6726174pzb.13.1684809874412; 
 Mon, 22 May 2023 19:44:34 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:34 -0700 (PDT)
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
Subject: [PATCH v5 12/48] tests/avocado: Remove test_igb_nomsi_kvm
Date: Tue, 23 May 2023 11:43:03 +0900
Message-Id: <20230523024339.50875-13-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
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

It is unlikely to find more bugs with KVM so remove test_igb_nomsi_kvm
to save time to run it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/netdev-ethtool.py | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/tests/avocado/netdev-ethtool.py b/tests/avocado/netdev-ethtool.py
index 8de118e313..6da800f62b 100644
--- a/tests/avocado/netdev-ethtool.py
+++ b/tests/avocado/netdev-ethtool.py
@@ -29,7 +29,7 @@ def get_asset(self, name, sha1):
         # URL into a unique one
         return self.fetch_asset(name=name, locations=(url), asset_hash=sha1)
 
-    def common_test_code(self, netdev, extra_args=None, kvm=False):
+    def common_test_code(self, netdev, extra_args=None):
 
         # This custom kernel has drivers for all the supported network
         # devices we can emulate in QEMU
@@ -57,9 +57,6 @@ def common_test_code(self, netdev, extra_args=None, kvm=False):
                          '-drive', drive,
                          '-device', netdev)
 
-        if kvm:
-            self.vm.add_args('-accel', 'kvm')
-
         self.vm.set_console(console_index=0)
         self.vm.launch()
 
@@ -86,13 +83,6 @@ def test_igb_nomsi(self):
         """
         self.common_test_code("igb", "pci=nomsi")
 
-    def test_igb_nomsi_kvm(self):
-        """
-        :avocado: tags=device:igb
-        """
-        self.require_accelerator('kvm')
-        self.common_test_code("igb", "pci=nomsi", True)
-
     # It seems the other popular cards we model in QEMU currently fail
     # the pattern test with:
     #
-- 
2.40.1


