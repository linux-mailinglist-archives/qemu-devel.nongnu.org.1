Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8395973E41B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDog9-0006ZN-BK; Mon, 26 Jun 2023 12:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDofm-0006Aj-Hc
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDofk-0007wO-Rm
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=EH87wa0THoZUwxiGYpIKrOZOy8o8fWuUt1aP7vcdNIo+k7c6C2hWMdyjCizGZYX4Q/w2dF
 7T70d5MDEv1Zp/H2nGQWq0KsIH2fe6DLUY74KcAVY7CaMFKHAurbF0SNvxV9CeJ9uPqo4S
 fpdP21GuLXVgP1wBnO345K54DBZSb8c=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-p-W-LdDLP4yFLHH1_SUgAg-1; Mon, 26 Jun 2023 12:02:29 -0400
X-MC-Unique: p-W-LdDLP4yFLHH1_SUgAg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-666eb0346c4so1508070b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795334; x=1690387334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=V/Im01d7g6psGiXN57qb4DDstK3Ht2FerrDZ4Ys7Etoi8OxafYdqO8b9CqA5/1YSB7
 2ROwr4levRnJnJJ1yqe7wKM28QpQxd0fzvhZesv9Mi5t5XzvDShnEi0alzJJqnaatck/
 g/khjXXGSLzDknjD6EJXbZHL/blGQbGwAE8UWKPKyUOdKFknTQtXYe1LCRf+BBE7607Z
 1HL6Vj+/tQUxrIMpcL5/mzHhj9rawG5+F1L+/Qhl+wExB9N6QKPmfqFtF+DA7XDkhNUO
 U6X6wh379iFPHzUTfsZ8ZDe6rx//pN/MxgzLNmdahDzb14dtjuFVIqV+lKwSKE0jnJZ2
 ROMQ==
X-Gm-Message-State: AC+VfDy4DRm9BBmmiScqnm8XUG6Ey7XbDT0Nj1m4Q6cUGrEeg4jW5P1l
 Mv41lkempCGLm8OvszwG5R3xCISvbKuWZjo/VzMGYzipUV1U0tCm9Rl3XJUYRYXsKe9fTR6xkRR
 RslALphLeo/LM43rArQMl71AP7svfDlsJ+QfchPgNpHFmx4kq7S5ZSMi8JKB0FeJV7Ooj00wkBN
 c=
X-Received: by 2002:a05:6a00:2d82:b0:668:715a:6fcd with SMTP id
 fb2-20020a056a002d8200b00668715a6fcdmr18508295pfb.5.1687795334529; 
 Mon, 26 Jun 2023 09:02:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Spa9gv068n8iu1A+P8IzILFnIcLYt7/wb5zGE4Y3OQkmNCabZPQiBcoh44/XePznxTWD0mw==
X-Received: by 2002:a05:6a00:2d82:b0:668:715a:6fcd with SMTP id
 fb2-20020a056a002d8200b00668715a6fcdmr18508269pfb.5.1687795334100; 
 Mon, 26 Jun 2023 09:02:14 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 l23-20020a62be17000000b0065ebeb9bb23sm4120174pff.149.2023.06.26.09.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:02:13 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v5 2/5] tests/acpi: allow changes in DSDT.noacpihp table blob
Date: Mon, 26 Jun 2023 21:31:53 +0530
Message-Id: <20230626160156.3938-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626160156.3938-1-anisinha@redhat.com>
References: <20230626160156.3938-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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


