Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE397CE23A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:08:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8xr-0003QO-RW; Wed, 18 Oct 2023 12:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xd-0002sk-5S
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xb-0007nN-7p
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3gMlvdquObTcfo3FR9W9RmnS7UYRddpgF0RI5ANGAvI=;
 b=JtFZaT6XLxaRiq4e3YvasO5U05JIfxqmXSg1cQ7CY31WUxPgQNt+mx5uNw3lE1S0oidtI1
 nwvkaoK7SL1588R/qd4yi1Mn9qqnGEJyM4ZAdpELvUBjbmbRvYKiR6XGZojuQD1Wq66YOr
 mzbU1axhI9lUGE/aqiN5AjPNc4o4pyE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-x1kqF8YUPfmlzld_LSMjxQ-1; Wed, 18 Oct 2023 11:59:48 -0400
X-MC-Unique: x1kqF8YUPfmlzld_LSMjxQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c50c873604so49686571fa.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644786; x=1698249586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gMlvdquObTcfo3FR9W9RmnS7UYRddpgF0RI5ANGAvI=;
 b=Go1X9RtjPNSJNivEM98lFZb/nvDFg8xGmWH0F2cY5Vi9kvzuBDjv5s5GfqjjubA6tB
 WVu0918ywrJmXm8hKYOEsgitlv7aPslI8Vduu/cgDwyYU6ERfLHoU47kpj/4/pqM4dpH
 U6nJxu9DxOZZM1E6cEcZLt3OQK/GhJ3MowGmSaQV31wr8YpZiILddLGkmLc4v1k2zTC9
 61FHBe8If2HtGDCdiyuvf9a4ibMQxayatDZPJH4nf0XrpWSm5hXXV5AE3kduijbsRptH
 g4BJ30rtNtj7fLhzMIWoPJumUx8e+qPKm38im3xhpaDGBl3geDb/Mrgf2el6CuKEqBib
 K2kw==
X-Gm-Message-State: AOJu0YyrLmvLQwg43cSvvrqtoY5DDu3qOlAXAqO1gfafwG0OJf2jlOFJ
 aS962+h7UZ2UFdOPYrLX+9YW7hB4iXxg0eus7rmcAwtvCq4DW8tYeizjyXO0DA3JtdlV1jbqP4G
 L1TXRWdAkAHGnh9fp8PLuVyI/ThpLxhEVAnZh2x99M46dtMnCQQY7cbrJxhA8U7ynuAUNvtU=
X-Received: by 2002:a2e:5411:0:b0:2c5:d3c:8f4d with SMTP id
 i17-20020a2e5411000000b002c50d3c8f4dmr4075303ljb.13.1697644786699; 
 Wed, 18 Oct 2023 08:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd3vesm4SqiLLk+CGYKGyRMOcIaYi16iAE0O++nITUqHeOTdkECIzJB2DQoCunRaHUA+uXPQ==
X-Received: by 2002:a2e:5411:0:b0:2c5:d3c:8f4d with SMTP id
 i17-20020a2e5411000000b002c50d3c8f4dmr4075284ljb.13.1697644786377; 
 Wed, 18 Oct 2023 08:59:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a05600c099800b0040652e8ca13sm1978163wmp.43.2023.10.18.08.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:59:45 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:59:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Dave Jiang <dave.jiang@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 80/83] tests/acpi: Update DSDT.cxl with QTG DSM
Message-ID: <7c6f17793f3f3338d8a4018588c3fc3a1527c064.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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

Description of change in previous patch.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Message-Id: <20231012125623.21101-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/q35/DSDT.cxl                | Bin 9655 -> 9713 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 9ce0f596cc..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT.cxl",
diff --git a/tests/data/acpi/q35/DSDT.cxl b/tests/data/acpi/q35/DSDT.cxl
index ee16a861c2de7b7caaf11d91c50fcdf308815233..145301c52af9a17242bb306c210f8a7e0f01b827 100644
GIT binary patch
delta 118
zcmV-+0Ez#%OYutzL{mgm@g)EN0r#;Aks)191z%G_Ut5Ak1w&X&O$c8|Nkk1nLr_UD
zFflg(6bN5aR6ziw0Tef1L{m)+pfHnY5fcg!ruk*_-luUurfRed3r~(xpb3*|0HhHE
Y0Rf;6lWGB^5(okT5(EMOv%Vqu1A4<F)c^nh

delta 60
zcmez9z1^G3CD<ioyD9?%qu)lZiHgc9@xe~<(M__>5k9^g@gANoypGNRo(2Yn<_sbn
Q@xdXE3`;iuQ2faZ03i7h)c^nh

-- 
MST


