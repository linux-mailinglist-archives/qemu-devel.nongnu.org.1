Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0E7EA17A
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 17:47:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2a4u-0007Rq-3a; Mon, 13 Nov 2023 11:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r2a4r-0007RZ-Sb
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:46:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r2a4d-00016g-8d
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699893964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N9sdvsElH989P9p1L4gIexr2yH4t60hRRp7WLR8X6io=;
 b=ZPzew8tpkHoCFOEid6ZcjC40xxtMUntDByrRh1xaNMlBvsdXGtUlG8WMA/ajmTndVbUls6
 YJLk39LQE2ZGENpl3r3jS9FPCt6qe73dJtj9HiU+xKvZ0YuI+1yT+xs5FPwwxZZORt+BH9
 UZgEkvmrCUD3emoNHgrv+VNDNtF8l64=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-2pJwNiH1PX6OXGJes5cAqA-1; Mon, 13 Nov 2023 11:46:03 -0500
X-MC-Unique: 2pJwNiH1PX6OXGJes5cAqA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6ce2908d14dso458048a34.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 08:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699893962; x=1700498762;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9sdvsElH989P9p1L4gIexr2yH4t60hRRp7WLR8X6io=;
 b=HO0RNxsf4Ld5fftKIDBZ4pNJ+AboY/l+BhYm3CmasurMI0oZxyt1pI0ne+oCO/KmtJ
 Pmso6ho9cQA/MKICLFqxzFIxVDe8Tb8Q6khdMVsQBc64D2a2drXnEKYZA671CjiZUERu
 eeBqd6uTNtaTfrcIuHctX23pjroFv1v3RD2e6yE8AxaZt4mU6Rax8o7lwA7jDOu3aVmN
 lEn5gAPUnB5aFT82I5QPy4HHub/zI5oY1p3+gF6gaHW141xZugjXGMOMLaoa98OLA0iP
 Uxt8Zq4Iwj/ZUKlX0jrYXQgOdLvd+RWytU77aI/xYEYc9trwQtW8SzdO72+UZS4T4ZU8
 kQow==
X-Gm-Message-State: AOJu0Yy7TRNFyZQkpciVDFrDYMGfadtfJRDBhIY97stkmLiVB0B4xI06
 PMTGeh9C3L/iHQ0YUM2IEWg9Od2sSHXCXpsIFS3Oj/RFwaWnASOSwhKRdUD3+bHYD/IAB82Nz2P
 ZjVKcvDSwh0+Eqcs=
X-Received: by 2002:a05:6808:13c7:b0:3b2:e4b7:2ad9 with SMTP id
 d7-20020a05680813c700b003b2e4b72ad9mr9234330oiw.5.1699893962269; 
 Mon, 13 Nov 2023 08:46:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx9fJjkjNSU9p1EpbL98wbLnBOFeLLD0BPotfCiKq7K/jZi02YDkmLxSkS3As0iNrWHQvfKw==
X-Received: by 2002:a05:6808:13c7:b0:3b2:e4b7:2ad9 with SMTP id
 d7-20020a05680813c700b003b2e4b72ad9mr9234315oiw.5.1699893961976; 
 Mon, 13 Nov 2023 08:46:01 -0800 (PST)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z22-20020a05620a101600b007671b599cf5sm1987174qkj.40.2023.11.13.08.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 08:46:01 -0800 (PST)
Date: Mon, 13 Nov 2023 11:45:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/2] migration/multifd: Move semaphore release into
 main thread
Message-ID: <ZVJSx6FOg8WfSbrz@x1n>
References: <20231109165856.15224-1-farosas@suse.de>
 <20231109165856.15224-3-farosas@suse.de> <ZU0rY662a5C1mvyf@x1n>
 <87pm0hzucq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pm0hzucq.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Nov 10, 2023 at 09:05:41AM -0300, Fabiano Rosas wrote:

[...]

> > Then assuming we have a clear model with all these threads issue fixed (no
> > matter whether we'd shrink 2N threads into N threads), then what we need to
> > do, IMHO, is making sure to join() all of them before destroying anything
> > (say, per-channel MultiFDSendParams).  Then when we destroy everything
> > safely, either mutex/sem/etc..  Because no one will race us anymore.
> 
> This doesn't address the race. There's a data dependency between the
> multifd channels and the migration thread around the channels_ready
> semaphore. So we cannot join the migration thread because it could be
> stuck waiting for the semaphore, which means we cannot join+cleanup the
> channel thread because the semaphore is still being used.

I think this is the major part of confusion, on why this can happen.

The problem is afaik multifd_save_cleanup() is only called by
migrate_fd_cleanup(), which is further only called in:

  1) migrate_fd_cleanup_bh()
  2) migrate_fd_connect()

For 1): it's only run when migration comletes/fails/etc. (in all cases,
right before it quits..) and then kicks off migrate_fd_cleanup_schedule().
So migration thread shouldn't be stuck, afaiu, or it won't be able to kick
that BH.

For 2): it's called by the main thread, where migration thread should have
not yet been created.

With that, I don't see how migrate_fd_cleanup() would need to worry about
migration thread

Did I miss something?

Thanks,

-- 
Peter Xu


