Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A820076F5AF
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:23:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRgh6-0004Nt-9g; Thu, 03 Aug 2023 18:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRgh4-0004NO-QX
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRgh3-0000Rz-5c
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ifjgxfMBV4xR+8ddwA/Qkk5UE1d3vleT1b8VgxEZlsk=;
 b=Z4kzw6fiqHX9jpoOUkWhs0YFAKM4aHe4OohZYjy2fcbOBEsEtg+w4aB+j9JXtz4HmIChoc
 1RABjyjlKn1usl4PAlrHn+ZjG4nad6zBGe/WYqz2Eec8MOH2trx1ySCTPqfKj1ZobrOI12
 xU4Z9NEbersKNIT44HQdgXKUHdEkoKU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-_jWLPzabPvyK0SHz800DiA-1; Thu, 03 Aug 2023 18:21:14 -0400
X-MC-Unique: _jWLPzabPvyK0SHz800DiA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a34a0b75eso92202966b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101273; x=1691706073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifjgxfMBV4xR+8ddwA/Qkk5UE1d3vleT1b8VgxEZlsk=;
 b=CiWtrNNOBRW9XUbPdQI/fqvfd8eJQQyO1cHzAytp5JVIyDALW7qmOevGKp0lvOncm5
 XmJTSltyfBy1clj4XF23gE85wbdJYO7hcZuxrCm+M2sCYiVtb52WErEcKdMk69BPYnmM
 I3Z9u5o1ek0ZwGDC7fS5/fuZ1uUlYG6mXR2RcRP7HmFlVAt4HD4E3nudvEue1I74TYl/
 nzouY0rPdxX3Bvtnh6Q/ubKBOmRQU+vpgSJAfGv+6Dki20o9Usm+c6GhTQZq9PokY2So
 mFefSjQ3vFMNOnlhSZxFx6+DO1vzf04bZCfl0s7jrObM7ACYWw1hyS6swZRWA5G5hxT1
 7j+Q==
X-Gm-Message-State: ABy/qLanp0s95v5/jpTFyRrSHvNfi4IIWvssiV6vJycPMY4l3/C4xuE3
 OM92VqSPdjcNq1rRdyuzP6i2Ta3fn1r0r5GMhjz5NXEC871q+VuAM//JWPc4m1We8nFReRpl9IY
 yGh7DocKAUPHWI++xDn+ZMNDm7lRnZGG2sQoupKJhZ3a11XLQm8/9nasNMq3HjZdR3OPC
X-Received: by 2002:a17:906:3f18:b0:99b:f925:2f6c with SMTP id
 c24-20020a1709063f1800b0099bf9252f6cmr7882936ejj.39.1691101273305; 
 Thu, 03 Aug 2023 15:21:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE166Xo9jwcEL8BKiiktq7nlByWUENjjLpSxFjkAohdUOgfoGqFUEsxfGj86wUsE4/awu5TdQ==
X-Received: by 2002:a17:906:3f18:b0:99b:f925:2f6c with SMTP id
 c24-20020a1709063f1800b0099bf9252f6cmr7882928ejj.39.1691101273101; 
 Thu, 03 Aug 2023 15:21:13 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 d7-20020a170906c20700b009929d998abcsm368400ejz.209.2023.08.03.15.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:12 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 08/22] tests: acpi: whitelist expected blobs
Message-ID: <d3dc64f34d6b0567ae99fbfe80ed3c094991194b.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20230720133858.1974024-5-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..8911b10650 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,38 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT",
+"tests/data/acpi/pc/DSDT.acpierst",
+"tests/data/acpi/pc/DSDT.acpihmat",
+"tests/data/acpi/pc/DSDT.bridge",
+"tests/data/acpi/pc/DSDT.cphp",
+"tests/data/acpi/pc/DSDT.dimmpxm",
+"tests/data/acpi/pc/DSDT.hpbridge",
+"tests/data/acpi/pc/DSDT.hpbrroot",
+"tests/data/acpi/pc/DSDT.ipmikcs",
+"tests/data/acpi/pc/DSDT.memhp",
+"tests/data/acpi/pc/DSDT.nohpet",
+"tests/data/acpi/pc/DSDT.numamem",
+"tests/data/acpi/pc/DSDT.roothp",
+"tests/data/acpi/q35/DSDT",
+"tests/data/acpi/q35/DSDT.acpierst",
+"tests/data/acpi/q35/DSDT.acpihmat",
+"tests/data/acpi/q35/DSDT.acpihmat-noinitiator",
+"tests/data/acpi/q35/DSDT.applesmc",
+"tests/data/acpi/q35/DSDT.bridge",
+"tests/data/acpi/q35/DSDT.core-count2",
+"tests/data/acpi/q35/DSDT.cphp",
+"tests/data/acpi/q35/DSDT.cxl",
+"tests/data/acpi/q35/DSDT.dimmpxm",
+"tests/data/acpi/q35/DSDT.ipmibt",
+"tests/data/acpi/q35/DSDT.ipmismbus",
+"tests/data/acpi/q35/DSDT.ivrs",
+"tests/data/acpi/q35/DSDT.memhp",
+"tests/data/acpi/q35/DSDT.mmio64",
+"tests/data/acpi/q35/DSDT.multi-bridge",
+"tests/data/acpi/q35/DSDT.noacpihp",
+"tests/data/acpi/q35/DSDT.nohpet",
+"tests/data/acpi/q35/DSDT.numamem",
+"tests/data/acpi/q35/DSDT.pvpanic-isa",
+"tests/data/acpi/q35/DSDT.tis.tpm12",
+"tests/data/acpi/q35/DSDT.tis.tpm2",
+"tests/data/acpi/q35/DSDT.viot",
+"tests/data/acpi/q35/DSDT.xapic",
-- 
MST


