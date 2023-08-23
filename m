Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCD8785CB4
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 17:54:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYqA0-0002Dx-8c; Wed, 23 Aug 2023 11:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYq9T-00024o-KN
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:52:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYq9R-00038T-Po
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692805928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRRyQ5MRv8xdAFpPkZ/ocBuYccF1xtbfQoCm6L6AMVA=;
 b=dbbN/K+R0PfIGjkx+hDgTq6CRJsdI+hOhORWx3yJUG4m99sX+1ZGYbfRaZiEKIlDEs+ZwU
 bUZF/UFcqs06LG8E7GkcPJufytgdF5u88DI4pCkGX1k6KGQEQT5SPLGAh376e+ShFmtEVR
 5pZqSnQBJH8PPbTagaRO6d6se4jHBNM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-HiUGQdv2OtyTk7Oz-_e64g-1; Wed, 23 Aug 2023 11:52:07 -0400
X-MC-Unique: HiUGQdv2OtyTk7Oz-_e64g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-64f54ababd1so3473866d6.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 08:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692805926; x=1693410726;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CRRyQ5MRv8xdAFpPkZ/ocBuYccF1xtbfQoCm6L6AMVA=;
 b=PaemmMfOWoQDiRvL8k1G98HnYKNbWZDB5eRJeVCFSO6N34VNj1E8pwBLNq6BN/mPeP
 DLO+BnSmIaJ1nrAh2URBsMF/128f95IiqRJLofbqkum+m4mWZNbtR+orps1otgOOJB1w
 ARFetDSKawaYjrHKP7/bqjXwt8i5LzT5zGie5uSxB3/+11pQD8Ofs5IyYOTBNoWkKBR3
 BWo/AwIowNLIxV1xiU40LL9jMs7CHw0nC2gy8o64KiEhHYB4nt9qXW18jie6AEHoYJQP
 v333Xu7HidHMgfZ1rcX5q6kq3lFniQmEQkHG15OGLA+TXx4icsNKS6PRxRcV7Eh+aUiH
 gIkA==
X-Gm-Message-State: AOJu0YwN87i5jWo6fKHwSRaQ5XyIjblZSU8/FabGCljObbt66s6kEw4o
 BOpAZC8DnijfCwreK+fN0p4fEueC+O/6v1MK+qH4ZSbzjdYLjcDxpEaV1bIABu34E2mNEJe2kOD
 mFIwSBdAx0xElP/4=
X-Received: by 2002:a05:6214:4111:b0:621:65de:f60c with SMTP id
 kc17-20020a056214411100b0062165def60cmr14993766qvb.3.1692805926527; 
 Wed, 23 Aug 2023 08:52:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHblVM0hL/S5SXx9bXKJcod4NZdtnM3567eMzv2tnOfUb+uPIk4qsVCue0ciVrK79dJ8PFHvQ==
X-Received: by 2002:a05:6214:4111:b0:621:65de:f60c with SMTP id
 kc17-20020a056214411100b0062165def60cmr14993750qvb.3.1692805926199; 
 Wed, 23 Aug 2023 08:52:06 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o9-20020a0ccb09000000b0063d20fa8341sm4612050qvk.8.2023.08.23.08.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 08:52:05 -0700 (PDT)
Date: Wed, 23 Aug 2023 11:52:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH for-8.2 3/4] migration/qapi: Replace
 @MigrateSetParameters with @MigrationParameters
Message-ID: <ZOYrIhps4AL9ZyTx@x1n>
References: <20230814221947.353093-1-peterx@redhat.com>
 <20230814221947.353093-4-peterx@redhat.com>
 <871qftx532.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871qftx532.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 23, 2023 at 03:26:25PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > These two structs are mostly identical besides some fields (quote from
> > Daniel P. Berrangé in his reply):
> >
> >   1c1
> >   < { 'struct': 'MigrationParameters',
> >   ---
> >   > { 'struct': 'MigrateSetParameters',
> >   14,16c14,16
> >   <             '*tls-creds': 'str',
> >   <             '*tls-hostname': 'str',
> >   <             '*tls-authz': 'str',
> >   ---
> >   >             '*tls-creds': 'StrOrNull',
> >   >             '*tls-hostname': 'StrOrNull',
> >   >             '*tls-authz': 'StrOrNull',
> >
> > Here the difference is @MigrateSetParameters object would allow 'null'
> > values for any tls-* fields passed in.
> >
> > Markus used to describe why it happened to be StrOrNull, and also his
> > concern on having a pure "str" type to be problematic as the reset
> > indicator in the commit 01fa559826 ("migration: Use JSON null instead of ""
> > to reset parameter to default").  There, "null" is introduced for the tls
> > fields even though being treated as "" (empty string) internally to match
> > the code.
> 
> Suggest
> 
>   migration/qapi: Replace @MigrateSetParameters with @MigrationParameters
> 
>   migrate-set-parameters sets migration parameters, and
>   query-migrate-parameters gets them.  Unsurprisingly, the former's
>   argument type MigrateSetParameters is quite close to the latter's
>   return type MigrationParameters.  The differences are subtle:
> 
>   1. Since migrate-set-parameters supports setting selected parameters,
>      its arguments must all be optional (so you can omit the ones you
>      don't want to change).  query-migrate-parameters results are also
>      all optional, but almost all of them are in fact always present.
> 
>   2. For parameters @tls_creds, @tls_hostname, @tls_authz,
>      migrate-set-parameters interprets special value "" as "reset to
>      default".  Works, because "" is semantically invalid.  Not a
>      general solution, because a semantically invalid value need not
>      exist.  Markus added a general solution in commit 01fa559826
>      ("migration: Use JSON null instead of "" to reset parameter to
>      default").  This involved changing the type from 'str' to
>      'StrOrNull'.
> 
>   3. When parameter @block-bitmap-mapping has not been set,
>      query-migrate-parameters does not return it (absent optional
>      member).  Clean (but undocumented).  When parameters @tls_creds,
>      @tls_hostname, @tls_authz have not been set, it returns the
>      semantically invalid value "".  Not so clean (and just as
>      undocumented).
> 
> Items 2. and 3. need fact-checking.

For 2: "reset to default" is correct, assuming the default is not enabling
TLS.  Or perhaps we can also say "TLS disabled" to be clear?

Currently in the code we rely on the string non-null (of tls-creds) to
detect whether tls is enabled in general for migration:

bool migrate_tls(void)
{
    MigrationState *s = migrate_get_current();

    return s->parameters.tls_creds && *s->parameters.tls_creds;
}

Definitely not as clean (which I agree..), but we probably need to keep it
working anyway.

> 
> > Here to deduplicate the two objects, logically it'll be safe only if we use
> > "StrOrNull" to replace "str" type, not vice versa.  However we may face
> > difficulty using StrOrNull as part of MigrationState.parameters [1] when
> > replacing existing @MigrationParameters to use StrOrNull.  With the fact
> > that nobody seems to be using "null" for tls-* fields (see the long
> > standing qemu crash bug on tls-authz when "null" was passed in), let's use
> > "str" to represent both objects.
> 
> "May face difficulty" is insufficiently strong to justify such
> incompatible change.
> 
> I'll have a look at the difficulties you mentioned in [1].  If we can
> overcome them with reasonable effort, we can and should avoid the
> compatibility break.  If we can't, we add proper rationale here.

Thanks, Markus.  Just in case of anything helpful, I've pushed the other
version here:

https://github.com/xzpeter/qemu/tree/mig-param-dedup-strornull

-- 
Peter Xu


