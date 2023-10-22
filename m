Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBC77D2254
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:31:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUkP-0002iz-3F; Sun, 22 Oct 2023 05:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUjP-0001S2-S7
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUjO-00014e-EF
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3gMlvdquObTcfo3FR9W9RmnS7UYRddpgF0RI5ANGAvI=;
 b=b9jnpvewlzvmGpc/wD74eSVY+nS7dQBhnS2TBNNjS26BvYxKrGzTsLfB2GCvjhg+qH2X2e
 pIveB4RK/NuhUkZRK8QDWKfKGjcKJdOFvdKaQ0r5NaKZ0qT1DpjmUrUVQlIrTJRLPrkLcM
 KeYGtFk52AIO/1gKzSHIKO+LVagxVfA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-mg-fioCsMtaGKh7K2yxihA-1; Sun, 22 Oct 2023 05:26:44 -0400
X-MC-Unique: mg-fioCsMtaGKh7K2yxihA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507c4c57567so2270145e87.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966802; x=1698571602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gMlvdquObTcfo3FR9W9RmnS7UYRddpgF0RI5ANGAvI=;
 b=fZ6jzEafMGztnmWRx37nZXJhG5oRK+5HEKl4wY55J1t1sxvQSuDNoTuCYKTIPkNQNU
 962L5Yz04Cm7cRAx5FSsjwfWtzQ1wdOr5G2CGzv/iBm59HJuuTK9OfoYjKMthQ/W1/y4
 LboyRf+I7lhKqKKaenOW/w1aIKWFhuAecABxgseef4U/yw7rVsb6TGqYfq+0U311f6oO
 q8VTvHLGEIh4QqFYt5uxYAk1xHuQ5G1OtdfACvCLxVKMpJXokusVm0U6pLORAN9DB2Ll
 yjFW+P5nAVLUD/Jfci9P3VuKZhYDKFP+cEqWC089L3KqY6KnS6j4nDRD8r4EYDKOC/Ky
 /bFQ==
X-Gm-Message-State: AOJu0Yx04H4E7offOdVuxJANOkTR8qLTrrSKmWCWR1RCRpAW0rtOOpkR
 zFDUlq9ItdRpnlY7HK21Q6HSJlAtISstZcIQey/5l2N+sO+Rf+I/zDFKWyNby0djfFHgrXSObIs
 d9GkrNi72+KNFtJpKeK6QWqpSzkfd6DOPUMGC9A6aCJh1j9MPu1PNjIUiC2baP4myJns3
X-Received: by 2002:ac2:59d0:0:b0:507:8c55:39f9 with SMTP id
 x16-20020ac259d0000000b005078c5539f9mr4428827lfn.49.1697966802055; 
 Sun, 22 Oct 2023 02:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEczsJbN3DB/870S+/LM29GqAltHFEG8QU46SybxryOvlLYp/H90Gko5mVd62gAiZcH8I0QYw==
X-Received: by 2002:ac2:59d0:0:b0:507:8c55:39f9 with SMTP id
 x16-20020ac259d0000000b005078c5539f9mr4428813lfn.49.1697966801782; 
 Sun, 22 Oct 2023 02:26:41 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 u13-20020a05600c19cd00b004068e09a70bsm6565700wmq.31.2023.10.22.02.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:26:41 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:26:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Dave Jiang <dave.jiang@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v3 59/62] tests/acpi: Update DSDT.cxl with QTG DSM
Message-ID: <e0c72452559ea8dd723c5f13c64318cd1d1fef4c.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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


