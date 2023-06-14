Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6497D730038
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 15:37:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Qfk-0005VS-Py; Wed, 14 Jun 2023 09:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9Qfj-0005V1-A6
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 09:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9Qfh-0006fk-Jz
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 09:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686749784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v+FxCz9bQHpI7KUW51pVfNAx5Njh5yyomy08tKiydos=;
 b=gC9YYIoE+1WcdfPPWUAzqFwdyG0lknidgC0+XSxsmigtJTmt7IZQb6ImYvF7R2UsdCzKay
 oA09LgyyUuVQ6BjkJtHllsBMSJibaXCS1VbDWuVfHiwJWEGmTAdYI3uJOdaYdDQ7M1Q+fV
 eB1uFddgF9JCz/A5JMN8lxpCY2TFZr0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-XFufmFxpM3a0tQXAWEvViA-1; Wed, 14 Jun 2023 09:36:21 -0400
X-MC-Unique: XFufmFxpM3a0tQXAWEvViA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-75fd4851fb9so64841685a.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 06:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686749781; x=1689341781;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v+FxCz9bQHpI7KUW51pVfNAx5Njh5yyomy08tKiydos=;
 b=lIfjuqh3iT3nUGAQUwbFVvBWvNa8UgKg7rfwVsufdWepLJaE0vh0VNomcZ5087clVh
 BOJguLW7mTDWf8gWCXsJwLxP6lH41seGRO04H57Ados07apJ21LJM0f5nW0pbDupRjSb
 sVQKBW2RvGOlfpntFdvHnGXhRu0J4YNrnuJfxLQzbma8qyzZ5NJJa0uJVzKXFueRcHEK
 53yRHgumeQ8lUACnvEYBe2jzvwAcuVSWfyaknZ/M0rvfmcVDl2869C1a2oj0KwORZ/O7
 XHTRhmff+1jjxouMUw40ngxl4nkz+O1VkOQa5QjEeCca5iP2w5yE92Cioog4d9hOXRb5
 q+vw==
X-Gm-Message-State: AC+VfDxM53DK/xlEAOKsL593ocaS+mhdkxTxm1DWteHlsr8cnS1vPHWQ
 EoaXPVBC/qkmslU2WDKeiPKkP0cp+4K4MX1gYarrQtjLz3HuDmPOaZGIXMRWqEO+Vm+yN9qnwMY
 z8Et3WcSXhAFBkn0=
X-Received: by 2002:a05:622a:1009:b0:3f8:46d:dacc with SMTP id
 d9-20020a05622a100900b003f8046ddaccmr20041785qte.2.1686749780860; 
 Wed, 14 Jun 2023 06:36:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5a14eV6NGtnbFbMTd+/aHpjHSiRCr/yNqv1AQoU3tkvVff9e8gfcJN2EZkHewMOV+17ACstg==
X-Received: by 2002:a05:622a:1009:b0:3f8:46d:dacc with SMTP id
 d9-20020a05622a100900b003f8046ddaccmr20041763qte.2.1686749780549; 
 Wed, 14 Jun 2023 06:36:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 fg25-20020a05622a581900b003f6b8a6fd18sm5000378qtb.96.2023.06.14.06.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 06:36:19 -0700 (PDT)
Date: Wed, 14 Jun 2023 09:36:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 04/20] qemu-file: We only call qemu_file_transferred_*
 on the sending side
Message-ID: <ZInCUphJMtmWLkKq@x1n>
References: <20230530183941.7223-1-quintela@redhat.com>
 <20230530183941.7223-5-quintela@redhat.com> <ZH4m8nUAEfZglPLD@x1n>
 <87y1kne4g2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1kne4g2.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jun 13, 2023 at 06:02:05PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Tue, May 30, 2023 at 08:39:25PM +0200, Juan Quintela wrote:
> >> Remove the increase in qemu_file_fill_buffer() and add asserts to
> >> qemu_file_transferred* functions.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >
> > The read side accounting does look a bit weird and never caught my notice..
> >
> > Maybe worth also touching the document of QEMUFile::total_transferred to
> > clarify what it accounts?
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >
> > Though when I'm looking at the counters (didn't follow every single recent
> > patch on this..), I found that now reading transferred value is actually
> > more expensive - qemu_file_transferred() needs flushing, even if for the
> > fast version, qemu_file_transferred_fast() loops over all possible iovs,
> > which can be as large as MAX_IOV_SIZE==64.
> >
> > To be explicit, I _think_ for each guest page we now need to flush...
> >
> >   ram_save_iterate
> >     migration_rate_exceeded
> >       migration_transferred_bytes
> >         qemu_file_transferred
> >
> > I hope I'm wrong..
> 
> See patch 7:
> 
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index 79eea8d865..1696185694 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -62,7 +62,7 @@ uint64_t migration_transferred_bytes(QEMUFile *f)
>  {
>      uint64_t multifd = stat64_get(&mig_stats.multifd_bytes);
>      uint64_t rdma = stat64_get(&mig_stats.rdma_bytes);
> -    uint64_t qemu_file = qemu_file_transferred(f);
> +    uint64_t qemu_file = stat64_get(&mig_stats.qemu_file_transferred);
>  
>      trace_migration_transferred_bytes(qemu_file, multifd, rdma);
>      return qemu_file + multifd + rdma;

If this is a known regression, should we make a first patchset fix it and
make it higher priority to merge?

It seems this is even not mentioned in the cover letter.. while IMHO this
is the most important bit to have in it..

> 
> 
> > Does it mean that perhaps we simply need "sent and put into send buffer"
> > more than "what really got transferred"?  So I start to wonder what's the
> > origianl purpose of this change, and which one is better..
> 
> That is basically what patch 5 and 6 do O:-)
> 
> Problem is arriving to something that is bisectable (for correctness)
> and is easy to review.
> 
> And yes, my choices can be different from the ones tat you do.
> 
> The other reason for the small patches is that:
> a - sometimes I found a different test where things broke, and have to
>     bisect
> b - small patches are much easier to rebase (that I am doing a lot)

That's okay.  Thanks,

-- 
Peter Xu


