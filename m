Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58748718599
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:05:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NMd-0004pS-SR; Wed, 31 May 2023 11:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4NMY-0004mM-Sn
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4NMW-0002iA-PM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685545422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NhxrCPb9J0NW3ELxaOEWfBxb5kuRA0dvJn6W5ONUGVU=;
 b=ZRvv7iI4NLZSEY54N8Hg9zyhRcHhTXEEVhP4vIOSk4PAWBm9zHq97E4VTQWSkrzjSJHrGw
 D0d5fUs6zk+DGA52a/cpX6pMNVMtwasxLJIDVtO5BY1aMFeraZNGOELnj3ln7uUePGttmf
 yF2+bQpvvnm7yQr7jHtMOqdzkF9eD7k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-EphYErtcPeW05PgoIU94Sg-1; Wed, 31 May 2023 11:03:41 -0400
X-MC-Unique: EphYErtcPeW05PgoIU94Sg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-3f8283a3a66so5059421cf.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 08:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685545421; x=1688137421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhxrCPb9J0NW3ELxaOEWfBxb5kuRA0dvJn6W5ONUGVU=;
 b=EeDzk9x2arYjW5h78A/fIgZM2XvWKh8jwpG21GGpzJwjVxuYLIH0QVYa5W6eTZJ2vl
 7oZYxIkcbGVWU36pYxux2LwPSzSvp+v1kQ7LZmvMNt12kEKMufTR+nRtPWTIqG+NaaOo
 q/PAP2zPmdxcisal7NnO7s05zgi2tcLoHJ8Qm8xGq3NfbbAwsl4RSmIHxvWSuqbiHXRZ
 SpG2+K+L6dr2jsjefwnv5lTTH8tPcO+epm2bLXBZKWmBWA/yrrUa/jehtGjKcsX3e2v7
 k3wkdfq/Pt9Qy/YtkmJy3J3avPLXSN8T1QF6PjnHPVA8tAqtoUrqDHJ6Ym1HbPxRLsbb
 ZsNw==
X-Gm-Message-State: AC+VfDwt67KQMoOTcAO52kHDKnTeoyuyAo1ml1TjpkDsb7WNL+744MSG
 2wPgszhlsiuA8oPQeV3cJ7X47xPxKsywyEcGnpLbvfss8my5Ybmhadpde8mN++s0D2txaQYy/s8
 re/sqtZH8FPeKObA=
X-Received: by 2002:ac8:5c50:0:b0:3f5:315f:5c1d with SMTP id
 j16-20020ac85c50000000b003f5315f5c1dmr3733223qtj.4.1685545420727; 
 Wed, 31 May 2023 08:03:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5eiCoalt+B8Z53Vv2GeTWPQy2rFSVOHaF7LAYcmGi5S3IV04OWQMJbwjgCCmL/0fuZCDyy+g==
X-Received: by 2002:ac8:5c50:0:b0:3f5:315f:5c1d with SMTP id
 j16-20020ac85c50000000b003f5315f5c1dmr3733132qtj.4.1685545419715; 
 Wed, 31 May 2023 08:03:39 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 cf18-20020a05622a401200b003f6ac526568sm6020351qtb.39.2023.05.31.08.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 08:03:38 -0700 (PDT)
Date: Wed, 31 May 2023 11:03:37 -0400
From: Peter Xu <peterx@redhat.com>
To: gudkov.andrei@huawei.com
Cc: qemu-devel@nongnu.org, quintela@redhat.com, eblake@redhat.com,
 armbru@redhat.com, berrange@redhat.com, zhengchuan@huawei.com
Subject: Re: [PATCH v2 0/4] Migration time prediction using calc-dirty-rate
Message-ID: <ZHdhycvhn/lWJQxy@x1n>
References: <cover.1682598010.git.gudkov.andrei@huawei.com>
 <ZHYaajucX3WbO5oW@x1n>
 <ZHdd0BDefsv02SWX@DESKTOP-0LHM7NF.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZHdd0BDefsv02SWX@DESKTOP-0LHM7NF.china.huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

On Wed, May 31, 2023 at 05:46:40PM +0300, gudkov.andrei@huawei.com wrote:
> On Tue, May 30, 2023 at 11:46:50AM -0400, Peter Xu wrote:
> > Hi, Andrei,
> > 
> > On Thu, Apr 27, 2023 at 03:42:56PM +0300, Andrei Gudkov via wrote:
> > > Afterwards we tried to migrate VM after randomly selecting max downtime
> > > and bandwidth limit. Typical prediction error is 6-7%, with only 180 out
> > > of 5779 experiments failing badly: prediction error >=25% or incorrectly
> > > predicting migration success when in fact it didn't converge.
> > 
> > What's the normal size of the VMs when you did the measurements?
> 
> VM size in all experiments was 32GiB. However, since some of the pages
> are zero, the effective VM size was smaller. I checked the value of
> precopy-bytes counter after the first migration iteration. Median value
> among all experiments is 24.3GiB.
> 
> > 
> > A major challenge of convergence issues come from huge VMs and I'm
> > wondering whether those are covered in the prediction verifications.
> 
> Hmmm... My understanding is that convergence primarily depends on how
> agressive VM dirties pages and not on VM size. Small VM with agressive
> writes would be impossible to migrate without throttling. On the contrary,
> migration of the huge dormant VM will converge in just single iteration
> (although a long one). The only reason I can imagine why large VM size can
> negatively affect convergence is due to the following reasoning: larger VM
> size => bigger number of vCPUs => more memory writes per second.
> Or do you probably mean that during each iteration we perform
> KVM_CLEAR_DIRTY_LOG, which is (I suspect) linear in time and can become
> bottleneck for large VMs?

Partly yes, but not explicitly to CLEAR_LOG, more to the whole process that
may still be relevant to size of guest memory, and I was curious whether it
can keep being accurate even if mem size grows.

I assume huge VM normally should have more cores too, and it's even less
likely to be idle if there's a real customer using it (rather than in labs,
if I'm a huge VM tenant I won't want to make it idle anytime).  Then with
more cores there's definitely more chance of having higher dirty rates,
especially with the larger mem pool.

> Anyway, I will conduct experiments with large VMs.

Thanks.

> 
> I think that the easiest way to predict whether VM migration will converge
> or not is the following. Run calc-dirty-rate with calc-time equal to
> desired downtime. If it reports that the volume of dirtied memory over
> calc-time period is larger than you can copy over network in the same time,
> then you are out of luck. Alas, at the current moment calc-time accepts
> values in units of seconds, while reasonable downtime lies in range 50-300ms.
> I am preparing a separate patch that will allow to specify calc-time in
> milliseconds. I hope that this approach will be cleaner than an array of
> hardcoded values I introduced in my original patch.

I actually haven't personally gone through the details of the new
interface, but what you said sounds reasonable, and happy to read the new
version.

-- 
Peter Xu


