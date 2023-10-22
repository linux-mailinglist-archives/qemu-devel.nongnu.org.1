Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2BD7D25CE
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 22:18:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quety-0001sU-Ls; Sun, 22 Oct 2023 16:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quetw-0001s8-Pb
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quetv-0006lZ-C2
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698005898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+6UEYQBu/Dqgh/sz0C77HuJTs8B/70/DderQeQMVTRg=;
 b=WeiaJZ17zcbDSUi0/9rb+ge42k1RNBE3SVeHcL1B8cUZ7PWuXcgBstj70Y/posyGKgH7e0
 a/GMVFfUEkKJ+y3JBo7B43FVR+rbhuDcxL8WS3SAdcxn/3fqcK613UCYLR75kkWPpfcUMG
 ViLldoIVhcYD1PSVPi3U01OHdbAcu/Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-W-_nbR0eOxeWKAXVdNLUag-1; Sun, 22 Oct 2023 16:18:06 -0400
X-MC-Unique: W-_nbR0eOxeWKAXVdNLUag-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66011f0d521so11045076d6.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 13:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698005886; x=1698610686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6UEYQBu/Dqgh/sz0C77HuJTs8B/70/DderQeQMVTRg=;
 b=GT3IiD6ylp40n1CvlFYHBpbz5gqO6pmyVkjbDttdWYmveFeEXh1Nk/stpzTLeExf8l
 qehZJVc+4KKqfiT797jL3Z9FUM7wDK4JXaLEWIOwDSXVd1X0ihcu8l1LazZWtqeqvvzx
 2JGwunqh+4qM8q1+KWSmQdUE7oQZfGDaozmeo4Z8D7djXQ350UGtAtj/4ZJTGSpaRqXa
 F0PRtQoJV7ye7wsYD9lQxd+17J+CrjD1IG0KsA+d3A76m2iOsJVd0YC0vFrDCyEFmXDm
 CvCvfbz6Qs6YN0EznV5pwZuQxVuuRznLSUK1dH5nwKcqWmAPXECsCxhC+b2vEPOByy5m
 ut5Q==
X-Gm-Message-State: AOJu0YwljFTIvtn2uszTeG92pzeNMWPkpTUrM44tP0k7QTzR3vU3xGRC
 HKmvm77hrMPRK2Syt/pISf1vQ1aLHlqnirNlriqY4J0NdCN3OLH7aGtR8XPGZN7EvS+MptLbg9P
 rvefh3KHnHwkzx6I=
X-Received: by 2002:a05:620a:2793:b0:76f:1846:2f6b with SMTP id
 g19-20020a05620a279300b0076f18462f6bmr7702423qkp.1.1698005886158; 
 Sun, 22 Oct 2023 13:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+r4qEvroebnsmNcncq8mOBVmGSOrDK/9Zf13YIB0Pmf+Few7iAJx48IplecLeiHHux0zAdw==
X-Received: by 2002:a05:620a:2793:b0:76f:1846:2f6b with SMTP id
 g19-20020a05620a279300b0076f18462f6bmr7702410qkp.1.1698005885835; 
 Sun, 22 Oct 2023 13:18:05 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u24-20020a05620a085800b007756e75b91bsm2215671qku.78.2023.10.22.13.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 13:18:05 -0700 (PDT)
Date: Sun, 22 Oct 2023 16:17:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: quintela@redhat.com, qemu-devel@nongnu.org,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
Message-ID: <ZTWDbc2b3PNQKizx@x1n>
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de>
 <87sf676kxt.fsf@secure.mitica> <87r0lqy83p.fsf@suse.de>
 <87wmvi3akc.fsf@secure.mitica> <87lebyy5ac.fsf@suse.de>
 <87a5se3161.fsf@secure.mitica> <ZTF9vL8yyn6McuTx@x1n>
 <87ttql20hz.fsf@secure.mitica> <87ttqlh32h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttqlh32h.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 20, 2023 at 09:48:54AM -0300, Fabiano Rosas wrote:
> > If pending_job == 0 -> owner of the channel is migration_thread and it
> > can use it.
> >
> > If pending_job > 0 -> owner of the channel is the channel thread and
> > migration_thread can't use it.
> 
> Do you really mean "migration_thread" here or just multifd_send_pages()?
> Because multifd_send_sync_main() doesn't care about this ownership
> rule. Does that mean that code is incorrect?

Yes, that's also what I was referring as the confusion, too.

[...]

> It's a semantic issue really, but I'd rather we avoid locking ourselves
> more into the "pages" idea for multifd threads. The data being sent by
> the multifd thread should be opaque.

I've put these ideas into a RFC patchset here:

[PATCH RFC 0/7] migration/multifd: quit unitifications and separate sync packet

I kept it "pending_job" there, avoid using "pages" as a name.

Fabiano, I have a patch there that dropped p->quit, so there will be
crossovers with your patchset.  I tried to leave that alone, but found I'd
better clean that up when add the send thread helpers.  Let's see how it
goes..

Thanks,

-- 
Peter Xu


