Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B53C7800D12
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 15:23:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r94Oq-0007OI-8h; Fri, 01 Dec 2023 09:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r94Oo-0007Nm-4C
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:21:46 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r94Om-0005ru-82
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:21:45 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b54261534so20446725e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 06:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701440502; x=1702045302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d2YiR4ePkVTdqMsR4HI9tsHMbtlkS6mKlXFF/LJFnks=;
 b=Z+EmR5hLk4HAUpbfumy8uB4F05AWaZPwZ+7MGPeplNIAa+YtxLMLkZoCw3zoKmKOEC
 KbLarLjWqxuHlZlVtm15dLbNZWR5K4w4JjOkCxR0skxZZvAGLZW1jAMOL1gjYuTRfitl
 1SP5fGWiLGcoH95pJ6dh5Bjiv24K+TTZZa7dNOwunhDL7eUYYGxtm/J+zVksv+MTb1tO
 WWeuW5ATT9Y0MxnAlouav/8a6gDCdfHyhzJV4lj9OFWi8OgMLFO53Q7dYFGTK/SsSgBD
 g5mvcG9DQMdSpXsPROc4TsvkrBqRCWL8Ho+cA1a/jYJzyztdKblx60O3E08HJ/CiVRa4
 osvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701440502; x=1702045302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d2YiR4ePkVTdqMsR4HI9tsHMbtlkS6mKlXFF/LJFnks=;
 b=wJ0IEzI/AJkcKmKlLEDq/4/QHm7Y1fqaL8Q4ywLPKXolYJ9+JcvZhX+TJChiGa8F5Y
 JO1tphDsCg4IkN41WcHhfnlPqWjNhcrfD4fNdzI0wTNnTouU0+zIUY/ciOcC2UBlXM+v
 XuWpw91hrF7gXOLW1vUF58NUdK0+roFDL0PHamLW0sZDT7hcTIVwTANl1Hq5ny8w5IVu
 G6uNYdo3ZZsHdt5ORgGdu6APT1CcUaKZxJVLrfaMQ34ODVWG4kdz18UmNprs862Q5dVz
 ZNcXPLkCcqQ/Cd03Z0QHWGQ/2yBU5i6D5vkrncFsTDP2I6g7OcWMjRqmMHmi5BlRdjye
 8uSA==
X-Gm-Message-State: AOJu0YwN2gt4DOA3363j2x2WeKDGmLGYtnXq17L3nlLyB6aLlDGIj5SJ
 5gM2vG7S4JjjrZPrHoQ9j0nuO4GrzI/q+f4okwo=
X-Google-Smtp-Source: AGHT+IE8v84wwavDkZzWpK4/ttSRZCd9Qy16F4H9SblzVw7BYMi2nyPY4HDcasVaQSgcYfCunniqlg==
X-Received: by 2002:a05:600c:1990:b0:40b:5e59:99b7 with SMTP id
 t16-20020a05600c199000b0040b5e5999b7mr316199wmq.215.1701440501876; 
 Fri, 01 Dec 2023 06:21:41 -0800 (PST)
Received: from m1x-phil.lan ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c471500b0040836519dd9sm5566564wmo.25.2023.12.01.06.21.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 01 Dec 2023 06:21:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Beraldo Leal <bleal@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH-for-8.2] tests/avocado: Stop fetching yamon-bin-02.22.zip
Date: Fri,  1 Dec 2023 15:21:39 +0100
Message-ID: <20231201142139.39816-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Per https://mips.com/develop/tools/boot-loaders/:

  To support existing users of these, and the QEMU project,
  YAMON is now available under the GPL License.

However the link https://mips.com/downloads/yamon-version-02-22/
is invalid:

  > GET /tools/mips-tools/downloads/yamon/yamon-bin-02.22.zip HTTP/1.1
  > Host: www.imgtec.com
  >
  < HTTP/1.1 301 Moved Permanently

Stop fetching the archive, use a patch to a downloaded one.

When YAMON_02_22_ZIP_PATH is not set we get:

   (4/4) tests/avocado/machine_mips_malta.py:MaltaMachineYamon.test_mips64el_malta_yamon: SKIP: YAMON_02_22_ZIP_PATH not available

Otherwise we keep testing:

   (4/4) tests/avocado/machine_mips_malta.py:MaltaMachineYamon.test_mips64el_malta_yamon:
  console: YAMON ROM Monitor, Revision 02.22.
  console: Copyright (c) 1999-2007 MIPS Technologies, Inc. - All Rights Reserved.
  console: For a list of available commands, type 'help'.
  console: Compilation time =              May 24 2013  12:16:34 (pburton)
  console: Board type/revision =           0x02 (Malta) / 0x00
  console: Core board type/revision =      0x01 (CoreLV) / 0x00
  console: System controller/revision =    Galileo / GT_64120A-B-0
  console: FPGA revision =                 0x0000
  console: MAC address =                   ff.ff.ff.ff.ff.ff
  console: Board S/N =                     0123456789
  console: PCI bus frequency =             33.33 MHz
  console: Processor Company ID/options =  0x01 (MIPS Technologies, Inc.) / 0x00
  console: Processor ID/revision =         0x82 (MIPS 20Kc) / 0xa0
  console: Endianness =                    Little
  console: CPU/Bus frequency =             320 MHz / 419 MHz
  console: Coherency =                     None
  console: Flash memory size =             4 MByte
  console: SDRAM size =                    128 MByte
  console: First free SDRAM address =      0x800c3300
  console: WARNING: Environment variable flash area is invalid!
  console: HINT   : Perform "erase -e"
  console: YAMON>
  PASS (3.50 s)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Supersedes: <20231201093633.2551497-5-alex.bennee@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
---
 tests/avocado/machine_mips_malta.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
index 9bd54518bf..7f82f3abba 100644
--- a/tests/avocado/machine_mips_malta.py
+++ b/tests/avocado/machine_mips_malta.py
@@ -121,13 +121,16 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         """
         self.do_test_i6400_framebuffer_logo(8)
 
-class MaltaMachine(QemuSystemTest):
+@skipUnless(os.getenv('YAMON_02_22_ZIP_PATH'),
+            'YAMON_02_22_ZIP_PATH not available')
+class MaltaMachineYamon(QemuSystemTest):
 
     def do_test_yamon(self):
         rom_url = ('http://www.imgtec.com/tools/mips-tools/downloads/'
                    'yamon/yamon-bin-02.22.zip')
         rom_hash = '8da7ecddbc5312704b8b324341ee238189bde480'
-        zip_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
+        zip_path = os.getenv('YAMON_02_22_ZIP_PATH')
+        zip_path = self.fetch_asset(f'file://{zip_path}', asset_hash=rom_hash)
 
         archive.extract(zip_path, self.workdir)
         yamon_path = os.path.join(self.workdir, 'yamon-02.22.bin')
-- 
2.41.0


