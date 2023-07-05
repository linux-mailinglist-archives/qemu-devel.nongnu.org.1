Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD707483B3
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:02:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1Ad-0006Ic-8G; Wed, 05 Jul 2023 07:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1Ab-0006Hm-8Z
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1AZ-00010g-RJ
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688558379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=AFU2JpwaHcsNA7qqEfjJPzVtYZEVtIJEFyeYOIn4mH7Ar07RG5G0jRhN5MPg2J+zafbknS
 wuMIDm0MPsuvw/QhUNTrfAUzNHc0q1Xg/1t9p4XZ3h7eAD6qejxrDA6A/lyw+of1tlt8E3
 nHI/j6HPQHnU4JJvNf8aUOiDgIVRW3I=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-FPM3KGiwOGuSqPapKLyZOA-1; Wed, 05 Jul 2023 07:59:38 -0400
X-MC-Unique: FPM3KGiwOGuSqPapKLyZOA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1b89712d613so33360355ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558376; x=1691150376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=Umv6ZmFs0RLBerdfiStclkWpIhzEU/XCo9mtxSlPg4XhWO3O7P0QsCQ/jOMmMDASXV
 WR/KQXBgbwtiRvk361C9cLUGYlp6ji9H+pSmDzWrMun68zicb9cH1eFhvWA9m2LMDBx4
 hav5nBesjdvLAsAvmuzPIFwXOMGIp/NxbTKjkyvZQfkBaoNgH4jgBAY3KdJIrOtuMOxg
 m797aJKQe7gfTEJXAEjFbmSGIfXXTIHHgN+BS3TXPEJFC+RMuSiEEYtc5p1o9sJyCur8
 2uAq7Xcmss+wtJJfvk4B3qJIrKoalgkMWGwWcpyaP6Le12X8F3eIrPkXEI+1ufzKkfPJ
 11sA==
X-Gm-Message-State: ABy/qLYwFUcurDzlwHhtNXWrdKUtMoiCxEgfqKzLWSs6zJ3ubEaIcdcH
 op7/kqgn1kspRpS0rrI6gqKcQaOcPICfqJfBEISJxIMaMcirBfw4S/2lgLOooSmsb44jTVcXHgK
 nQx/ZS8D0I42NvxXlSAGX0eSga8rzA/CNnMufYCs7qOqhQwRudq83ETuAmFomhfisyW00+pogcx
 Y=
X-Received: by 2002:a17:903:2281:b0:1b6:6b90:7c2f with SMTP id
 b1-20020a170903228100b001b66b907c2fmr15351437plh.55.1688558376757; 
 Wed, 05 Jul 2023 04:59:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFqNPeRxwQRorYyOuloaBImu1hFVLOVDeILmBd27kd3xsyFG4r69WClLDBsq2Fm9MXHEBhsgQ==
X-Received: by 2002:a17:903:2281:b0:1b6:6b90:7c2f with SMTP id
 b1-20020a170903228100b001b66b907c2fmr15351421plh.55.1688558376411; 
 Wed, 05 Jul 2023 04:59:36 -0700 (PDT)
Received: from localhost.localdomain ([115.96.119.220])
 by smtp.googlemail.com with ESMTPSA id
 v3-20020a1709028d8300b001b89c313185sm4878852plo.205.2023.07.05.04.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 04:59:36 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v8 1/6] tests/acpi: allow changes in DSDT.noacpihp table blob
Date: Wed,  5 Jul 2023 17:29:19 +0530
Message-Id: <20230705115925.5339-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230705115925.5339-1-anisinha@redhat.com>
References: <20230705115925.5339-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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

We are going to fix bio-tables-test in the next patch and hence need to
make sure the acpi tests continue to pass.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..31df9c6187 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT.noacpihp",
-- 
2.39.1


