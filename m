Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1B3738649
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:09:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByVI-0006na-Mv; Wed, 21 Jun 2023 10:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qByVG-0006mb-Db
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qByVF-0000J6-1H
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687356488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/N6PTQEbMIEn1dKaYWGWb1K9ljZmMm888p1OQh5X59Q=;
 b=HUdk8plsUepXwlx7R26jIZ6Oi14b67uO9AlIpWmX+W1uaGIR7IqChsP1HB7SJiRCjto0G8
 /OhT1TFHjVFocN2+7Fpf8bPpM9x5qOFgMvYSZ5Wx28yi5mhWqkAQWwYYvKZqUdBHvlo67B
 TpcyTFqSIVs/4EF80NwfgG4sjFa4R7E=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-bm2DIYuRNx2WFhHEm85UxQ-1; Wed, 21 Jun 2023 10:07:56 -0400
X-MC-Unique: bm2DIYuRNx2WFhHEm85UxQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1b530648be5so25911025ad.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 07:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687356464; x=1689948464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/N6PTQEbMIEn1dKaYWGWb1K9ljZmMm888p1OQh5X59Q=;
 b=mAuuxBHpjJJIidVIEl/4OiUBXl6MMqa69N7ZMHCuG/nWcdUIjcllsSKlD2jepeUdcH
 7upl3PBZeCz+KxztKIoe1Lg4ZWwJ2a2mGU2wzyMtxu2kRkBLHcms03YMQbi8y3AVKIzV
 Vzv4qjWlQlbDfWEzTTODvRAhHbzHYJjn/IuXMb3P4Yxkkzt9QEUnGsW3lGRpBQXzmkMy
 bJTkTcMHzsIA2BbijCKZVnbvWuRAQ3rVGXA5NiepUGwzW4eyWyOeiXa1MwvzUZY3HXG7
 PypTHGiebu98rDZUQSeQmFYbXOmWIQ4AD4h9OIDnnnB6jnd8H9pld/4pkNK3oHkCtA01
 sWdw==
X-Gm-Message-State: AC+VfDx/PaoRup8M4pdn4oWI7VyHWfgD5MHs9Sk0ZOPpxzjL9QPlh7pw
 WBMt7r3rCvbDUyxGo9atdZ4+OCmznkh0X/D/0cO9nw0nvlfF6qjqPBNZQ1zJCEZ3YbesZ8AuJTf
 fLADzS/jC/YbKDAs=
X-Received: by 2002:a17:902:e548:b0:1b6:788a:551d with SMTP id
 n8-20020a170902e54800b001b6788a551dmr5884653plf.44.1687356463899; 
 Wed, 21 Jun 2023 07:07:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RIFPrJT9xjxbTJ64bjDOysCeybPepCpcPkvBO0cjfXFA4/UlSSkOtTCcEAPnFiM9/hW6efQ==
X-Received: by 2002:a17:902:e548:b0:1b6:788a:551d with SMTP id
 n8-20020a170902e54800b001b6788a551dmr5884629plf.44.1687356463595; 
 Wed, 21 Jun 2023 07:07:43 -0700 (PDT)
Received: from localhost.localdomain ([115.96.199.101])
 by smtp.googlemail.com with ESMTPSA id
 y7-20020a17090322c700b001b4fee3ea25sm3502427plg.277.2023.06.21.07.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 07:07:43 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/3] tests/acpi: allow changes in DSDT.noacpihp table blob
Date: Wed, 21 Jun 2023 19:37:21 +0530
Message-Id: <20230621140723.462220-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230621140723.462220-1-anisinha@redhat.com>
References: <20230621140723.462220-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


