Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBAB739E96
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:34:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCHdE-0002yj-Tz; Thu, 22 Jun 2023 06:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHdA-0002y7-2w
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHd8-0006ur-Hp
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687430013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/N6PTQEbMIEn1dKaYWGWb1K9ljZmMm888p1OQh5X59Q=;
 b=cWHVdMyt8Zza3uq3+BVkKGTCrRh+psCaGFKGUow1Su69LOVkckeC/T8Nu9I1rLqcV+WNe9
 /PKmbBwkLzXK4VA9QVPk1OuEG6nlQ1RCCyuas0uPOVDz/mneDPKab/GPlniee95QQrOcdN
 7mVmQtuOmdb2dgwlyKPhW9PR8jbHwvU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-E0lxWEKTMOOLbXe4I3ZJlw-1; Thu, 22 Jun 2023 06:33:31 -0400
X-MC-Unique: E0lxWEKTMOOLbXe4I3ZJlw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3a034580b21so3020533b6e.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 03:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687430010; x=1690022010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/N6PTQEbMIEn1dKaYWGWb1K9ljZmMm888p1OQh5X59Q=;
 b=Kj4dpdIvuY6p88G72MnR/sYUdx0lw73xJxv/kMDPJbEQQm8Pifo2gug2uWICDcOuoJ
 2NVtHwzP4AhZ2nB0M5tBOb/On4VeosT4b8weVS4ot0TE87osPVrY1MyXJ5N9AI2LAJ0C
 slyNd52t/CvPhI0YKqLy4lDeJll46sxyN6yhX6PVB4da56ICr89L5Tpr7jDX/b8WXSZL
 Piaib/9Bsfesyz8SuQGbdx5vZVWawFnkfyal24lOPq6Pv4w27M5cKOrPfH89Jrm5cZ+/
 3E5Y4DhzAZ2akACJPX8FmDAq8XjDxuOSllLBvuEq7g9nplZPyzmEXTocAeb1CBG5TYe6
 48WQ==
X-Gm-Message-State: AC+VfDwHYcBBnuvFpXvgku2W+2IbuODo8MLhoUMJY02KhDDbPZBe6ht2
 0S45ajqQhTZc/3tD/U7QJ5uogHAVtOmXkM3iA8jNhW7Bbiy7cm4A5g/bVdxSgli6kbLTrPc35xu
 zSqf+iKBvxQ4U2/5qg35cHM9R90ewlvbRMgEvVLPZtnOOaACnv01lvZDdU107/51mHPLbwTFybI
 w=
X-Received: by 2002:a05:6808:1412:b0:3a0:83cf:1d82 with SMTP id
 w18-20020a056808141200b003a083cf1d82mr290594oiv.22.1687430010744; 
 Thu, 22 Jun 2023 03:33:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7CKinhspOsoFy9GsXiIqCUubb5Xz9oxjYoBn7JmyVilcuwE2mXQOOJ20uOMCMbtyBj5RhhTA==
X-Received: by 2002:a05:6808:1412:b0:3a0:83cf:1d82 with SMTP id
 w18-20020a056808141200b003a083cf1d82mr290566oiv.22.1687430010433; 
 Thu, 22 Jun 2023 03:33:30 -0700 (PDT)
Received: from localhost.localdomain ([115.96.105.213])
 by smtp.googlemail.com with ESMTPSA id
 29-20020a17090a035d00b0025eb3b237b4sm11004872pjf.44.2023.06.22.03.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 03:33:29 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 1/5] tests/acpi: allow changes in DSDT.noacpihp table blob
Date: Thu, 22 Jun 2023 16:02:51 +0530
Message-Id: <20230622103255.267289-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230622103255.267289-1-anisinha@redhat.com>
References: <20230622103255.267289-1-anisinha@redhat.com>
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


