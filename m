Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F027E38A7
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:17:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J4B-0007uo-Bz; Tue, 07 Nov 2023 05:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3r-0007So-Uf
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3q-0002cI-9N
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0kx8qJ2YzraSWvCM5ZZfa/pcBINgphK8RV/OZhF/o4=;
 b=X+sPFjTFhyKg/54O4SUbJzQ5aSAB0arUlWO5zF4Sc1qqEH2mztyhhSWyv66VzlWTwNl1cv
 HwnBIPnLsaxiejyNp4wGBBdGkuGTH3mevPWMJva5pv3sfC4HXJ26w+T0zwbtbqx/qXC6ZL
 DOtUNgt4C7KflSw3Zg4TA6iY884tzo4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-oGuFOoAFPUW2m7R98_QNhQ-1; Tue, 07 Nov 2023 05:11:52 -0500
X-MC-Unique: oGuFOoAFPUW2m7R98_QNhQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32cef5f8af5so3907824f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351910; x=1699956710;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0kx8qJ2YzraSWvCM5ZZfa/pcBINgphK8RV/OZhF/o4=;
 b=RyldPwMm8NsGfjf1UDdcM1QKIirKFMsON8Tve7cti9inbUDTnYUCEjxNqyM/D7Wc1s
 /pxyGIO35JztShYkDaoV1sC3OKABd9IWYH7bvm1ZfRWbRZcmxt9ktsRWkfjRuAqUveZO
 Iz1qLwt8MIIKW3Y6ta3fqUU4R8VQhHhW0Ajk+07jtivzGYudiGwbWgDfbIs1nEXGMazB
 fQjYRnVtQoIixhlxLc/TAkfqFz1GtfLrUTDB4y7zH8dvwuYtDjy8KJPCRJphF/Adu6OP
 6Hn7+z1ecNfSyVtfvspwqjQ6FSkWZ5F1RxqWtf3H3qD0lLLARrG1SbmqYwtCoCy21ggK
 pcCQ==
X-Gm-Message-State: AOJu0Yyz2ayFJSb48AVW3OSYtQltsVgOR0gm5/lnnx87raPEam5NZq5B
 2pjfHKrAIw6CY6SL+bog3LB4wxo/Wd4yHNrCPjUuijR1gktOUGwmiPYlOXhpMzBSzMyqfCXrTqK
 GE2MV39QzDJhVPR/cD8Xi0RcjaAViKy8XE4jRynxuHkrob7RgaV5B1/MJM3O9+46BqDID
X-Received: by 2002:a5d:588f:0:b0:32f:b47c:f1f6 with SMTP id
 n15-20020a5d588f000000b0032fb47cf1f6mr2520113wrf.32.1699351910620; 
 Tue, 07 Nov 2023 02:11:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrRjU3YZYrAMXwTtPZeHTNhPaxifl5jEe3PT+G4DOJ2UiFjfImPq6t0aowIi9Qkx8BeR8CiA==
X-Received: by 2002:a5d:588f:0:b0:32f:b47c:f1f6 with SMTP id
 n15-20020a5d588f000000b0032fb47cf1f6mr2520083wrf.32.1699351910345; 
 Tue, 07 Nov 2023 02:11:50 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b004060f0a0fd5sm15235837wms.13.2023.11.07.02.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:11:49 -0800 (PST)
Date: Tue, 7 Nov 2023 05:11:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 31/63] tests: bios-tables-test: Prepare the ACPI table change
 for smbios type4 core count2 test
Message-ID: <c63fcb2c10810e8294712f6e09657ef5bdd78833.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Following the guidelines in tests/qtest/bios-tables-test.c, this
is step 1 - 3.

List the ACPI tables that will be changed about the type 4 core count2
test case.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231023094635.1588282-9-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..0f95d1344b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/APIC.core-count2",
+"tests/data/acpi/q35/DSDT.core-count2",
-- 
MST


