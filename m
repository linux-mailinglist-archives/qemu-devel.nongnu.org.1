Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 194C67B07E3
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:13:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWD6-0003BJ-OK; Wed, 27 Sep 2023 11:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWD1-00037a-9N
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWCw-0005kb-CW
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40537481094so115331425e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695827529; x=1696432329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cqxGgxmXG6J8W9osNYYxJtFRwXKNwKGrhboUE2fncFA=;
 b=ziOQwvxbpEg5DeAdlHNzLwqmn4HGCSamnezW1dIZ6ckkLtOyZmr0VN3sAigNUL/ex/
 9WY6igF18q1/DEdQTB8g94TBHutdJBUHbr6GXuEVSr+kfg4UmE6+CpYHajhF9gki27Hb
 mBsfr0FS3h1V/J7JpigSP/A4h3rUS5C4Wirq49HZQsWotuyE1S+/1CGdCmwDu70XU9x9
 ySbUGmpuESromauH2i1F58G3wJOMhK2nn0uRR/aCIt/TVBqQqHyxu3AFSfsCusye4RWC
 c5ieJKBoNfanRMa2Zq2aCSgFVeidr2uPsgv7TfUviEBfRh8HZTDDYZOsqyba2Om4IO0P
 Ks+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695827529; x=1696432329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqxGgxmXG6J8W9osNYYxJtFRwXKNwKGrhboUE2fncFA=;
 b=CYOlAYe2isjcqTTcnblUstUhvtnUEwd/mJJoIrYi8DMxCyVKpGX9CZH/bnOMISOrt5
 z5kdUJsOThLgMmBpsEGMaOXS45CE+BstJ9x3R5+CGXI2g44UAHdzzKfttfGwFqaVB6tU
 JHojoRcU4FUe37nPVER5NRQBD8btGrykayuKiwDdRd1iysTM8pSrwETsV5E3SyD6wtnZ
 KWoRfOQYcopyVYjKR241IY2nWGLzfzgt8NpwzS6UY7PmmgSQz1xW8iiEAkTkf968M5Wh
 MfqKJ99L7VT3YspFkGL67V7/FcVdzMiuBRbX/LBDnnTy6rThLf7EDFyQPO544K6aZpVm
 YCHQ==
X-Gm-Message-State: AOJu0YzPA7OzN43Vadfjr8L1/P+BOiF72abtx7MuNLsoiYwFGfKKGwh9
 WA/cp2BWzTEpPYnZutOlQjpHAUB2B9MlJS0obDc=
X-Google-Smtp-Source: AGHT+IEvw45iY1+PWpYcoSQTyIYKE6hk2RgSzspB7KukefiPmESPq1nyCtpNneA2q5b0LDR7N4tciw==
X-Received: by 2002:a05:600c:291:b0:405:959e:dc6f with SMTP id
 17-20020a05600c029100b00405959edc6fmr2290569wmk.37.1695827529085; 
 Wed, 27 Sep 2023 08:12:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a1c7209000000b00401bbfb9b2bsm467474wmc.0.2023.09.27.08.12.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:12:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/8] docs/specs/pvpanic: Convert to rST
Date: Wed, 27 Sep 2023 16:12:01 +0100
Message-Id: <20230927151205.70930-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927151205.70930-1-peter.maydell@linaro.org>
References: <20230927151205.70930-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert docs/specs/pvpanic.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/specs/index.rst                    |  1 +
 docs/specs/{pvpanic.txt => pvpanic.rst} | 41 ++++++++++++++++---------
 2 files changed, 28 insertions(+), 14 deletions(-)
 rename docs/specs/{pvpanic.txt => pvpanic.rst} (64%)

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index e60c8377541..52bfab2f68b 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -27,3 +27,4 @@ guest hardware that is specific to QEMU.
    vmw_pvscsi-spec
    edu
    ivshmem-spec
+   pvpanic
diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.rst
similarity index 64%
rename from docs/specs/pvpanic.txt
rename to docs/specs/pvpanic.rst
index 8afcde11cc8..f894bc19555 100644
--- a/docs/specs/pvpanic.txt
+++ b/docs/specs/pvpanic.rst
@@ -21,18 +21,21 @@ recognize. On write, the bits not recognized by the device are ignored.
 Software should set only bits both itself and the device recognize.
 
 Bit Definition
---------------
-bit 0: a guest panic has happened and should be processed by the host
-bit 1: a guest panic has happened and will be handled by the guest;
-       the host should record it or report it, but should not affect
-       the execution of the guest.
+~~~~~~~~~~~~~~
+
+bit 0
+  a guest panic has happened and should be processed by the host
+bit 1
+  a guest panic has happened and will be handled by the guest;
+  the host should record it or report it, but should not affect
+  the execution of the guest.
 
 PCI Interface
 -------------
 
 The PCI interface is similar to the ISA interface except that it uses an MMIO
 address space provided by its BAR0, 1 byte long. Any machine with a PCI bus
-can enable a pvpanic device by adding '-device pvpanic-pci' to the command
+can enable a pvpanic device by adding ``-device pvpanic-pci`` to the command
 line.
 
 ACPI Interface
@@ -40,15 +43,25 @@ ACPI Interface
 
 pvpanic device is defined with ACPI ID "QEMU0001". Custom methods:
 
-RDPT:       To determine whether guest panic notification is supported.
-Arguments:  None
-Return:     Returns a byte, with the same semantics as the I/O port
-            interface.
+RDPT
+~~~~
 
-WRPT:       To send a guest panic event
-Arguments:  Arg0 is a byte to be written, with the same semantics as
-            the I/O interface.
-Return:     None
+To determine whether guest panic notification is supported.
+
+Arguments
+  None
+Return
+  Returns a byte, with the same semantics as the I/O port interface.
+
+WRPT
+~~~~
+
+To send a guest panic event.
+
+Arguments
+  Arg0 is a byte to be written, with the same semantics as the I/O interface.
+Return
+  None
 
 The ACPI device will automatically refer to the right port in case it
 is modified.
-- 
2.34.1


