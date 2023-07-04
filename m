Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05564746FDC
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 13:26:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGeAk-0001mx-Sm; Tue, 04 Jul 2023 07:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGeAd-0001mE-Cw
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGeAb-0002Bg-Vr
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688469969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=SEd3LWXJ2TRbcXIjL4ItQ96DyHz4pELBSvKselbMfyYtz0BQtnHG4WiYpyZXc1xxLskL3O
 F8Jm7HTPAJQhuzLrbJEbxq9A7iuXOzgzAe1HfNgd5ykrhdugj5HSvWLTJP69dUSh/8B1E0
 4gxcZEpZ9PJ/nsbTDP8JANLrWc5goGg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-E9bigWHLPrquSM77pWRcqg-1; Tue, 04 Jul 2023 07:26:08 -0400
X-MC-Unique: E9bigWHLPrquSM77pWRcqg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-55ac8fcc887so5665640a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 04:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688469967; x=1691061967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEZcgPReFyzDcO9cLJl1A0SSdm0joHIvq6RFVgYxRzg=;
 b=UvK5CZsWfkp01AB9QxIqGMIv7us89+gl0iwIkzujlCGX0GMzd5AgQAFsJsIbx+aKmR
 XcwpuiR3wlJ4+dsf4yjLGSsSZOoYlX2sYsOFAWRPCs9v1CgCYWjt49UcV0m+q+PieZDp
 Up9Umak4UdKClo5yylWadbkPi9iBJjN5qLJWiDcrAiD6aRc3BsW1B+ICcAz6v1VIVCCI
 QKdITfpAQoTJrq8MvuNb6TiKVn7eT6M+pq4AlpsmFbgu6z7Fmx614oDkTYSVNVOl909S
 oRcoJ4eWrpD/gu9ibjvEIoD8i9SeXJgcOP/k7jwg/FclnEK+6dmm3lOwekRi49ddKMhj
 13Ag==
X-Gm-Message-State: ABy/qLbrJsjIZyftqz7AdpdvKgpWF4Mw8+qWlpHGYUfZL5O37kj3Nqb5
 0nb5unggSNU6STYFNcnc2byDvrgccw/8Svt5pbgZ1ThcGhiFjXvE0o1dF0V1s+ZBdlj5rpf4dh8
 LzVm2lBsMniczBatLOygmbwoYpNOFOZlZnRET+Lh29n+9+aaTxhs7SJJtmvCeQ3u6UwFJ7Q1kfg
 U=
X-Received: by 2002:a17:902:ea06:b0:1b8:9b17:f63d with SMTP id
 s6-20020a170902ea0600b001b89b17f63dmr4278628plg.23.1688469966847; 
 Tue, 04 Jul 2023 04:26:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGJrKgF6k21A0KUI7xTGSiXKohqrIIpDLphcGEH6Pui76qK72oYrhrcYf4Y/IW9d74NwqSsmA==
X-Received: by 2002:a17:902:ea06:b0:1b8:9b17:f63d with SMTP id
 s6-20020a170902ea0600b001b89b17f63dmr4278606plg.23.1688469966370; 
 Tue, 04 Jul 2023 04:26:06 -0700 (PDT)
Received: from localhost.localdomain ([115.96.131.170])
 by smtp.googlemail.com with ESMTPSA id
 o7-20020a170902bcc700b001b8a897cd26sm780608pls.195.2023.07.04.04.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 04:26:06 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v7 1/6] tests/acpi: allow changes in DSDT.noacpihp table blob
Date: Tue,  4 Jul 2023 16:55:50 +0530
Message-Id: <20230704112555.5629-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230704112555.5629-1-anisinha@redhat.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

We are going to fix bio-tables-test in the next patch and hence need to
make sure the acpi tests continue to pass.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
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


