Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F6A73E07E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:21:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlZL-0007dw-2z; Mon, 26 Jun 2023 08:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDlZ6-0007L3-N9
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDlZ5-0006rM-5c
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687783410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=K3T3NQPTy9zcmgGBcagQiyrVNNx+5YBva+6wp6eO12taM4BISLyfcc6dSL3B1vlC97wj2X
 noyDxOm8M+shv3tmEXn/RsgJNdnRa56AQRoaDDhBjeG13NmA3Cssckl8TwSCkL/EDunw03
 os0D5zldAjmsp7aTAhe5kbYcdVSzk7s=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-SMWyY5MUM6yKtMx08QlTpA-1; Mon, 26 Jun 2023 08:43:29 -0400
X-MC-Unique: SMWyY5MUM6yKtMx08QlTpA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1b7fad414cdso5390355ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687783407; x=1690375407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=CaPqA+b8Iz8E6QBubJMAkSF8IhmNoafHL2I1NVd5EdZsfCZYg7N78oxhcdxlD7Hf5+
 gT5nOGmda7haUOy+iiGd3CXFUX88RfRPtJmFrKce7tLET42HvqkN9CW09oNp9llgHFTN
 8yRmGrkiwBz55BvcGFqaHSSnFNhOJGLYSUDEZKa9Z0SVb1cxvrlbk98PKF+i8QJb32to
 pxi6plokxJyzkk9jcncuc5OS2wNzf7EMQgldxIU0Oie2jSXDHemAbp1Hq4OeWfmMPIR4
 1a67XBxYvTcBQwW3N3+e3suiYRwunTrQTCQsqPzyrlTJbX2o0Zjvtqb+z0uct30PvHGz
 ZHEA==
X-Gm-Message-State: AC+VfDzLBKo5MF2LaMpb2pORz5hC2lVoirqqFixvhhbi0ZnvKhN1j/zP
 HJvIjDsMDt8PUf+Nv76oZbynU0lGiahOa95r4zFmUin5Ib+OIgm+t1HQ9saqMancqn2HXasK6wP
 n3B7tbxc2/frDdWtewSeM1XyE7u0ibBy8lDYanSFyRyrZuWcjTio9rTxNn3HW6YV8i8911g2t5t
 0=
X-Received: by 2002:a17:903:189:b0:1b6:649b:92de with SMTP id
 z9-20020a170903018900b001b6649b92demr3787873plg.65.1687783407502; 
 Mon, 26 Jun 2023 05:43:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/SeWmtsDoeh67uGpJHwWf/J4Fl+7tfw9i8zEQSRhYf66bJOO7UZUPQJD4piPmJU3qi7PGtw==
X-Received: by 2002:a17:903:189:b0:1b6:649b:92de with SMTP id
 z9-20020a170903018900b001b6649b92demr3787859plg.65.1687783407148; 
 Mon, 26 Jun 2023 05:43:27 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 j22-20020a170902759600b001b3c892c367sm4111671pll.63.2023.06.26.05.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:43:26 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 1/5] tests/acpi: allow changes in DSDT.noacpihp table blob
Date: Mon, 26 Jun 2023 18:13:02 +0530
Message-Id: <20230626124306.4572-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626124306.4572-1-anisinha@redhat.com>
References: <20230626124306.4572-1-anisinha@redhat.com>
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


