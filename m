Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC017D015F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:26:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXi8-00023y-0N; Thu, 19 Oct 2023 14:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhH-0000KV-HQ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhF-0002k6-PU
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3gMlvdquObTcfo3FR9W9RmnS7UYRddpgF0RI5ANGAvI=;
 b=In8wF5Zx2KG6ExBPbGVz/KN3CY6vwKfGWEqhsCo2gFziRKvVn15GW+jjYl5/iKxYNwLg5B
 FDTpMGKhM0ElpkDMHVMcK30mo/XRgM855BLlmsnGBW6SehopboGOVgjpVeAlBV17wGLnFj
 3f8Ll8A9T9hFOhlAImnb2VR8MKIRkKw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-lAflrJ6LPXuw3PO23-cUlg-1; Thu, 19 Oct 2023 14:24:35 -0400
X-MC-Unique: lAflrJ6LPXuw3PO23-cUlg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32db9cd71d7so14853f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739874; x=1698344674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gMlvdquObTcfo3FR9W9RmnS7UYRddpgF0RI5ANGAvI=;
 b=b0VBcBRXo5uTO2rO1x5HP0E/x9Z2f8C/lSUqdl23yhGn1FSb+nLYiMnJTAK0uYP3iO
 1725AcwbwYN9HmITTXoqxlRoNVTi6SwRZ7ipgwiwFEE8rTNC1plC/pEL/XZwJubrPUOy
 QSrS6dVk7W5IRFaITIhaAKPyHFc//eaxD8GKNzvgm36IwB5o6nhji8Ud/Yik86EwOn8K
 jOsR+11C02KMQ/15IwiVnBW4xOSz3lp+Mjvlnlb0s/i4TEwXY5aDvbalPALLxQLTQGnb
 jmD5Lgd3nFcYMOAVD7PMhi4NgAVrYbeeNe/WT3mG4cRibYoutcnUNPUzJTiL4eMjUeQu
 mUfw==
X-Gm-Message-State: AOJu0YzmV8Ve/7PJjzXoWdpmiGZbB8VpXeoJ7N7mQGH6WKlcrzNnJOeR
 VhZCRrKdbI62I4RpnFK+TuJ9/syZ/RKWECC09klOEHkul9Wpt4H59yLsz9AexQi9pP1isNh/k3t
 W/StCVu0J6lPZMoC7TE0FPkMcN4PPP78ZZ35vBGPV75u7WWNIAbwLSHGVogHLkOUvm5FI
X-Received: by 2002:a05:6000:1b05:b0:313:f75b:c552 with SMTP id
 f5-20020a0560001b0500b00313f75bc552mr2474734wrz.15.1697739873917; 
 Thu, 19 Oct 2023 11:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO/ZKkzhX7ptlpKDLUMQ6N6e21F/4v1jTTn9fOdqOZ6lPd3v1XV4/9Hq+TzNmJGB9O54kpkQ==
X-Received: by 2002:a05:6000:1b05:b0:313:f75b:c552 with SMTP id
 f5-20020a0560001b0500b00313f75bc552mr2474717wrz.15.1697739873652; 
 Thu, 19 Oct 2023 11:24:33 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adff841000000b003253523d767sm5001411wrq.109.2023.10.19.11.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:24:32 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:24:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Dave Jiang <dave.jiang@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 75/78] tests/acpi: Update DSDT.cxl with QTG DSM
Message-ID: <9a5c9dd5dd24e58454825594545c731d1c66a8c1.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


