Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B862F76F59E
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRggv-0004Ld-S8; Thu, 03 Aug 2023 18:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRggu-0004LT-Oe
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRggt-0000Qh-Af
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oU8V7VIrt8Ft51zkm09tFOBYRYyclp6SwII5cbUjg0=;
 b=Vc+OHjoknEycNElPg+L59VjVZARhhAP+Gnixfu50lMQKBko9p/Sc5ehH0PcFCBpmZAm6ob
 zKij32/RTO+5PL1kHCNp4v5GM37ShZPEvBMLUWv22etYXJIBZ5Duru4FKBHiy269yOqcSl
 dyc0n2vMMiHf2OHWGZdb1+F8xiiGh4k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-JBjHdKr0M7uNn99xvsXCiw-1; Thu, 03 Aug 2023 18:21:05 -0400
X-MC-Unique: JBjHdKr0M7uNn99xvsXCiw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b710c5677eso16121051fa.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101263; x=1691706063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/oU8V7VIrt8Ft51zkm09tFOBYRYyclp6SwII5cbUjg0=;
 b=LlzOd1u/OX9zuMB9ECqlYrVMpA00yYKjIEEmmq2uLOdEh4gZY3pc278pxMrYNC8P5u
 xk3qY4IQd9luSnMnj5hUPHTKb9tXjdDPZ67kZlBVGQMkwUtMET0tfpU7bOm7uvU4hGKT
 rPwgGcKhY/6AXjrNr2g+EFbSFPAKjXkXPYmTAqYGBxnUh63Ei/79wpCg7Og5aS9uSE7w
 3NIuqwDmX+ISijVQNPzCodq902tlywznidGMzXCTN6FK4pM+hnuFoFKzofImMKDGrRyu
 7yuLVLvvj5ggYVTsW4VB4OqgTfL8Lqo6EiSuX97rqD2Uq1crzHEzccl+jwNd6gEaRL2B
 k+Zg==
X-Gm-Message-State: AOJu0Yzq4S6Uouv8JuHODjBWo7MEeu9gBP59yFVzczoSvARo8BEo7CSd
 6WZinriH44dc/jH/8eWhac2jE1dIIH300NTs0+40VZ4LWTEEf+gYri6dAG9VE3uxpvjyrG5fcSV
 uP/xjm4y9cXtifGxPyAG3jERyLaA9sOBEQvsCiQjSR1QHbGjjniLWRbfbRM4tD8c9t1Hx
X-Received: by 2002:a2e:9bc5:0:b0:2b9:ce86:b4e7 with SMTP id
 w5-20020a2e9bc5000000b002b9ce86b4e7mr76817ljj.28.1691101263477; 
 Thu, 03 Aug 2023 15:21:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ0GMrCGj8Ye2UXnfkf6KRL0JZEMtBiz2y1cEvbkwhe+BHeHhZdFObJ2mgkvyT5PdHFHRmbQ==
X-Received: by 2002:a2e:9bc5:0:b0:2b9:ce86:b4e7 with SMTP id
 w5-20020a2e9bc5000000b002b9ce86b4e7mr76801ljj.28.1691101263075; 
 Thu, 03 Aug 2023 15:21:03 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 t6-20020a1709060c4600b0099bcb44493fsm376088ejf.147.2023.08.03.15.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:02 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:20:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 05/22] tests: acpi: x86: whitelist expected blobs
Message-ID: <45d9d318c8d435cbe2d465f61e6975885d2242ca.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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
Message-Id: <20230720133858.1974024-2-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..1983fa596b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,15 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT",
+"tests/data/acpi/pc/DSDT.acpierst",
+"tests/data/acpi/pc/DSDT.acpihmat",
+"tests/data/acpi/pc/DSDT.bridge",
+"tests/data/acpi/pc/DSDT.cphp",
+"tests/data/acpi/pc/DSDT.dimmpxm",
+"tests/data/acpi/pc/DSDT.hpbridge",
+"tests/data/acpi/pc/DSDT.ipmikcs",
+"tests/data/acpi/pc/DSDT.memhp",
+"tests/data/acpi/pc/DSDT.nohpet",
+"tests/data/acpi/pc/DSDT.numamem",
+"tests/data/acpi/pc/DSDT.roothp",
+"tests/data/acpi/q35/DSDT.bridge",
+"tests/data/acpi/q35/DSDT.multi-bridge",
-- 
MST


