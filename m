Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 732B073E11B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmf1-0004uK-8B; Mon, 26 Jun 2023 09:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDmey-0004ty-QR
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDmex-00060Y-Dx
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687787618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=aoavmDNcvUsp0v3InvUigtaqa+5hNRO0IYRFmEmStc76VXnwl0mXT6U3dUnvw4qCsxPI9S
 k/posucVPQ+/P1eU6RvrnKVMHT6IIwYtxq6q9dVCiv39f1siFG1URZMegf3PCTdluQxElW
 LnU3CPtMGGKKwkWnnryLNVC/YH3hmpA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-gR46rx7GOI6BLgiL97-RFQ-1; Mon, 26 Jun 2023 09:53:37 -0400
X-MC-Unique: gR46rx7GOI6BLgiL97-RFQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b7f8598d5aso13791935ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687787616; x=1690379616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=iyynXIHpdnPBtS5Rs9RpIm6YexLYDlPoaUWaMbfk+VsekhbvJPLjmawBlu2UhJZREY
 tb5019/XPVyow5Q90i2V26Nd2RyJCAd02cFoAecZ8/vPisis+7fwHiXaPDUui0X8tE2o
 3bM/AEWAiJQ0qxX2ih+SlowsafytCQB179X0RE15ZA/fqfTP5YxeVu5XshpKwuV4G5dk
 mEGAhCjSXjzQLXXHq2EfY/SkvBkMkCEFiQs89yg5p/62l0wVCZIS6fL8DiSOfyR774nP
 9kdXDeA4jgo296A2ilRLoinDJx/RhVWcsr90Tz6KejMXL0Lgmg64Kq6BzfvmaKsnG8VR
 Xr7Q==
X-Gm-Message-State: AC+VfDyI9dtIpsMFeUADiFYigvWr5bRyrVp0zR5FrmH/Y370sOflaM9G
 q6B6an9y8s+P9y43uUEwM76y4oX+B/9G29EB76nlXtXIvTRP5EL3KRkvJaeQOP0tjqIyAGnXunv
 Mue9sNw32isXOHJIubFoTCl8MECFpn9RgitAO04Moapq4creQAMuvzvd2u8rtvpeJHjTG6cm6M0
 4=
X-Received: by 2002:a17:902:7402:b0:1b2:28ca:d16 with SMTP id
 g2-20020a170902740200b001b228ca0d16mr6664663pll.44.1687787615774; 
 Mon, 26 Jun 2023 06:53:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7QcZWRRwaEvhVR2FrvtmEVWyYQtImevSht5iiMOjlUN4L4fXr1KWY2fkjy+mP4ATfo1cYi8g==
X-Received: by 2002:a17:902:7402:b0:1b2:28ca:d16 with SMTP id
 g2-20020a170902740200b001b228ca0d16mr6664649pll.44.1687787615407; 
 Mon, 26 Jun 2023 06:53:35 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 w7-20020a170902904700b001b809082a69sm1559621plz.235.2023.06.26.06.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:53:34 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 1/5] tests/acpi: allow changes in DSDT.noacpihp table blob
Date: Mon, 26 Jun 2023 19:23:20 +0530
Message-Id: <20230626135324.10687-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626135324.10687-1-anisinha@redhat.com>
References: <20230626135324.10687-1-anisinha@redhat.com>
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


