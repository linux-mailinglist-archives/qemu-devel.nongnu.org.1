Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B111708006
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzc3f-0003EL-7s; Thu, 18 May 2023 07:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzc3c-00037P-Vy
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzc3b-0003cU-Kh
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684410270;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=M8CBsU1YrLA8lTJurNNlZ6udQjgtu5HxOABPMwURlbw=;
 b=dCPKGRu8vI2jwT4QCHhPNpp0rtMTbMN0nnf/0VrFo6cPZXMDIpOUuq/zaRgG+1XDB4ais/
 ZW+PV7vbypDS9kbih5AkKz1dkskn4ndiUBhBNWgU8UV1yg0USoXLdk3hUlgAv8GJnmwfp1
 cU/JWLYkdjKdg4c9PSltGtWibP0olbQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-5slEz_AhNJSYRR870T_Y9A-1; Thu, 18 May 2023 07:44:26 -0400
X-MC-Unique: 5slEz_AhNJSYRR870T_Y9A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f429072212so8091205e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684410265; x=1687002265;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8CBsU1YrLA8lTJurNNlZ6udQjgtu5HxOABPMwURlbw=;
 b=YluRFot9y5wFRZuIm4PiTCsnd7akchqgdORt88oIBEFuo9MGp7XnnjBfh+0OEnzfem
 vrFMESB70rgeESW5d1bwzld5YuzkW4NRvjvTEmNtL2ZX3VFVyO5YTSkmivVT2gDNxFLZ
 qHpRdrSwavEKpqdGBhPvwoNNfUa9P07vhWSYKmfN8YBoDU5Z8J5dMXjediaRIwTT0NVw
 JCUM8ZS5Pl7ygOlGyKYXQs15tjQgVghguJmbyuxvt69ruaTmc2QHCNnPFzqtoxayfo2E
 +gjxTn3FSy9XkuvBMk8YDNUwJhmXNIhyDTKa5fl6sVH7muTXPYgbc3iFKpHb4Af7gs0Z
 nYRw==
X-Gm-Message-State: AC+VfDwFhTctp2JxaG1PPycze0NkbetdKePgzBFBeRQBun5C9NKK88jM
 5rM6kbRyd6+WtlrfcT8z3JQOcyWSgSTA9Q7fKlK2ZOnCMYlSrdnx+me+9anLGyvds/jlW1XgWdu
 EMw7R7s5ujHk7ZrY=
X-Received: by 2002:a7b:cc82:0:b0:3f4:253f:c3d6 with SMTP id
 p2-20020a7bcc82000000b003f4253fc3d6mr1331875wma.33.1684410265235; 
 Thu, 18 May 2023 04:44:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ75DErYhuNeNpIO58gIU2KH0o5tobVLjVvTnDCbSLsxJpwPg18blJlWH8rWWE4hK6EHDgkM5Q==
X-Received: by 2002:a7b:cc82:0:b0:3f4:253f:c3d6 with SMTP id
 p2-20020a7bcc82000000b003f4253fc3d6mr1331862wma.33.1684410264894; 
 Thu, 18 May 2023 04:44:24 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 i3-20020adff303000000b0030795b2be15sm1903808wro.103.2023.05.18.04.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:44:23 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "Wang, Lei4" <lei4.wang@intel.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH] multifd: Set a higher "backlog" default value for listen()
In-Reply-To: <DS0PR11MB6373D659BCA67BD75D8ECC5DDC7F9@DS0PR11MB6373.namprd11.prod.outlook.com>
 (Wei W. Wang's message of "Thu, 18 May 2023 09:13:58 +0000")
References: <20230518085228.172816-1-lei4.wang@intel.com>
 <DS0PR11MB6373D659BCA67BD75D8ECC5DDC7F9@DS0PR11MB6373.namprd11.prod.outlook.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 13:44:22 +0200
Message-ID: <87sfbtdfu1.fsf@secure.mitica>
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

"Wang, Wei W" <wei.w.wang@intel.com> wrote:
> On Thursday, May 18, 2023 4:52 PM, Wang, Lei4 wrote:
>> When destination VM is launched, the "backlog" parameter for listen() is set
>> to 1 as default in socket_start_incoming_migration_internal(), which will
>> lead to socket connection error (the queue of pending connections is full)
>> when "multifd" and "multifd-channels" are set later on and a high number of
>> channels are used. Set it to a hard-coded higher default value 512 to fix this
>> issue.
>> 
>> Reported-by: Wei Wang <wei.w.wang@intel.com>
>> Signed-off-by: Lei Wang <lei4.wang@intel.com>
>> ---
>>  migration/socket.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/migration/socket.c b/migration/socket.c index
>> 1b6f5baefb..b43a66ef7e 100644
>> --- a/migration/socket.c
>> +++ b/migration/socket.c
>> @@ -179,7 +179,7 @@
>> socket_start_incoming_migration_internal(SocketAddress *saddr,
>>      QIONetListener *listener = qio_net_listener_new();
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>>      size_t i;
>> -    int num = 1;
>> +    int num = 512;
>> 
>
> Probably we need a macro for it, e.g.
> #define MIGRATION_CHANNEL_MAX  512
>
> Also, I think below lines could be removed, as using a larger value of num (i.e. 512)
> doesn't seem to consume more resources anywhere:

Could you confirm that?

> -    if (migrate_use_multifd()) {
> -        num = migrate_multifd_channels();
> -    } else if (migrate_postcopy_preempt()) {
> -        num = RAM_CHANNEL_MAX;
> -    }

Agreed that in this case we should drop this bit.

But on the other hand, if it does'nt consume more resources, why isn't
the kernel just ignoring the value passed to listen an just use a big
number?

Later, Juan.


