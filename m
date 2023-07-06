Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C1C749534
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 08:02:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHI3O-0004Sk-G7; Thu, 06 Jul 2023 02:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1qHI3H-0004SJ-Ls
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 02:01:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1qHI3G-0001h4-0W
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 02:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688623272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ube1y7JOBK0sYBUge2MjDkyKJYg7nc/dcuBp4XK4m2M=;
 b=QPC7jsYVsG5eOBRsz1vC2MibTOLQV5DaF4L281RkRgCpqA91CHaEt2jLr5YY+MLJwHWBKk
 i6I/UFdltB8s1ae8DRLrgu2LhcekLAUWUWy+4uivOXF7R1kCPT/dPXijDWPjMdxtpKRGPN
 dATmNh0YfIp8aOfop7QVQrxzClPt4SA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-U5M4XtxOPA6x8W3lQ8Cj6w-1; Thu, 06 Jul 2023 02:00:05 -0400
X-MC-Unique: U5M4XtxOPA6x8W3lQ8Cj6w-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6f97c9d54so2919271fa.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 23:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688623204; x=1691215204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ube1y7JOBK0sYBUge2MjDkyKJYg7nc/dcuBp4XK4m2M=;
 b=l5YzwXcH7g21J/09psAe5v8rXf4OESOZlBr70IEXJxxemBYJCDo5b3mKV79EGqahpp
 afXsIMdGc/N0C3JWCY/EAfVT1Ks5g7QG4WSDIgJ3suiBh1AxkXCMR/tIigi7f07qDVcr
 xXtFyCJBrVBDkvg8rP1etXkui0aeC0gAKYHm/tNwtAnlgmT4ro68pIvSjZqn/GQeEAbu
 wru23KpsBUXziTY70csIWL3FuYcJde5wKxSLkPjHF41LsSF9l2aZzdi+NZlgidlmcdGf
 mePedekX+9WWam0N/P6AqNGmIKIWi0CN0K8uCQSpP4FX6phADAlEY0uOwWhCdbzomsa1
 wqEQ==
X-Gm-Message-State: ABy/qLYlIApullCsbQKY8K9aY7PjD0qqPzmIUuXeGGcQ+iWzjEJPidrB
 m6obnpqvdF/MSW7o+HGnXK2ZqAGJchqjiKHtxu3MRWaNUZTokOpEoiajKyOeLwcdZm/WpVlPz8H
 XzMpSkwEDONvkk1IdovKvVpLF/D0m3Qs=
X-Received: by 2002:a2e:8706:0:b0:2b5:9f54:e290 with SMTP id
 m6-20020a2e8706000000b002b59f54e290mr519525lji.0.1688623204160; 
 Wed, 05 Jul 2023 23:00:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH5dC+QauLezhrplZL+O1uEhTILzY1Y5kwNDaxerNYLS5LWy31HLsJ7/BKtKYrSZ73jYcBEdLIsCogNQgJBnb0=
X-Received: by 2002:a2e:8706:0:b0:2b5:9f54:e290 with SMTP id
 m6-20020a2e8706000000b002b59f54e290mr519519lji.0.1688623203853; Wed, 05 Jul
 2023 23:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230620130354.322180-1-david@redhat.com>
In-Reply-To: <20230620130354.322180-1-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Thu, 6 Jul 2023 07:59:53 +0200
Message-ID: <CAMXpfWs5cz2xqkPLwkuCz1NLV+0rKv3wafRtBCQqcyPzvWhGOg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] virtio-mem: Support "x-ignore-shared" migration
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peng Tao <tao.peng@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcasquer@redhat.com;
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

This series has been tested successfully by QE. Start a VM with a 8G
virtio-mem device and start memtester on it. Enable x-ignore-shared
capability and then do migration. Migration was successful and
virtio-mem can be resized as usual.

Tested-by: Mario Casquero <mcasquer@redhat.com>

BR,
Mario




On Tue, Jun 20, 2023 at 3:05=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> Stumbling over "x-ignore-shared" migration support for virtio-mem on
> my todo list, I remember talking to Dave G. a while ago about how
> ram_block_discard_range() in MAP_PIRVATE file mappings is possibly
> harmful when the file is used somewhere else -- for example, with VM
> templating in multiple VMs.
>
> This series adds a warning to ram_block_discard_range() in that problemat=
ic
> case and adds "x-ignore-shared" migration support for virtio-mem, which
> is pretty straight-forward. The last patch also documents how VM templati=
ng
> interacts with virtio-mem.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Leonardo Bras <leobras@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> Cc: Peng Tao <tao.peng@linux.alibaba.com>
>
> David Hildenbrand (4):
>   softmmu/physmem: Warn with ram_block_discard_range() on MAP_PRIVATE
>     file mapping
>   virtio-mem: Skip most of virtio_mem_unplug_all() without plugged
>     memory
>   migration/ram: Expose ramblock_is_ignored() as
>     migrate_ram_is_ignored()
>   virtio-mem: Support "x-ignore-shared" migration
>
>  hw/virtio/virtio-mem.c   | 67 ++++++++++++++++++++++++++++------------
>  include/migration/misc.h |  1 +
>  migration/postcopy-ram.c |  2 +-
>  migration/ram.c          | 14 ++++-----
>  migration/ram.h          |  3 +-
>  softmmu/physmem.c        | 18 +++++++++++
>  6 files changed, 76 insertions(+), 29 deletions(-)
>
> --
> 2.40.1
>
>


