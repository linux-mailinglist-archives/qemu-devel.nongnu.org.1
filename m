Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F277441F8
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:16:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFId8-0005lF-Mw; Fri, 30 Jun 2023 14:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcl-0005T2-4I
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIch-0003Xx-2Y
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3113da5260dso2419094f8f.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148813; x=1690740813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vRjuiilHj41vuYTU55vTlTL6iGYeqfANvYZbGxWyZk=;
 b=twd++pV818VZ5cb8kSXntM/xDeg7w7p5+ZJuoSidY242qZRqz+AO56Bi2nB7L3A4Pf
 2h/uvC2yKBLHkmT4kVZ0xARt7F1I7JqXdErTX+8dSLRtb7xLrggkaioA4pcATmlA0dnp
 8K31QxmK8cjLcUkyC+F+519KBTZ7ZfX6cuX5R6d+b/Ceb09gOGSjvhh5iYWegvGjoRZu
 PqYMomJ+hYIYX81/zoMDMKMSIHheJwk5NKgjDwRKA1i9pxOhfHwfbEtIl8YlLNcoEZhn
 Di/+2NC8e8yBIsknhIz+J2cBSR84Q11BcZrMCJtZgPQWMzOgKadE9YYrGIbnet+8SWk7
 CNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148813; x=1690740813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3vRjuiilHj41vuYTU55vTlTL6iGYeqfANvYZbGxWyZk=;
 b=OnIuyGBAyQp92FMl7yAQXOZLHMIkJ/2cXOoErAL/NoPGnTgfYibrAmniI9mNrhCX+I
 ExSg3Lk3PAFUz7EqsMy7RVAF6mYeeS6z+DMMDGN+LkY9PWGIR1nSUTlcs6Po+eCtOgmM
 6mvL1SxNtJlggeO8hayTXEvRnbXMVmDinWxq14vwoLqkqcVBzymaTPzABN5nC7SZNFko
 imPwXExf6TDjaJcA073CD9uoGIBq8cQ+OXYJpJ9lq4kY8tmD3yafbzjhWnLH/jBuhzzZ
 ZspN8XbolK6ru8YbJEuua8pc7znViHq3kNZDRFKdHi7kKsYDHLBT6m12j6mzYklzZm9G
 PGtA==
X-Gm-Message-State: ABy/qLap5o7RPMq5ZV9ZmlkYCgN4nGqPhgDvV8Zyk6vZq7pBZFlChLYS
 WL8DoRUAQ/2U5V8bJC3rVmJtFg==
X-Google-Smtp-Source: APBJJlFZ6eNrzOjxX/uXJ+Bx/4PmpklPtb1BexdUJaCaDX4ZxCdy0JIKdpaqn/7jOIZPxJ1I2LVmXg==
X-Received: by 2002:a5d:525c:0:b0:314:99e:af3a with SMTP id
 k28-20020a5d525c000000b00314099eaf3amr2873262wrc.48.1688148813718; 
 Fri, 30 Jun 2023 11:13:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l6-20020adff486000000b00313fd294d6csm10797951wro.7.2023.06.30.11.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:13:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D350A1FFC9;
 Fri, 30 Jun 2023 19:04:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v4 17/38] tests/avocado: Make the test_arm_bpim2u_gmac test
 more reliable
Date: Fri, 30 Jun 2023 19:04:02 +0100
Message-Id: <20230630180423.558337-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The test_arm_bpim2u_gmac test sometimes fails (ca. 1 out of 20 runs
here) since the disk shows up as /dev/mmcblk1 instead of /dev/mmcblk0
in some runs. No matter of the name in /dev, the major:minor encoding
seems always to be the same, so we can fix this issue by using the
correct major:minor hex number in the "root=" parameter instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230630161604.446394-1-thuth@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/boot_linux_console.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 6ed660611f..6eab515718 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -869,7 +869,7 @@ def test_arm_bpim2u_gmac(self):
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyS0,115200 '
-                               'root=/dev/mmcblk0 rootwait rw '
+                               'root=b300 rootwait rw '
                                'panic=-1 noreboot')
         self.vm.add_args('-kernel', kernel_path,
                          '-dtb', dtb_path,
@@ -885,7 +885,7 @@ def test_arm_bpim2u_gmac(self):
         exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
                                                 'Allwinner sun8i Family')
         exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
-                                                'mmcblk0')
+                                                'mmcblk')
         exec_command_and_wait_for_pattern(self, 'ifconfig eth0 up',
                                                  'eth0: Link is Up')
         exec_command_and_wait_for_pattern(self, 'udhcpc eth0',
-- 
2.39.2


