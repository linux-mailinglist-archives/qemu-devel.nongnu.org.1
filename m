Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C757E38ED
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:22:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J6A-0005Qc-KG; Tue, 07 Nov 2023 05:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J66-0005MR-8H
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:14:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J64-00033B-GB
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cq8e/T3fhqKdlArKCJAyjRr/9dufWVuRJaWAjpre1Es=;
 b=hSKrj4R4W8DvhviqJG12dJPKoRJ4Y087UTJ/mp+9iQWlVBJ4PmkdD6kafC4MsdsOHOxVWb
 dGL9eRguCBnbhnc6LRo2w5LziqA9YHvnmnTj07k280qQO3PpMfchIkwztqEXJRk5YWFhL2
 fJW8AWXH6XRsaKwO+iQqo+/ksAmsEWA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-Tcv4-fWEMXinGgak8V6aRQ-1; Tue, 07 Nov 2023 05:14:10 -0500
X-MC-Unique: Tcv4-fWEMXinGgak8V6aRQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32d83fd3765so2478849f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352048; x=1699956848;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cq8e/T3fhqKdlArKCJAyjRr/9dufWVuRJaWAjpre1Es=;
 b=MS91MyKU1Eh0xSgHYXdhj3CZylIWAoj8AaVxc1jHr4fYZ9i3tZN4bMx1J6d6ROYH57
 f5G3f7uKvyxjXLNKBHG8j/+gjq5io38oT/DoShgq5MdnA9z+bLJGnOai5VX6oNOIIeOt
 DnrCRY5AsrE3SC02ZwnR9BjzoZ529FxAb+XpbcwG5TNZvGaoy551Eoqtp69mddz+dT2G
 Mfn7R0dAFCS902+ncKc0uqE20yp2YXE3B+bF60cGdigziByu36ZpplhCKq0iJuMry6Sn
 Sa678rFjtCDLqtdPMp3fZFj7YV7TUET/ZQ3CyAcpFYIMmm5LZWViw1fvvlz5GjFC58NE
 HV5Q==
X-Gm-Message-State: AOJu0YwY5pBdikK2PWKf/cR8uLEqsDq4VYIOdvkM8WzcKFU7m3rpLOzC
 0bbGJ1Qcpc5TyjApq24zDYBYp+PNtVl9htmbUJ0ieItjj3oEblAssr0bWSrxlqbmEVpcli8Ptbu
 kul3kGBURDQ3fLS4/3k5YUwoRFJ2ldVyZk5ouF77pwVfQ3r1pEEjW4umf+SFf83W+Ye7C
X-Received: by 2002:a5d:64e6:0:b0:32f:7734:a0fa with SMTP id
 g6-20020a5d64e6000000b0032f7734a0famr30537580wri.2.1699352048614; 
 Tue, 07 Nov 2023 02:14:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwX+FWz4E28nZS2rA3aJn23YqMBRf7DfkqIGs1KckgqGeiWFY2+y3wkldsrXq66xyrl3vE1A==
X-Received: by 2002:a5d:64e6:0:b0:32f:7734:a0fa with SMTP id
 g6-20020a5d64e6000000b0032f7734a0famr30537550wri.2.1699352048093; 
 Tue, 07 Nov 2023 02:14:08 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 v17-20020a5d6111000000b0031c52e81490sm1932943wrt.72.2023.11.07.02.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:14:07 -0800 (PST)
Date: Tue, 7 Nov 2023 05:14:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, jsnow@redhat.com,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 63/63] acpi/tests/avocado/bits: enable console logging from
 bits VM
Message-ID: <94cd94f1c0137b56000c01208e03d0907ad34910.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ani Sinha <anisinha@redhat.com>

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
Message-Id: <20231027032120.6012-3-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/avocado/acpi-bits.py | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

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
-
-        self.logger.info("launching QEMU vm with the following arguments: %s",
-                         args)
-
+        # enable console logging
+        self._vm.set_console()
         self._vm.launch()
+
+        self.logger.debug("Console output from bits VM follows ...")
+        c_drainer = drainer.LineLogger(self._vm.console_socket.fileno(),
+                                       logger=self.logger.getChild("console"),
+                                       stop_check=(lambda :
+                                                   not self._vm.is_running()))
+        c_drainer.start()
+
         # biosbits has been configured to run all the specified test suites
         # in batch mode and then automatically initiate a vm shutdown.
         # Rely on avocado's unit test timeout.
+        self._vm.event_wait('SHUTDOWN')
         self._vm.wait(timeout=None)
         self.parse_log()
-- 
MST


