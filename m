Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 905147D8D61
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 05:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwDQ9-0008AO-FL; Thu, 26 Oct 2023 23:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qwDQ7-0008A8-Lo
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 23:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qwDQ6-0001JS-9l
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 23:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698376917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XR+7cxp9kRhmFZSGDPM/Q/js16jwVnbpxH/cRH+4IKA=;
 b=QrePnA1CG71CCtuGZXNyVr37q9g77Id6/oJ+71tNNasssZ5rU8/t0Xya0mTMvAdqZEbFmC
 KqMcnx6I48uQFc1a5X7vfSBxus2IxN9jLTLRDLNdJ2a1MRqWE3J0+Xzos7SiHWyJzrz84i
 2Qo6Z5vY6/Pg3wueqnvhSqleEyHIU4w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-Fn25cyBZPcaicEEU7aN5tw-1; Thu, 26 Oct 2023 23:21:45 -0400
X-MC-Unique: Fn25cyBZPcaicEEU7aN5tw-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1ca28f36249so15749405ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 20:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698376904; x=1698981704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XR+7cxp9kRhmFZSGDPM/Q/js16jwVnbpxH/cRH+4IKA=;
 b=F5vRFPEmwvPA+bRUrILCGT/xQDeH4zRREiZk2CcsrHj1JyAhN6L3iUc/URpSnX1o+s
 g21+gSLIwYun+XM4Oc5UBjMqFUBv99EMMPgUcMJV4wa8aCCN2AXxZpAO82wt6dFOPWG3
 KCC8nQMDt7QR/mH3NA0/c8N0OBF8QmrhFcXYyl7toB20l9P0pHfpwFpeHoVpOE3uGz2d
 6ErepJ39MUbOqNsvhQNlYBpOpl0qIcOpox1uwWpU5l40DOhJvK+5Ln3BDyRs7FFuW+E3
 fuBA9klKnpxiPG7hZmdzGW/czspXJg/a5Ed+dWigVwwezFJjaLBEz1oK6F0eTdfKBRsw
 YlTw==
X-Gm-Message-State: AOJu0Ywei1K6Lb7OVck34ct2VmAYe0fCBBNmRneWQ6AR4ltX03aBFBGX
 YqrRBnpJumt6LYAIorvcjcj/U4B5kThCCcVoZ3AcWFiXS2mcXNPlZBl9FuA2XVnKRE8zeBcgW8o
 YDpJgx0Q1PQYs4KI=
X-Received: by 2002:a17:903:2382:b0:1cc:23e7:d522 with SMTP id
 v2-20020a170903238200b001cc23e7d522mr123532plh.29.1698376904393; 
 Thu, 26 Oct 2023 20:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKMfoRB+iRk1jpsvYAsWfBlUTLYGg4HTUAhEq884pvnvAvcLBn9BRfRYyESmszSD9iUuHwDQ==
X-Received: by 2002:a17:903:2382:b0:1cc:23e7:d522 with SMTP id
 v2-20020a170903238200b001cc23e7d522mr123516plh.29.1698376904075; 
 Thu, 26 Oct 2023 20:21:44 -0700 (PDT)
Received: from localhost.localdomain ([115.96.30.106])
 by smtp.googlemail.com with ESMTPSA id
 j6-20020a170902da8600b001cc131c65besm418431plx.168.2023.10.26.20.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 20:21:43 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: jusual@redhat.com,
	imammedo@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] acpi/tests/avocado/bits: enforce 32-bit SMBIOS entry point
Date: Fri, 27 Oct 2023 08:51:18 +0530
Message-ID: <20231027032120.6012-2-anisinha@redhat.com>
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

QEMU defaults to 64-bit entry point since the following commit
bf376f3020 ("hw/i386/pc: Default to use SMBIOS 3.0 for newer machine models")
The above change is applicable for all newer machine versions from version 8.1
and newer. i440fx and q35 machine versions 8.0 and older still use 32-bit entry
points.
Unfortunately, bits currently does not recognize 64-bit entry points and hence
is not able to parse SMBIOS tables. Therefore, we need to enforce 32-bit
SMBIOS entry point in QEMU command line so that bits is able to parse the
SMBIOS tables.
Once we implement the support in bits to parse 64-bit entry points, we can
remove the extra command line that is passed to enforce a 32-bit entry point.
The support can be added to the following smbios test script:
tests/avocado/acpi-bits/bits-tests/smbios.py2 in QEMU repository.

CC: jusual@redhat.com
CC: imammedo@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/avocado/acpi-bits.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/avocado/acpi-bits.py b/tests/avocado/acpi-bits.py
index eca13dc518..042007b0b8 100644
--- a/tests/avocado/acpi-bits.py
+++ b/tests/avocado/acpi-bits.py
@@ -380,6 +380,11 @@ def test_acpi_smbios_bits(self):
         # consistent in terms of timing. smilatency tests have consistent
         # timing requirements.
         self._vm.add_args('-icount', 'auto')
+        # currently there is no support in bits for recognizing 64-bit SMBIOS
+        # entry points. QEMU defaults to 64-bit entry points since the
+        # upstream commit bf376f3020 ("hw/i386/pc: Default to use SMBIOS 3.0
+        # for newer machine models"). Therefore, enforce 32-bit entry point.
+        self._vm.add_args('-machine', 'smbios-entry-point-type=32')
 
         args = " ".join(str(arg) for arg in self._vm.base_args()) + \
             " " + " ".join(str(arg) for arg in self._vm.args)
-- 
2.42.0


