Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 176B0826BA1
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 11:36:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMmyg-0000jr-OV; Mon, 08 Jan 2024 05:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMmye-0000jU-4n
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:35:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMmyc-0003xi-HZ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704710125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14TRo9jTHiw5/wiV8jsJcgYUbYz2MJq8+Oopf4D3xPM=;
 b=fPU+tiLD8038CRgpsn/y+gHYT2lbjpqoXliV+X8WktjnElzPDxVr+NiYyblNGShnpAejHp
 bmAx9d7ZEjLrqhqAixuN4XDCS69v3VYEPl/RznkMs/HJxbCAWZV9IEw+y54Mc8vgGGXlGg
 7PEfzdlMHCmB0Qy8H0jf+9p0TJXe0m4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-lH489FMNPkuXJEWv4A34hQ-1; Mon, 08 Jan 2024 05:35:23 -0500
X-MC-Unique: lH489FMNPkuXJEWv4A34hQ-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1d3eaaaa5a1so18351095ad.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 02:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704710123; x=1705314923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14TRo9jTHiw5/wiV8jsJcgYUbYz2MJq8+Oopf4D3xPM=;
 b=Dco57eNVSpluoCVyiVRlHgPDPLwH82BjcL8lf9/s3MGIFhby3iRv2Y7BYzIYO61+ib
 mfR0rqeSZtRHGqz+OX9VK+5Djj5xINFaKhq0+F5/RLFKhw+RKBPws1esiDW4leBmI19b
 m+AUQ0KieiWfKnE0+ueUM61GwzIuohb/6hY/9zgzWWGBPp3BDdsccXzYyR7ouY0CIUvI
 3JBANfiS4BGgoTtt/oA+EG6IUCL21f3BfWyJKLA2Z5rO6ZgqDH/c3cEW8xxPrJd7NsO6
 /xwXXFBGdsG0Q9cfR90BBuy2iETxS+h1rqXu6tpxz5+WernKvw1Ijvxz0zv80IGVTADu
 e3NA==
X-Gm-Message-State: AOJu0Yx7eqKIwBmMK3C7lt61nDX8VjfecnuvWDvo9xOHXAS1YfKsGG5K
 qkqsgrtsdGbxbbKTHRZJXZjSE/QZUqcOd08uncNfrJ6SQERPE7UAO7tPGERSZG7iPYvg1Nt6qnE
 CVWfc+/2FCztqHNkeJ3HzgZQ=
X-Received: by 2002:a17:902:f806:b0:1d4:e1d3:fb3a with SMTP id
 ix6-20020a170902f80600b001d4e1d3fb3amr3381833plb.49.1704710122787; 
 Mon, 08 Jan 2024 02:35:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO+90nAUZ63MS14vzbybprP5idRvW/cSYqHkPXCdgNT5XHqmMtTiSX1+jeWBt1RvfHdzMR2g==
X-Received: by 2002:a17:902:f806:b0:1d4:e1d3:fb3a with SMTP id
 ix6-20020a170902f80600b001d4e1d3fb3amr3381822plb.49.1704710122545; 
 Mon, 08 Jan 2024 02:35:22 -0800 (PST)
Received: from localhost.localdomain ([116.73.134.99])
 by smtp.googlemail.com with ESMTPSA id
 u11-20020a170902e80b00b001cf658f20ecsm5927487plg.96.2024.01.08.02.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 02:35:22 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, peter.maydell@linaro.org, mst@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] acpi/tests/avocado/bits: disable smilatency tests
Date: Mon,  8 Jan 2024 16:04:39 +0530
Message-ID: <20240108103439.4369-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240108103439.4369-1-anisinha@redhat.com>
References: <20240108103439.4369-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

smilatncy tests in bios bits seems to generate some flakyness in running the
bits avocado tests. Disable them for now.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2077

CC: peter.maydell@linaro.org
CC: crosa@redhat.com
CC: philmd@linaro.org
CC: bleal@redhat.com
CC: mst@redhat.com
CC: wainersm@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/avocado/acpi-bits/bits-tests/smilatency.py2 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/acpi-bits/bits-tests/smilatency.py2 b/tests/avocado/acpi-bits/bits-tests/smilatency.py2
index 48083bfb0d..405af67e19 100644
--- a/tests/avocado/acpi-bits/bits-tests/smilatency.py2
+++ b/tests/avocado/acpi-bits/bits-tests/smilatency.py2
@@ -37,8 +37,9 @@ import time
 import usb
 
 def register_tests():
-    testsuite.add_test("SMI latency test", smi_latency);
-    testsuite.add_test("SMI latency test with USB disabled via BIOS handoff", test_with_usb_disabled, runall=False);
+     pass
+#    testsuite.add_test("SMI latency test", smi_latency);
+#    testsuite.add_test("SMI latency test with USB disabled via BIOS handoff", test_with_usb_disabled, runall=False);
 
 def smi_latency():
     MSR_SMI_COUNT = 0x34
-- 
2.42.0


