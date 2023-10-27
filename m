Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 311297D8D5F
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 05:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwDQ4-00089d-Sd; Thu, 26 Oct 2023 23:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qwDQ3-00089O-87
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 23:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qwDQ1-0001JD-Ec
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 23:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698376911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=simh88NQ8JXz8AjVZeNXJQud8G+aRTJe35SVm9ACyQs=;
 b=jIhTWw1Sm1nyCeCtTQpqp72HMivNdjzzRJRimSBRQJofusqINCLVO4ijuw+5Qt7RLMGdAH
 RzixtGGLTzBrCnaxHJc4rG5UejT0c7SNKM2VOr7RrJutkjPEu44T3Zuqui3ua6fucwAszX
 Co5f5+LEvOEfTTpY1zB63WPzK6ER8Ew=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-7md5G9zyP1W1_u-YMWQZuw-1; Thu, 26 Oct 2023 23:21:50 -0400
X-MC-Unique: 7md5G9zyP1W1_u-YMWQZuw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1c9d140fb3eso15163675ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 20:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698376909; x=1698981709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=simh88NQ8JXz8AjVZeNXJQud8G+aRTJe35SVm9ACyQs=;
 b=MLyHSCjbxCIPl9iBzjcjbj8CYIwLlKOVWXc2llPk6glpV3SsZABplx+BIaEhTlrIbt
 qnCbp+MyLXpBXwf9TIG0rsrtl1cUh260HtMyxAQl/L47hFa79OwusG8YDR4+psalcuMJ
 U/d3mcNLEyrDA8K+2tiPWwCG/4k7o0QctSg7mt/tNxIx03mFRACIPb+DQYUt87VfS2ED
 VQ2zuCEpdr7amJEYRF9v9qjVNyU9p6kdgC4mbvUNRlVgRoBd4GQNYU3P81UAPPBXtWPk
 wNMsV6SR5w3eOwKZIakyorxIDKqMp2LMBYQT/UmQxzFkNWxrRgjaNsQfni6HHBv1euri
 j9bA==
X-Gm-Message-State: AOJu0YwtUNOol7ZpOXqxnBwBNHCXUbDlwRN9lreh7SRWREM5tQj1d1Hh
 9/fwE5/S+Uyc6ykwRll/Z5NeZJDoRkvdCKJo8IhGpKCLU/aZ/BDOIPmy4XgtZNt6zk5Cw+YlLGc
 JZ4l/UK55ArcjGyE=
X-Received: by 2002:a17:902:c146:b0:1c6:3157:29f3 with SMTP id
 6-20020a170902c14600b001c6315729f3mr1475318plj.36.1698376908894; 
 Thu, 26 Oct 2023 20:21:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHquaDsWc+oVlPzPd4kPA1RU95KcL2SPRCfEAhJaIUPfdM0lm5zM71HOLhiixDaTxcoocuHRg==
X-Received: by 2002:a17:902:c146:b0:1c6:3157:29f3 with SMTP id
 6-20020a170902c14600b001c6315729f3mr1475305plj.36.1698376908565; 
 Thu, 26 Oct 2023 20:21:48 -0700 (PDT)
Received: from localhost.localdomain ([115.96.30.106])
 by smtp.googlemail.com with ESMTPSA id
 j6-20020a170902da8600b001cc131c65besm418431plx.168.2023.10.26.20.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 20:21:48 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: jsnow@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] acpi/tests/avocado/bits: enable console logging from bits
 VM
Date: Fri, 27 Oct 2023 08:51:19 +0530
Message-ID: <20231027032120.6012-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027032120.6012-1-anisinha@redhat.com>
References: <20231027032120.6012-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Console logs from the VM can be useful for debugging when things go wrong.
Other avocado tests enables them. This change enables console logging with the
following changes:
 - point to the newer bios bits image that actually enabled VM console.
 - change the bits test to drain the console logs from the VM and write the
   logs.
 - wait for SHUTDOWN event from QEMU so that console logs can be drained out
   of the socket before it is closed as a part of vm.wait().

Additionally, following two cosmetic changes have been made:
 - Removed VM QEMU command line logging as avocado framework already logs it.
   This is a minor cleanup along the way.
 - Update my email to my work email in the avocado acpi bios bits test.

CC: jsnow@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/avocado/acpi-bits.py | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tests/avocado/acpi-bits.py b/tests/avocado/acpi-bits.py
index 042007b0b8..68b9e98d4e 100644
--- a/tests/avocado/acpi-bits.py
+++ b/tests/avocado/acpi-bits.py
@@ -18,7 +18,7 @@
 #
 #
 # Author:
-#  Ani Sinha <ani@anisinha.ca>
+#  Ani Sinha <anisinha@redhat.com>
 
 # pylint: disable=invalid-name
 # pylint: disable=consider-using-f-string
@@ -48,6 +48,7 @@
 )
 from qemu.machine import QEMUMachine
 from avocado import skipIf
+from avocado.utils import datadrainer as drainer
 from avocado_qemu import QemuBaseTest
 
 deps = ["xorriso", "mformat"] # dependent tools needed in the test setup/box.
@@ -141,12 +142,12 @@ def __init__(self, *args, **kwargs):
         self._baseDir = None
 
         # following are some standard configuration constants
-        self._bitsInternalVer = 2020
-        self._bitsCommitHash = 'b48b88ff' # commit hash must match
+        self._bitsInternalVer = 2020 # gitlab CI does shallow clones of depth 20
+        self._bitsCommitHash = 'c7920d2b' # commit hash must match
                                           # the artifact tag below
-        self._bitsTag = "qemu-bits-10182022" # this is the latest bits
+        self._bitsTag = "qemu-bits-10262023" # this is the latest bits
                                              # release as of today.
-        self._bitsArtSHA1Hash = 'b04790ac9b99b5662d0416392c73b97580641fe5'
+        self._bitsArtSHA1Hash = 'b22cdfcfc7453875297d06d626f5474ee36a343f'
         self._bitsArtURL = ("https://gitlab.com/qemu-project/"
                             "biosbits-bits/-/jobs/artifacts/%s/"
                             "download?job=qemu-bits-build" %self._bitsTag)
@@ -386,15 +387,20 @@ def test_acpi_smbios_bits(self):
         # for newer machine models"). Therefore, enforce 32-bit entry point.
         self._vm.add_args('-machine', 'smbios-entry-point-type=32')
 
-        args = " ".join(str(arg) for arg in self._vm.base_args()) + \
-            " " + " ".join(str(arg) for arg in self._vm.args)
+        # enable console logging
+        self._vm.set_console()
+        self._vm.launch()
 
-        self.logger.info("launching QEMU vm with the following arguments: %s",
-                         args)
+        self.logger.debug("Console output from bits VM follows ...")
+        c_drainer = drainer.LineLogger(self._vm.console_socket.fileno(),
+                                       logger=self.logger.getChild("console"),
+                                       stop_check=(lambda :
+                                                   not self._vm.is_running()))
+        c_drainer.start()
 
-        self._vm.launch()
         # biosbits has been configured to run all the specified test suites
         # in batch mode and then automatically initiate a vm shutdown.
         # Rely on avocado's unit test timeout.
+        self._vm.event_wait('SHUTDOWN')
         self._vm.wait(timeout=None)
         self.parse_log()
-- 
2.42.0


