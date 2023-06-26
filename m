Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F5973E092
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:24:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNo-0006Tb-P2; Mon, 26 Jun 2023 08:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlME-0004ab-6s
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMC-0003TU-2m
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XW1yczzSwWWDigtQnZw3yk+r1NAQ2QkzD7hi2j1+cLQ=;
 b=M2VT5yBjKi/VUW0obXBaGqwP4XNIbCihd7NOXedyvUja8findWwiBhgKYmT1cqvfXkqPBG
 0pXRuikUuY4eSC3yLjcYH20ax4QZUd8uNNVtpozplBYd9OPzn/+RiASK2IxbpUZ6PysZ5r
 MCPBH8RCYvmZCnE6OQXMvo7eCTV3gSE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-_oQwmYOCO8KnnRMiZ3GEqQ-1; Mon, 26 Jun 2023 08:30:09 -0400
X-MC-Unique: _oQwmYOCO8KnnRMiZ3GEqQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-313f5021d9bso248002f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782608; x=1690374608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XW1yczzSwWWDigtQnZw3yk+r1NAQ2QkzD7hi2j1+cLQ=;
 b=BPiy57+I9rW1GKW+SoiEi7J+VuJrQboOPYf32u+C9XSbexK13ZY1ORGx1RzGmDyfne
 J049U/TgGmLFZrSnr9CwxRR7CSLjNzP4QoRYThfHlQHthBXJiinaaa2j8Iw7yBsCpxPz
 ELiRvyxG7kMevGoI7KdrDX9QbvQNLXglGAM7lxqf9dRtO0kFk2I4mgZBrGYFsRkq75Jn
 Z6FAQZqWnOWofutOfslLVDgtPBX/ulso7v9F6qjMwTTSIY3KAlYesfhjf2zDzh9nHPZ+
 QsM/EBWZLgGlTVcS3pTk266oVl5Ehz+cxh4DF8FsU5EjkXZutyUzE64mslS0qQM4hvPZ
 F+cQ==
X-Gm-Message-State: AC+VfDwuQiQfnzd6IBypS34SAPzFVriIG2DXSlkZjWYtH6LTMF/Gubop
 FXNhFMlzKpLTuLfbti3oISB14Aa3IkIB8CBTV3ZjXzrJc2/+xRZEGPW36+wnrqm/1UViHs6KB/s
 Fv9EXU+TeACF0NIJySb42h+hdCTgbf0iaQ6qOl1Fo+3wVAl17jhYKW7r1JKIkbItqSSSB
X-Received: by 2002:a5d:4e8f:0:b0:30f:bf2e:4b99 with SMTP id
 e15-20020a5d4e8f000000b0030fbf2e4b99mr19622262wru.49.1687782608199; 
 Mon, 26 Jun 2023 05:30:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7RxNIEGTQPzDRapji3CzDC5tYJysZNShIucZQPbUk8fY2ypND2DMAknnwsWZp/Fm4kesVT9Q==
X-Received: by 2002:a5d:4e8f:0:b0:30f:bf2e:4b99 with SMTP id
 e15-20020a5d4e8f000000b0030fbf2e4b99mr19622241wru.49.1687782607890; 
 Mon, 26 Jun 2023 05:30:07 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 z3-20020a5d4d03000000b0030aec5e020fsm7224686wrt.86.2023.06.26.05.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:30:07 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:30:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 46/53] hw/i386/pc: Clean up pc_machine_initfn
Message-ID: <b7a738e59121b0e98bba00bbe60273a431d26977.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To use the newly introduced PC machine class local variable.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-Id: <20230609164107.23404-1-suravee.suthikulpanit@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8d37567e08..f01d7de5ad 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1867,7 +1867,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
 
     /* acpi build is enabled by default if machine supports it */
-    pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
+    pcms->acpi_build_enabled = pcmc->has_acpi_build;
     pcms->smbus_enabled = true;
     pcms->sata_enabled = true;
     pcms->i8042_enabled = true;
-- 
MST


