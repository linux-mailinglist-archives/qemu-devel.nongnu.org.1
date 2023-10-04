Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 853C87B7ACD
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:55:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxV5-0006gf-Bs; Wed, 04 Oct 2023 04:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxV3-0006ep-TX
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxV2-0001v6-C0
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=76Y7R960dFSN7szv/0REqiWmKtJ7HjYPh/yqQYLIzh4=;
 b=AU1GSgv6V8Jxr0tLFcvdOAB8tL60ip2aI0YGU8ov/unacQncJmLbhAqang9htLZ6zjaZ3m
 4CiuhZ4dNY5qT200iFUS443rQaW1nDbGA9x7Nt2oe8fOT5HFqSfDsW9VMDF9j1q3QfstIw
 3p+MB7JHfUhGzCQ2Tvk3EUYMjdb6t/0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-qGFhJEvpNKSrdpxtUqbusA-1; Wed, 04 Oct 2023 04:44:54 -0400
X-MC-Unique: qGFhJEvpNKSrdpxtUqbusA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-326f05ed8f9so1480961f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409092; x=1697013892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76Y7R960dFSN7szv/0REqiWmKtJ7HjYPh/yqQYLIzh4=;
 b=s2sLBHre97muGDoGrsMVrG0qcVvrGff7pWze7TrAKMpm7JJ98m0iyWOxrMTSj63GSz
 EzWoIGB8j0Q5eHIk96StvDvp+CoiXOnrdM/BV3/pG8TBhkx9hhNd/AdCw6LCVP3yaRDJ
 UCh0gBL/TOR7PsooiYtuiC3+AX+1wvMJWjIc7Mb6xIy01InR1PKXRAoQP5npoMAPgbYT
 fAE82A0fh4dzzARpUwuoKqI99DS60DVkoxhIfHVK0cU3EXTJR7ugH5RI7NagjDwrw3JD
 B6yhMkRipH+SaPIrqLqHZ+drVnWGTU76GgZ2GJmxuS7E4hzqXaVAwdqUeZuAWjAglVqm
 YNoA==
X-Gm-Message-State: AOJu0YwThyZKfZiySTpgPmWJaU59grqBdYdmjSDwqG1/DY0Dy4T/IKNf
 jYwOBh2JYicYoHBaYOtP1Zi8q5UDKgIvRWVcGCX46MyDxLlPCJQYBr4uXjCqIDCLSfGaT5QOl/D
 O9zRWZUftNq1oG+qgaA/N/sxgoKFh8nSDGnSXgwRbBXcsg75P5B925f01odaTogLMmIEX
X-Received: by 2002:a5d:4b4f:0:b0:31d:8fed:c527 with SMTP id
 w15-20020a5d4b4f000000b0031d8fedc527mr1346745wrs.42.1696409092416; 
 Wed, 04 Oct 2023 01:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2N7UWQxugwjedo52VAKInlxBvYanSCDO1qBi+Lg2oGBtADSNH4LhRhdE6QKzgLsjsHJNQWA==
X-Received: by 2002:a5d:4b4f:0:b0:31d:8fed:c527 with SMTP id
 w15-20020a5d4b4f000000b0031d8fedc527mr1346735wrs.42.1696409092154; 
 Wed, 04 Oct 2023 01:44:52 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 c4-20020a5d4f04000000b0031773a8e5c4sm3425863wru.37.2023.10.04.01.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:51 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Dave Jiang <dave.jiang@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 32/63] tests/acpi: Allow update of DSDT.cxl
Message-ID: <168cd6ba1e0ecfe2e078218e3dd2c68edcb7bac3.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Addition of QTG in following patch requires an update to the test
data.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230904161847.18468-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..9ce0f596cc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT.cxl",
-- 
MST


