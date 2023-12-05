Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2FC8060E6
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 22:38:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAd71-0000SO-Bw; Tue, 05 Dec 2023 16:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAd6y-0000RO-RZ
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:37:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAd6w-0008Qz-Pq
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701812266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gPLZyY1oIOHxhalx9db4V5w/T3deSAe8KelXdb7nwZM=;
 b=gXfbUCeUHqUjW30/UCWi7OlLnt13dCEIdyf3CQCF8FTsflJkFvo8IS+Iz9Fbp7eqtmP1ef
 YOaCH8aWmlzKopSyjHP9bnsfv6gAjR9aVXhCoYRFa6DdWdRR5HfnIvzm7HxAOMQprcMykQ
 3g/HwbxNlb0oAGFY7nivPvubqeoNaGM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-60Pv_JVxM0a2sDmJkyYgiQ-1; Tue, 05 Dec 2023 16:37:44 -0500
X-MC-Unique: 60Pv_JVxM0a2sDmJkyYgiQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3b85dcecb63so1262552b6e.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 13:37:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701812264; x=1702417064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPLZyY1oIOHxhalx9db4V5w/T3deSAe8KelXdb7nwZM=;
 b=W6aCCT7EJ9Ei1Spj61T8KVyDtZ8Irs50qiAc8d3H+1h1wZxNHVMMe85XZj88bhQl3H
 YpDM4BkUXImakcPOCe1QAnYHVZMtx96LfafSsPi+/ilyH/F0eHtonWUNe0kQgpJl05ty
 IPGm/oNkpTpti5S+ms7T5mC2SQSvovmcme1PK63tA8tryFsFO1e6lPyWDOsr4GT+iX8/
 F8qpusnj4OXU2OXn0ndVPPUP1ai49c19W31njYe6VoPBMrocVx7L+xDX3JpJGvz3nCXd
 2ATZvOSRMDGC86frmyZRQ7kg9/btOpvkmnHOsqHkVDGt7X7Z28OaTG8We55KhKwBVZUk
 ntYw==
X-Gm-Message-State: AOJu0YyOr75zfDgaJzbLTlza45dUh6TMKONOTmhWB0mlpi6Rl20v0s6w
 FXaAkvp9f77nML4IjS3e28Cif4xPLIm/Fnc0GfNJIxzWx7xi8bTorLtjpGmBYS5ozTwmAxlvHwL
 sXjv2VMe5nXktWxI=
X-Received: by 2002:a05:6808:1827:b0:3b8:9714:34a7 with SMTP id
 bh39-20020a056808182700b003b8971434a7mr24955868oib.4.1701812264108; 
 Tue, 05 Dec 2023 13:37:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFg+IcuMVf46f5n6aA0ZsUVBSoy0C26Z4FEDWcw3ma2FjZ3ezGmThRovJyjnou8woxYyrstwA==
X-Received: by 2002:a05:6808:1827:b0:3b8:9714:34a7 with SMTP id
 bh39-20020a056808182700b003b8971434a7mr24955855oib.4.1701812263824; 
 Tue, 05 Dec 2023 13:37:43 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 y9-20020a05620a44c900b0077f0a4bd3c6sm2378099qkp.77.2023.12.05.13.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 13:37:43 -0800 (PST)
Date: Tue, 5 Dec 2023 16:37:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 00/14] fix migration of suspended runstate
Message-ID: <ZW-YJZG36Z0aw3PW@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <a0350701-617e-43a2-b856-02c35a203fb8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0350701-617e-43a2-b856-02c35a203fb8@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Dec 05, 2023 at 01:52:23PM -0500, Steven Sistare wrote:
> Hi Peter and Fabiano,
> 
> Any comments on these patches, before I send V7?  They are not affected by
> the other changes we have discussed, except for renaming runstate_is_started
> to runstate_is_live.
> 
>   [PATCH V6 04/14] cpus: vm_resume
>   [PATCH V6 06/14] migration: preserve suspended runstate
>   [PATCH V6 07/14] migration: preserve suspended for snapshot
>   [PATCH V6 08/14] migration: preserve suspended for bg_migration

One nitpick I put in the reply there, all look good to me in general.

Side note: I'll be away for the rest of the week.

Thanks,

-- 
Peter Xu


