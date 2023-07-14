Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E02C9752F5D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 04:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK8Tf-0005Ur-H2; Thu, 13 Jul 2023 22:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qK8Td-0005UC-At
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 22:24:13 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qK8Tb-0000Dw-KR
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 22:24:13 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fb7373dd35so3281072e87.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 19:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689301449; x=1691893449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWHldrozDftZKiaSVtQteang63AH6dHfHZTI7AOgVLk=;
 b=IdIdOA/o7aL5Cl/8YRZBrFm7gKTy3CwWC6k56Ba80VnJ+CBko8aG+v4WlsRk/24sai
 UAEdM6UOgn8P0XaXuEwb8mEkUTqzCfke2AFtY2OwPdjLWlalTXfnVLeC6eEExps2MEk0
 FRmZJOamc+HnO9DxDgg3Qh+XPvJYS8iAdoDDOsnvRgRf8WAAZfRut15tLeGgIt+YDLpm
 1OxjWOAJEUKpJClRcr5jUOOeVV+eLqb8S3zcpdBgf28hgHCBbccRIh6fj4SNoujZ7usl
 siAFa6IshDve9hrfXyDHg3zsyQdWpbbQ+huoWWC6fk9hqS5+C4x9qWbyGH8TL0qbqsIq
 5kOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689301449; x=1691893449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWHldrozDftZKiaSVtQteang63AH6dHfHZTI7AOgVLk=;
 b=AbZdVCUjIz9UNkUpKftKOItt3vLbe7MWbmdO5cnHaWLPVYXUAXHlJRe7cuqp2USfiF
 LEbB0jQbGEPsM1J96IVwicRms8QBd2euC2LVRRixRG11Vy6acV9H/GpWRKZdVlPY/2bw
 z7jAB29T5CLOSUB5/y+AZzfIEz6cyAGzaR8IfXN6nP0EmTYS+jtHv8YDJOfGdDUoGOkM
 vg/zruObBRgGPHQhk4yJf+RfZHvuHzuWTJTTh/ylYSTHZ7w3x5OzvaO7H4u5tl8wcpAw
 m3prykQAhaUn4MMF6FG22q1ba9qAHPlYMHWORva19Zr3cymA4tRz57+piHPisMx4YYL/
 rMgA==
X-Gm-Message-State: ABy/qLag7Z21+22of0g987QHA4esE7sccm7WL+X1JlSBiNlQlucStrfG
 dQDrgrfmqv5kj2TO0gnftehYww==
X-Google-Smtp-Source: APBJJlE8OIFKpn2tbwD/BV2Y9t8vKcq8cDMQUHG8DoPo5JY6r8K+RkUOf2XL+3Iu76rDix9DbEyH5A==
X-Received: by 2002:ac2:4c86:0:b0:4f8:52a8:d123 with SMTP id
 d6-20020ac24c86000000b004f852a8d123mr420313lfl.12.1689301449663; 
 Thu, 13 Jul 2023 19:24:09 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 r24-20020ac24d18000000b004fbe2172f7csm1294765lfi.49.2023.07.13.19.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 19:24:09 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v4 5/6] qmp: Added new command to retrieve eBPF blob.
Date: Fri, 14 Jul 2023 05:23:57 +0300
Message-Id: <20230714022358.2438995-6-andrew@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714022358.2438995-1-andrew@daynix.com>
References: <20230714022358.2438995-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::133;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Added command "request-ebpf". This command returns
eBPF program encoded base64. The program taken from the
skeleton and essentially is an ELF object that can be
loaded in the future with libbpf.

The reason to use the command to provide the eBPF object
instead of a separate artifact was to avoid issues related
to finding the eBPF itself. As the eBPF maps/program should
correspond to QEMU, the eBPF cant be used from different
QEMU build.
The first solution was a helper that comes with QEMU
and loads appropriate eBPF objects. And the issue is
to find a proper helper if the system has several
different QEMUs installed and/or built from the source,
which helpers may not be compatible.
Another issue is QEMU updating while there is a running
QEMU instance. With an updated helper, it may not be
possible to hotplug virtio-net device to the already
running QEMU. Overall, requesting the eBPF object from
QEMU itself solves possible failures with very little effort.

Links:
[PATCH 3/5] qmp: Added the helper stamp check.
https://lore.kernel.org/all/20230219162100.174318-4-andrew@daynix.com/

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 qapi/ebpf.json        | 58 +++++++++++++++++++++++++++++++++++++++++++
 qapi/meson.build      |  1 +
 qapi/qapi-schema.json |  1 +
 3 files changed, 60 insertions(+)
 create mode 100644 qapi/ebpf.json

diff --git a/qapi/ebpf.json b/qapi/ebpf.json
new file mode 100644
index 0000000000..3237da69a7
--- /dev/null
+++ b/qapi/ebpf.json
@@ -0,0 +1,58 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+##
+# = eBPF Objects
+##
+
+{ 'include': 'common.json' }
+
+##
+# @EbpfObject:
+#
+# Structure that holds eBPF ELF object encoded in base64.
+#
+# Since: 8.3
+#
+##
+{ 'struct': 'EbpfObject',
+  'data': {'object': 'str'},
+  'if': 'CONFIG_EBPF' }
+
+##
+# @EbpfProgramID:
+#
+# The eBPF programs that can be gotten with request-ebpf.
+#
+# @rss: Receive side scaling, technology that allows steering traffic
+# between queues by calculation hash. Users may set up indirection table
+# and hash/packet types configurations. Used with virtio-net.
+#
+# Since: 8.3
+##
+{ 'enum': 'EbpfProgramID',
+  'if': 'CONFIG_EBPF',
+  'data': [ { 'name': 'rss' } ] }
+
+##
+# @request-ebpf:
+#
+# Returns eBPF object that can be loaded with libbpf.
+# Management applications (g.e. libvirt) may load it and pass file
+# descriptors to QEMU. Which allows running QEMU without BPF capabilities.
+# It's crucial that eBPF program/map is compatible with QEMU, so it's
+# provided through QMP.
+#
+# Returns: RSS eBPF object encoded in base64.
+#
+# Since: 8.3
+#
+##
+{ 'command': 'request-ebpf',
+  'data': { 'id': 'EbpfProgramID' },
+  'returns': 'EbpfObject',
+  'if': 'CONFIG_EBPF' }
+
diff --git a/qapi/meson.build b/qapi/meson.build
index 60a668b343..90047dae1c 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -33,6 +33,7 @@ qapi_all_modules = [
   'crypto',
   'cxl',
   'dump',
+  'ebpf',
   'error',
   'introspect',
   'job',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 6594afba31..2c82a49bae 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -53,6 +53,7 @@
 { 'include': 'char.json' }
 { 'include': 'dump.json' }
 { 'include': 'net.json' }
+{ 'include': 'ebpf.json' }
 { 'include': 'rdma.json' }
 { 'include': 'rocker.json' }
 { 'include': 'tpm.json' }
-- 
2.40.1


