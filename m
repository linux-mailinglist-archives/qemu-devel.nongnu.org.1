Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E45E7CD917
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:22:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3h9-00064j-Mh; Wed, 18 Oct 2023 06:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3h7-00062q-Qg
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3h6-0001sK-CX
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697624547;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=h+T0sm/z19p88kREzhgNGMTHC8Ipv8p32Mzf4o2Jd4U=;
 b=VHkPOkrKl9u6H73oBzZkds4DyMn5AhF6fmFCmdwS45gz5ek0eoMzWJB33cycp63ndZ/Ts6
 XviK2W9lfL33eYperAnRGYb68T6DeBeDnM3mNv75v+0EeQfIKl1sPK2A4bEGGQ55NOxwEN
 e/CY2rfcJHDfLAOLRm3BgoY/ZOlrar0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-dhosw-FzNziLgVnpxTARlQ-1; Wed, 18 Oct 2023 06:22:15 -0400
X-MC-Unique: dhosw-FzNziLgVnpxTARlQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4083a670d25so4628355e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 03:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697624534; x=1698229334;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+T0sm/z19p88kREzhgNGMTHC8Ipv8p32Mzf4o2Jd4U=;
 b=pymCIHXswLJZ1vYYelNvObNoxM1QgAvvJVsf+qE3IQgJBZpwzo3Pgi4FPN7IR+vaMm
 AQdFIZzjyJOhK1NiIQfkm0KyzvrE+2HQHvhTMEIxsu2+TMOua1AwycjNYXq2hCv3Bb9u
 RqL6Gp/adQTrFfBvu+1JSeIo6DSvcgkJN8/MxQAnZfAp+6+rZJtIBEkxhRxsSbsLfXzI
 YEi9c6kR+d871WHuNjK6FGZoS4dA39+6juziqnUAfpW/qDCwrIQFQxT8N8pp5X/cKK6G
 dFIskHGTQLRZEKTJjKqhawvvoscl3zFEHFuJrNlipoWmIorInO0hkCx8LIcXmaOMbmFA
 o3dQ==
X-Gm-Message-State: AOJu0Yx4kVWrlAeCTC0188NbRAn1f2v++iEwxK6SX0ii7W+o/x+zZUb5
 oHN06pWPjdhgOSJZ57jDf7rHoEGAFdlHak5T8dn5LAoyUOMhmktpgOnBYYFspTJCs98uoCoDdxV
 +WLHwaQaYtLfBA8I=
X-Received: by 2002:a05:600c:4686:b0:401:be5a:989 with SMTP id
 p6-20020a05600c468600b00401be5a0989mr3567971wmo.23.1697624534707; 
 Wed, 18 Oct 2023 03:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0OWgJQ24HnapII8XYT71ECkoHTORMztDH5y+Gd3OGJlXgAcWpGH8dP1t3zeVmg1Zeem4kFw==
X-Received: by 2002:a05:600c:4686:b0:401:be5a:989 with SMTP id
 p6-20020a05600c468600b00401be5a0989mr3567945wmo.23.1697624534323; 
 Wed, 18 Oct 2023 03:22:14 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l1-20020a5d6741000000b003200c918c81sm1771199wrw.112.2023.10.18.03.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 03:22:13 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  libvir-list@redhat.com,  Fabiano Rosas
 <farosas@suse.de>,  qemu-block@nongnu.org,  Leonardo Bras
 <leobras@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v6 2/5] migration: migrate 'inc' command option is
 deprecated.
In-Reply-To: <87jzrkwcvz.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 18 Oct 2023 10:30:56 +0200")
References: <20231017172307.22858-1-quintela@redhat.com>
 <20231017172307.22858-3-quintela@redhat.com>
 <87jzrkwcvz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 12:22:12 +0200
Message-ID: <87il74xmaz.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> Use blockdev-mirror with NBD instead.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  docs/about/deprecated.rst      | 9 +++++++++
>>  qapi/migration.json            | 8 +++++++-
>>  migration/migration-hmp-cmds.c | 5 +++++
>>  migration/migration.c          | 5 +++++
>>  4 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 2febd2d12f..b51136f50a 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -461,3 +461,12 @@ Migration
>>  ``skipped`` field in Migration stats has been deprecated.  It hasn't
>>  been used for more than 10 years.
>>  
>> +``inc`` migrate command option (since 8.2)
>> +''''''''''''''''''''''''''''''''''''''''''
>> +
>> +Use blockdev-mirror with NBD instead.
>> +
>> +As an intermediate step the ``inc`` functionality can be achieved by
>> +setting the ``block-incremental`` migration parameter to ``true``.
>> +But this parameter is also deprecated.
>> +
>
> If you need to respin for some other reason, drop the blank line at end
> of file.  Same in later patches.
>
> [...]

Done.

There is a tool, git-am maybe, that complains if files don't end in a
blank line.

You can't have happy everybody.

Later, Juan.


