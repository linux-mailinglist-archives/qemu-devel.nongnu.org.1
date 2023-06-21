Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC0D7384AA
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:16:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBxge-00032b-6c; Wed, 21 Jun 2023 09:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBxgX-0002su-EE
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBxgV-0001kY-EZ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687353342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W4yv9YLdlvUkn/cVF/3Tg0IcTtYjZPY5DSdDIquMwe4=;
 b=az3wt1RYwNfnuMEqaeR0OJ9mC+WXBx5dTfHjkuhXz2GopgchYTf110STT8nRLuFGAo4nLN
 +x8idQYqSrZlabpTk2Fh8DW2ripPYuvm3lTxnsr05va4qfrlrK3w6Y104qWZ1J3W1j1t4R
 BPL0w6DIz449p0qALryPrALHAwCryFc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-sbbusSQrMIiiq1ug1mA6cA-1; Wed, 21 Jun 2023 09:15:41 -0400
X-MC-Unique: sbbusSQrMIiiq1ug1mA6cA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3ff1fec3500so6800491cf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 06:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687353340; x=1689945340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4yv9YLdlvUkn/cVF/3Tg0IcTtYjZPY5DSdDIquMwe4=;
 b=D8NpZgK2tQJ98a6Nuv2vG+TrFgvM4DsqJybpoTn6wrb3pW6ceWh0uedFc8vtxpzbHf
 GQPeiNCRgoX+0tfzovoAgenLGVHXvnsbRBQHP18/hu7+e9iItP8KUlaUilRvLZzhebyN
 fCWvInQQ1XW4IyH512WIWnz1OqtwaaY8/TVallZxo6MBARJIzmKB3p1cR6M8sTOayclg
 1GXoYL1qkeIPWW4p4pCnqoFWlax3I8GRypOVamtaql1wGmiXns2RSl7YlS2s4J2BapL/
 YAkV5Y9SDHiWuHMeyZAAWHXwWUfp0Tx+Soa+m3UjYiWyrxOXO81BL8e6A3+OrXRMthbB
 APbg==
X-Gm-Message-State: AC+VfDzYSF8E5dpD72QsdGYzRT32yiVaHCWLd0ffb6yzXpxl6k9XBH6T
 vqy/xU3XK2K2WTG5fTVzSfqMbv3G6R+agihy2XNkcrIwGgUj8gH7TzBm7jt4iecu7v04+fbFfPc
 GCPOribNmv08PA3Q=
X-Received: by 2002:a05:622a:292:b0:3ff:3151:a8a7 with SMTP id
 z18-20020a05622a029200b003ff3151a8a7mr4572198qtw.3.1687353340639; 
 Wed, 21 Jun 2023 06:15:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tvkISMNy4U0Gwk+m8GyFLtB2udhhupK9+/rswzN4MyLF/x3+xCU/KJkBT5QyIMpVswZxjuQ==
X-Received: by 2002:a05:622a:292:b0:3ff:3151:a8a7 with SMTP id
 z18-20020a05622a029200b003ff3151a8a7mr4572176qtw.3.1687353340324; 
 Wed, 21 Jun 2023 06:15:40 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f15-20020ac8464f000000b003fecd4f0063sm2303919qto.95.2023.06.21.06.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 06:15:39 -0700 (PDT)
Date: Wed, 21 Jun 2023 09:15:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 03/42] migration-test: simplify shmem_opts handling
Message-ID: <ZJL3+lW/VX6QLmeT@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-4-quintela@redhat.com> <ZJG/jqmk1hHwzXpJ@x1n>
 <87pm5pb17u.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pm5pb17u.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 21, 2023 at 11:42:45AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Fri, Jun 09, 2023 at 12:49:04AM +0200, Juan Quintela wrote:
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  tests/qtest/migration-test.c | 9 ++++-----
> >>  1 file changed, 4 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> >> index 73b2f01427..95ccc9bce7 100644
> >> --- a/tests/qtest/migration-test.c
> >> +++ b/tests/qtest/migration-test.c
> >> @@ -681,9 +681,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >>              "-object memory-backend-file,id=mem0,size=%s"
> >>              ",mem-path=%s,share=on -numa node,memdev=mem0",
> >>              memory_size, shmem_path);
> >> -    } else {
> >> -        shmem_path = NULL;
> >> -        shmem_opts = g_strdup("");
> >>      }
> >>  
> >>      cmd_source = g_strdup_printf("-accel kvm%s -accel tcg%s%s "
> >> @@ -696,7 +693,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >>                                   machine_opts ? " -machine " : "",
> >>                                   machine_opts ? machine_opts : "",
> >>                                   memory_size, tmpfs,
> >> -                                 arch_source, shmem_opts,
> >> +                                 arch_source,
> >> +                                 shmem_opts ? shmem_opts : "",
> >>                                   args->opts_source ? args->opts_source : "",
> >>                                   ignore_stderr ? ignore_stderr : "");
> >>  
> >> @@ -718,7 +716,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >>                                   machine_opts ? " -machine " : "",
> >>                                   machine_opts ? machine_opts : "",
> >>                                   memory_size, tmpfs, uri,
> >> -                                 arch_target, shmem_opts,
> >> +                                 arch_target,
> >> +                                 shmem_opts ? shmem_opts : "",
> >
> > Isn't this adding duplications instead?
> 
> I don't follow.
> 
> > Meanwhile, shmem_opts right now is auto-free.  If we do this we don't need
> > it to be auto-free anymore..
> 
> We need.
> It can still be from g_strdup_printf().
> 
> What this patch change is that it will never be (again) "".
> 
> It is going to be NULL or a real string, like all the other options.
> The real string is generated, so it needs to be auto_free.

Ah ok.. after I read some other reply I think I see what you mean.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


