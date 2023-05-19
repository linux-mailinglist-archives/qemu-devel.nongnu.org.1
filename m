Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73418709B12
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:17:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01rL-0002wL-Mm; Fri, 19 May 2023 11:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q01rI-0002qK-O4
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q01rH-0004UP-83
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684509450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EQ62l771aNJ5hqK7BAs9uSJRQd9KFUYLZ/W96lzMe9E=;
 b=A+HSWNTyYC4DxDUgJkAva7AWlreLZL8CoQHUosG99Ios/mdaUxSO6iE97bAstKt8t3ZNXV
 ULe2WzoiG7xBnEso0ex2/V2IuvLrz7HV1JyopEOzFI1gNnJPlN86K8oXp8vpe197AuVbm1
 A6VoqmaI/ZOuU270iGq/BM+yf2RHPPE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-X7hfPmXaNRipEgHZZpQBjg-1; Fri, 19 May 2023 11:17:29 -0400
X-MC-Unique: X7hfPmXaNRipEgHZZpQBjg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f393bf5546so7082771cf.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684509448; x=1687101448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQ62l771aNJ5hqK7BAs9uSJRQd9KFUYLZ/W96lzMe9E=;
 b=L4YXCYMsNgC0trk4i3zLO48gipJ/NFdszW2NLLOXGfmLhH+hriPcUhaObEAMbqpz5r
 mv3EAgO2d+hi/LQd0XfodpeK96OjcmwrHQPyA1gzUANdZxTsUWXdmeEcgacPv1xWCcBy
 DxLZfdzw0XHMj7TnU3HF626nojOiw6A3SnQe3HgdvN/4vQ5UKkWfPxP90IZh2UUCLtSs
 w8WJA5UW9LBUpDdVDsV6VmtAXHk6FGQOHbGiZEWdeqLSoabW9+PJFfixkqVinmT4ae3z
 TOXHmcr9aoC4GumDLKjAdV0/aVv/Wz9SLCEZUvEYCfnEnPir4REh3kOvM9/naPmBQn8d
 +wgQ==
X-Gm-Message-State: AC+VfDy6gf65WmDdWBF501xxMut1ZcNdIi8cf9W1J0ifZavd6oUpxAc8
 UP9En4m7hka70DqAQE8o/8MzLSrnrJZW9Yngx8fTYvnVkKw06S3Ba4rZXY8jQae4twfqQhGN8A+
 v7zjXospKdt36zpw=
X-Received: by 2002:ac8:5c54:0:b0:3f5:29b9:59e3 with SMTP id
 j20-20020ac85c54000000b003f529b959e3mr4865622qtj.3.1684509448783; 
 Fri, 19 May 2023 08:17:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ42ZLAWOG39mEAPDsB1HR8zthseSBVXR/3eKEbvUykfEjv/qdQAor5NzSBb9MidHxhO0LRA5Q==
X-Received: by 2002:ac8:5c54:0:b0:3f5:29b9:59e3 with SMTP id
 j20-20020ac85c54000000b003f529b959e3mr4865591qtj.3.1684509448544; 
 Fri, 19 May 2023 08:17:28 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 s19-20020ac87593000000b003ee08d3e073sm1370162qtq.42.2023.05.19.08.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 08:17:27 -0700 (PDT)
Date: Fri, 19 May 2023 11:17:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: "Wang, Wei W" <wei.w.wang@intel.com>, "Wang, Lei4" <lei4.wang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "leobras@redhat.com" <leobras@redhat.com>,
 Daniel Berrange <berrange@redhat.com>
Subject: Re: [PATCH] multifd: Set a higher "backlog" default value for listen()
Message-ID: <ZGeTBgo5mBDlaDpe@x1n>
References: <20230518085228.172816-1-lei4.wang@intel.com>
 <87h6saf18t.fsf@secure.mitica>
 <9def6eb4-e317-2b6d-87ab-d0aa34ea3afe@intel.com>
 <DS0PR11MB637345417B81FF5637B2D7D8DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <87jzx4y39v.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzx4y39v.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 19, 2023 at 01:22:20PM +0200, Juan Quintela wrote:
> "Wang, Wei W" <wei.w.wang@intel.com> wrote:
> > On Friday, May 19, 2023 9:31 AM, Wang, Lei4 wrote:
> >> On 5/18/2023 17:16, Juan Quintela wrote:
> >> > Lei Wang <lei4.wang@intel.com> wrote:
> >> >> When destination VM is launched, the "backlog" parameter for listen()
> >> >> is set to 1 as default in socket_start_incoming_migration_internal(),
> >> >> which will lead to socket connection error (the queue of pending
> >> >> connections is full) when "multifd" and "multifd-channels" are set
> >> >> later on and a high number of channels are used. Set it to a
> >> >> hard-coded higher default value 512 to fix this issue.
> >> >>
> >> >> Reported-by: Wei Wang <wei.w.wang@intel.com>
> >> >> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> >> >
> >> > [cc'd daiel who is the maintainer of qio]
> >> >
> >> > My understanding of that value is that 230 or something like that
> >> > would be more than enough.  The maxiimum number of multifd channels is
> >> 256.
> >> 
> >> You are right, the "multifd-channels" expects uint8_t, so 256 is enough.
> >> 
> >
> > We can change it to uint16_t or uint32_t, but need to see if listening on a larger
> > value is OK to everyone.
> 
> If we need something more than 256 channels for migration, we ar edoing
> something really weird.  We can saturate a 100Gigabit network relatively
> easily with 10 channels.  256 Channels would mean that we have at least
> 2TBit/s networking.  I am not expecting that really soon.  And as soon
> as that happens I would expect CPU's to handle easily more that
> 10Gigabits/second.

Besides the network limitation, I'd also bet when the thread number goes to
some degree it'll start to have bottleneck here and there on either
scheduling or even cache bouncing between the cores even when atomically
updating the counters (afaiu those need mem bus locking).

So I agree 256 would be good enough.  We can wait to see when there're
higher speed network..

> 
> > Man page of listen mentions that the  maximum length of the queue for
> > incomplete sockets can be set using /proc/sys/net/ipv4/tcp_max_syn_backlog,
> > and it is 4096 by default on my machine.
> 
> I think that current code is ok.  We just need to enforce that we use
> defer.
> 
> Later, Juan.
> 

-- 
Peter Xu


