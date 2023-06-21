Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB35738C6F
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:57:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC17S-0002Ol-SI; Wed, 21 Jun 2023 12:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC17O-0002Gr-OC
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC17N-0002y8-3O
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687366539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mtjmyv/2OPDTQxWgbRLzpOwHQacTwu7jWSfqOTQpokM=;
 b=L/rbmLZwx5mU/r6uQ50xpcho0twYjuHiDwu2fnEFHcnenq1gVYCNytIJ3g16D+xfYwdP5C
 yJjII7p3KCOABVdZ/IDB+GvacwYoZHSZVOcLAFpwNY/PB6oTR6h4hmbneGXl0nHFfj4oYG
 oIIc+nNy/1ovUSDrW76eyQrJk1ncCRM=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-yOFI9AorOx60ljLZHczemQ-1; Wed, 21 Jun 2023 12:55:37 -0400
X-MC-Unique: yOFI9AorOx60ljLZHczemQ-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-471603b2e6dso295979e0c.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 09:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687366537; x=1689958537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mtjmyv/2OPDTQxWgbRLzpOwHQacTwu7jWSfqOTQpokM=;
 b=DmZOfCakn/p8pK+F0198wYu06ljD2SnEpc4vHiyF9HnGcoTFAuoi9mpHBi3LlndrNH
 028Veo6C6LuNf4Lx+wsA2G3HvnUrkbpYd9Uh1ktuy0h8/Y1QD0QSQOXiWlIgfH0Nkb+Z
 J6N4USr7Cv9yN4omvSlHXW0U88knfCEZTvmbExE124dh42cDv3bOCPlhdgGcQxTIJs8X
 aY5AyykrvTnvDfl6eWxb5c2q3YyJXyKeCuGxax+JIdAgo+cMK5GMFe77xkViQus5joUl
 BGQTcmuuxl7QxkpoZ9wPSmbyeQcf3onBOyZGbhiM+9QiNMyeplNQmsk6RDU/IWS+0rBP
 nxkw==
X-Gm-Message-State: AC+VfDxj7YcvQFCyWg3EszVMTS5DHI5XkJCgMHv5TUNFPwNSHx8mfkro
 fqHLG+m59BsDciqJVXUS4uujwSzKf4ftwkzD/LRjgss2I/yjJtXqOhDVfYtSqAy30W1M253/UaK
 jiJLtaAXsO4rWug4=
X-Received: by 2002:a05:6102:2924:b0:440:a800:c005 with SMTP id
 cz36-20020a056102292400b00440a800c005mr5372155vsb.1.1687366536850; 
 Wed, 21 Jun 2023 09:55:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ478U3YrwT9r1LVrgTgkghx5dP8+SXnyvduEHvcIjTiJbtrrFoo58XQLIKp0DMcvm4J/2hOmw==
X-Received: by 2002:a05:6102:2924:b0:440:a800:c005 with SMTP id
 cz36-20020a056102292400b00440a800c005mr5372141vsb.1.1687366536588; 
 Wed, 21 Jun 2023 09:55:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a7-20020ac84d87000000b003f6bbd7863csm2542224qtw.86.2023.06.21.09.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 09:55:36 -0700 (PDT)
Date: Wed, 21 Jun 2023 12:55:34 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>
Subject: Re: [PATCH v1 1/4] softmmu/physmem: Warn with
 ram_block_discard_range() on MAP_PRIVATE file mapping
Message-ID: <ZJMrhgEbzYUyt1KH@x1n>
References: <20230620130354.322180-1-david@redhat.com>
 <20230620130354.322180-2-david@redhat.com> <ZJMdZRoeu9BVm0z8@x1n>
 <9f7afce0-ff7f-33f8-4f39-bba77f2b2ba4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f7afce0-ff7f-33f8-4f39-bba77f2b2ba4@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Wed, Jun 21, 2023 at 06:17:37PM +0200, David Hildenbrand wrote:
> As documented, ram_block_discard_range() guarantees two things
> 
> a) Read 0 after discarding succeeded
> b) Make postcopy work by triggering a fault on next access
> 
> And if we'd simply want to drop the FALLOC_FL_PUNCH_HOLE:
> 
> 1) For hugetlb, only newer kernels support MADV_DONTNEED. So there is no way
> to just discard in a private mapping here that works for kernels we still
> care about.
> 
> 2) free-page-reporting wants to read 0's when re-accessing discarded memory.
> If there is still something there in the file, that won't work.

Ah right.  The semantics is indeed slightly different..

IMHO, ideally here we need a zero page installed as private, ignoring the
page cache underneath, freeing any possible private page.  But I just don't
know how to do that easily with current default mm infrastructures, or
free-page-reporting over private mem seems just won't really work at all,
it seems to me.

Maybe.. UFFDIO_ZEROPAGE would work? We need uffd registered by default, but
that's slightly tricky.

> 
> 3) Regarding postcopy on MAP_PRIVATE shmem, I am not sure if it will
> actually do what you want if the pagecache holds a page. Maybe it works, but
> I am not so sure. Needs investigation.

For MINOR I think it will.  I actually already implemented some of that (I
think, all of that is required) in the HGM qemu rfc series, and smoked it a
bit without any known issue yet with the HGM kernel.

IIUC we can work on MINOR support without HGM; I can separate it out.  It's
really a matter of whether it'll be worthwhile the effort and time.

Thanks,

-- 
Peter Xu


