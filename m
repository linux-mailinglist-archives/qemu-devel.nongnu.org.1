Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B037A5D8A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:15:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWpA-0002rd-6K; Tue, 19 Sep 2023 05:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiWp0-0002lD-Jg
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiWov-00074J-IF
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695114898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kfxG+3NvGJ16XDG6IYWSuJ/qFRiAs98yf3kCl72PcqQ=;
 b=avJBefGU6o6FoMYcmRvDJhcje/agiEpqQH48azyrDDtOiti/I+Nlk0auER4gkrlnMAw9SA
 UYxKH6esnhaNSjTiYFKD95Yn0LgC2PiBUQB20AUjIgldj+Q6TJV/GsgzbZhnLidmnOojRw
 CKIfM4esNjkOaTb+TPBeScuZZxEOvhc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-02CO63O_PzKDr7QFNvZVzQ-1; Tue, 19 Sep 2023 05:14:55 -0400
X-MC-Unique: 02CO63O_PzKDr7QFNvZVzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A9311C04B45;
 Tue, 19 Sep 2023 09:14:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0893D20268CB;
 Tue, 19 Sep 2023 09:14:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EE45221E6900; Tue, 19 Sep 2023 11:14:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Andrei Gudkov <gudkov.andrei@huawei.com>,  qemu-devel@nongnu.org,
 yong.huang@smartx.com,  quintela@redhat.com,  peterx@redhat.com,
 leobras@redhat.com,  eblake@redhat.com
Subject: Re: [PATCH] migration/dirtyrate: use QEMU_CLOCK_HOST to report
 start-time
References: <399861531e3b24a1ecea2ba453fb2c3d129fb03a.1693905328.git.gudkov.andrei@huawei.com>
 <62489e2b-5d03-1650-6337-a4159e88e439@linaro.org>
Date: Tue, 19 Sep 2023 11:14:52 +0200
In-Reply-To: <62489e2b-5d03-1650-6337-a4159e88e439@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 Sep 2023 11:39:28
 +0200")
Message-ID: <87il86zfqr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Andrei,
>
> On 5/9/23 11:18, Andrei Gudkov via wrote:
>> Currently query-dirty-rate uses QEMU_CLOCK_REALTIME as
>> the source for start-time field. This translates to
>> clock_gettime(CLOCK_MONOTONIC), i.e. number of seconds
>> since host boot. This is not very useful. The only
>> reasonable use case of start-time I can imagine is to
>> check whether previously completed measurements are
>> too old or not. But this makes sense only if start-time
>> is reported as host wall-clock time.
>> This patch replaces source of start-time from
>> QEMU_CLOCK_REALTIME to QEMU_CLOCK_HOST.
>> Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
>> ---
>>   qapi/migration.json   |  4 ++--
>>   migration/dirtyrate.c | 15 ++++++---------
>>   2 files changed, 8 insertions(+), 11 deletions(-)
>
>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index bccb3515e3..0510d68765 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -259,11 +259,10 @@ static struct DirtyRateInfo *query_dirty_rate_info=
(void)
>>       return info;
>>   }
>>   -static void init_dirtyrate_stat(int64_t start_time,
>> -                                struct DirtyRateConfig config)
>> +static void init_dirtyrate_stat(struct DirtyRateConfig config)
>>   {
>>       DirtyStat.dirty_rate =3D -1;
>> -    DirtyStat.start_time =3D start_time;
>> +    DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
>>       DirtyStat.calc_time =3D config.sample_period_seconds;
>>       DirtyStat.sample_pages =3D config.sample_pages_per_gigabytes;
>>   @@ -600,7 +599,7 @@ static void calculate_dirtyrate_dirty_bitmap(struc=
t DirtyRateConfig config)
>>       record_dirtypages_bitmap(&dirty_pages, true);
>>         start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>> -    DirtyStat.start_time =3D start_time / 1000;
>> +    DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
>
> You can directly use qemu_clock_get_us().

Andrei, care to respin?


