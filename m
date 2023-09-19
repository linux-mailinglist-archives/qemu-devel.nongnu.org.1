Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B417A5994
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 07:48:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiTar-0001b1-PT; Tue, 19 Sep 2023 01:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiTap-0001aL-7B
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 01:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiTan-00018K-N3
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 01:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695102493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b/fZBqgWohIXDyoS//C2CQBh2i20NsRptRtuC2Sy1CY=;
 b=UuyALlnJEi82JZ+3NVyCSU1D47gfyFQha906sERqwkf9OWkDpDcZfUOktXmw7XEui73i9+
 WwpBQ7ttF8ynS2OH03yy/RPkXSXsAHK5q+xrrHqPB747QfGLlqKbVaORtMjVY7LtmKfEzu
 wnjT2m2w2WTOI3z/xcGzbjZmwi289EQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-683-xHw6_rRWPtevVZjCFt_5Cw-1; Tue, 19 Sep 2023 01:48:07 -0400
X-MC-Unique: xHw6_rRWPtevVZjCFt_5Cw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98501811E7B;
 Tue, 19 Sep 2023 05:48:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69AFDC15BB8;
 Tue, 19 Sep 2023 05:48:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5EA2321E6900; Tue, 19 Sep 2023 07:48:05 +0200 (CEST)
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
Subject: Re: [PATCH 4/7] block/dirty-bitmap: Clean up local variable shadowing
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-5-armbru@redhat.com>
 <ZQQNUjN4Laf+k1Nk@redhat.com>
Date: Tue, 19 Sep 2023 07:48:05 +0200
In-Reply-To: <ZQQNUjN4Laf+k1Nk@redhat.com> (Kevin Wolf's message of "Fri, 15
 Sep 2023 09:52:50 +0200")
Message-ID: <8734za4stm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
>> ---
>>  block/monitor/bitmap-qmp-cmds.c | 2 +-
>>  block/qcow2-bitmap.c            | 3 +--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>> 
>> diff --git a/block/monitor/bitmap-qmp-cmds.c b/block/monitor/bitmap-qmp-cmds.c
>> index 55f778f5af..4d018423d8 100644
>> --- a/block/monitor/bitmap-qmp-cmds.c
>> +++ b/block/monitor/bitmap-qmp-cmds.c
>> @@ -276,7 +276,7 @@ BdrvDirtyBitmap *block_dirty_bitmap_merge(const char *node, const char *target,
>>  
>>      for (lst = bms; lst; lst = lst->next) {
>>          switch (lst->value->type) {
>> -            const char *name, *node;
>> +            const char *name;
>>          case QTYPE_QSTRING:
>>              name = lst->value->u.local;
>>              src = bdrv_find_dirty_bitmap(bs, name);
>
> The names in this function are all over the place... A more ambitious
> patch could rename the parameters to dst_node/dst_bitmap and these
> variables to src_node/src_bitmap to get some more consistency (both with
> each other and with the existing src/dst variables).

What exactly would you like me to consider?  Perhaps:

* Rename parameter @node to @dst_node

* Rename which parameter to @dst_bitmap?

* Rename nested local @node to @src_node

* Rename which local variable to @src_bitmap?

* Move nested locals to function scope

> Preexisting, so I'm not insisting that you should do this.
>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 037fa2d435..ffd5cd3b23 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -1555,7 +1555,6 @@ bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>      FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
>>          const char *name = bdrv_dirty_bitmap_name(bitmap);
>>          uint32_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
>> -        Qcow2Bitmap *bm;
>>  
>>          if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
>>              bdrv_dirty_bitmap_inconsistent(bitmap)) {
>> @@ -1625,7 +1624,7 @@ bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>  
>>      /* allocate clusters and store bitmaps */
>>      QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>> -        BdrvDirtyBitmap *bitmap = bm->dirty_bitmap;
>> +        bitmap = bm->dirty_bitmap;
>>  
>>          if (bitmap == NULL || bdrv_dirty_bitmap_readonly(bitmap)) {
>>              continue;
>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Thanks!


