Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E82117B7AB5
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxX7-0000lE-HO; Wed, 04 Oct 2023 04:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVQ-0007IO-PR
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVE-00027O-Fw
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6itHRAaeA/7KQ1bC8dVzBpGkW9LElZrsjasdFphZEno=;
 b=UbsH8DzrTDAe4voFD+rlLjbX5nK5is2+7jKY20oMg+pUvTC8ZmM5DtNLpha3opSoknuBcP
 GjeOg9RrinPOAa/pnxvPFx9qS7yBBU8HBmvl0EcGKB/UWJbbM/z9CJjgt8qQtPgQy55H5q
 wI5C4xjEeHfF+9P3Cl1uICyAH3v7DO8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-e533WUoAN_Svkobi1G8NMQ-1; Wed, 04 Oct 2023 04:45:00 -0400
X-MC-Unique: e533WUoAN_Svkobi1G8NMQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32320b3ee93so1407096f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409099; x=1697013899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6itHRAaeA/7KQ1bC8dVzBpGkW9LElZrsjasdFphZEno=;
 b=vbyKSuWdaIBslM/SXgEITwLHfucjdsvAG8rrSECp/cCPeyL664hBmovhg67IQHCkpF
 rJSAZhA/uu380oC87CAMI1hPV/E4cmfj5YiYcXYtfTCGvOhfrL3YO4SS/J0twbaioDFk
 dYXh6aB5Wa3dafUYtV+t+KFbRT0dHolegouFDrpIhFe12P8LEamoKRZRUi3GV+nIbs+o
 ZsXqTojvor5kchARbkClZWFPYkfGoCeEOMA3f2KL9NDqEQl/yJecW21p8ymfWpnwj09F
 sXNF2g6JLbFf1QBcnuACIbj4FwhATVlj2Rw3aK30UENAKYjI9wSI89FQhohJ29TbAjY2
 Wu2A==
X-Gm-Message-State: AOJu0YzwkoTTvFbyf3Q0uI8H+B+Ft1xGWKLqlpV8z5gZKN9TeJyOhCuv
 GXQSgtHxCSm3J7IB5Q2ao/Pq+LwSQveVvH1w+LabloTfwTXNgOYuMXcQv+R53iHFWNECRtAlklO
 OPHEqbGVjvgaZ2nsuTBWuFKxKUAGER9slcE/zvKnID/5BAP06OW4DccCmjmuA2HS7R3/W
X-Received: by 2002:a5d:4650:0:b0:319:7c14:b06b with SMTP id
 j16-20020a5d4650000000b003197c14b06bmr1523153wrs.47.1696409098990; 
 Wed, 04 Oct 2023 01:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH23axWlQmn6dARg+FupF7f1gMaz8ryWc4Epy0aQERWJuFpeY9XURv6Rnbhu6PomMR1pFnDRA==
X-Received: by 2002:a5d:4650:0:b0:319:7c14:b06b with SMTP id
 j16-20020a5d4650000000b003197c14b06bmr1523136wrs.47.1696409098663; 
 Wed, 04 Oct 2023 01:44:58 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 k16-20020a5d4290000000b00325b29a6441sm3449033wrq.82.2023.10.04.01.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:57 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Dave Jiang <dave.jiang@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 34/63] tests/acpi: Update DSDT.cxl with QTG DSM
Message-ID: <27b59bd77e74bcb7056a20e33fe2eaadbd278879.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Description of change in previous patch.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230904161847.18468-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/q35/DSDT.cxl                | Bin 9655 -> 9723 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 9ce0f596cc..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT.cxl",
diff --git a/tests/data/acpi/q35/DSDT.cxl b/tests/data/acpi/q35/DSDT.cxl
index ee16a861c2de7b7caaf11d91c50fcdf308815233..d4272e87c00e010a6805b6a276fcc87d9b6ead17 100644
GIT binary patch
delta 129
zcmdn){o9+%CD<k8w<-ezW5-6WiHaE>Z1KTP@zG5VY|arrz8vu$o-VwO&H<hV28QMg
zA{_C-A&v}77)2ae;$4D$c@|hs&JYyl5?J;#_4B>ug$~QIw(xNK_XREBoSen5M39-0
gae?^cEXE~5f=q&}Tuh7%LL7`B1_Q(9{fa-B0lXk1>i_@%

delta 61
zcmezEz1^G3CD<ioyD9?%qu)lZiHa&J@xe~<(M__>5k9^g@gANoypGNRo(2Yn<_sbn
R@xdXE3`-a{Gb{aI1^_O_5bOW|

-- 
MST


