Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2D7BBA3B
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 16:28:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qolnQ-00044Z-Tj; Fri, 06 Oct 2023 10:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qolnP-00044J-Dy
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 10:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qolnN-0003GA-NK
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 10:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696602431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GHErx43z7h+MFxodRLpA64K+nISp5poS0od1Qqb5WcM=;
 b=CKYsFMYaPWYUH6lALA/T2l1FNyYCSnuT2gBpIKJA9acnRGU9J0rVWgkJC/ATrvD0ibMrjm
 p8ASCHrK8sev1UPvXbOHIZ6DvtuNufXs3X51PA1P33nlGvguCi4KalIQU1F3PGzAiD3YFM
 HRnqn8bqulr+oXwA0jhg+kjTvqqbtuQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-Bn8nQWhaOWCAwZx_9-p6KQ-1; Fri, 06 Oct 2023 10:27:09 -0400
X-MC-Unique: Bn8nQWhaOWCAwZx_9-p6KQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7742bd869e4so40353685a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 07:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696602428; x=1697207228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHErx43z7h+MFxodRLpA64K+nISp5poS0od1Qqb5WcM=;
 b=ZdLZIujxNv5F9fQYoy7lOX8in0H7WAsuxGLHxpioGGpuzfEJ8KE8oG4/eNkfgmGCdQ
 PpQ+uqX5Hm80AHcChFoRB9LjR2QIGB4PUPJgEGWadQNUYl6gZMZ0FEeDJJwcEWGkTOa/
 mSMJSRKELglv00Hb3BpweDm8cITdhFnvlc9uBRwonVGMtNcUB/l7d+MtsGIGlFjFJGWp
 UdhrmcFDbFYS/nZjth/MmnE85Fu/2AUcr3OSXHbSBUa5+ZPxGLlPAt7KMXxRuheB2Z3v
 7MPrqFaV+K7Y7Lcuc3X2eiFtDA/SOE8E28M58oL5PcRmOs6mDhTVgeWVlMjJvswsigUd
 Vlkw==
X-Gm-Message-State: AOJu0YyOEP7ERT0froClXjf4JKk0YQ6S5mPsA/Oy1adwXCwOrGH13tbE
 1yjy4F249mbYUgSVhqeyUlqoossPSK5fpCthX/Pz07pElttxkGEdLcrNKYJ5mJAVko2UcOLHwxU
 g5Hkx0qWRZ9KIQoI=
X-Received: by 2002:a05:620a:46ac:b0:76d:9234:1db4 with SMTP id
 bq44-20020a05620a46ac00b0076d92341db4mr8997831qkb.7.1696602428507; 
 Fri, 06 Oct 2023 07:27:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4ONvZIAJz7lIiFivyhv8wWJzcxDrPU5WkgkwRBlXUJlOlcp/niGOMUmq6PDKvy5pigWnxrg==
X-Received: by 2002:a05:620a:46ac:b0:76d:9234:1db4 with SMTP id
 bq44-20020a05620a46ac00b0076d92341db4mr8997812qkb.7.1696602428148; 
 Fri, 06 Oct 2023 07:27:08 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h23-20020a05620a13f700b00767d6ec578csm1347393qkl.20.2023.10.06.07.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 07:27:07 -0700 (PDT)
Date: Fri, 6 Oct 2023 10:27:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: [PATCH 4/5] migration: Provide QMP access to downtime stats
Message-ID: <ZSAZOhSL2X0AJckQ@x1n>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
 <20230926161841.98464-5-joao.m.martins@oracle.com>
 <ZR2cgcj//sAjzOav@x1n>
 <f254478a-2e4d-4e6e-b19f-d5e56099f2a9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f254478a-2e4d-4e6e-b19f-d5e56099f2a9@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Oct 06, 2023 at 12:37:15PM +0100, Joao Martins wrote:
> I added the statistics mainly for observability (e.g. you would grep in the
> libvirt logs for a non developer and they can understand how downtime is
> explained). I wasn't specifically thinking about management app using this, just
> broad access to the metrics.
> 
> One can get the same level of observability with a BPF/dtrace/systemtap script,
> albeit in a less obvious way.

Makes sense.

> 
> With respect to motivation: I am doing migration with VFs and sometimes
> vhost-net, and the downtime/switchover is the only thing that is either
> non-determinisc or not captured in the migration math. There are some things
> that aren't accounted (e.g. vhost with enough queues will give you high
> downtimes),

Will this be something relevant to loading of the queues?  There used to be
a work on greatly reducing downtime especially for virtio scenarios over
multiple queues (and iirc even 1 queue also benefits from that), it wasn't
merged probably because not enough review:

https://lore.kernel.org/r/20230317081904.24389-1-xuchuangxclwt@bytedance.com

Though personally I think that's some direction good to keep exploring at
least, maybe some slightly enhancement to that series will work for us.

> and algorithimally not really possible to account for as one needs
> to account every possible instruction when we quiesce the guest (or at least
> that's my understanding).
> 
> Just having these metrics, help the developer *and* user see why such downtime
> is high, and maybe open up window for fixes/bug-reports or where to improve.
> 
> Furthermore, hopefully these tracepoints or stats could be a starting point for
> developers to understand how much downtime is spent in a particular device in
> Qemu(as a follow-up to this series),

Yes, I was actually expecting that when read the cover letter. :) This also
makes sense.  One thing worth mention is, the real downtime measured can,
IMHO, differ on src/dst due to "pre_save" and "post_load" may not really
doing similar things.  IIUC it can happen that some device sents fast, but
loads slow.  I'm not sure whether there's reversed use case. Maybe we want
to capture that on both sides on some metrics?

> or allow to implement bounds check limits in switchover limits in way
> that doesn't violate downtime-limit SLAs (I have a small set of patches
> for this).

I assume that decision will always be synchronized between src/dst in some
way, or guaranteed to be same. But I can wait to read the series first.

Thanks,

-- 
Peter Xu


