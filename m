Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC97923F3
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:32:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdY1d-0005WX-Cz; Tue, 05 Sep 2023 11:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdY1W-0005T7-FI
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdY1U-0004GM-4L
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693927882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=79FUHVIYV/qsmgbMY8XTJW3GSbCmqnw4bjlH5MbY7ZE=;
 b=bFeNfmyEU7yinB4Ru/gaxYKC9VqKmhMkjq16/8bTbV2lMoKedL4JAv1su5Eeja3/bErVFp
 ya+UVeLGr4z5ez+1BK7IX1BkKIo2i22NyGfmbAFKljcXliJ/jOSBZ/fJeUhB4BiUPCinHJ
 EY/fDeGiEd0o2V6URRAI4fFr3ndL/Ro=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-pMySUoiWOuGunM5Wrr-opw-1; Tue, 05 Sep 2023 11:31:21 -0400
X-MC-Unique: pMySUoiWOuGunM5Wrr-opw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76d9b5fd22eso14661285a.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 08:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693927878; x=1694532678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79FUHVIYV/qsmgbMY8XTJW3GSbCmqnw4bjlH5MbY7ZE=;
 b=k9pFumwduckZwwhL1RA2+d2OSKOttxe7fmdXRiLZVFSH/K41LkxS/6a48SnB2KhsmB
 boS0gimpyoEfAzOb5W+DgvOugjZY3Oj36hW2GUstTdVZoL+ye2Yga6graRHCiMhg2cpU
 0KEsDJdXi4jvIfuURy5kmWR4cA/CaoR/eivRat858/EVuLwLtp4cGjBnHWrSWl0dPQJq
 OEed2+5ea7yMU2/rCSlqNVd7gL+PUr7v81mWmgWyoXpW8IHUxU5cCxzNwShCxreVp9iz
 DdZJAKBgAYhVBzsRJ51e/eE/7JfzwB4+txztCUt+7pmUXE8dBl9mKLNcTA5NVLBQ3b6a
 VAWQ==
X-Gm-Message-State: AOJu0YwL38HafAN8KGDs0Hw7QRh3leRgVGL3uZp53UvbTQRCrHXkuyck
 LEP85MvaK7LR3U6u3geCWZTOHvTuJAc9UdMHHdeG5oRGNdNo6bqihmCxc0lCBUrUmIxQpkI6IXM
 krfrC02VU+lWQ+9Q=
X-Received: by 2002:a05:620a:470e:b0:76c:ff2e:5a3f with SMTP id
 bs14-20020a05620a470e00b0076cff2e5a3fmr15069201qkb.3.1693927878454; 
 Tue, 05 Sep 2023 08:31:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGXx69LUVrlzsoeg5FnUAxvX911UTpchbue4lKLah+zaEAFCnj/S/zddx2sLVJ37IsbU3I1g==
X-Received: by 2002:a05:620a:470e:b0:76c:ff2e:5a3f with SMTP id
 bs14-20020a05620a470e00b0076cff2e5a3fmr15069175qkb.3.1693927878152; 
 Tue, 05 Sep 2023 08:31:18 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w14-20020a05620a148e00b0076745f352adsm4111483qkj.59.2023.09.05.08.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 08:31:17 -0700 (PDT)
Date: Tue, 5 Sep 2023 11:31:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Zhiyi Guo <zhguo@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Chensheng Dong <chdong@redhat.com>
Subject: Re: [PATCH for-8.2 v2 2/2] migration: Allow user to specify
 migration switchover bandwidth
Message-ID: <ZPdJwx7hg41GXRle@x1n>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-3-peterx@redhat.com>
 <2f53f68e-7876-9cb1-4804-82fa08116aad@oracle.com>
 <ec2f4daa-f094-a1b4-107c-509e21aa4553@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec2f4daa-f094-a1b4-107c-509e21aa4553@oracle.com>
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

On Fri, Sep 01, 2023 at 07:39:07PM +0100, Joao Martins wrote:
> 
> 
> On 01/09/2023 18:59, Joao Martins wrote:
> > On 03/08/2023 16:53, Peter Xu wrote:
> >> @@ -2694,7 +2694,17 @@ static void migration_update_counters(MigrationState *s,
> >>      transferred = current_bytes - s->iteration_initial_bytes;
> >>      time_spent = current_time - s->iteration_start_time;
> >>      bandwidth = (double)transferred / time_spent;
> >> -    s->threshold_size = bandwidth * migrate_downtime_limit();
> >> +    if (migrate_max_switchover_bandwidth()) {
> >> +        /*
> >> +         * If the user specified an available bandwidth, let's trust the
> >> +         * user so that can be more accurate than what we estimated.
> >> +         */
> >> +        avail_bw = migrate_max_switchover_bandwidth();
> >> +    } else {
> >> +        /* If the user doesn't specify bandwidth, we use the estimated */
> >> +        avail_bw = bandwidth;
> >> +    }
> >> +    s->threshold_size = avail_bw * migrate_downtime_limit();
> >>  
> > 
> > [ sorry for giving review comments in piecemeal :/ ]

This is never a problem.

> > 
> > There might be something odd with the calculation. It would be right if
> > downtime_limit was in seconds. But we are multipling a value that is in
> > bytes/sec with a time unit that is in miliseconds. When avail_bw is set to
> > switchover_bandwidth, it sounds to me this should be a:
> > 
> > 	/* bytes/msec; @max-switchover-bandwidth is per-seconds */
> > 	avail_bw = migrate_max_switchover_bandwidth() / 1000.0;
> > 
> > Otherwise it looks like that we end up overestimating how much we can still send
> > during switchover? If this is correct and I am not missing some assumption, 
> 
> (...)
> 
> > then
> > same is applicable to the threshold_size calculation in general without
> > switchover-bandwidth but likely in a different way:
> > 
> > 	/* bytes/msec; but @bandwidth is calculated in 100msec quantas */
> > 	avail_bw = bandwidth / 100.0;
> > 
> 
> Nevermind this part. I was wrong in the @bandwidth adjustment as it is already
> calculated in bytes/ms. It's max_switchover_bandwidth that needs an adjustment
> it seems.
> 
> > There's a very good chance I'm missing details, so apologies beforehand on
> > wasting your time if I didn't pick up on it through the code.

My fault, thanks for catching this.  So it seems even if the test will
switchover with this patch, it might be too aggresive if we calculate with
a number 1000x larger than the real bandwidth provided..

I'll rename this to expected_bw_per_ms to be clear when repost, too.

Thanks,

-- 
Peter Xu


