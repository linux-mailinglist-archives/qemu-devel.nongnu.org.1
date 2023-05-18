Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A636F7084BB
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfKA-0001dS-Ap; Thu, 18 May 2023 11:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzfK6-0001c1-JW
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzfK4-0001Bv-KG
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684422823;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wY31to70a5r93rJi7UWpbq+qXC7wpC36n158+Yf4Zb4=;
 b=enyJiIgM690e9ABCDWLFbxfjHq1sHzfyAVyqKiXNb6cKp3z7+Llr9auG6vlwS7oQTwTaQ1
 re44KwlE1OgHq3FlAFLFl46lK9JRDGWfT+4T9GSNfIZerBnxq0PjDjsvZNXqJCG+ltazRj
 5cKj2c2hxj9oWkXFqXmJH3OG7Zep7Sk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-2TZpyBJRMgqmLwHYUGvSwQ-1; Thu, 18 May 2023 11:13:42 -0400
X-MC-Unique: 2TZpyBJRMgqmLwHYUGvSwQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f4245ffb03so13700095e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684422821; x=1687014821;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wY31to70a5r93rJi7UWpbq+qXC7wpC36n158+Yf4Zb4=;
 b=dvkRWxTZxb/ob1f904Hi0njbmEYggQ/UKgeEPdppgdKXMawVLpJnc3PzswSDWcJQM+
 8b0XBdCC0Pl7x4dJwe4D7VSY9eFVQha5EGq3J19bv5yZTA/kiWNEdCIJWfThuXar4ekV
 2+pwXHH0eydTcnj4psA0x1pPOBsVk+GwIK74YxmCIKL6dordQ4apov4izJJ6Imi7WU7Y
 BzfH4JPUYRAfyUf61WFj4KbsjIGGQJW/yMDOil5HHwIyI7vF4XTnFtKnICEIU5SiZfGI
 CNxIVPRo6Eb3hP0y5mwl7OV5UObSv3LaKdQPDujOK7V/zEXhDKUDrpfTY9gJE2VPU5kT
 x7ng==
X-Gm-Message-State: AC+VfDyK5VBBPz48Zk4aNjxyBn1ejzYHql4U0gajT64BjqPPV1dUANNm
 FxUAoPiV7K10+pJXiijf+vU2lV1P6cclSajDCZiKvpo9spq0z0VsfjzDtTaxE8TvMrABV9PaIUC
 uBa3nPL3kNtaHzNM=
X-Received: by 2002:a7b:cd0a:0:b0:3f4:e4fa:90f1 with SMTP id
 f10-20020a7bcd0a000000b003f4e4fa90f1mr1731181wmj.33.1684422821387; 
 Thu, 18 May 2023 08:13:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5of5o+bRivNxnYO9ZPqUzJSYifs75kP+PxyK9NvGjrbvgv39gyHpj1Bn1HkFfam7RhFrgFUA==
X-Received: by 2002:a7b:cd0a:0:b0:3f4:e4fa:90f1 with SMTP id
 f10-20020a7bcd0a000000b003f4e4fa90f1mr1731166wmj.33.1684422821026; 
 Thu, 18 May 2023 08:13:41 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 a20-20020a1cf014000000b003f506e6ff83sm2367398wmb.22.2023.05.18.08.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 08:13:40 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: <gudkov.andrei@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <eblake@redhat.com>,  <armbru@redhat.com>,
 <berrange@redhat.com>,  <zhengchuan@huawei.com>,  <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 2/4] migration/calc-dirty-rate: detailed stats in
 sampling mode
In-Reply-To: <ZGY5ttHypAtAhFSi@DESKTOP-0LHM7NF.china.huawei.com> (gudkov
 andrei's message of "Thu, 18 May 2023 17:45:26 +0300")
References: <cover.1682598010.git.gudkov.andrei@huawei.com>
 <22436421241c49c9b6d9b9120d166392c40fb991.1682598010.git.gudkov.andrei@huawei.com>
 <875y906qce.fsf@secure.mitica>
 <ZF47+rkmPdTKIaH8@DESKTOP-0LHM7NF.china.huawei.com>
 <87h6se2ecs.fsf@secure.mitica>
 <ZGY5ttHypAtAhFSi@DESKTOP-0LHM7NF.china.huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 17:13:39 +0200
Message-ID: <875y8pd658.fsf@secure.mitica>
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

<gudkov.andrei@huawei.com> wrote:
> On Mon, May 15, 2023 at 10:22:43AM +0200, Juan Quintela wrote:
>> <gudkov.andrei@huawei.com> wrote:
>> > On Wed, May 10, 2023 at 07:36:33PM +0200, Juan Quintela wrote:
>> >> Andrei Gudkov <gudkov.andrei@huawei.com> wrote:
>> >> > Collect number of dirty pages for progresseively increasing time
>> >> > periods starting with 125ms up to number of seconds specified with
>> >> > calc-dirty-rate. Report through qmp and hmp: 1) vector of dirty page
>> >> > measurements, 2) page size, 3) total number of VM pages, 4) number
>> >> > of sampled pages.
>> >> >
>> >> >  3 files changed, 160 insertions(+), 54 deletions(-)
>> >> >
>> >> > diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> >> > index acba3213a3..4491bbe91a 100644
>> >> > --- a/migration/dirtyrate.c
>> >> > +++ b/migration/dirtyrate.c
>> >> > @@ -224,6 +224,7 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
>> >> >      info->calc_time = DirtyStat.calc_time;
>> >> >      info->sample_pages = DirtyStat.sample_pages;
>> >> >      info->mode = dirtyrate_mode;
>> >> > +    info->page_size = TARGET_PAGE_SIZE;
>> >> 
>> >> I thought we exported this trough ""info migrate"
>> >> but we do it only if we are in the middle of a migration.  Perhaps we
>> >> should print it always.
>> >
>> > So, which one do you prefer? To keep it here or to make "info migrate" print it always (or both)?
>> 
>> info migrate to print it allways.  Thanks.
>
> I looked into "info migrate". To print page size irregarding migration status,
> all other 17 fields of MigrationInfo.ram will have to be made optional.
> Atop of that, it feels like that page size doesn't belong to "info migrate"
> since it is the only one "static" value, while all others are "dynamic" counters.
>
> I think I found a better place where page size can be reported --
> query-memory-size-summary. After the change it would be as following:
>   {"execute": "query-memory-size-summary"}
>   {"return": {"page-size": 4096, "base-memory": 34359738368, "plugged-memory": 0}}
>
> What do you think about it?

Perfect for me.

Thanks.


