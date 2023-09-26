Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9DA7AF183
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:02:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBRR-0001WR-Ma; Tue, 26 Sep 2023 13:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlBRO-0001GY-SJ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 13:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlBRJ-0007JW-CB
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 13:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUHlq6clJsgDxC0NxK0Dd218L98wNS3trsTbkX6oGlA=;
 b=D8+WcJZqP4naCGvKrUVuVlMh3LKtA1sXp6Wwuwdm5dukW4TX19i7f2peQ/ns2RUhI86HIm
 znI1y854WM6DrMIm9GC0huWd3FkQ5DW26rcYnNtQ9MP1kecN3/EN99bITCMtKzIVi3ijK0
 eIuR+m8jWFM1IHs6ZQDo1T0XOAeeKqo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-p71w1aViNE6NBvZYzUO4Ow-1; Tue, 26 Sep 2023 13:01:33 -0400
X-MC-Unique: p71w1aViNE6NBvZYzUO4Ow-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7742be66d25so171728785a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 10:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747693; x=1696352493;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qUHlq6clJsgDxC0NxK0Dd218L98wNS3trsTbkX6oGlA=;
 b=YWaMtOcnkawRpu/HCD8+tj7fBdcUo8aVNZCiret+gbn9YYzUZmcjquWE+YAHpePjgg
 NEzCfFsExT/hVltJuX2zNkaoTFVTwCmmsZYU0JXoBDRuAQG/1h/qRCUIQonBYC4lAs40
 qOgO56672RBPSjZl0kwC0DvyLEle4xn+52ZQRVpY7FAu40t/YzaKm5BLZGSKL6WrRnPh
 ChwSbn3Mj70OUibw2ZRTKqGtS6S6viSENIvKSvqkiiCJnpUrKGYF70LIbjqUIhJaSVps
 KFwzrd0c8eDxBKaT38XI8XYPm378b6GaZjp7atlz4zaEMclIK+NFW0as5ZyZZ1fz5THd
 +fhA==
X-Gm-Message-State: AOJu0Ywba43KNIez7bIYgMESZkZgXUL2MmL/YzjVnBGXJrdDqJNV65pk
 iRtC995JpzSNlHxqbro8BoAKzxpbxxolMw6sDvUSNSHFa9tc4qnYhAm68C4J5Nsbbic8aF3ZAw+
 zMrzhBwpUMd73da4=
X-Received: by 2002:a05:620a:1aa9:b0:772:5267:3ddf with SMTP id
 bl41-20020a05620a1aa900b0077252673ddfmr11302073qkb.2.1695747693389; 
 Tue, 26 Sep 2023 10:01:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP+WepMw14fei4TX6UcO9luQoAE5feuq3GzRqkQapw+L0dbxD4Vls4HgHt9O0W9VF1uD17oA==
X-Received: by 2002:a05:620a:1aa9:b0:772:5267:3ddf with SMTP id
 bl41-20020a05620a1aa900b0077252673ddfmr11302047qkb.2.1695747693013; 
 Tue, 26 Sep 2023 10:01:33 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 dc3-20020a05620a520300b0076f19b9e96fsm4851598qkb.107.2023.09.26.10.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 10:01:32 -0700 (PDT)
Date: Tue, 26 Sep 2023 13:01:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] MAINTAINERS: Add entry for rdma migration
Message-ID: <ZRMOaYzpVdgORVM3@x1n>
References: <20230925133441.265455-1-peterx@redhat.com>
 <8734z2s6gz.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734z2s6gz.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 25, 2023 at 03:55:08PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > It's not obvious to many that RDMA migration is in Odd Fixes stage for a
> > long time.  Add an explicit sub entry for it (besides migration, which
> > already covers the rdma files) to be clear on that, meanwhile add Zhijian
> > as Reviewer, so Zhijian can see the patches and review when he still has
> > the bandwidth.
> >
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Cc: Juan Quintela <quintela@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  MAINTAINERS | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 355b1960ce..f6b21da753 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3217,6 +3217,11 @@ F: qapi/migration.json
> >  F: tests/migration/
> >  F: util/userfaultfd.c
> >  
> > +RDMA Migration
> > +R: Li Zhijian <lizhijian@fujitsu.com>
> > +S: Odd Fixes
> > +F: migration/rdma*
> > +
> >  Migration dirty limit and dirty page rate
> >  M: Hyman Huang <yong.huang@smartx.com>
> >  S: Maintained
> 
> Hmm...
> 
>     $ scripts/get_maintainer.pl --status -f migration/rdma.cLi Zhijian <lizhijian@fujitsu.com> (reviewer:RDMA Migration)
>     Juan Quintela <quintela@redhat.com> (maintainer:Migration)
>     Peter Xu <peterx@redhat.com> (reviewer:Migration)
>     Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
>     qemu-devel@nongnu.org (open list:All patches CC here)
>     Odd Fixes
>     Maintained
> 
> Contradictory status.  Do we care?

Not a problem to me, but if you or anyone thinks that's better, please feel
free to post another patch to replace this one with Zhijian's ACK attached.

> 
> To avoid, try something like the appended patch.  With that one:
> 
>     $ scripts/get_maintainer.pl --status -f migration/rdma.c
>     Juan Quintela <quintela@redhat.com> (odd fixer:RDMA Migration)
>     Li Zhijian <lizhijian@fujitsu.com> (reviewer:RDMA Migration)
>     Peter Xu <peterx@redhat.com> (reviewer:RDMA Migration)
>     Leonardo Bras <leobras@redhat.com> (reviewer:RDMA Migration)
>     qemu-devel@nongnu.org (open list:All patches CC here)
>     Odd Fixes
> 
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 355b1960ce..3e80857eab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3216,6 +3216,15 @@ F: docs/devel/migration.rst
>  F: qapi/migration.json
>  F: tests/migration/
>  F: util/userfaultfd.c
> +X: migration/rdma*
> +
> +RDMA Migration
> +M: Juan Quintela <quintela@redhat.com>
> +R: Li Zhijian <lizhijian@fujitsu.com>
> +R: Peter Xu <peterx@redhat.com>
> +R: Leonardo Bras <leobras@redhat.com>
> +S: Odd Fixes
> +F: migration/rdma*

It's slightly a pity we need to copy the lines, and I think this may not be
the only place where we have >1 entries pointing to the same file.

>  
>  Migration dirty limit and dirty page rate
>  M: Hyman Huang <yong.huang@smartx.com>
> 

Thanks,

-- 
Peter Xu


