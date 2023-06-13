Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C26072E7EE
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 18:13:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q96dC-0007VT-31; Tue, 13 Jun 2023 12:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96d9-0007V5-8r
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96d7-0005uD-HX
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686672744;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QUNK7MOLNJUvdnWGTs/h+/EyblZwz0bl8Tr7iKOiHDI=;
 b=KY4IX3mRcha8CWfB/4RCtOtpQKRtxf6WtPDF9Sbr9m0Wf3wDEUnioQu0hYDBPElC94mcMJ
 t8wD/E7U0xwT+IhQ0rd5cfYbnVILZHrhpyAb4glnJJAGz3SL3+RBKlzXRHRAQ4WRtImMGs
 HRjPybcP/3vMXApzVBSVvS050ursQSM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-mrYv-KXbP3yLBJlcC0AEtQ-1; Tue, 13 Jun 2023 12:12:22 -0400
X-MC-Unique: mrYv-KXbP3yLBJlcC0AEtQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e55b42af1so3477914f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 09:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686672740; x=1689264740;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUNK7MOLNJUvdnWGTs/h+/EyblZwz0bl8Tr7iKOiHDI=;
 b=MN8N8DxpHSaWa+vBnLm9FACIUA20Uik9mMUh9JBHZJ74bCWB/VSEz06Zf2UX8Uxp76
 l11NkEt/Z93OGvvS5vTK4Q7J2v6NcDZmKJGP79LBmVwSieAnv4aafiF43NIrsvV3INWn
 jQPd6EQhWydIb1yoEE0GV//OIxGGJHv/CGGNygaqQjqidUGoQf20oUQubujBQqh/ey1U
 4OONMGBj94Qo04wTKgk+eLQQM9uz3DAsK7gyz9AtsYOIGsgmg08lmvzWIq7ZuQU50E3G
 HKD1TKKUDJxCkM/2CmJMJMlOrcNWu0BNGPvXIlXYEQjHrW7cvZCM9j8eFt2TYcBbNv0X
 hoPw==
X-Gm-Message-State: AC+VfDxcSxDfShEfYXEoRSNeoe2ykJz0k2KWIwLhX0225glmIp9mi9jr
 6bahBFrfXhapdao8JSYeeFn9/Kk1lefBWqhPRfuduLzFzBG5mfbXHeZZjfGRDFniyBmAfY5hO/I
 foqZDoQs5mFeFRdE=
X-Received: by 2002:a5d:44ca:0:b0:307:cb94:85de with SMTP id
 z10-20020a5d44ca000000b00307cb9485demr8107607wrr.11.1686672740323; 
 Tue, 13 Jun 2023 09:12:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7O2/lZoYzK31O4UD6Cc+P4lZNqwBDGIjOEIyTnwej9kRL+A/yL+ayACTm2MESyGAXjjvm4rg==
X-Received: by 2002:a5d:44ca:0:b0:307:cb94:85de with SMTP id
 z10-20020a5d44ca000000b00307cb9485demr8107591wrr.11.1686672740028; 
 Tue, 13 Jun 2023 09:12:20 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 d8-20020a5d6dc8000000b0030aec5e020fsm15694043wrz.86.2023.06.13.09.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 09:12:19 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Hailiang
 Zhang <zhanghailiang@xfusion.com>,  Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  qemu-block@nongnu.org,  Fam Zheng
 <fam@euphon.net>
Subject: Re: [PATCH v2 05/20] qemu_file: Use a stat64 for qemu_file_transferred
In-Reply-To: <ZH4n9jeN6PcoZ3A1@x1n> (Peter Xu's message of "Mon, 5 Jun 2023
 14:22:46 -0400")
References: <20230530183941.7223-1-quintela@redhat.com>
 <20230530183941.7223-6-quintela@redhat.com> <ZH4n9jeN6PcoZ3A1@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 13 Jun 2023 18:12:18 +0200
Message-ID: <87ttvbe3z1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Tue, May 30, 2023 at 08:39:26PM +0200, Juan Quintela wrote:
>> This way we can read it from any thread.
>> I checked that it gives the same value than the current one.  We never
>> use to qemu_files at the same time.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> The follow up patch may be better to be squashed or it's very confusing..

As said before, there used to be a nice:

if (old_counter != new_counter)
   printf(old_counter and new counter)

> Why do we need to convert mostly everything into atomics?  Is it modified
> outside migration thread?

Because we have four users of this stuff:

- io thread: needs it for info migrate basically
- migration_thread: needs it to know when to stop.  qemu_file is
  supposed to only happen here.
- ... until someone called peter decided to create another qemu file for
  preempt.  Current code don't account for this.
- multifd bytes is a completelly diffrent story, that is why it use its
  own atomics.

After this series go in, basically we only update one atomic for each
write (ok two yet, downtime/precopy/postocpy_bytes are still not
integrated).

But there used to be three:
- transferred
- multifd_bytes (for multifd pages)
- downtime/-precopy/postocpy

And we are back to only one (now we use transferred or multifd, never both).

> AFAIR atomic ops are still expensive, and will get more expensive on larger
> hosts,

If you care for performance, you are using multifd.
one atomic every 64 pages is kind ok.

For rate limiting, we do it 10 times a second, and:
a - it shouldn't matter with so few times
b - it is not a regression, we were already updating some
c - correct vs fast any day

And the other big improvement is that after this series, you can use any
counter on any thread.  No need to contorsions to update the rate_limit
that we used to have.

> IOW it'll be good for us to keep non-atomic when possible (and
> that's why when I changed some counters in postcopy work I only changed the
> limited set because then the rest are still accessed in 1 single thread and
> keep running fast).

void ram_transferred_add(uint64_t bytes)
{
    if (runstate_is_running()) {
        stat64_add(&mig_stats.precopy_bytes, bytes);
    } else if (migration_in_postcopy()) {
        stat64_add(&mig_stats.postcopy_bytes, bytes);
    } else {
        stat64_add(&mig_stats.downtime_bytes, bytes);
    }
    stat64_add(&mig_stats.transferred, bytes);
}

That is used everywhere, and I am dropping this to a single atomic.

Later, Juan.


