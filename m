Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A7D749E85
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 16:04:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHPa2-0001S3-LQ; Thu, 06 Jul 2023 10:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHPa1-0001Rs-6r
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHPZz-0007HD-Ov
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688652201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrZVbCvknETnEghSIR083CT8pRzhdF5OOK+UVwMGpE0=;
 b=MFgb27oyuGFcsGLIDsPC4/wA2DZ4Epdl4x/IZhtS4jmdUgrgBCtCw51ZSrRdOy2evcWeN+
 hSt5q9hLzK+0TUyivpm4nnxHbvHfmGOh87LmUsYLPFjn0z3OLVYBCL09JFGSA9cwbRcBi3
 UhoxJLgejeIjr9URqNAY+gcdp9YRUfw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-2AHvT95QOBybjs_j_5LXGw-1; Thu, 06 Jul 2023 10:03:19 -0400
X-MC-Unique: 2AHvT95QOBybjs_j_5LXGw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fa8d203eccso9916275e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 07:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688652198; x=1691244198;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GrZVbCvknETnEghSIR083CT8pRzhdF5OOK+UVwMGpE0=;
 b=GduAIF0UKTxVycIU8l7JCPDXRrkP4iFw+2Kowc5Q4o5VJj+Ov34hiOASJXhZ12hJ7V
 zXBRAU+xP5kLZXIGtd6ZkO5AIw+fXpcoLMPYGfcSDt/rBLj0Ma7W41G3lpKl8lDhmJT8
 c15Gr8VNrPUPkyJ0eIE44LdiGBWVrP1QDEj3TRZ2SrwFUqatqxyihQW6EQcELpFp0OYD
 lCi07NF7ZdFpBj1m1uRuS7zyIWNQF5Ej7gvmBloYytjmcvkxhUzLag1xr0jqLHRrHXHX
 WV31Zdc3Uh30gJblhhylhsE7d7qF+Z8zbI/F31qC+N3TGmlcRpPYiTmLL4bvIsYu22fY
 9RZA==
X-Gm-Message-State: ABy/qLbN4nRj0sX2fg5fr59Idc1QtKfBoibK/5UIMb6PR7aa43LjDSxi
 DLf52iXvuTZFOdMtV8UZi+4C0iGnrB9iLp7yngpHQQqNF7FF36cLNIaVB3NiQPk+h3LFkbg6hOl
 O9qaMkvt80p+CBzg=
X-Received: by 2002:a7b:c8d4:0:b0:3fb:e1d0:6417 with SMTP id
 f20-20020a7bc8d4000000b003fbe1d06417mr5134889wml.19.1688652198496; 
 Thu, 06 Jul 2023 07:03:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEL0mWg7okqvxEJDYBNiPoaueUqIfHmjpxCP/EhUEaWSJbUN1WekwpJaNqWxQutMgufA8pBuw==
X-Received: by 2002:a7b:c8d4:0:b0:3fb:e1d0:6417 with SMTP id
 f20-20020a7bc8d4000000b003fbe1d06417mr5134875wml.19.1688652198236; 
 Thu, 06 Jul 2023 07:03:18 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 y10-20020a7bcd8a000000b003fb9ebb6b88sm5226105wmj.39.2023.07.06.07.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 07:03:17 -0700 (PDT)
Date: Thu, 6 Jul 2023 10:03:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Mario Casquero <mcasquer@redhat.com>
Subject: Re: [PATCH v2 0/4] virtio-mem: Support "x-ignore-shared" migration
Message-ID: <20230706100303-mutt-send-email-mst@kernel.org>
References: <20230706075612.67404-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706075612.67404-1-david@redhat.com>
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

On Thu, Jul 06, 2023 at 09:56:05AM +0200, David Hildenbrand wrote:
> If there is no further feedback, I'll queue this myself shortly.
> 
> Stumbling over "x-ignore-shared" migration support for virtio-mem on
> my todo list, I remember talking to Dave G. a while ago about how
> ram_block_discard_range() in MAP_PIRVATE file mappings is possibly
> harmful when the file is used somewhere else -- for example, with VM
> templating in multiple VMs.
> 
> This series adds a warning to ram_block_discard_range() in that problematic
> case and adds "x-ignore-shared" migration support for virtio-mem, which
> is pretty straight-forward. The last patch also documents how VM templating
> interacts with virtio-mem.
> 
> v1 -> v2:
> - Pick up tags
> - "virtio-mem: Support "x-ignore-shared" migration"
>  -> Fix spelling mistake

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Leonardo Bras <leobras@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> Cc: Peng Tao <tao.peng@linux.alibaba.com>
> Cc: Mario Casquero <mcasquer@redhat.com>
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
> 2.41.0


