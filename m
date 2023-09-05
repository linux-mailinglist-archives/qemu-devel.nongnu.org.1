Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D68C79290E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdZCG-0006Ul-Aj; Tue, 05 Sep 2023 12:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdZCB-0006UE-MJ
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdZC9-00031e-El
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693932388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7P0o1pV4ay4osDtu6EHBSK5iw9vixaEzfAafQzYyRY4=;
 b=UbnMpm6aF1vBjvBifXHyQ1kwlF0Mtzu5mOo+nkJnJwSZGYQ4CiYEzfq8RhC6Vga7r9BpaM
 YMcCael5h5W7BAVUKg/tLZI5W8lgmPjZcIlSNgYOrFRAY6SI0kAH52SEY+A3ozOVqS7Axb
 H4t3gbyDKligVSaszpGFGMklrLx4F2U=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-0NnlwZ3TPLKjx8kJGRJfaw-1; Tue, 05 Sep 2023 12:46:22 -0400
X-MC-Unique: 0NnlwZ3TPLKjx8kJGRJfaw-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5733de62ca4so304706eaf.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 09:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693932367; x=1694537167;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7P0o1pV4ay4osDtu6EHBSK5iw9vixaEzfAafQzYyRY4=;
 b=Kfh41ibbQuTziPIn28c9XZGms46XAARKRGelCGZjZ5tDYoSnUNLPnEv8pM4bf+g6RN
 7ZaXKgoNLbNe0b2WBTzdlyu7yODDND2Zxoy6ibW1KY7fdnA4vv/IEJMQdWEAd83rjJ3m
 wjOUJzBnnDss1n+BK9tWki4/Ncls/Y0WWWv3/OAs75RO9IiyKgIOmop3qo2vHzQQtPf/
 EOMjizvRDNjPzND/Ax78U1wB1zcZDxMhHgYmp+meAIY48jE12L5s3EZH2F9qZkmWQOAB
 Z0I1fpjRbQ714SKzQTqcbaNzF/OQ59nufEadjKn2anxvEkCEPvb3+bKGhp7VUwa/i+4V
 7Zhg==
X-Gm-Message-State: AOJu0YwJW+CUQystgI5S3tW4FVhQ9RVNYDLwyl6HKnT1rv1uvR2AZWFc
 T1aHlobKKuUUaMCu+KQ282/tCWFp+N2eOLkLs/PUWw/kga4Z1tZK2aK30W5LevlzQaeExzn76Fh
 fJcEDTDhxlh5o8a8=
X-Received: by 2002:a05:6808:6542:b0:3a9:ef9f:c4c1 with SMTP id
 fn2-20020a056808654200b003a9ef9fc4c1mr12682567oib.3.1693932367081; 
 Tue, 05 Sep 2023 09:46:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO0s9TJyZiA94Gsg9B25hUUZ8afAWhi9uqrlNmIQZhVQIeKtzNaIfF0HVLJO369XVGhzpdGw==
X-Received: by 2002:a05:6808:6542:b0:3a9:ef9f:c4c1 with SMTP id
 fn2-20020a056808654200b003a9ef9fc4c1mr12682551oib.3.1693932366867; 
 Tue, 05 Sep 2023 09:46:06 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h16-20020ac846d0000000b0040ff387de83sm4502892qto.45.2023.09.05.09.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 09:46:06 -0700 (PDT)
Date: Tue, 5 Sep 2023 12:46:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Chensheng Dong <chdong@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH for-8.2 v2 2/2] migration: Allow user to specify
 migration switchover bandwidth
Message-ID: <ZPdbS1pyl5Pzjh4T@x1n>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-3-peterx@redhat.com>
 <8bb36b56-e2f6-ece8-0d8f-90b87a3b5c40@intel.com>
 <ZPGizMa52LF7Qek1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPGizMa52LF7Qek1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Sep 01, 2023 at 09:37:32AM +0100, Daniel P. Berrangé wrote:
> > > When the user wants to have migration only use 5Gbps out of that 10Gbps,
> > > one can set max-bandwidth to 5Gbps, along with max-switchover-bandwidth to
> > > 5Gbps so it'll never use over 5Gbps too (so the user can have the rest
> > 
> > Hi Peter. I'm curious if we specify max-switchover-bandwidth to 5Gbps over a
> > 10Gbps network, in the completion stage will it send the remaining data in 5Gbps
> > using downtime_limit time or in 10Gbps (saturate the network) using the
> > downtime_limit / 2 time? Seems this parameter won't rate limit the final stage:)
> 
> Effectively the mgmt app is telling QEMU to assume that this
> much bandwidth is available for use during switchover. If QEMU
> determines that, given this available bandwidth, the remaining
> data can be sent over the link within the downtime limit, it
> will perform the switchover. When sending this sitchover data,
> it will actually transmit the data at full line rate IIUC.

I'm right at reposting this patch, but then I found that the
max-available-bandwidth is indeed confusing (as Lei's question shows).

We do have all the bandwidth throttling values in the pattern of
max-*-bandwidth and this one will start to be the outlier that it won't
really throttle the network.

If the old name "available-bandwidth" is too general, I'm now considering
"avail-switchover-bandwidth" just to leave max- out of the name to
differenciate, if some day we want to add a real throttle for switchover we
can still have a sane name.

Any objections before I repost?

Thanks,

-- 
Peter Xu


