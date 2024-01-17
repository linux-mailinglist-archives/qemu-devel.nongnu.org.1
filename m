Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BFD82FF8C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 05:26:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPxVO-0000Ld-QN; Tue, 16 Jan 2024 23:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rPxVK-0000Kj-KJ
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 23:26:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rPxVJ-0001UI-24
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 23:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705465575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2Jq1atmRlGfJZwdUuseFdF0BjNshHDnRtPSBxhYeHWI=;
 b=cMvBws98Xqs5uSzsCA1KRXXbDfzo5t198WBpwd+4hhsXy5d9MVEHFKEiJ7ZdUcnF2G22l4
 KKtn72IJbdFJKxksnd5ciZPuYlKiCswylq8V0SQ8REvg6jH+VF9WPsjKLQeTL/mdEOUNtU
 VtR9bcdGFx5cfly27TW9FwO5mXAQC4Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-xfHfmx1xM32y7dsXAPcXSA-1; Tue, 16 Jan 2024 23:26:13 -0500
X-MC-Unique: xfHfmx1xM32y7dsXAPcXSA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-67f8c9542c6so196810426d6.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 20:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705465573; x=1706070373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Jq1atmRlGfJZwdUuseFdF0BjNshHDnRtPSBxhYeHWI=;
 b=VbzaSCk2iZBGUB86E7DZrgOTjiAqR1T7EGKjTqlWj/nYxQKWlelBxsiPNCnvxgQSST
 hmtMmSJM7V4waKRzgW+y4/wUKoXpGu05tbhdW1FFPDXG/HFaQHBusJ6E4iLBvJwd1pjg
 H5bLStEdqJTd+41d/L43zqqligiSgw3Gztyz1vn5gDGhTtEgGTl7Kdw3OV2jU6zZLYfZ
 hqKcho1xg45FmhMVssEdvYDlHGDJ39H3r11n62gp1j6QAzgI3ft4qOrCo6F4v3wzbDkF
 emtn3Ac7JeEKzZb3cQqElSSdy/1LbRbl8pk+kKqTVWx5o2byZGqdlBXAJmhfKSvb/qKd
 16Dg==
X-Gm-Message-State: AOJu0Yybam0Apiw3z2iHR5IW9y74P6HJsrCNKLGOjnnCuGn7GJkzEWK1
 ZkEm6kT2yQm6Qh3SCUjKF27ajo3PD1SVlJS6RBJDZaXWopkoJ8HKV2Luz60gmvghPSqCpn5X/EX
 WzwyjOUPbbDpubgbL/n7vPYQ=
X-Received: by 2002:ad4:5d4a:0:b0:681:127f:8369 with SMTP id
 jk10-20020ad45d4a000000b00681127f8369mr10529480qvb.35.1705465572835; 
 Tue, 16 Jan 2024 20:26:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt6fS8WwbeO+wCmJEb/aOZNY0ejB15S6qlk9c7nBRkNx4w/mbN9PB6z62cxx1YRPf/hbUmKQ==
X-Received: by 2002:ad4:5d4a:0:b0:681:127f:8369 with SMTP id
 jk10-20020ad45d4a000000b00681127f8369mr10529471qvb.35.1705465572496; 
 Tue, 16 Jan 2024 20:26:12 -0800 (PST)
Received: from fc37-ani.redhat.com ([115.96.146.72])
 by smtp.googlemail.com with ESMTPSA id
 o2-20020a0cc382000000b00680d39626fcsm4697514qvi.47.2024.01.16.20.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 20:26:12 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2] acpi/tests/avocado/bits: wait for 200 seconds for SHUTDOWN
 event from bits VM
Date: Wed, 17 Jan 2024 09:55:56 +0530
Message-Id: <20240117042556.3360190-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

By default, the timeout to receive any specified event from the QEMU VM is 60
seconds set by the python avocado test framework. Please see event_wait() and
events_wait() in python/qemu/machine/machine.py. If the matching event is not
triggered within that interval, an asyncio.TimeoutError is generated. Since the
timeout for the bits avocado test is 200 secs, we need to make event_wait()
timeout of the same value as well so that an early timeout is not triggered by
the avocado framework.

CC: peter.maydell@linaro.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2077
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/avocado/acpi-bits.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

changelog:
v2: cosmetic comment updates in code and patch description.

diff --git a/tests/avocado/acpi-bits.py b/tests/avocado/acpi-bits.py
index 68b9e98d4e..efe4f52ee0 100644
--- a/tests/avocado/acpi-bits.py
+++ b/tests/avocado/acpi-bits.py
@@ -54,6 +54,8 @@
 deps = ["xorriso", "mformat"] # dependent tools needed in the test setup/box.
 supported_platforms = ['x86_64'] # supported test platforms.
 
+# default timeout of 120 secs is sometimes not enough for bits test.
+BITS_TIMEOUT = 200
 
 def which(tool):
     """ looks up the full path for @tool, returns None if not found
@@ -133,7 +135,7 @@ class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
 
     """
     # in slower systems the test can take as long as 3 minutes to complete.
-    timeout = 200
+    timeout = BITS_TIMEOUT
 
     def __init__(self, *args, **kwargs):
         super().__init__(*args, **kwargs)
@@ -400,7 +402,8 @@ def test_acpi_smbios_bits(self):
 
         # biosbits has been configured to run all the specified test suites
         # in batch mode and then automatically initiate a vm shutdown.
-        # Rely on avocado's unit test timeout.
-        self._vm.event_wait('SHUTDOWN')
+        # Set timeout to BITS_TIMEOUT for SHUTDOWN event from bits VM at par
+        # with the avocado test timeout.
+        self._vm.event_wait('SHUTDOWN', timeout=BITS_TIMEOUT)
         self._vm.wait(timeout=None)
         self.parse_log()
-- 
2.39.2


