Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC8C7B8658
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:20:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5X3-0005cR-4W; Wed, 04 Oct 2023 13:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo5X0-0005br-KE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo5Wu-0004FE-VU
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696439964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZbKKCC+1E41i6ysWm5BYKfHCcHLldGqv/+wT8RhsgR0=;
 b=h61UsqFyOYyPQTwRweFAfqkWksGyxe74ou2nEf7e5QqppR9QBo7TSidKPGscnSyf1+6jjn
 Ay3Agtpr2iC7NVYRvWE05dSuEz0J6Pc+8UXxXmOTbzajQyU7onQEQxZzMttBEjjgmWCg+r
 0He8BRz/ieOdOVW5NgSGY2bwTU8o0S0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-jo_mo6ouPAC_3NQVLK-6dg-1; Wed, 04 Oct 2023 13:19:22 -0400
X-MC-Unique: jo_mo6ouPAC_3NQVLK-6dg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4194e7f41e1so107381cf.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696439962; x=1697044762;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZbKKCC+1E41i6ysWm5BYKfHCcHLldGqv/+wT8RhsgR0=;
 b=Og34a3bDHNRn/E3MnAjfYHqFkmG1huLGaWRX3UtVgiaLiZO7/gV7oJN0QBJ4pD4Zyv
 O7dgRy9eF1Ka8NdJxnNZZ1BoCnZIpPQP15U1mhpuu85jskMHMpRavvCvRHm7XgzZ5vSa
 0HcaEwkUU4gmh8Sx6EcM9wLptE+Eb2l1xBoDWaxivnwqgpC61gKywY12lsBg7rAGUlmu
 lfrfBFYtiLz998OSUK5OgZ0wDoL8i4q8/zdSbxZPmLLMQRUf8Rj1cZQt52r+Mm+ZDdlB
 /Bn9nHUlUveQpMIcE7mqz4YSGdXl/OJyHgCVt8fDGR/AzDBBmJNMDBbwlIoC0DCl80Bj
 ANvA==
X-Gm-Message-State: AOJu0Ywy/Wi7KueVtsY3tHdGCDlOdwYCO+u/FkkfHeVx5UOktLd7uBvx
 nQ7CwprQknSmlt07sT84Nl7oUXQHhZFeYf1twPZY5mBt4HQblTAIsTerFg6B/mzIOF7d+jMD1Sp
 m6Pmepvk+rvQTbB8=
X-Received: by 2002:a05:622a:1802:b0:40f:f509:3a85 with SMTP id
 t2-20020a05622a180200b0040ff5093a85mr3120490qtc.6.1696439962401; 
 Wed, 04 Oct 2023 10:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk+nHcABPUxWWENflRa81j2sHvrzqn0b++G2n8oziB5K5dMIz818AWfybRK6U58gntpL4NUg==
X-Received: by 2002:a05:622a:1802:b0:40f:f509:3a85 with SMTP id
 t2-20020a05622a180200b0040ff5093a85mr3120471qtc.6.1696439962066; 
 Wed, 04 Oct 2023 10:19:22 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c8-20020a05622a058800b003f6ac526568sm1354689qtb.39.2023.10.04.10.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 10:19:21 -0700 (PDT)
Date: Wed, 4 Oct 2023 13:19:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: [PATCH 0/5] migration: Downtime observability improvements
Message-ID: <ZR2emE8jdcYRLVUr@x1n>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230926161841.98464-1-joao.m.martins@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 26, 2023 at 05:18:36PM +0100, Joao Martins wrote:
> For now, mainly precopy data, and here I added both tracepoints and
> QMP stats via query-migrate. Postcopy is still missing.

IIUC many of those will cover postcopy too, but not all?

I think the problem is postcopy didn't update downtime_start, however it
updates MigrationState.downtime, and probably we can start to keep it more
like precopy, e.g., in postcopy_start(), where downtime_start can be
time_at_stop (or it can be more accurate; now it's probably fetching the
timestamp too early).

Basically if we want to expose anything, especially some qapi object, IMHO
we'd better make it work for both pre/post copy because otherwise it'll be
hard for mgmt app to know which qemu supports precopy only, and which
support both (if we'll add that for postcopy too).

Thanks,

-- 
Peter Xu


