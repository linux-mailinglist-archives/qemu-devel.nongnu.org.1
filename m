Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B7E7D2242
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:28:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUk0-0001a9-G5; Sun, 22 Oct 2023 05:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUjI-0001AM-5V
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUjG-00010A-5Q
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YGr1H8ijLV736mqcmWstFWaefAIRGO/VVLKqx2ky5/4=;
 b=WU+YcvT7la9mvbZ8vlQqR00xSiVzTHmncr6bbjlx25z1cdcs54MR6AE7e63mpsRA+sUHlL
 FVBE65kgMqRlKdzgtBadS5duO8JQkMUrLSWmKqoSSJz957f2HubFd75/ytGXqpDkS5bFdq
 zfltU2Rz8YxhvdIQEPVHMKqQ0o55mWE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-Sd59Q08pPmCSRdysShHfjg-1; Sun, 22 Oct 2023 05:26:36 -0400
X-MC-Unique: Sd59Q08pPmCSRdysShHfjg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso12654215e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966794; x=1698571594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGr1H8ijLV736mqcmWstFWaefAIRGO/VVLKqx2ky5/4=;
 b=gbTe7nrVLuaACKd29Oy/kU6hbpEygWCoy9k4+ZIOF0vwbgTL0aCovEtBjHswyndMWr
 kYMWT001kP0jmk4ubse8sAnxYY1TG32e/9fehf0bnSCj7RLXrwzs1/fVOQ/Wdku9rP76
 EGpdsZf5E+GcFdmLZ4J2B9jknZ/0WrKat3O+aNvYX+GYUFCJfZLPg6Wd3+ntKPr0+SPY
 VhCOzdWBr+iPqy38zXwtK/mPrQELHVhWMUqOtk3JCD379aUUxbDyC306bklouKco89NT
 rVOsWUvZeLmj/SDvSuwd3mnENTUp3IU7RTqgmCUdGGSSbQhWH35bmOzaFtFvyj//+1mC
 Q1yg==
X-Gm-Message-State: AOJu0YyIm5JASQjwgnIrVpE/hCrMuvjcEUUKIAmZywDunt2Aq77Eg7z0
 gu7WnMVvLjDn/I+kKwV+1IEwJjPHfSOt5nkm3xepMPbCmtAu2kI1qrzgvesZHuUK9ruOteizVW0
 y0Z3UKSKlKfW4rSRas5bqy07wZ46l8LMce8z8mzb+I502a5AxwWRE6+vsx5coeRMBH3Qz
X-Received: by 2002:a05:600c:3b97:b0:3ff:ca80:eda3 with SMTP id
 n23-20020a05600c3b9700b003ffca80eda3mr5047752wms.10.1697966794418; 
 Sun, 22 Oct 2023 02:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhgSfBtKuGqMU4/4oq0HrABhAM2Ys3LWqmPgmkX01CeJTKhZPmbR/bHeheSNetGZ+vFxnaaQ==
X-Received: by 2002:a05:600c:3b97:b0:3ff:ca80:eda3 with SMTP id
 n23-20020a05600c3b9700b003ffca80eda3mr5047737wms.10.1697966793968; 
 Sun, 22 Oct 2023 02:26:33 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 bh9-20020a05600c3d0900b003feae747ff2sm11413367wmb.35.2023.10.22.02.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:26:33 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:26:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Dave Jiang <dave.jiang@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v3 57/62] tests/acpi: Allow update of DSDT.cxl
Message-ID: <57a6beacd88b67af7ca9dbaf29800442a0e1bfed.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Addition of QTG in following patch requires an update to the test
data.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Message-Id: <20231012125623.21101-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..9ce0f596cc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT.cxl",
-- 
MST


