Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F21B773E45D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:14:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoqA-0007SR-UC; Mon, 26 Jun 2023 12:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDoq6-0007RU-Ee
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDoq3-0002li-HP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=HhKtOoLRVBPmZ0mmPcCYBtXZXwTGStiAAmRz465EBN2OOTT9hSb6oDnMYIOXHTsoGsHu5I
 jc4q5AIovjU0SsPlmbAeNu1GMfLx4NA4ljCjoskmvRJIbrZuL41cZ4mMtrxapdFMwQkW1G
 HxV5m+uIW4Om+TJg9Q/k0Zn0AaxaMvY=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-PzPvsZ6xML6tb7LdqTj2Vw-1; Mon, 26 Jun 2023 12:13:10 -0400
X-MC-Unique: PzPvsZ6xML6tb7LdqTj2Vw-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1b00f3adde2so2950159fac.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795989; x=1690387989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=A2FTl7TvRp2kfA61G6x3blTDkINyANRWQy8Bu+RCSjgr2dhBVuIhiLZLLRgOhZO6Uf
 ANqNrjRl0R0fQKdhhBlHGNcsdxCWupNb3Mht2BKYCzsTkZZHedIv+Lw5vCo9nxnB1ASm
 CY91M/XFX+wqLUTMhvElZTJtixkrG+7HwJNGashPJfZdwKqxfgJECAY3LMh14JiNblFA
 yATqn2rpU2eisc2Nx1Y+4le+NyYqQ+V9tvZC55SnL0UYPaD/6hQQHvONHnc/ZV5sVta6
 aOdDX6BMEpbalukVOLwOr10j/FO4M2cjuKQ+kiTcjaBW4VIYKOFtwNYWxjJQdfJFLrLk
 o0ZQ==
X-Gm-Message-State: AC+VfDyxGtE/0hRYa1/O8I+IU9gGDK5qQKVt24Ely6yxh1/0NLsktNHY
 bTztXyHmzjgCzxFQi2VpoB6xHFagcN+zLbhNWeUE3IV8TSLzuzkppJ4Uzf+Gbnoinsy+OHm/t/e
 kOp5B7gDR0IUF0jQ8JjlttraFhJpl84vpJTvCKpxB6E0zzoYk9VuzrEV/TiXGepDS1zMpQBNSe6
 c=
X-Received: by 2002:a05:6870:e7c3:b0:1a6:a547:ffe1 with SMTP id
 q3-20020a056870e7c300b001a6a547ffe1mr18312005oak.21.1687795989217; 
 Mon, 26 Jun 2023 09:13:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bjq+WqqtHwwr+uVWNaWLjYJbLbT7A3WWbtlai85C9tRcTrdYCf6M85UVM2Ejqqi2V7sHeig==
X-Received: by 2002:a05:6870:e7c3:b0:1a6:a547:ffe1 with SMTP id
 q3-20020a056870e7c300b001a6a547ffe1mr18311989oak.21.1687795988936; 
 Mon, 26 Jun 2023 09:13:08 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 q5-20020a631f45000000b0051b7d83ff22sm4318745pgm.80.2023.06.26.09.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:13:08 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [RESEND PATCH v5 1/5] tests/acpi: allow changes in DSDT.noacpihp
 table blob
Date: Mon, 26 Jun 2023 21:42:40 +0530
Message-Id: <20230626161244.4145-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626161244.4145-1-anisinha@redhat.com>
References: <20230626161244.4145-1-anisinha@redhat.com>
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


