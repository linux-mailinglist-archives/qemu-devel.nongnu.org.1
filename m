Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA28D7CE1FB
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:00:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8xk-00037y-9u; Wed, 18 Oct 2023 12:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xR-0002QW-S5
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xQ-0007ma-EN
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YGr1H8ijLV736mqcmWstFWaefAIRGO/VVLKqx2ky5/4=;
 b=fFVaxE3NORuikTp3pq+eUZQzoXme4hXSpnaEHeq9BADSi2VYYCDfoXj5GIMxmraN6V9kSz
 /MB1jSnGU6OHq9a0h70kwPevV6DcvPlnFHHXcSalhuq+HweCwOkBXbKdn3h5h8xa1aCtf/
 g+sQwxWc8xNN4kgY5oi6qGH1N5rs1UM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-EvZX0OmGPx-tPmVVReQncQ-1; Wed, 18 Oct 2023 11:59:36 -0400
X-MC-Unique: EvZX0OmGPx-tPmVVReQncQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso49857435e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644774; x=1698249574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGr1H8ijLV736mqcmWstFWaefAIRGO/VVLKqx2ky5/4=;
 b=WqxixV0f3m1tj/FHWfD5vHv9cBIAHzyGcluTwaAsuTh2j4zFq5xgqTl4SVyaQYQlNW
 0WJiJbTSjdFSAAm5Hk6wpwBfnbn5nNrdQBOCG5D5xD6I1fvqhhHIy2mHjMf2mQMu5KJg
 hl/ePg/mUIkZ0M1bOIdCP3atn2lP4FODvtuVv5OFO6sxovuGZPDllkOIE8vcugrd6rta
 PBu3nd7oG/5OdIiw8bpSrAZ9Xo1TypNXnRFtHwPyhubfhxBFtOp9/GQffo/4kacbIwQW
 0Ejh+Ql3bFu06lLhqOPMWid388K889DGLhG5zQmmIxv3a6tfgBwvtPrYquyd1UweBZ5L
 7ZsQ==
X-Gm-Message-State: AOJu0Yx5bWM8M01xIYxpt0g2LPGZfgAHDDE57lBMsiBcFcTudNkPHA1Z
 JajL6zDR2OLXqzNYkVWex8LZ3tcVG37EdiwDqATFUeJtxx7jwyjaMcTlMr9FNv3r3eUT5QICUer
 AtS8I/x0WZ8lDhmLtVWscDMOESqvMd52Cr3gjq84ukXpPLyVXnvbAcYTkdu+IUYQ3vYODl3o=
X-Received: by 2002:adf:ef05:0:b0:31f:8999:c409 with SMTP id
 e5-20020adfef05000000b0031f8999c409mr4565556wro.66.1697644774419; 
 Wed, 18 Oct 2023 08:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGftO7mDq8bIiDJLKH2MjBnOg2PjUxh2ikE4qGIBXgTr+U4OyW6j0kxeVJ/68O9fWY9UaB1Ew==
X-Received: by 2002:adf:ef05:0:b0:31f:8999:c409 with SMTP id
 e5-20020adfef05000000b0031f8999c409mr4565543wro.66.1697644774139; 
 Wed, 18 Oct 2023 08:59:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a5d66c1000000b0032dbf99bf4fsm2384768wrw.89.2023.10.18.08.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:59:33 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:59:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Dave Jiang <dave.jiang@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 78/83] tests/acpi: Allow update of DSDT.cxl
Message-ID: <c8c56b6a8baa3ccce56e7a0f76c365598f1f3b67.1697644299.git.mst@redhat.com>
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


