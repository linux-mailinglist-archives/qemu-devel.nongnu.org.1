Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC15703729
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 19:17:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybod-000273-Ng; Mon, 15 May 2023 13:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pybob-00026H-1s
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyboZ-0000xT-2H
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684171009;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3yWC2Lu+CoTSxhFaUwNpndQe8kPTs0fjhmLwbLI4aXM=;
 b=icQzd/eORiLIQ2cp2kTTi6hyF/3mifjqgqoIRv8K2anf8vJKJn2Y0Ef4nvmj3SvrfRTcst
 1IS4jlNDoCxslNPx01HFjk77ivpgEdh337dID4n6uYcQTDLTYtDtkKjqUeCND9M20HHCV8
 IIROgqYIP2iZ5Y0YeLsTZ7AWtXoPR2s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-efBR2Q0yMK20O06U6OVeWA-1; Mon, 15 May 2023 13:16:48 -0400
X-MC-Unique: efBR2Q0yMK20O06U6OVeWA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f426514683so30973385e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 10:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684171007; x=1686763007;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3yWC2Lu+CoTSxhFaUwNpndQe8kPTs0fjhmLwbLI4aXM=;
 b=YalZNW0klyT7hqCPxEREJ9nT0nGDB2UUeXU6OUAyiafV7spJXnPaqwgq4aPwLt2NHx
 d7gyv+mcxrmk9LZDN5ZhDSxtKUfQj4PYHhu0bU8WbgwDGmfDVmGjGdLaRGXO6KCvv2u2
 H7iNDpPYnb85TiDVUx+qCrgTI0q9JD5u8IR2brg1kyIgt+0E5jsDqxrqLbvi1luBu3h1
 RLWOrzzI392dhcgJVuR1FJuKBBimr7+IYkktomke3qSA1pidAOfvScVXoRMxOLiywQnG
 23KHG8cM6+dRYYckZ8NXn6NRERnSaE4Z1BmWPCmGxyil/2LUlhpr58YGf2aUhxRNklzu
 aeWw==
X-Gm-Message-State: AC+VfDxQwxyVoPMinKN9yfhNzH+imKdOFTkPAds6z7yizOCprgfkSCiS
 vfNGggdGUcQ06YVakBKuUHu+uzk8DGvxx/PrgzzBJDxbWefczAMNmMbqeItbMCD+U1XjQJciQYz
 UY8ZwPl+9YhHDhIY=
X-Received: by 2002:a05:600c:2298:b0:3f4:2bce:eeff with SMTP id
 24-20020a05600c229800b003f42bceeeffmr14727185wmf.25.1684171007350; 
 Mon, 15 May 2023 10:16:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6S99Y3aNSZWTb2iGmKCaaaMaGITziLYbHk6ZpiBV0cDrJOpCo50D/4AwQYXJY/hyNTZx9IbQ==
X-Received: by 2002:a05:600c:2298:b0:3f4:2bce:eeff with SMTP id
 24-20020a05600c229800b003f42bceeeffmr14727158wmf.25.1684171007005; 
 Mon, 15 May 2023 10:16:47 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 l9-20020a1c7909000000b003f4e3ed98ffsm14327wme.35.2023.05.15.10.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 10:16:46 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  <qemu-block@nongnu.org>,  Eric
 Blake <eblake@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  John Snow <jsnow@redhat.com>,  Halil Pasic
 <pasic@linux.ibm.com>,  Peter Xu <peterx@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Gibson
 <david@gibson.dropbear.id.au>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  Greg Kurz
 <groug@kaod.org>,  <qemu-ppc@nongnu.org>,  <qemu-s390x@nongnu.org>,  Fam
 Zheng <fam@euphon.net>,  Thomas Huth <thuth@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 10/21] migration: Move rate_limit_max and
 rate_limit_used to migration_stats
In-Reply-To: <eda6df92-f363-ef12-3f70-e07b26ed0512@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Mon, 15 May 2023 15:28:35 +0200")
References: <20230508130909.65420-1-quintela@redhat.com>
 <20230508130909.65420-11-quintela@redhat.com>
 <4a7fcac1-a8f1-44d2-1a5a-284a80486633@kaod.org>
 <87h6sdzqoo.fsf@secure.mitica>
 <eda6df92-f363-ef12-3f70-e07b26ed0512@kaod.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 15 May 2023 19:16:45 +0200
Message-ID: <878rdpy0oy.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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

C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 5/15/23 15:09, Juan Quintela wrote:
>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>> On 5/8/23 15:08, Juan Quintela wrote:
>>>> This way we can make them atomic and use this functions from any
>>>> place.  I also moved all functions that use rate_limit to
>>>> migration-stats.
>>>> Functions got renamed, they are not qemu_file anymore.
>>>> qemu_file_rate_limit -> migration_rate_limit_exceeded
>>>> qemu_file_set_rate_limit -> migration_rate_limit_set
>>>> qemu_file_get_rate_limit -> migration_rate_limit_get
>>>> qemu_file_reset_rate_limit -> migration_rate_limit_reset
>>>> qemu_file_acct_rate_limit -> migration_rate_limit_account.
>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>> ---
>>>> If you have any good suggestion for better names, I am all ears.
>>>
>>> May be :
>>>
>>>   qemu_file_rate_limit -> migration_rate_limit_is_exceeded
>> I try not to put _is_ in function names.  If it needs to be there, I
>> think that I need to rename the functino.
>
> It is common practice for functions doing a simple test and returning a b=
ool.
> No big deal anyway.
>  > migration_rate_limit_exceeded()
>> seems clear to me.
>>=20
>>>   qemu_file_acct_rate_limit -> migration_rate_limit_inc
>> My problem for this one is that we are not increasing the
>> rate_limit, we
>> are "decreasing" the amount of data we have for this period.  That is
>> why I thought about _account(), but who knows.
>>=20
>>> Also, migration_rate_limit() would need some prefix to understand what =
is
>>> its purpose.
>> What do you mean here?
>
> I am referring to :
>
>   /* Returns true if the rate limiting was broken by an urgent request */
>   bool migration_rate_limit(void)
>   {
>       ...
>       return urgent;
>   }

out of ideas:

migration_rate_wait()
- the good
  *we wait if we have to
- the bad
  we can be interrupted if there is anything urgent
  we only wait if counters says that we have to

migration_rate_check()
* we always check
* we return a value consistent with checking
* but we check if we have to wait, not if there is anythying urgent

I am leaving it with migration_rate_limit() name until someone cames
with a better one.  It is not worse than what we have in.


>
> which existed prior to the name changes and I thought migration_rate_limi=
t()
> would suffer the same fate. May be keep the '_limit' suffix for this one =
if
> you remove it for the others ?

I am no sure if migration_rate() is better than migration_rate_limit().

Later, Juan.


