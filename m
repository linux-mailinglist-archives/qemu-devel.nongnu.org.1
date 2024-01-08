Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB23826BA2
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 11:37:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMn0E-0002As-Bw; Mon, 08 Jan 2024 05:37:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMn0C-0002Ae-Ah
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:37:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMn0A-0006R3-Kp
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704710221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14TRo9jTHiw5/wiV8jsJcgYUbYz2MJq8+Oopf4D3xPM=;
 b=HDfhbaSmXkuCzRuqbABG4enAhKbKiVqy5wZhly6x7SnKSo2xAFlZknoF9UeA+zi34zVWdP
 qf+r+rMUqVuHseHfkkO9nEM36O5bye1qamqOleQnCw7VxeGe0MhK9JzkqT6eEK13daa3nS
 dGXF51C6HnIOni46J7oylJ2xNQ2/aM0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-kQ_3whgJN7-gs-rNbteGbA-1; Mon, 08 Jan 2024 05:37:00 -0500
X-MC-Unique: kQ_3whgJN7-gs-rNbteGbA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5cdfd47de98so336372a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 02:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704710219; x=1705315019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14TRo9jTHiw5/wiV8jsJcgYUbYz2MJq8+Oopf4D3xPM=;
 b=J5yPh1FR/+AoDnCW/nql9Npv3gyklbIMzB/4cZ21CnG9hivYGe1hWOEMPJMIPFn92O
 j56iUmmmF/GgPZGgvPV5rdulNZaDJiQ+Ipjx4Xvk61sLXOtSs+jOZb6ODty6nKdJVZts
 jYIom44HaKRZsSf55Ra+nin29mMuKsHRYmr2t8Xso5Mk2pMphuket6qfikHArYdY7EIj
 IT2I+euM4CWrTj6xNGKt+HbXXkfxGlYcSkS48SI9xkJ21tY70W0OLloOM/PKE9sIBjIS
 H9B4FlkvnKKM37N6jeD6oqWJbUOTMVWJmldEtr6kzd38eCxvs+/eLx/AT1fc5ErSXSbo
 1P3g==
X-Gm-Message-State: AOJu0YxxaUw6qX78/GO60kVpQpF7UOWkU8nS0qpnxlh/idBPxQU5x6JL
 lvBOoypKjf3ollBPmYPS++5Fx4ODgVIs7V/YMeCfjbnRWRYxataIJvmIDvCg0WMeV3KuEVI+hey
 iU8ed86dS34ShbvnXP+VbvB8=
X-Received: by 2002:a05:6a20:54a7:b0:199:7b5e:f8c0 with SMTP id
 i39-20020a056a2054a700b001997b5ef8c0mr867345pzk.66.1704710219299; 
 Mon, 08 Jan 2024 02:36:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3+po6G1IMMJUimBWi9rWYGVHUhnZYndrAJfZqvsxQNRwtVGQIJfQNcA5rWhqh5CMaGgAqvw==
X-Received: by 2002:a05:6a20:54a7:b0:199:7b5e:f8c0 with SMTP id
 i39-20020a056a2054a700b001997b5ef8c0mr867335pzk.66.1704710218971; 
 Mon, 08 Jan 2024 02:36:58 -0800 (PST)
Received: from localhost.localdomain ([116.73.134.99])
 by smtp.googlemail.com with ESMTPSA id
 u11-20020a17090282cb00b001d3563c87a6sm5899502plz.281.2024.01.08.02.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 02:36:58 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, peter.maydell@linaro.org, mst@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] acpi/tests/avocado/bits: disable smilatency tests
Date: Mon,  8 Jan 2024 16:06:43 +0530
Message-ID: <20240108103643.4434-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240108103643.4434-1-anisinha@redhat.com>
References: <20240108103643.4434-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


