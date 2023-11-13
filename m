Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB07EA2B6
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:19:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bVm-0007se-IT; Mon, 13 Nov 2023 13:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2bVk-0007oJ-SW
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:18:12 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2bVj-0000YO-3B
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:18:12 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9d242846194so701585666b.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699899489; x=1700504289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifmwVFTsAvMvKqxRkmI19PrzZdtj10CaHWbOV7iF2UM=;
 b=yveT8bMvDHIiLC1ZYPXtGqeGPHOCOe3BuiWCyNf0X0GoajGhMGYu9bkODvwfX6+q17
 UatPOYtq1+xuA37CWWWsL3LPMN92KiABbs3nOODRqBDIF032XvHrGFM+hMWOP3fZ0ZeQ
 iPuSL2wMafp8jt6z5+CoFg2dIGwycuIQGNxVdigd76BhQNUI3ccXUmvbQ9poG9SINfLG
 rA2ERB7A8eCqUtixP1aofvmVnFpd7sb+5nHFGfTSdLhauu92XFrM+q17AUOC71F3uPVS
 XfLY6F4P0UltDS0FfX1w9CiuxfgcFSIEc5CPyh8711s6e6G97lnmK8wwK7FyksF08U+N
 v2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899489; x=1700504289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifmwVFTsAvMvKqxRkmI19PrzZdtj10CaHWbOV7iF2UM=;
 b=v1PuTuI8wxhwttTp+TiFHJJTXz9hDQHuRYGkVbMLEB7z2SPDaPQz+zB+7GQrhHHA7z
 x9ROjcUi44Twi8lnyBS58XMBQhQ1oFeG+bzQBdV5/iSMQbd7Cbl2C+qeFdtQdhiUGiNi
 Ig0T02CTX+gKpLczUs7AdnR3jU+cjl9OSqIcibuUGSDrT6qI5OkamBg9Z/4yyK2JqCAW
 0YnCmlMlFxQRsEM5X+tI22p1qDxO7lpDWF+Y++HFURbpg/gKBY4O80xY7woI9J31Dsi4
 giJ19QgwVZ0rHiKAnGWhuhUJ8zIr1dQAHCmEWIQ2DC6ivDuzGwc8oJYzhFE7CBWmfcQ3
 vnXg==
X-Gm-Message-State: AOJu0Yz8y4x4wpg/CDfjZ4J0nVRUHAJAdv/JnEoBKIjZCRZg+U+kQSnY
 9oiVTNrMGiBCqdo98RdWYpUXyrNRjA0nOojb9tA=
X-Google-Smtp-Source: AGHT+IGPmybe8o3HgF7f1mhXfaC50/beUnQMwcff9JZYOX/6TUqX5Ghc1F/m6sMXbGpyl3wQpNuQGA==
X-Received: by 2002:a17:906:268b:b0:9e6:59d5:820d with SMTP id
 t11-20020a170906268b00b009e659d5820dmr5255342ejc.2.1699899489669; 
 Mon, 13 Nov 2023 10:18:09 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 c20-20020a17090603d400b009e61366a4c3sm4360438eja.2.2023.11.13.10.18.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 10:18:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 4/5] tests/avocado/machine_s390_ccw_virtio.py: Fix
 SyntaxWarnings from python 3.12
Date: Mon, 13 Nov 2023 19:17:43 +0100
Message-ID: <20231113181744.49537-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113181744.49537-1-philmd@linaro.org>
References: <20231113181744.49537-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Python 3.12 now warns about backslashes in strings that aren't used
for escaping a special character from Python. Silence the warning
by using raw strings here instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231113140721.46903-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/machine_s390_ccw_virtio.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/avocado/machine_s390_ccw_virtio.py b/tests/avocado/machine_s390_ccw_virtio.py
index e1f493bc44..ffd914ded9 100644
--- a/tests/avocado/machine_s390_ccw_virtio.py
+++ b/tests/avocado/machine_s390_ccw_virtio.py
@@ -36,8 +36,8 @@ def wait_for_crw_reports(self):
     dmesg_clear_count = 1
     def clear_guest_dmesg(self):
         exec_command_and_wait_for_pattern(self, 'dmesg -c > /dev/null; '
-                    'echo dm_clear\ ' + str(self.dmesg_clear_count),
-                    'dm_clear ' + str(self.dmesg_clear_count))
+                    r'echo dm_clear\ ' + str(self.dmesg_clear_count),
+                    r'dm_clear ' + str(self.dmesg_clear_count))
         self.dmesg_clear_count += 1
 
     def test_s390x_devices(self):
@@ -121,15 +121,15 @@ def test_s390x_devices(self):
                                     'cat /sys/bus/ccw/devices/0.1.1111/cutype',
                                     '3832/01')
         exec_command_and_wait_for_pattern(self,
-                    'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_vendor',
-                    '0x1af4')
+                    r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_vendor',
+                    r'0x1af4')
         exec_command_and_wait_for_pattern(self,
-                    'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_device',
-                    '0x0001')
+                    r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_device',
+                    r'0x0001')
         # check fid propagation
         exec_command_and_wait_for_pattern(self,
-                        'cat /sys/bus/pci/devices/000a\:00\:00.0/function_id',
-                        '0x0000000c')
+                    r'cat /sys/bus/pci/devices/000a\:00\:00.0/function_id',
+                    r'0x0000000c')
         # add another device
         self.clear_guest_dmesg()
         self.vm.cmd('device_add', driver='virtio-net-ccw',
@@ -235,7 +235,7 @@ def test_s390x_fedora(self):
                         'while ! (dmesg | grep gpudrmfb) ; do sleep 1 ; done',
                         'virtio_gpudrmfb frame buffer device')
             exec_command_and_wait_for_pattern(self,
-                'echo -e "\e[?25l" > /dev/tty0', ':/#')
+                r'echo -e "\e[?25l" > /dev/tty0', ':/#')
             exec_command_and_wait_for_pattern(self, 'for ((i=0;i<250;i++)); do '
                 'echo " The  qu ick  fo x j ump s o ver  a  laz y d og" >> fox.txt;'
                 'done',
-- 
2.41.0


