Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A2E7122C7
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:56:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TEV-0005yp-BI; Fri, 26 May 2023 04:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2TER-0005y5-TG
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2TEQ-0006NA-Bj
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685091329;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gRK3S2ZyQSdewueIapIOeT+/yJmBHA9usxo545mnMeg=;
 b=Kp0MHc7U51VBGFaov1cFqAC2D53qGzMEZAb3vFT3nQcAzavhuVJ7SHS85POILjNnmtwcL4
 cYmYqcXthZmW1Q16ksD31Rl6ISiWKY1Z5lMuPLsGhyIo9Z+FOmKOSWTfVY8UCtyiC263q7
 rV2mXYbhjvCBbMJ3K9IhF+P8gY+VdmI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-qIffJ19nPhuqGh_FGqEayw-1; Fri, 26 May 2023 04:55:20 -0400
X-MC-Unique: qIffJ19nPhuqGh_FGqEayw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30a88ed463eso204780f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685091319; x=1687683319;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRK3S2ZyQSdewueIapIOeT+/yJmBHA9usxo545mnMeg=;
 b=a1jRg6ZjgVIrO9BiRaDDGVLrbMGGGEI8VsQXEAKpqbmedJ8gWu/cb0zMohXq82lNWF
 k1sql1PDwzBquVpbhZ44/6r3rloktKT9zexAxV/ygC6D/KU2Xk7pxmqLkwShg0G3L4lc
 6FajrzZui+/CkFvx4MiJSXN884UqIFdtNrWdZziKxP4ZXTManL6dF3jUAVDSnS5kbbSc
 vKgNz7lkawd0+tfF5gLs0xaX9ubl5aATLSRG7nCez06pz0BEMcqTgDGYxh5RgEPMjqwE
 TiicEFo3mSXIuGTQuPptYh+oNEV0qsawKNWJ/XdXcX4RCgmPOFaTi6pjowr5TX1Mi1fY
 BF/Q==
X-Gm-Message-State: AC+VfDxXhu2G+qFTyxL/5nuWBaPjkR8oIdujlSxC5kYgjGuQ6Nxe0+X0
 BCFTH4mpJiKEtWJxdux/Nbw+lpdEGNLLg0lZHL2vE++epxMpCNtcUNgs4OxYr5/iCMBiWhVikc+
 TsmAKs5/PDPQi6is=
X-Received: by 2002:adf:ef4c:0:b0:2f9:61d4:1183 with SMTP id
 c12-20020adfef4c000000b002f961d41183mr812109wrp.45.1685091319664; 
 Fri, 26 May 2023 01:55:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5RGIpVax1JV4yrZm08Vf5i7Bzw6/gnfL4bJrcrve18k6ajlgRJsOgF0doH5ieRHUrtiRmMsA==
X-Received: by 2002:adf:ef4c:0:b0:2f9:61d4:1183 with SMTP id
 c12-20020adfef4c000000b002f961d41183mr812088wrp.45.1685091319377; 
 Fri, 26 May 2023 01:55:19 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b0030647449730sm4474117wrm.74.2023.05.26.01.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 01:55:18 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,  David Gibson
 <david@gibson.dropbear.id.au>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Fam
 Zheng <fam@euphon.net>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>,  Halil Pasic <pasic@linux.ibm.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  qemu-ppc@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,  John Snow
 <jsnow@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-block@nongnu.org,  Eric Blake <eblake@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PULL 09/12] migration: Use migration_transferred_bytes() to
 calculate rate_limit
In-Reply-To: <5023cb18-9e9a-4666-e6b5-a7eb0e8dbd6c@proxmox.com> (Fiona Ebner's
 message of "Tue, 23 May 2023 14:31:41 +0200")
References: <20230518171304.95006-1-quintela@redhat.com>
 <20230518171304.95006-10-quintela@redhat.com>
 <5023cb18-9e9a-4666-e6b5-a7eb0e8dbd6c@proxmox.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 10:55:18 +0200
Message-ID: <877csv3215.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Fiona Ebner <f.ebner@proxmox.com> wrote:
> Am 18.05.23 um 19:13 schrieb Juan Quintela:
>> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
>> index feec7d7369..97759a45f3 100644
>> --- a/migration/migration-stats.c
>> +++ b/migration/migration-stats.c
>> @@ -24,7 +24,9 @@ bool migration_rate_exceeded(QEMUFile *f)
>>          return true;
>>      }
>>  
>> -    uint64_t rate_limit_used = stat64_get(&mig_stats.rate_limit_used);
>> +    uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
>> +    uint64_t rate_limit_current = migration_transferred_bytes(f);
>> +    uint64_t rate_limit_used = rate_limit_current - rate_limit_start;
>>      uint64_t rate_limit_max = stat64_get(&mig_stats.rate_limit_max);
>>  
>>      if (rate_limit_max == RATE_LIMIT_DISABLED) {
>
> Hi,
> just wanted to let you know that the call to
> migration_transferred_bytes(f) here can introduce a huge performance
> penalty when taking a snapshot. I ran into the issue when testing
> something else, with a single-disk snapshot. Without this call it takes
> about two seconds, with the call about two minutes.

Ouch.

Now that everything is reviewed for that series I can sent the new set
of patches.  As I drop the counter it should just get the speed back.

New series comming that removed rate_limit counter altogether.

Can you take a look after I send it?

Thanks for the report.

And now that we are at it.  How are you testing this?

As you appears to be the bigger user of snapshots (or at least the
louder).  Creating tests/qtest/snapshot-test.c could be a good idea.

1st to check this kind of breakage.
2nd so I be sure that we don't "pesimize" your use case.

Hint, hint.

2 seconds vs 2 minutes.

A more detailed explanation that what are you doing would be great.
I.e. you are taking lots of snapshots by second or what?

Later, Juan.


