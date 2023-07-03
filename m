Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F56745DBB
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:50:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrb-00082R-Ix; Mon, 03 Jul 2023 09:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr5-0007Tb-Kw
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr2-0005iS-QS
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so40244425e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391875; x=1690983875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yHFer7VjnRbyKbTmhJ/jIDL23JfeX2bf67sUnbUfgAQ=;
 b=v1eyvKOl7Wl/dIJra8S9QW4B7tcwAoa4b3FUF/FQedog9i0o6c1rraL00TUAEjNUiG
 pyiKTbMOJzPG0tSTyH+u/bq2gJ0n5W09xAX41WRdTnd7sLiUzU6ZGVnaIkDmCDd0ZgmG
 R/G4ldIUlrAeBgyMJq0WzP3P+LbDNzBm4e8ssr+9RKwwiWACpndM9YD0sETXYWXaeygD
 tI2XhOuN3m+XgN5z8X7Lltdf3vlJUEf1cMZXntyGmoj3PGRI63AtXb3PQJUGw0W2bUG6
 5MzNiProwJOTegOLgTz3WPWmVwZP1+9NSEkxw+/eN5ZmJvAnI65e5uiatrRvW1ReXYb1
 hM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391875; x=1690983875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yHFer7VjnRbyKbTmhJ/jIDL23JfeX2bf67sUnbUfgAQ=;
 b=Ol7+Pg6TGXzlKVrdfjES6St9zBXbgU24G2CDAiw7qzXKUrxEasyxYoRJ1aNO3UwXQW
 YY/B53N8Ukj0mh6/v0EKoPJ8DwRzH+VkSmDxJafiF0fUkaMCDPIIwPktg1zoGa2qfIcY
 WGnh5Ba84KGc/Gl+Qld4VCuRtFCDIywDlzjq+2ueTqo+dCSZ4ALGycl0xMqSQEdNiTnQ
 /xUR/dinGM8GLMRcjud6RkKsQwEkIoBCLWqaUcfMcMXEHthYbZsN98vAD/Vxh30M8XtX
 AnmoEPu/apmUR4DiAN2eiP3oGk6Ijnxq26YFOKPXS4TDgN9u1+1c0xdYltnC0/ILK39V
 V/Ig==
X-Gm-Message-State: AC+VfDzQKrW+lmeeXR6xqjDAwUm5VVcjlUFahfZ+cmJg/sM/oxJHB1Cj
 PAKWtlQymrnb9N4cpXI//6uc9w==
X-Google-Smtp-Source: ACHHUZ5vvoCjsNgAVrefSqUSmQB2syYYoAOl6VCjdt/mbba75gtgj6U8ban2/MdRpmiIdgHVI4cKaA==
X-Received: by 2002:a05:600c:2217:b0:3f9:c986:a2ca with SMTP id
 z23-20020a05600c221700b003f9c986a2camr8815178wml.24.1688391875379; 
 Mon, 03 Jul 2023 06:44:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a5d60c8000000b003142b0d98b4sm6485318wrt.37.2023.07.03.06.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:34 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BA6DF1FFC9;
 Mon,  3 Jul 2023 14:44:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 17/38] tests/avocado: Make the test_arm_bpim2u_gmac test more
 reliable
Date: Mon,  3 Jul 2023 14:44:06 +0100
Message-Id: <20230703134427.1389440-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
Message-Id: <20230630180423.558337-18-alex.bennee@linaro.org>

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


