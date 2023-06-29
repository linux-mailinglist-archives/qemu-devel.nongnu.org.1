Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA901741F29
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 06:09:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEix7-0004FV-UZ; Thu, 29 Jun 2023 00:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEix2-0004FE-6o
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 00:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEix0-00015p-OO
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 00:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688011690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=ZYjD4Vh0xZ0tONTRY4faJRBYFHJk9th+FEasSXp6fSSRDun/PrlBigRnHnqQwie8vmASyL
 jMPn48rcno3D0q6pcPIh+uRRxpzAuXPgsengLFmYo6FmNNrzNvcpYsDy/BoGd95tOBiAiT
 POvTh05T/sfXiqfkmg1BZTmwy+J4v70=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-toD9BCt4McmEubqS0SBG8Q-1; Thu, 29 Jun 2023 00:08:08 -0400
X-MC-Unique: toD9BCt4McmEubqS0SBG8Q-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-763a3e3e760so34283485a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 21:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688011687; x=1690603687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=SQqbjE+FcWVi2qmFtKkDOwUZWES+r+iyg0jW7OCAYHIrOTDX+mrU5/ftGnzeNAN39D
 9SLM7GSlpO8aUyeyMkueqibnZJ/I9xcr26hYdn4ei/ii6kxS5ecl+Sv7My5GzADLoER1
 nuWQC+/4U/CPRSooAGoL4Ha+nCuF3d0YhSaa9Xpv6Ajbfskqx+cfCm2Lw+ET6o8DqzCH
 eswYwKa3SE69ay1XxN4q8Dd4tSXqrtxL+6WxqGBd4erhkzNB4D3z53gy3tkwHy3PZkHM
 0BOdfoFmzsx6orqUXrBD9KeHbpanU8EGHYzQM7UclHWgwX+CRHw3MrPcviWjuWV5Nf9c
 3fLQ==
X-Gm-Message-State: AC+VfDx59M2driiWPd7iliPlc2gd7TcxawutpJNKt0qvCT4TFbySmH7k
 P/er+mwLy/kljEZa2vImiLLMqMONOCREYe7xNJSzBwN+vn+K3w8r3cNUl4MRBpayf3jXygvRr/+
 SPdURHsKKq6Chhd7XEUhrsFGq7GEwKeF+0I4t/Xwre/yBM27etMRGSm8AIprcLn/rtMlh5mpyzj
 Q=
X-Received: by 2002:a05:620a:2a07:b0:767:2919:f38f with SMTP id
 o7-20020a05620a2a0700b007672919f38fmr3605796qkp.10.1688011686901; 
 Wed, 28 Jun 2023 21:08:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RFAs/49F87mFuUJow1mPX/wikMTXIIMBs+ti4/r6Ji1IWskHT090goZprnlcJH3PXps7TUg==
X-Received: by 2002:a05:620a:2a07:b0:767:2919:f38f with SMTP id
 o7-20020a05620a2a0700b007672919f38fmr3605775qkp.10.1688011686575; 
 Wed, 28 Jun 2023 21:08:06 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.183])
 by smtp.googlemail.com with ESMTPSA id
 21-20020a17090a019500b00256b67208b1sm10978169pjc.56.2023.06.28.21.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 21:08:06 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v6 1/5] tests/acpi: allow changes in DSDT.noacpihp table blob
Date: Thu, 29 Jun 2023 09:37:03 +0530
Message-Id: <20230629040707.115656-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230629040707.115656-1-anisinha@redhat.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
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


