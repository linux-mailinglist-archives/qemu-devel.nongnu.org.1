Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 392B17B9A6C
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFIH-0007CH-77; Wed, 04 Oct 2023 23:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFI8-0006sf-7L
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFI6-0000Kh-LZ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SD/pP7NiyThvBXd+OfzcmY5b45I6wA7NnZdpFrf/vjg=;
 b=isam87ojbgXI1iwQi8t9dAeWvlnROK7VGvZ1yCbFOgdi0Cg5wAAJ/p539aganxSC+f1TlF
 UmiszRBFbbeNDvm54cCvT4WulYvkEkTR6CJmz0pR7ijEeFs9HjjQO54qqiOwB/DMF9m1U6
 CUXYqUQcqovVkEbxTWi98Bwfp/K21Xo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-hpzSny24MHSLgj612s5KBQ-1; Wed, 04 Oct 2023 23:44:34 -0400
X-MC-Unique: hpzSny24MHSLgj612s5KBQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so3636645e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477472; x=1697082272;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SD/pP7NiyThvBXd+OfzcmY5b45I6wA7NnZdpFrf/vjg=;
 b=FGdrXi1NHDV7mudPEhgLHuDlKo0cFGfYh6DUXg/Rou1n4zb6B77gye+oOaBa142GBe
 bzgrLXt9kxuGhLsnvLk/97B5a0BUn0ezwAsdWHNR5voRNcrFZUXCE/mtbMll1IwrqZwk
 yIs71iD/BasceOy1Wh6+L7XEr/b5CGnGahXT1RXgfq9ymUOsj9DwzamJACj8c23a2mhZ
 SOVHghngsAKtRwOtfLMoxd3ytWi/9dvlwRF0LLtz1CvAHTDr4aNNVWrMJSubFaVCqjzq
 TwCqBr2Ghjqg10lkBaMPG3HsIGRqBC2AMtTFgSIcyT2AOEqu30rKIb0ydTCRl0aVIGxa
 KD3w==
X-Gm-Message-State: AOJu0YxdG86UgWPs0DM+QKOEDip2oAuGOp2N1q7Ko9cH+hkR8mvLFeZl
 UeipSNNhQ3UZIViO2+QLRdpfsovtNKAAANNOnxT6U8fXiOS63y7uWn+1ZbyNLwVJQKZaAiHFqMT
 DCNLv2Z5202MfIJa+K37QojQmrh3qEO0Ez8QpOoOxXVWxcmX5gz8jiYIjcCM9GRXtYTB1
X-Received: by 2002:a7b:cd98:0:b0:405:1ba2:4fcb with SMTP id
 y24-20020a7bcd98000000b004051ba24fcbmr3934735wmj.16.1696477472809; 
 Wed, 04 Oct 2023 20:44:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoOsNYc3LEDhHsuD0fIMd/D5T6mh6IenAhcuvT2559mWYWrtyyD1+MRJxaNZWUs6Z7mJoUFA==
X-Received: by 2002:a7b:cd98:0:b0:405:1ba2:4fcb with SMTP id
 y24-20020a7bcd98000000b004051ba24fcbmr3934717wmj.16.1696477472388; 
 Wed, 04 Oct 2023 20:44:32 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 k22-20020a7bc416000000b00404719b05b5sm537774wmi.27.2023.10.04.20.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:44:31 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v2 30/53] hw/i386/acpi-build: Determine SMI command port just
 once
Message-ID: <5cdb639d25f9951a90b6b7ba31d376d8ab132a61.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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

From: Bernhard Beschow <shentey@gmail.com>

The SMI command port is currently hardcoded by means of the ACPI_PORT_SMI_CMD
macro. This hardcoding is Intel specific and doesn't match VIA, for example.
There is already the AcpiFadtData::smi_cmd attribute which is used when building
the FADT. Let's also use it when building the DSDT which confines SMI command
port determination to just one place. This allows it to become a property later,
thus resolving the Intel assumption.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230908084234.17642-7-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 76581d51aa..863a939210 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1495,14 +1495,14 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(crs,
                 aml_io(
                        AML_DECODE16,
-                       ACPI_PORT_SMI_CMD,
-                       ACPI_PORT_SMI_CMD,
+                       pm->fadt.smi_cmd,
+                       pm->fadt.smi_cmd,
                        1,
                        2)
             );
             aml_append(dev, aml_name_decl("_CRS", crs));
             aml_append(dev, aml_operation_region("SMIR", AML_SYSTEM_IO,
-                aml_int(ACPI_PORT_SMI_CMD), 2));
+                aml_int(pm->fadt.smi_cmd), 2));
             field = aml_field("SMIR", AML_BYTE_ACC, AML_NOLOCK,
                               AML_WRITE_AS_ZEROS);
             aml_append(field, aml_named_field("SMIC", 8));
-- 
MST


