Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50252785C32
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 17:35:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYptB-0002fl-94; Wed, 23 Aug 2023 11:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYpsf-0001yo-NW
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYpsd-0008Ad-AC
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692804886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRwjrEQkp0ocMUr/NIyYCppb9dEB4o9Kris2ocNIc0c=;
 b=DtF2Il9Zsv1qFj2IeghOnGw7AD4CUSAnedqNqyeqzPc34m9mklzzOAWfzUmv7kunYHGT59
 BhxQcSMjMabaP9PZ2YcH59So6Scy5hc42MCtamEDQPMrF4VxQu2v526BLj4D7OIHB2eJrI
 QhJcFDN4MrZX2BWEY/S6H/f4AD9EyCo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-835CFNDpOQe6yOntVye4Tw-1; Wed, 23 Aug 2023 11:34:44 -0400
X-MC-Unique: 835CFNDpOQe6yOntVye4Tw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4219D1C09A47;
 Wed, 23 Aug 2023 15:34:43 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 801231121315;
 Wed, 23 Aug 2023 15:34:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 09/11] docs: Start documenting VM templating
Date: Wed, 23 Aug 2023 17:34:09 +0200
Message-ID: <20230823153412.832081-10-david@redhat.com>
In-Reply-To: <20230823153412.832081-1-david@redhat.com>
References: <20230823153412.832081-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Let's add some details about VM templating, focusing on the VM memory
configuration only.

There is much more to VM templating (VM state? block devices?), but I leave
that as future work.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS                   |   1 +
 docs/system/index.rst         |   1 +
 docs/system/vm-templating.rst | 125 ++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 docs/system/vm-templating.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 6111b6b4d9..096acb71a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2954,6 +2954,7 @@ M: Igor Mammedov <imammedo@redhat.com>
 S: Maintained
 F: backends/hostmem*.c
 F: include/sysemu/hostmem.h
+F: docs/system/vm-templating.rst
 T: git https://gitlab.com/ehabkost/qemu.git machine-next
 
 Cryptodev Backends
diff --git a/docs/system/index.rst b/docs/system/index.rst
index 3605bbe1ce..28abcf2b17 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -38,3 +38,4 @@ or Hypervisor.Framework.
    security
    multi-process
    confidential-guest-support
+   vm-templating
diff --git a/docs/system/vm-templating.rst b/docs/system/vm-templating.rst
new file mode 100644
index 0000000000..28905a1eeb
--- /dev/null
+++ b/docs/system/vm-templating.rst
@@ -0,0 +1,125 @@
+QEMU VM templating
+==================
+
+This document explains how to use VM templating in QEMU.
+
+For now, the focus is on VM memory aspects, and not about how to save and
+restore other VM state (i.e., migrate-to-file with ``x-ignore-shared``).
+
+Overview
+--------
+
+With VM templating, a single template VM serves as the starting point for
+new VMs. This allows for fast and efficient replication of VMs, resulting
+in fast startup times and reduced memory consumption.
+
+Conceptually, the VM state is frozen, to then be used as a basis for new
+VMs. The Copy-On-Write mechanism in the operating systems makes sure that
+new VMs are able to read template VM memory; however, any modifications
+stay private and don't modify the original template VM or any other
+created VM.
+
+!!! Security Alert !!!
+----------------------
+
+When effectively cloning VMs by VM templating, hardware identifiers
+(such as UUIDs and NIC MAC addresses), and similar data in the guest OS
+(such as machine IDs, SSH keys, certificates) that are supposed to be
+*unique* are no longer unique, which can be a security concern.
+
+Please be aware of these implications and how to mitigate them for your
+use case, which might involve vmgenid, hot(un)plug of NIC, etc..
+
+Memory configuration
+--------------------
+
+In order to create the template VM, we have to make sure that VM memory
+ends up in a file, from where it can be reused for the new VMs:
+
+Supply VM RAM via memory-backend-file, with ``share=on`` (modifications go
+to the file) and ``readonly=off`` (open the file writable). Note that
+``readonly=off`` is implicit.
+
+In the following command-line example, a 2GB VM is created, whereby VM RAM
+is to be stored in the ``template`` file.
+
+.. parsed-literal::
+
+    |qemu_system| [...] -m 2g \\
+        -object memory-backend-file,id=pc.ram,mem-path=template,size=2g,share=on,... \\
+        -machine q35,memory-backend=pc.ram
+
+If multiple memory backends are used (vNUMA, DIMMs), configure all
+memory backends accordingly.
+
+Once the VM is in the desired state, stop the VM and save other VM state,
+leaving the current state of VM RAM reside in the file.
+
+In order to have a new VM be based on a template VM, we have to
+configure VM RAM to be based on a template VM RAM file; however, the VM
+should not be able to modify file content.
+
+Supply VM RAM via memory-backend-file, with ``share=off`` (modifications
+stay private), ``readonly=on`` (open the file readonly) and ``rom=off``
+(don't make the memory readonly for the VM). Note that ``share=off`` is
+implicit and that other VM state has to be restored separately.
+
+In the following command-line example, a 2GB VM is created based on the
+existing 2GB file ``template``.
+
+.. parsed-literal::
+
+    |qemu_system| [...] -m 2g \\
+        -object memory-backend-file,id=pc.ram,mem-path=template,size=2g,readonly=on,rom=off,... \\
+        -machine q35,memory-backend=pc.ram
+
+If multiple memory backends are used (vNUMA, DIMMs), configure all
+memory backends accordingly.
+
+Note that ``-mem-path`` cannot be used for VM templating when creating the
+template VM or when starting new VMs based on a template VM.
+
+Incompatible features
+---------------------
+
+Some features are incompatible with VM templating, as the underlying file
+cannot be modified to discard VM RAM, or to actually share memory with
+another process.
+
+vhost-user and multi-process QEMU
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+vhost-user and multi-process QEMU are incompatible with VM templating.
+These technologies rely on shared memory, however, the template VMs
+don't actually share memory (``share=off``), even though they are
+file-based.
+
+virtio-balloon
+~~~~~~~~~~~~~~
+
+virtio-balloon inflation and "free page reporting" cannot discard VM RAM
+and will repeatedly report errors. While virtio-balloon can be used
+for template VMs (e.g., report VM RAM stats), "free page reporting"
+should be disabled and the balloon should not be inflated.
+
+virtio-mem
+~~~~~~~~~~
+
+virtio-mem cannot discard VM RAM that is managed by the virtio-mem
+device. virtio-mem will fail early when realizing the device. To use
+VM templating with virtio-mem, either hotplug virtio-mem devices to the
+new VM, or don't supply any memory to the template VM using virtio-mem
+(requested-size=0), not using a template VM file as memory backend for the
+virtio-mem device.
+
+VM migration
+~~~~~~~~~~~~
+
+For VM migration, "x-release-ram" similarly relies on discarding of VM
+RAM on the migration source to free up migrated RAM, and will
+repeatedly report errors.
+
+Postcopy live migration fails discarding VM RAM on the migration
+destination early and refuses to activate postcopy live migration. Note
+that postcopy live migration usually only works on selected filesystems
+(shmem/tmpfs, hugetlbfs) either way.
-- 
2.41.0


