Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37685739DFB
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:02:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCH8o-0007hv-3G; Thu, 22 Jun 2023 06:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCH8g-0007aA-Tr
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCH8f-0002wc-7B
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687428123;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HtdmmSKSaBX9SWZXFRFwXq1Bmc/iY0w1sIUafLgjMyU=;
 b=RZx9Qmjsnn6Ki/8wIH6E8FpBHeD4SbGP3ZRSqaqfN9lA7blC93tivlVup2O7nrMiMTZzR1
 l0IKSobYwW81ObkLw6kZbmPuE5Ph63n5yrB7iMO5XE4HPDkl9YeWSzjExRaGKWTaoy1sPc
 6mzQ5P0yta5+hz6uUisef5cBcdFmAro=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-KH-YVL7iML-zIcwjwXH_8Q-1; Thu, 22 Jun 2023 06:01:58 -0400
X-MC-Unique: KH-YVL7iML-zIcwjwXH_8Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f76712f950so5277142e87.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 03:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687428117; x=1690020117;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtdmmSKSaBX9SWZXFRFwXq1Bmc/iY0w1sIUafLgjMyU=;
 b=dk90w31zy+cLL2xPsfUNv+GvlNO4RhsGEV5VwYGJpQVjw9ajPNGphQQEMBEYkXf9M3
 keS18BVp5e1FlWoYVGc3qwhW77v4kk4Fypk7+lM7UTgZEM3bpUU7VE6qdo4NFHAE2tqn
 lxeojCI20Nrg6KKSCIUydx7KaYGGszSn+2duQ4dpmWXNiwWTB5Lu1YrB3AsVm9xAQD8R
 AauOUbfy/NHZQo0yN+BeZEFxkURO7LBO6trKZuik7yv6JS2X9vVa0ENXdQjTQgyNQ470
 +pEZh+7vqVVAHJsXMZo1VrbsGOo4h0qXxIj+9VHmJ7DYzbBvl1LqhurWmRLH+y+7tkHl
 wKoQ==
X-Gm-Message-State: AC+VfDyAfybC4uIlJtTt1we2vkyss/4elY8r/2f6W1MNWoL/OAxLxhA1
 j5J3bsfG8LGLsZ+MvDr1tHcrCFZXNghwuLcaD8B9FONq1oC8cv16erj9CywzFkB5li4ASci4kvk
 sfm6BIJC2hANhipQ=
X-Received: by 2002:a19:e304:0:b0:4dd:ce0b:7692 with SMTP id
 a4-20020a19e304000000b004ddce0b7692mr10082340lfh.46.1687428117334; 
 Thu, 22 Jun 2023 03:01:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5J/bpn1m77ZmkN45dbwpKxwXe4zG4DnrvgAMWGk3cHSmRNPWw7GB6vtXiPc3oKSoJhb+8DCw==
X-Received: by 2002:a19:e304:0:b0:4dd:ce0b:7692 with SMTP id
 a4-20020a19e304000000b004ddce0b7692mr10082316lfh.46.1687428116817; 
 Thu, 22 Jun 2023 03:01:56 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 k1-20020a5d66c1000000b003079c402762sm6740545wrw.19.2023.06.22.03.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 03:01:55 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Markus Armbruster
 <armbru@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Daniel
 =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Eric Blake <eblake@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Thomas Huth <thuth@redhat.com>,  libvir-list@redhat.com
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
In-Reply-To: <59f958ac-807d-e940-e5de-8109de62eb8c@redhat.com> (Paolo
 Bonzini's message of "Thu, 22 Jun 2023 11:45:28 +0200")
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica>
 <59f958ac-807d-e940-e5de-8109de62eb8c@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 12:01:55 +0200
Message-ID: <87sfaj7r3g.fsf@secure.mitica>
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

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 6/22/23 10:52, Juan Quintela wrote:
>> User friendliness.
>> The problem is that if you use more than two channels with multifd, on
>> the incoming side, you need to do:
>
> You're sacrificing user-friendliness for the 99.99% that don't use
> multifd, for an error (i.e. it's not even fixing the issue) for the
> 0.01% that use multifd.  That's not user-friendly.

You are forgeting of the 0.01% that uses postocopy preempt (that is easy
just changing the default value to 2), and the 0.0000001% that uses
compression (they have exactly the same problem with compress_threads,
compress_zlib, etc).

>> - migrate_set_parameter multifd-channels 16
>> - migrate_incoming <uri>
>> 
>>> The issue is not how many features the command line has, but how
>>> they're implemented.
>> Or if they are confusing for the user?
>
> Anyone using multifd is not a typical user anyway.

>>> If they're just QMP wrappers and as such they're self-contained in
>>> softmmu/vl.c, that's fine.
>>>
>>> In fact, even for parameters, we could use keyval to parse "-incoming"
>> What is keyval?
>
> util/keyval.c and include/qemu/keyval.h.  It parses a list of
> key=value pairs into a QDict.  Once you have removed the "source" key
> from the QDict you can use a visitor to parse the rest into a
> MigrateSetParameters.  See the handling of QEMU_OPTION_audio, it could
> be something like
>
>
>             case QEMU_OPTION_incoing: {
>                 Visitor *v;
>                 MigrateSetParameters *incoming_params = NULL;
>                 QDict *dict = keyval_parse(optarg, "source", NULL,
>                 &error_fatal);
>
>                 if (incoming) {
>                     if (qdict_haskey(dict, "source")) {
>                         error_setg(&error_fatal, "Parameter 'source'
>                         is duplicate");
>                     }
>                 } else {
>                     if (!qdict_haskey(dict, "source")) {
>                         error_setg(&error_fatal, "Parameter 'source'
>                         is missing");
>                     }
>                     runstate_set(RUN_STATE_INMIGRATE);
>                     incoming = g_strdup(qdict_get_str(dict, "source"));
>                     qdict_del(dict, "source");
>                 }
>
>                 v = qobject_input_visitor_new_keyval(QOBJECT(dict));
>                 qobject_unref(dict);
>                 visit_type_MigrateSetParameters(v, NULL,
>                 &incoming_params, &error_fatal);
>                 visit_free(v);
>                 qmp_migration_set_parameters(incoming_params,
>                 &error_fatal);
>                 qapi_free_MigrateSetParameters(incoming_params);
>             }
>
>
> For example "-incoming [source=]tcp:foo,multifd-channels=16" would
> desugar to
>
>   migrate_set_parameter multifd-channels 16
>   migrate_incoming tcp:foo
>
> The only incompatibility is for people who are using "," in an URI,
> which is rare and only an issue for the "exec" protocol.

Aha, that makes sense.  And will allow us to deprecate/remove the
--global migration.* stuff.

Thanks very much.

See why this was an RFC O:-)

Later, Juan.

>
> Paolo
>
>>> and
>>> set the parameters in the same place as above.  That would remove the need
>>> for "-global migration".
>> Could you elaborate?
>
>
>
>> The other option that I can think of is changing the error messages for
>> migrate_check_parameters() and give instructions that you can't set
>> multifd channels once that you have started incoming migration.
>> Explaining there to use migrate_incoming command?
>> Later, Juan.
>> 


