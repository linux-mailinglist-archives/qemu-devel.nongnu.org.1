Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D39227DF8F5
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:41:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybf3-0003NE-5Y; Thu, 02 Nov 2023 13:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybed-0003F9-T4
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:52 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeY-0002j0-P5
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:50 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507975d34e8so1634345e87.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946723; x=1699551523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7iUHUmJJKAYyf7dSrae5mE6BmOIBdjnU8UyawGJu76k=;
 b=b6IgFwim77gxDwmemgwqAyXwuw0nD7or43/xpvrRD62uD8AY0LtIs/aKb5oAmiv7G4
 z1gst9wPUzYFNSJ93BtbquqFwdhTNCnJPGykfSen57D2wK16HTNyCukOtSDwru6Eg2po
 93oD07OhxwDkD56UvNehzXDCKWRenAQ7Xm8ICREe6xFhpDAlRZ/NFf3m2bcpt/E1Tnx2
 K3RH4t7i1cYvEZfavKe4WKt45tvDhfQE9HW5IwjUu+Zm9jnUtk0GjytT07imqC7gzsTH
 E5rFRWLJJqX79TcAcDXHZTLf3GR/U966YxZHComMSm8Em2f/Tez4KDflxmdjDhIDNBe/
 Uqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946723; x=1699551523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7iUHUmJJKAYyf7dSrae5mE6BmOIBdjnU8UyawGJu76k=;
 b=ehlGqNYtou8EsC58JeN5+QdOQTxZ7EdAHK9bcw0RLSjbkCxBcwwNsQfNOC3cy6V01d
 xaIiUF5f86VrrMmzyDqBcsgE1LsclybWvnCyeVYl2r9Q3kgx3Hs2EG2ZiRQ6dQ79o97D
 I4RpJX2Co4tOvdQPlIayCa1WYnoWRH8ui3U6TCONcesoFGIOIxoEXHEQh6z3DzHdxGEO
 CfhPN8S54iS2qhRKB+52LWZtpNKmOehpJFQksRnstyFNGz+PjbdW6lkF6FMSU/1pfObH
 TH2Y+kW5PGEMDxVIf0FlvnHy8nNvaubipZJiFQe4LX9V63a53xglSd9HMMyovMPDiHgm
 Ablw==
X-Gm-Message-State: AOJu0YxmksLr2dT0wx9doP+p8/qoIUkMOwQ7nlK9V8GVZ4UC4Ij98iuz
 O5UIDrTzgqOuGgB5fNUJ4iUub7uagMEqVfcNszE=
X-Google-Smtp-Source: AGHT+IFjQOrGq9Uo2FP3rDKrXCk4WCzPlCGj8Nray+4NZztKW8NqJzCSm3lllJq76477jcs7n4ajXw==
X-Received: by 2002:ac2:4850:0:b0:507:a089:caf4 with SMTP id
 16-20020ac24850000000b00507a089caf4mr14651370lfy.60.1698946723592; 
 Thu, 02 Nov 2023 10:38:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/33] docs/specs/pvpanic: Convert to rST
Date: Thu,  2 Nov 2023 17:38:13 +0000
Message-Id: <20231102173835.609985-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

Convert docs/specs/pvpanic.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230927151205.70930-5-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


