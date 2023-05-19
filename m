Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E82B7709A97
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:54:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Rp-0001lG-T2; Fri, 19 May 2023 10:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Ra-0001A9-Sc
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01RV-0003bJ-BS
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WtjR93h6QuSbRUCTzbaJ4aOffqFPn7qbJ+P5umk+LYA=;
 b=hsjyG3c1wjD73Bmu5C70jhPjXxUyFkB2LNIfy4/ksAdBfsHQSYA77xyTHG3bjqh61/k1ZK
 edIgmwsjZlevdI9Pdx0TAYSYP7EDvKQab1SPEVx+rr9OHBkgqe4yJBl4Q/hDiDLEFzDsXa
 SJ8F881Y2qk012CQbSkcUvRuWUJSHa0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-hW9FtN5wN-mdneOaX7JnqA-1; Fri, 19 May 2023 10:50:51 -0400
X-MC-Unique: hW9FtN5wN-mdneOaX7JnqA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f3a517b5c6so598832e87.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507849; x=1687099849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtjR93h6QuSbRUCTzbaJ4aOffqFPn7qbJ+P5umk+LYA=;
 b=JDlSeDayGxR/tnsUJL0ylW0+M9EhEOmasOHS3rGYMCFK0IRcfXbppeAMhdRNqRsfN0
 3xoRpAusE6n4Mxz4JIfhNMQA66wCfppFz3k/0By/+XYsLpxmYlg5t0/pKwHiAmDOQKPe
 NDH3rOxKtqFghGjrmyGdYh0z6iyS4qhwQIyGGVKRMoXxvFsZoiETGmJDToSxMM3kAI/D
 cZcBsxvkclsI065LF/fXspKDUtBVC1o1+oeUSaWHqTReWJocASY2kN1O6D2VO2WNvX59
 oZT4lQshY0xrH7D9wtFXTIInXqb63g62hiwn4yhiXX/hdLKyIpa20l/WjIXmCNK2kSA/
 SXSg==
X-Gm-Message-State: AC+VfDy3cva8EnS5f06oP7tecFH8xoeZME3zRZi5+xUcJ1SEkmSxOVA5
 aWMWOZlk1+nvrs4KfCml73jkTXU/Y7IcIrtjl5+gx+LS/WHWb/atmvkC6p2MhIZ1LdmvYkCdT0c
 DEY9T61tdLr/EgWg+uzyzHKZAhnO+UAxgxKVbmsRDitqYHSUIDNpj67UB07RUCZ7Z4/21
X-Received: by 2002:a05:6512:31c5:b0:4f0:ee3:848f with SMTP id
 j5-20020a05651231c500b004f00ee3848fmr925772lfe.15.1684507849690; 
 Fri, 19 May 2023 07:50:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7OHBBP0laTNVOvW8DDsjG2Lf9jycCIPtrURKMPCY1JEJoi+M+DTZVljRpsTGQYk+1dUongiA==
X-Received: by 2002:a05:6512:31c5:b0:4f0:ee3:848f with SMTP id
 j5-20020a05651231c500b004f00ee3848fmr925758lfe.15.1684507849262; 
 Fri, 19 May 2023 07:50:49 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 12-20020ac2482c000000b004efef5cf939sm624961lft.83.2023.05.19.07.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:50:48 -0700 (PDT)
Date: Fri, 19 May 2023 10:50:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric DeVolder <eric.devolder@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 13/40] ACPI: bios-tables-test.c step 2 (allowed-diff entries)
Message-ID: <354b09d228e1d04272e126a1edfcc70701af2958.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Eric DeVolder <eric.devolder@oracle.com>

Following the guidelines in tests/qtest/bios-tables-test.c,
set up bios-tables-test-allowed-diff.h to ignore the
imminent changes to the APIC tables, per step 2.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Message-Id: <20230517162545.2191-2-eric.devolder@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..66ae44e6b9 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,15 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/microvm/APIC",
+"tests/data/acpi/microvm/APIC.ioapic2",
+"tests/data/acpi/microvm/APIC.pcie",
+"tests/data/acpi/pc/APIC",
+"tests/data/acpi/pc/APIC.acpihmat",
+"tests/data/acpi/pc/APIC.cphp",
+"tests/data/acpi/pc/APIC.dimmpxm",
+"tests/data/acpi/q35/APIC",
+"tests/data/acpi/q35/APIC.acpihmat",
+"tests/data/acpi/q35/APIC.acpihmat-noinitiator",
+"tests/data/acpi/q35/APIC.core-count2",
+"tests/data/acpi/q35/APIC.cphp",
+"tests/data/acpi/q35/APIC.dimmpxm",
+"tests/data/acpi/q35/APIC.xapic",
-- 
MST


