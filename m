Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F9B783FE8
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 13:47:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYPp1-0003WV-O6; Tue, 22 Aug 2023 07:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYPoy-0003Vf-I9
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYPow-0006VI-2o
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692704712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QbgWS0ByGAn+OLBHHOL0bCJwsL+Zzge/uNa69WBgcV0=;
 b=U4rm4t2OD1ngbwKUhDvVK7Bp05fbUX/wwOHmHWVwBNp6NBw/DhtCmSu5w+dbRNgrSqbQ8V
 jAny3/ocUl+WnAuglymR5ceDktg78Cn0+dCHuLVbzsvaJ6dJACN6p5iJN/zeKj54JfJNN3
 owTEz9OEdK8cS6t3FJEALgDk6MPt+Q0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-0XkFPZY_NRe3FtHVX25_Xg-1; Tue, 22 Aug 2023 07:45:08 -0400
X-MC-Unique: 0XkFPZY_NRe3FtHVX25_Xg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1429585C70B;
 Tue, 22 Aug 2023 11:45:08 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BB184A9005;
 Tue, 22 Aug 2023 11:45:05 +0000 (UTC)
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
Subject: [PATCH v2 0/9] memory-backend-file related improvements and VM
 templating support
Date: Tue, 22 Aug 2023 13:44:48 +0200
Message-ID: <20230822114504.239505-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

This is the result of the previous discussion of:
* "[PATCH v2] softmmu/physmem: try opening file readonly before failure
   in file_ram_open" [1]
* "[PATCH v1 0/3] softmmu/physmem: file_ram_open() readonly
   improvements" [2]

After looking into various ways to avoid a new parameter for
memory-backend-file to cleanly support VM templating with R/O files, I
concluded that it might be easier and cleaner to hust have a new parameter.
The alternatives all had their own problems.

Looking back, we could have designed the "readonly=on/off" parameter
slightly differently.

So this series adds a new "rom=on/off/auto" option and wires it up
internally. It uses new internal RAM flags to improve qemu_ram_remap() and
ram_block_discard_range().

Further, improve file_ram_open() with readonly=on and update+add some
documentation.

While working on this and testing some configurations, I realized that
an NVDIMM with label data on ROM does not work as expected (QEMU crashes).
Fix included as patch #1.

No changelog, because too much changed.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Thiner Logoer <logoerthiner1@163.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: Jagannathan Raman <jag.raman@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>

[1] https://lkml.kernel.org/r/20230726145912.88545-1-logoerthiner1@163.com
[2] https://lkml.kernel.org/r/20230807190736.572665-1-david@redhat.com

David Hildenbrand (9):
  nvdimm: Reject writing label data to ROM instead of crashing QEMU
  softmmu/physmem: Distinguish between file access mode and mmap
    protection
  backends/hostmem-file: Add "rom" property to support VM templating
    with R/O files
  softmmu/physmem: Remap with proper protection in qemu_ram_remap()
  softmmu/physmem: Bail out early in ram_block_discard_range() with
    readonly files
  softmmu/physmem: Fail creation of new files in file_ram_open() with
    readonly=true
  softmmu/physmem: Never return directories from file_ram_open()
  docs: Don't mention "-mem-path" in multi-process.rst
  docs: Start documenting VM templating

 backends/hostmem-file.c      |  61 +++++++++++++++++++-
 docs/devel/multi-process.rst |   5 +-
 docs/vm-templating.txt       | 109 +++++++++++++++++++++++++++++++++++
 hw/acpi/nvdimm.c             |  11 +++-
 hw/mem/nvdimm.c              |  10 +++-
 hw/ppc/spapr_nvdimm.c        |   3 +-
 include/exec/memory.h        |  14 +++--
 include/exec/ram_addr.h      |   8 +--
 include/hw/mem/nvdimm.h      |   6 ++
 qapi/qom.json                |   6 +-
 qemu-options.hx              |  10 +++-
 softmmu/memory.c             |   8 +--
 softmmu/physmem.c            |  74 +++++++++++++++++-------
 13 files changed, 279 insertions(+), 46 deletions(-)
 create mode 100644 docs/vm-templating.txt

-- 
2.41.0


