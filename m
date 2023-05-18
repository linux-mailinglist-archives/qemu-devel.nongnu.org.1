Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2E0708621
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 18:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzgg1-0003sT-DE; Thu, 18 May 2023 12:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzgfz-0003pr-At
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzgfv-00025G-Jq
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684428022;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KGtmDDzQqcT9tGxh+j+b2s05ATegQEPbU8TtbVFKcEk=;
 b=g59/etZjalawKcuzoJdOM1REtHRY67mQtrs/gT+dUiIC3cqz8xKf2t2CJ1ReXEPyowCa2t
 /QGohmKg55YiY8BVrZRE8vWnw3l7rWuoJiYQDoaaMRbmMysDWZi1CVZW7qyz+NcE4SjBYt
 IuNKer4s4+rJN5UOvX7ccOz4T0gSfB8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-eOp7NGEkNfa6bH4YsmjQWA-1; Thu, 18 May 2023 12:40:21 -0400
X-MC-Unique: eOp7NGEkNfa6bH4YsmjQWA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f42d18a079so13320395e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 09:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684428020; x=1687020020;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGtmDDzQqcT9tGxh+j+b2s05ATegQEPbU8TtbVFKcEk=;
 b=BxgI62hlAGoXDkVoU52lwrk5BUPylpa/uto50MdWNFuPYH+fDv8OspwZMeV9A2so//
 NjdA1M32kmxQ9NK9vgZ0jqmVcZY5Lilne6iv4gLirwUTmcYbbzuQWbD43onA1rprc16N
 fbsQ80Xhb2AazKjRG2zMi4zy9NtHNtekot+sHL6idsQ7Jr0TBgI6TCQP1KKAbSSfNt9p
 li63lTrq9TpLvBTobMiVnMJq49f+IPj6R3Y8PuUZwouQZ21mQL3z6l6lZ1TsFMYg57kH
 62Cn3ytOVCXFrFVjcz+JgimxqbhGbnS1xku1UklP+XvItsO8uHVzspshMGSXsT/P5Kh3
 gC6A==
X-Gm-Message-State: AC+VfDxdvWyi4Xac+pUKqREtyrhIsBjfp96PhwE6mYNPhdTks7cUGp6s
 Iiv/Ho+jXqFmlJWDhBTP9EW6EN5t0t178f8ut5OQ7WVakaagIGsTqxYrLiuPuzRJ20JCnON23lg
 FWG1nrPE+bUULGKg=
X-Received: by 2002:a1c:7415:0:b0:3f4:253b:92ab with SMTP id
 p21-20020a1c7415000000b003f4253b92abmr2205447wmc.8.1684428020164; 
 Thu, 18 May 2023 09:40:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70xxUK94LVhpGUQ3JKYGonrOKVYyhTvTBXpPxyqaVAQBMCZwfRjJJN8Cj2YKD9SOnOd+R6Uw==
X-Received: by 2002:a1c:7415:0:b0:3f4:253b:92ab with SMTP id
 p21-20020a1c7415000000b003f4253b92abmr2205430wmc.8.1684428019809; 
 Thu, 18 May 2023 09:40:19 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 z2-20020adfe542000000b0030647449730sm2708553wrm.74.2023.05.18.09.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 09:40:19 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  David Hildenbrand
 <david@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org,  Eric Blake <eblake@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  John Snow
 <jsnow@redhat.com>,  Halil Pasic <pasic@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Gibson
 <david@gibson.dropbear.id.au>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  Greg Kurz
 <groug@kaod.org>,  qemu-ppc@nongnu.org,  qemu-s390x@nongnu.org,  Fam Zheng
 <fam@euphon.net>,  Thomas Huth <thuth@redhat.com>,  =?utf-8?Q?C=C3=A9dric?=
 Le Goater
 <clg@kaod.org>,  Leonardo Bras <leobras@redhat.com>,  Ilya Leoshkevich
 <iii@linux.ibm.com>
Subject: Re: [PATCH 21/21] migration/multifd: Compute transferred bytes
 correctly
In-Reply-To: <ZGZTCAHV5M/+w3VS@x1n> (Peter Xu's message of "Thu, 18 May 2023
 12:32:08 -0400")
References: <20230508130909.65420-1-quintela@redhat.com>
 <20230508130909.65420-22-quintela@redhat.com> <ZGZTCAHV5M/+w3VS@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 18:40:18 +0200
Message-ID: <87o7mhbnkd.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> On Mon, May 08, 2023 at 03:09:09PM +0200, Juan Quintela wrote:
>> In the past, we had to put the in the main thread all the operations
>> related with sizes due to qemu_file not beeing thread safe.  As now
>> all counters are atomic, we can update the counters just after the
>> do the write.  As an aditional bonus, we are able to use the right
>> value for the compression methods.  Right now we were assuming that
>> there were no compression at all.
>
> Maybe worth mention that initial packet is also accounted after this.

Ok.
>>  
>> +            stat64_add(&mig_stats.multifd_bytes, p->next_packet_size);
>> +            stat64_add(&mig_stats.transferred, p->next_packet_size);
>
> Two nits:
>
> Maybe merge the two so half atomic operations?

On my tree, to send after this got in:

77fdd3475c migration: Remove transferred atomic counter

O:-)

> Also maybe also worth having a inline helper for adding both multifd_bytes
> and transferred?

I am removing it.

After next set of packates:

rate limit is calulated as:

begining_period = migration_transferred_bytes();
...

bytes_this_period = migration_transferred_bytes() - begining_period;

transferred is calculated as:
- multifd_bytes + qemu_file_bytes;

So things get really simple.  As all counters are atomic, you do a
write and after the write to increse the write size to the qemu_file or
to the multifd_bytes.  And that is it.


> With/without that, all look good:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks, Juan.


