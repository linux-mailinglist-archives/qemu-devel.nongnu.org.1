Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1197E38BF
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:18:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J6G-0005eu-5d; Tue, 07 Nov 2023 05:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J6C-0005aR-If
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J6A-00033b-Ot
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YEPOijjZL1kA2zDdRTW73xdfs8GU4Xo0XUpXURKwEzo=;
 b=AZpRLVxBTFjKB6x8M8YAQgHZ6dMEmbjfcA3fvf/+i7kikxeT6mHD8xf+P8css1DX+JKEc+
 0WROKpLogWa8w0JITiiDosiQbmQW1nSWNBOUEuuPOxf6kS/txaNgf+0hzEbYjet3igMvQg
 T5Z9phu9B6Ew8mUdVGVz5fuEIL2/ti4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-hqEwXPbUPGeRuN8tSI5aDw-1; Tue, 07 Nov 2023 05:14:07 -0500
X-MC-Unique: hqEwXPbUPGeRuN8tSI5aDw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32f7384d5a2so2648760f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352044; x=1699956844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YEPOijjZL1kA2zDdRTW73xdfs8GU4Xo0XUpXURKwEzo=;
 b=YNxtAE/T/vOZzIfgLZch9kaRpH51NTHJbIBBPx33ioAELRu0UbHiUQqXdJtUte/9Cn
 1hDVBuMFo+F4JlRMNlChOVshig/4OR31QfrcFbh3rIsu1HbiX1iOYuKUeQr1DSAV4mYG
 N2pTnvXrNi3U6depPkazjv1mPIBVLjojYpY8HTLOUkifX39ngiD6LJ8s4jb4jZigEO4H
 5hKC9X+hrlZJPIickInaqIdsYpoQseJvzwd7luqzzTRZ96c96kN5okcPhghBxLucAnr9
 kw9E4IgvCIdIgH+4wfnowuVVH7vcKkibxwbahpTeCIftvkOK37+Bx6wC4z4c1sKdrQjb
 CpgA==
X-Gm-Message-State: AOJu0YwDjLsaITPZy53snNTWadrYPqI8bUkKC12tqDp9FTvSkcrEgtWj
 VxpZATqLHH0eeGU0EV1LBVGzV77OThsFDfYIpmlmnTdQCmEh7658ZAF/3QPNLd3P29kALRHdTc6
 jsWnorN7fikP9SCH7NDiGkNDBT+gXC8Pwp1B2sz0ccpUhrFLMARw6tVOEcL6oKqVI+UNy
X-Received: by 2002:a5d:6dae:0:b0:32f:7867:112 with SMTP id
 u14-20020a5d6dae000000b0032f78670112mr25048321wrs.13.1699352044327; 
 Tue, 07 Nov 2023 02:14:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExKkQrV4S28CoIB0QM+lL7BXx18WQn28OvYKx+N/aA5+VYjiFU/gIS9bOQJgJpzLfQmuhSlQ==
X-Received: by 2002:a5d:6dae:0:b0:32f:7867:112 with SMTP id
 u14-20020a5d6dae000000b0032f78670112mr25048294wrs.13.1699352043890; 
 Tue, 07 Nov 2023 02:14:03 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 e12-20020adffd0c000000b0032196c508e3sm1942587wrr.53.2023.11.07.02.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:14:03 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, jusual@redhat.com,
 imammedo@redhat.com, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 62/63] acpi/tests/avocado/bits: enforce 32-bit SMBIOS entry
 point
Message-ID: <a874ddc95a2b8b4b6303366c6ac6a2be53c41be4.1699351720.git.mst@redhat.com>
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
Message-Id: <20231027032120.6012-2-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


