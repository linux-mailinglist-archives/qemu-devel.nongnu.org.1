Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F787A4B43
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:49:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFXX-0007jM-0z; Mon, 18 Sep 2023 10:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFXM-0007bF-Vt
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFXL-0003oy-Aa
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rr10BgvxSqJ2B7JFeQPeJKV1bmS3WBpXTQ2eSz0GfVQ=;
 b=fv5/wG4TvhqmLkjr3lRzYe9mmyesNHTHW+T24NjE9cbd1HUHLR2Oz8KUM9+N7pbwTMP+wy
 yK9N/KSJDiwD63Yqb/9J7zkKc8+TBprk1F56U4rkMbYG9NVP2LrqfXui3RBVXXOdkYWZC5
 TKkz8ecVB7O9gkRhWCsWxovtXcjpakE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-694-ZNSI5qm6NxGEWYqOK2iQsg-1; Mon, 18 Sep 2023 10:47:37 -0400
X-MC-Unique: ZNSI5qm6NxGEWYqOK2iQsg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBD30101A53B;
 Mon, 18 Sep 2023 14:47:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D456A1C554;
 Mon, 18 Sep 2023 14:47:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E818F21E6900; Mon, 18 Sep 2023 16:47:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org,  hreitz@redhat.com,  eblake@redhat.com,
 vsementsov@yandex-team.ru,  jsnow@redhat.com,  idryomov@gmail.com,
 pl@kamp.de,  sw@weilnetz.de,  sstabellini@kernel.org,
 anthony.perard@citrix.com,  paul@xen.org,  pbonzini@redhat.com,
 marcandre.lureau@redhat.com,  berrange@redhat.com,  thuth@redhat.com,
 philmd@linaro.org,  stefanha@redhat.com,  fam@euphon.net,
 quintela@redhat.com,  peterx@redhat.com,  leobras@redhat.com,
 kraxel@redhat.com,  qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org,  alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH 5/7] block/vdi: Clean up local variable shadowing
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-6-armbru@redhat.com>
 <ZQQKsxgrT2mLokFi@redhat.com>
Date: Mon, 18 Sep 2023 16:47:34 +0200
In-Reply-To: <ZQQKsxgrT2mLokFi@redhat.com> (Kevin Wolf's message of "Fri, 15
 Sep 2023 09:41:39 +0200")
Message-ID: <871qevczcp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 31.08.2023 um 15:25 hat Markus Armbruster geschrieben:
>> Local variables shadowing other local variables or parameters make the
>> code needlessly hard to understand.  Tracked down with -Wshadow=local.
>> Clean up: delete inner declarations when they are actually redundant,
>> else rename variables.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>> @@ -700,7 +699,7 @@ nonallocating_write:
>>          /* One or more new blocks were allocated. */
>>          VdiHeader *header;
>>          uint8_t *base;
>> -        uint64_t offset;
>> +        uint64_t offs;
>>          uint32_t n_sectors;
>>  
>>          g_free(block);
>> @@ -723,11 +722,11 @@ nonallocating_write:
>>          bmap_first /= (SECTOR_SIZE / sizeof(uint32_t));
>>          bmap_last /= (SECTOR_SIZE / sizeof(uint32_t));
>>          n_sectors = bmap_last - bmap_first + 1;
>> -        offset = s->bmap_sector + bmap_first;
>> +        offs = s->bmap_sector + bmap_first;
>>          base = ((uint8_t *)&s->bmap[0]) + bmap_first * SECTOR_SIZE;
>>          logout("will write %u block map sectors starting from entry %u\n",
>>                 n_sectors, bmap_first);
>> -        ret = bdrv_co_pwrite(bs->file, offset * SECTOR_SIZE,
>> +        ret = bdrv_co_pwrite(bs->file, offs * SECTOR_SIZE,
>>                               n_sectors * SECTOR_SIZE, base, 0);
>>      }
>
> Having two variables 'offset' and 'offs' doesn't really help with
> clarity either. Can we be more specific and use something like
> 'bmap_offset' here?

Sure!


