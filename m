Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 189C17180D7
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:59:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LPz-0003lj-4x; Wed, 31 May 2023 08:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4LPL-0003Ri-RB
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4LPG-0007ej-0h
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685537903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vM5CSWqbBFYoxvr0g16PeCuNkkOuAU9HB2k5GIoHBqc=;
 b=immFXTVe+BOID+2HTtrwQBpRDXgTgAEw6ZhZxhsI8U6LKeCEPhMH86JN/zsJ85mljVFccf
 m4IH+hGKvu6pasqb/gD9ENjsv+jjsLxoiIk69NQwHq8vVEEYdsFwwZnuHoufsL3/4CKHYs
 BtguncPamqeDw/VSFA+gkMW4YxeSUOE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-zHh5Eg01OdWTQY0-zbEgIQ-1; Wed, 31 May 2023 08:58:22 -0400
X-MC-Unique: zHh5Eg01OdWTQY0-zbEgIQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-62829b2aa10so856206d6.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 05:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685537902; x=1688129902;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vM5CSWqbBFYoxvr0g16PeCuNkkOuAU9HB2k5GIoHBqc=;
 b=cfpPMqe6xhbn/GgXuCQvBnLMs6MLFClREBHjkSjccuUMHQcJ9gDBepk58HlONkAanB
 RfR7XFEPWB71DKYk5oplbC5bJzIc+9pUYb45hrrJkKwqdqw6HY/yqHNFk4XagVuaFhJ8
 k9lgGE8Lmy6Eh1fTX4iWx8CwZXsnGJhbaIk3upO+68h28y0FXS9PRnXGfURa5UUId9+N
 RyMSaDE71NNMJO8oWFD3ZERnRsCtXtiZ+vKngy+S5xx/Z4NWTLJ2VhUIL70ityo3pbaW
 GIkcHr7LadCBL3USJiedEv/46LDAha7E9YIGJS0M3b35A7XhWO6GwCvJnwSeSSs3pGXj
 yYAA==
X-Gm-Message-State: AC+VfDx+aYA+Xc+etffwuyP0h30RsUvCe/lj/7xGP+fmK+gx3wry+hM1
 pqMiUgqJNALpH9rJikPnATm7digO6u/1s6xUsSxY2kkYjHp94PGAk1IEyCHN71AcKP8/VngvaIw
 5r6+AenboDcY9La4=
X-Received: by 2002:a05:6214:2526:b0:625:8684:3406 with SMTP id
 gg6-20020a056214252600b0062586843406mr5916166qvb.0.1685537902143; 
 Wed, 31 May 2023 05:58:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7PiGZBPPh3IAZzId9kkcFDy0YbEpaPtQAEo7AgvSQdEFZjB1dO4hU/aNS3aJIx0QUwKfLHeA==
X-Received: by 2002:a05:6214:2526:b0:625:8684:3406 with SMTP id
 gg6-20020a056214252600b0062586843406mr5916154qvb.0.1685537901884; 
 Wed, 31 May 2023 05:58:21 -0700 (PDT)
Received: from xz-m1.local
 (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
 by smtp.gmail.com with ESMTPSA id
 ph9-20020a0562144a4900b00605f796d30esm5761492qvb.51.2023.05.31.05.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 05:58:21 -0700 (PDT)
Date: Wed, 31 May 2023 08:58:19 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "quintela@redhat.com" <quintela@redhat.com>,
 "Wang, Lei4" <lei4.wang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/2] qtest/migration-tests.c: use "-incoming defer"
 for postcopy tests
Message-ID: <ZHdEa0jQJTAvg3RM@xz-m1.local>
References: <20230530090259.189462-1-wei.w.wang@intel.com>
 <20230530090259.189462-3-wei.w.wang@intel.com>
 <ZHYLDSZiP+BQXv6K@x1n>
 <DS0PR11MB6373797A00F0A4E6B22EF639DC489@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS0PR11MB6373797A00F0A4E6B22EF639DC489@DS0PR11MB6373.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, May 31, 2023 at 10:41:37AM +0000, Wang, Wei W wrote:
> On Tuesday, May 30, 2023 10:41 PM, Peter Xu wrote:
> > On Tue, May 30, 2023 at 05:02:59PM +0800, Wei Wang wrote:
> > > The Postcopy preempt capability requires to be set before incoming
> > > starts, so change the postcopy tests to start with deferred incoming
> > > and call migrate-incoming after the cap has been set.
> > >
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > 
> > Hmm.. so we used to do socket_start_incoming_migration_internal() before
> > setting the right num for the preempt test, then I'm curious why it wasn't
> > failing before this patch when trying to connect with the preempt channel..
> > 
> > Wei, do you know?
> 
> I think there are two reasons:
> #1 "backlog" specifies the number of pending connections. As long as the server
> accepts the connections faster than the clients side connecting, connection
> will succeed. For the preempt test, it uses only 2 channels, so very likely to not have
> pending connections. (This is easier to trigger for the multifd case, e.g. use a much
> larger number like 16).
> #2 per my tests (on kernel 6.2), the number of pending connections allowed is actually
> "backlog + 1", which is 2 in this case. Adding more pending connections will then be
> dropped. I'm not sure if " backlog + 1" is true for older versions of kernel, though.

Interesting to know, thanks.

If there'll be a new version, please consider adding some of those into the
commit message.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


