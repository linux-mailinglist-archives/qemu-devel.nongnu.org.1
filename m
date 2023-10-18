Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 886F47CE274
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:12:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8sZ-0001KA-Tg; Wed, 18 Oct 2023 11:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sX-00018N-TQ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sW-0006Th-B6
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2FZerVplP7gF2hzMNBoK9F/KJJRCWXJvDhhnD1MB+o4=;
 b=gcavAWjnhpf8q6zNegCd42/JFDOITRHC5iFOzMqbjSpW3beebbfrJfXs3sfqI9MWNDIQ0m
 xLuaDqXy7P7+9c9CdPqEHVvqAem2Bj72zJ6h4+eZNZ4dtddhyNzxX1oP8hy3n1vcfiKG8s
 VM6K6o1/ygtC+KAAeUu0nZayPcgMzek=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-mT8JcWc0PP-zxQST3Q7WQg-1; Wed, 18 Oct 2023 11:54:33 -0400
X-MC-Unique: mT8JcWc0PP-zxQST3Q7WQg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32db43129c6so2127029f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644471; x=1698249271;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2FZerVplP7gF2hzMNBoK9F/KJJRCWXJvDhhnD1MB+o4=;
 b=FX5D+3pEbt07sReJe1vzKVypwnMAiPvph11/b7Aaq/A3JVbmmjHYDEQwig6xOrU9BZ
 Rx+HlAO/zyXMvatNKFTEf42dc5BiHA6bGvn/uelWa61Oz0+SS7cH1GPzauEOi5WPFgmx
 vhMU11KsdprUFpnXGz9jSXKGE14bsNTq6u1MBbIaB00jcyHMzomRSzTCtUa2afg0N/vO
 z/vxXe4MBB0obCVJj0h9M1rFWcY0bWCyciJ3h5iJ6qAWXMxgIw9CQ3rUQlQCVY/+Wij/
 VyWhExOYupeZlGy3+BJ2N+4h0JSc4oawcpWw3e8D0clmB8Tp2GlBhb2sEH6MYGsfYfmE
 479g==
X-Gm-Message-State: AOJu0YxP7JQ3+tVyCl4nkpWgNSA7V4Sf0S7GthGhV32bl9iaC4ohD5oQ
 DdJw402+TRWwcQoLmYkGqTj4t/PqTbeOzZmDkhhROZFSdsWKZFNX/lvCRLVPIF0cZn43ma9FLFV
 8rlpVBEFFvLm2u/zAIAKj0caGQy3/lxKQCox5RWADoIi2LkI+S3H3L9K1+BPaso39Md2OK0o=
X-Received: by 2002:a5d:4390:0:b0:32d:857c:d546 with SMTP id
 i16-20020a5d4390000000b0032d857cd546mr4683009wrq.64.1697644471747; 
 Wed, 18 Oct 2023 08:54:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW/p2zYE9RznmzeGGNWUqxfAel3ynd4jzso9lHf9ymaLOvcjkt+EwoGjPh03Dz0yDw6+k2MA==
X-Received: by 2002:a5d:4390:0:b0:32d:857c:d546 with SMTP id
 i16-20020a5d4390000000b0032d857cd546mr4682994wrq.64.1697644471268; 
 Wed, 18 Oct 2023 08:54:31 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 x8-20020adfec08000000b00326f0ca3566sm2392180wrn.50.2023.10.18.08.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:54:30 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:54:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 17/83] tests: bios-tables-test: Prepare the ACPI table change
 for smbios type4 core count test
Message-ID: <7b2522a83f744f8fbadfa03c05c2076b5d12535c.1697644299.git.mst@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

Following the guidelines in tests/qtest/bios-tables-test.c, this
is step 1 - 3.

List the ACPI tables that will be added to test the type 4 core count
field.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230928125943.1816922-6-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 tests/data/acpi/q35/APIC.core-count         | 0
 tests/data/acpi/q35/DSDT.core-count         | 0
 tests/data/acpi/q35/FACP.core-count         | 0
 4 files changed, 3 insertions(+)
 create mode 100644 tests/data/acpi/q35/APIC.core-count
 create mode 100644 tests/data/acpi/q35/DSDT.core-count
 create mode 100644 tests/data/acpi/q35/FACP.core-count

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..b9bc196130 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/APIC.core-count",
+"tests/data/acpi/q35/DSDT.core-count",
+"tests/data/acpi/q35/FACP.core-count",
diff --git a/tests/data/acpi/q35/APIC.core-count b/tests/data/acpi/q35/APIC.core-count
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/DSDT.core-count b/tests/data/acpi/q35/DSDT.core-count
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/FACP.core-count b/tests/data/acpi/q35/FACP.core-count
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


