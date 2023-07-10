Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545674E1AD
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuM-0003fS-Bt; Mon, 10 Jul 2023 19:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuK-0003aY-81
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuI-0004AL-PF
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=is4JU1X/3OUSKq/URlPYqO+soLMMDT1XVm32TNN7udw=;
 b=i6UIcr4DGEvmfTPlSGGrrh/hamUA6RTquqMNh9MP1ncwpfZVWguH06AdQRcfAC4zOSzf7/
 cE6r5FRw7v7ytMn5ayKZrG5srLK//wdTJYaO2uFlK7v/TxJkhLb2bvt0v8RHKX8uYpE7Ek
 UDGA335p/gexb7vPRHy9/IhGfbU1fTw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-DMRD-kjgOz2UCqXvjxF_6A-1; Mon, 10 Jul 2023 19:03:00 -0400
X-MC-Unique: DMRD-kjgOz2UCqXvjxF_6A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbfc766a78so24382005e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030179; x=1691622179;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=is4JU1X/3OUSKq/URlPYqO+soLMMDT1XVm32TNN7udw=;
 b=VlqoHgBr6n9WK4tWFinA2k46QiClik1LB5SfIpoJ+4tyQBS+KjAZOrqNYebBeXnIU5
 l3Jwh21kZiQiA34uKPmCBjpjL3y8ZbzI9xDOI70Vboxkmikx/Pr4yhE8+tkioPQXWCs/
 ByX0YiuXhrWo5srXpsLmAQq3br9Ls8JSEXthhRewp9++cH8IKvWXVsNWcCbt5zU3godD
 szrkUlVF6TWX0UBzjt75DdYGsRt6sbWE0+ETaIkUAZU97RdJYQoJ2+BYAkJ+YFXBGzDz
 hQ+hC8YeLv5wPr+N5odZpkGhK1Vxk5vVGbX2NmVrzYEtoQoHhPVA1e0g8HNJRIPIPv7s
 pv4w==
X-Gm-Message-State: ABy/qLYB53LMtJPg7WJb+Cxvdh8eZjAYEfCXEemBCCtC+uC7radcLOas
 eWIclRaiUIVIGpdWcV+aovzjk8tWJAxlnGJqFdWv0H191SrvYApkS54MZ9LMutCo0iZvRUD9HW6
 JFLycZw8aC87678ZD4O1wPa9Ad6yDdOD88ycuDpypEFYfJNGrztUo25JgxaYC2ZjxaYvh
X-Received: by 2002:a7b:c8ca:0:b0:3fa:77ed:9894 with SMTP id
 f10-20020a7bc8ca000000b003fa77ed9894mr11222059wml.7.1689030179427; 
 Mon, 10 Jul 2023 16:02:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHxBB6CRPrxq10uB1kszRkoOc3U0Ccm3507ayOVkvU1V3FCsIHRwX4LJfQBnmGeeAfEluqYRA==
X-Received: by 2002:a7b:c8ca:0:b0:3fa:77ed:9894 with SMTP id
 f10-20020a7bc8ca000000b003fa77ed9894mr11222045wml.7.1689030179192; 
 Mon, 10 Jul 2023 16:02:59 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 13-20020a05600c228d00b003fbe4cecc3bsm11371299wmf.16.2023.07.10.16.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:02:58 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:02:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 11/66] machine: Add helpers to get cores/threads per socket
Message-ID: <a1d027be95bc375238e5b9292c6aa661a8ddef4c.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

The number of cores/threads per socket are needed for smbios, and are
also useful for other modules.

Provide the helpers to wrap the calculation of cores/threads per socket
so that we can avoid calculation errors caused by other modules miss
topology changes.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230628135437.1145805-2-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/boards.h   |  2 ++
 hw/core/machine-smp.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6b267c21ce..12d9e9d17c 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -35,6 +35,8 @@ void machine_set_cpu_numa_node(MachineState *machine,
                                Error **errp);
 void machine_parse_smp_config(MachineState *ms,
                               const SMPConfiguration *config, Error **errp);
+unsigned int machine_topo_get_cores_per_socket(const MachineState *ms);
+unsigned int machine_topo_get_threads_per_socket(const MachineState *ms);
 
 /**
  * machine_class_allow_dynamic_sysbus_dev: Add type to list of valid devices
diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 89fe0cda42..0f4d9b6f7a 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -197,3 +197,13 @@ void machine_parse_smp_config(MachineState *ms,
         return;
     }
 }
+
+unsigned int machine_topo_get_cores_per_socket(const MachineState *ms)
+{
+    return ms->smp.cores * ms->smp.clusters * ms->smp.dies;
+}
+
+unsigned int machine_topo_get_threads_per_socket(const MachineState *ms)
+{
+    return ms->smp.threads * machine_topo_get_cores_per_socket(ms);
+}
-- 
MST


