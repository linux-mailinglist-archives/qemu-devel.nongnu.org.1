Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3598739580
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 04:24:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC9yU-0002mb-RV; Wed, 21 Jun 2023 22:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9yS-0002lu-D2
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9yQ-000105-Ta
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687400581;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DzqftHJZuGuUvcgofzRZFS34qM7+GDbzBkVM9QqFKZY=;
 b=DmMqJ5rOiiXNv495fWk6HPajpi0Jas95RysJhJCaRx0INlTfjplcxvx18/VHGUcsVdQre7
 on0/Wq23ifQG/bKqBJ+73L3PB4lhUKkv5y2PgSuzXC7XJkPiJSbLsf5yTCPVaIn6h8Qb5Z
 29Z3HeYBW0BgQP3CMVAwbZTW4k2mnGk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-cV1oiD0CMqiAqISdh95TEw-1; Wed, 21 Jun 2023 22:22:58 -0400
X-MC-Unique: cV1oiD0CMqiAqISdh95TEw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31273e0507dso1729648f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 19:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687400577; x=1689992577;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DzqftHJZuGuUvcgofzRZFS34qM7+GDbzBkVM9QqFKZY=;
 b=E2G8Zo2PWHlTtTer6fg+aaR04fftePovfpd8xI/O+KAqMbRThNFtu8Tt1Me/eycQUu
 +dPxQQ6woLy15iEuksedYxc4+HcUiD2LUvToka+wLBOap1x5okNIifSppsdEVjt/5zx+
 z/IobiMmcqnuB5TGdH0w8DYjbBdm9ELVLJZ/MGCft59mkijCLXF/gx+ZkdyC6S6yzOn4
 XjrQT4tcswuBaumNk/UisXzBcG4nmSnmN8lyoeEywnkv2obaqQArJR7Ek/MFNBkjvKWD
 pGIqWq0Zt8QA9KbwgwaeTMqY0DD3Qv3PfaGzUDaazEKTtQkf2yIL/qEYpdXHxYBZZQMP
 CW7g==
X-Gm-Message-State: AC+VfDyeCErAeyd+pjGrYwG+akUvLfwcI2/ZvFdCfDI86oHSiMUbpQxK
 rSP3LvcwsDJhfmdNW6BcAGII1t1OLevLstJP5d7r/xkWrmFM/PM1zmh0J8x8ZBqxVTCGGRZgYYs
 j/YBjQpqMu+rD98Q=
X-Received: by 2002:adf:f3d0:0:b0:311:1bd2:de6f with SMTP id
 g16-20020adff3d0000000b003111bd2de6fmr14617544wrp.12.1687400577527; 
 Wed, 21 Jun 2023 19:22:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7u7/Hvn9NzUVsK+l6gpUrgLnGJq0EN3uu6j0+CNMIVr0yIALDdSeKvAm98/fL0EQ0/muDz1w==
X-Received: by 2002:adf:f3d0:0:b0:311:1bd2:de6f with SMTP id
 g16-20020adff3d0000000b003111bd2de6fmr14617535wrp.12.1687400577244; 
 Wed, 21 Jun 2023 19:22:57 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 m12-20020a7bcb8c000000b003f9b66a9376sm6260875wmi.42.2023.06.21.19.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 19:22:56 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Eric Blake <eblake@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  libvir-list@redhat.com,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
In-Reply-To: <e715e41d-b50a-3747-8007-e188e911a724@redhat.com> (Thomas Huth's
 message of "Wed, 21 Jun 2023 09:08:33 +0200")
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com>
 <e715e41d-b50a-3747-8007-e188e911a724@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 04:22:55 +0200
Message-ID: <875y7g8ccg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Thomas Huth <thuth@redhat.com> wrote:
> On 12/06/2023 21.33, Juan Quintela wrote:
>> Only "defer" is recommended.  After setting all migation parameters,
>> start incoming migration with "migrate-incoming uri" command.
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   docs/about/deprecated.rst | 7 +++++++
>>   softmmu/vl.c              | 2 ++
>>   2 files changed, 9 insertions(+)
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 47e98dc95e..518672722d 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -447,3 +447,10 @@ The new way to modify migration is using migration parameters.
>>   ``blk`` functionality can be acchieved using
>>   ``migrate_set_parameter block-incremental true``.
>>   +``-incoming uri`` (since 8.1)
>> +'''''''''''''''''''''''''''''
>> +
>> +Everything except ``-incoming defer`` are deprecated.  This allows to
>> +setup parameters before launching the proper migration with
>> +``migrate-incoming uri``.
>> +
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index b0b96f67fa..7fe865ab59 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -2651,6 +2651,8 @@ void qmp_x_exit_preconfig(Error **errp)
>>       if (incoming) {
>>           Error *local_err = NULL;
>>           if (strcmp(incoming, "defer") != 0) {
>> +            warn_report("-incoming %s is deprecated, use -incoming defer and "
>> +                        " set the uri with migrate-incoming.", incoming);
>>               qmp_migrate_incoming(incoming, &local_err);
>>               if (local_err) {
>>                   error_reportf_err(local_err, "-incoming %s: ", incoming);
>
> Could we maybe keep at least the smallest set of necessary parameters
> around? I'm often doing a "-incoming tcp:0:1234" for doing quick
> sanity checks with migration, not caring about other migration
> parameters, so if that could continue to work, that would be very
> appreciated.

I will try to explain myself here.

I think that everything except tcp works.
But when we have tcp, we have two cases where this is a trap:
- multifd channels:
  * if we default to a big number, we underuse resources in a normal
    case
  * if we default to a small number, we have the problem that if the
    user set "later" multifd-channels to a bigger number, things can
    break.
- postcopy+preempt:
  this case is also problematic, but easily fixable.  Put a default
  of 2 instead of 1.

The only other solution that I can think of is just fail if we set
multifd without incoming defer.  But more sooner than later we are going
to have to default to multifd, so ...

Later, Juan.


