Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA36D73A7FC
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 20:12:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOmr-0007Wn-HS; Thu, 22 Jun 2023 14:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCOmp-0007Up-IK
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 14:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCOmn-0002Gw-Qz
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 14:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687457520;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDYAyHIyw5ulxi4KJ/tLMhWEgFMdQ5JmcnzuA7oR2NM=;
 b=G7rHu/55tGIlAW2tpZ/AMae1fVkiAdSCaM2WTzj25kAqp5QpwU5w1MnNRquYDPFiBNleQI
 a4myhIYSXjxnkdtV2pocpa+ChQwURxwXBGc15xXh+uO39huwqt7F9PHAvGTD8Izq0gegp1
 LeiazXA2zaI198A4VejLKQUWHYyalpE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-5cLZIvh0Mc2ieTJzzzSceg-1; Thu, 22 Jun 2023 14:11:58 -0400
X-MC-Unique: 5cLZIvh0Mc2ieTJzzzSceg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so34781165e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 11:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687457517; x=1690049517;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YDYAyHIyw5ulxi4KJ/tLMhWEgFMdQ5JmcnzuA7oR2NM=;
 b=DqEpEYaIyABmw4DpgMQffQteDWTOVZCAFatVo89VQEPyQMqakVnqiQ9KP7tgHarSPw
 409zdywQycaSFJYx8+8iOLbH26h7ykCAgorPuKjJrwL9V4bn5T9xciOG4Bp7A6Sp6El8
 S0M2xIKbsUiTOhC5TmfFOJQlGyOyI+HDLv3/8qNUsG9GOk8WYYw+jnoPEjyHkhlXL1U2
 QzNpHA1TP0aWcX1bWEU0HAXHUhiCc2l6Wdp6+IgnMqpAQbXA6EDVfg/sasA8fRIAXzdj
 3PrEwBH3dwphlTTJkmXxllHsQBxFnHTBD1ei0T5dsz+m86Iab/g4fOMKfTplKgsZwy4W
 r0Kw==
X-Gm-Message-State: AC+VfDwQp/P1iH3ojzXlnu6sUQUs9FcgTXP6f31Xp2y3IeU2zX/fWx9s
 24Rng8WTowuaBSCtx/y5OUPjJkPazIMqDVfjEfJvbe+S6ofdbIh4em8tRW5iRSQhxO21a4n5eUg
 LvEvLYHHrp8KGBHM=
X-Received: by 2002:a7b:c407:0:b0:3f9:bd21:eb5e with SMTP id
 k7-20020a7bc407000000b003f9bd21eb5emr4551198wmi.29.1687457517209; 
 Thu, 22 Jun 2023 11:11:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6qVn1QhFAg5MU57dryT+1M2IjnHAR1Ssjzcoc7pcn8H+MpcAAl2YTYjW2v9ZYP90Z2XoYlDw==
X-Received: by 2002:a7b:c407:0:b0:3f9:bd21:eb5e with SMTP id
 k7-20020a7bc407000000b003f9bd21eb5emr4551177wmi.29.1687457516822; 
 Thu, 22 Jun 2023 11:11:56 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 v14-20020a05600c214e00b003f7f60203ffsm152898wml.25.2023.06.22.11.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 11:11:56 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  qemu-block@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  Thomas Huth
 <thuth@redhat.com>,  libvir-list@redhat.com,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [RFC 2/6] migration: migrate 'inc' command option is deprecated.
In-Reply-To: <ZJGWEhITI2hzT7Ro@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 20 Jun 2023 13:05:38 +0100")
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-3-quintela@redhat.com>
 <ZJGWEhITI2hzT7Ro@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 20:11:55 +0200
Message-ID: <875y7ffjtg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Mon, Jun 12, 2023 at 09:33:40PM +0200, Juan Quintela wrote:
>> Use 'migrate_set_parameter block_incremental true' instead.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  docs/about/deprecated.rst |  7 +++++++
>>  qapi/migration.json       | 11 +++++++++--
>>  migration/migration.c     |  5 +++++
>>  3 files changed, 21 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index e1aa0eafc8..c75a3a8f5a 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -433,3 +433,10 @@ Migration
>>  ``skipped`` field in Migration stats has been deprecated.  It hasn't
>>  been used for more than 10 years.
>>=20=20
>> +``inc`` migrate command option (since 8.1)
>> +''''''''''''''''''''''''''''''''''''''''''
>> +
>> +The new way to modify migration is using migration parameters.
>> +``inc`` functionality can be acchieved using
>> +``migrate_set_parameter block-incremental true``.
>
> This is a HMP command, but the change affects QMP too. I'd suggest
>
>  ``inc`` functionality can be achieved by setting the
>  ``block-incremental`` migration parameter to ``true``.

Applied all suggestions.  Thanks.


