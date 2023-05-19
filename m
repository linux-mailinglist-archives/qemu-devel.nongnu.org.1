Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D6F709B65
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q027F-0006OV-Q5; Fri, 19 May 2023 11:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q027D-0006Ny-Dv
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q027B-0007i2-Ct
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684510434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K48XX57UrXjNoI73ISVORiX3PL+ZEToqZ90PZvWQolE=;
 b=d+ZVqk8HhFoJlfj7GKl8Q0UjOAxhST/WupMaKabv8cDESAvpvSWqQQdz18/hE2GshNelG/
 ER6KVpjRnpHsFQAUuzUoDAR8oXJzO2ibfsSCVMVwXEHlJYFl8oQ7p2AXApmJrSeflIaA+g
 xQ3wJWbioah6oOVrTqvFipef8R/WEpo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-LOI0chP2MkWuD9J-82q_LQ-1; Fri, 19 May 2023 11:33:51 -0400
X-MC-Unique: LOI0chP2MkWuD9J-82q_LQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-75957ffa241so8084485a.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684510431; x=1687102431;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K48XX57UrXjNoI73ISVORiX3PL+ZEToqZ90PZvWQolE=;
 b=C68ZkmQiiAfz7hDwpq3H2uvYLFhUPY3cdLtcW6S8rMLRbsQliRldCXufTPdRz+QMqd
 GspzJ1GZzIKogpB9Gh3qYZAP/AUYppuPo8usNquiKUVsYA8HNbhYkR/ygBs1OUcTBxt6
 hC3L9vMPgIuNroY0I8oauDx6iP3OCKTNK+bH6C5HULqdibcHrSIWE5/GjYV+Udz8e8Ac
 VIsxAasODj46F5MCS0Bh1KjUvvqh60QMS7Q6rhQsNfvx/Fahcim3zlHFkCc1NM4fPpw0
 s0jsz9wOJ2JHyk54HBxA0L+dPagMMAoXKZbubTwiP3SIo7E9GfduZa9Std/BN/26oWM5
 hUyw==
X-Gm-Message-State: AC+VfDzRKrg+bBtzbkFD5UiikFknot18xXTbbZpBkz2PA0rEGbzRoG6x
 kqYviGfV8I/hLk93TDIBSEEGdBPi2btHqXjNhlLbWkSMwXkW1SIKXL3GKYXyigt/K2swQBgMF0s
 wsQQQ+0gOyNS5Bwk=
X-Received: by 2002:a05:6214:4009:b0:5ed:c96e:ca4a with SMTP id
 kd9-20020a056214400900b005edc96eca4amr4915575qvb.1.1684510430801; 
 Fri, 19 May 2023 08:33:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7abGNbWmfsHBZXagtWWrOuksa54bseKgDwalBWb1GZ5C4Ll1yHHT9zH5Q+JIeNdk+l0qfR/g==
X-Received: by 2002:a05:6214:4009:b0:5ed:c96e:ca4a with SMTP id
 kd9-20020a056214400900b005edc96eca4amr4915553qvb.1.1684510430527; 
 Fri, 19 May 2023 08:33:50 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 f11-20020a05621400cb00b006238dc71f5csm1357536qvs.144.2023.05.19.08.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 08:33:50 -0700 (PDT)
Date: Fri, 19 May 2023 11:33:49 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "quintela@redhat.com" <quintela@redhat.com>,
 "Wang, Lei4" <lei4.wang@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Message-ID: <ZGeW3R5McptUueJF@x1n>
References: <20230518160026.57414-1-wei.w.wang@intel.com>
 <ZGZ6Yqx2+dOp+Q73@x1n>
 <DS0PR11MB637350354B0285ABF3FA1BD9DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGeWF4lzBldLLH/y@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGeWF4lzBldLLH/y@x1n>
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

On Fri, May 19, 2023 at 11:30:31AM -0400, Peter Xu wrote:
> On Fri, May 19, 2023 at 02:34:57AM +0000, Wang, Wei W wrote:
> > On Friday, May 19, 2023 3:20 AM, Peter Xu wrote:
> > > On Fri, May 19, 2023 at 12:00:26AM +0800, Wei Wang wrote:
> > > > qemu_start_incoming_migration needs to check the number of multifd
> > > > channels or postcopy ram channels to configure the backlog parameter (i.e.
> > > > the maximum length to which the queue of pending connections for
> > > > sockfd may grow) of listen(). So multifd and postcopy-preempt caps
> > > > require the use of deferred incoming, that is, calling
> > > > qemu_start_incoming_migration should be deferred via qmp or hmp
> > > > commands after the cap of multifd and postcopy-preempt are configured.
> > > >
> > > > Check if deferred incoming is used when enabling multifd or
> > > > postcopy-preempt, and fail the check with error messages if not.
> > > >
> > > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > 
> > > IIUC this will unfortunately break things like:
> > > 
> > >   -global migration.x-postcopy-preempt=on
> > > 
> > > where the cap is actually applied before incoming starts even with !defer so
> > > it should still work.
> > 
> > Actually the patch doesn’t check "!defer". It just checks if incoming has been started
> > or not. It allows the 2 caps to be set only before incoming starts. So I think the above
> > should work.
> 
> Ah yes indeed it keeps working, because we apply -global bits before setup
> sockets. Then it's fine by me since that's the only thing I would still
> like to keep it working. :)
> 
> If so, can we reword the error message a bit?  Obviously as you said we're
> not really checking against -defer, but established channels.  The problem
> is if something is established without knowing multifd being there it may
> not work for multifd or preempt, not strictly about defer.
> 
> How about:
> 
>   "Multifd/Preempt-Mode cannot be modified if incoming channel has setup"
> 
> ?

We may also want to trap the channel setups on num:

migrate_params_test_apply():

    if (params->has_multifd_channels) {
        dest->multifd_channels = params->multifd_channels;
    }

-- 
Peter Xu


