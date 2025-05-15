Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB218AB8540
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 13:50:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFX5U-0003yC-NX; Thu, 15 May 2025 07:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uFX5E-0003Ve-Ej; Thu, 15 May 2025 07:49:04 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uFX5B-0001JF-Sy; Thu, 15 May 2025 07:49:03 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A6AD642A16;
 Thu, 15 May 2025 13:48:57 +0200 (CEST)
Message-ID: <d1d0c8c3-9cba-4916-877b-95ccd718a817@proxmox.com>
Date: Thu, 15 May 2025 13:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] block: move drain outside of read-locked
 bdrv_reopen_queue_child()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-3-f.ebner@proxmox.com> <aCTGceRCQ4bywHx5@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aCTGceRCQ4bywHx5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 14.05.25 um 18:36 schrieb Kevin Wolf:
> Am 08.05.2025 um 16:09 hat Fiona Ebner geschrieben:
>> @@ -4368,6 +4368,7 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
>>                          bool keep_old_opts)
>>  {
>>      assert(bs != NULL);
>> +    assert(qatomic_read(&bs->quiesce_counter) > 0);
> 
> BlockDriverState.quiesce_counter isn't accessed with atomics elsewhere.
> Did you confuse it with BlockBackend.quiesce_counter?

No, but I saw that it is modified via qatomic_fetch_inc/dec(). And those
modifications are in bdrv_do_drained_begin/end() which are
IO_OR_GS_CODE(). So isn't it more correct to read via atomics here?

The documentation in include/block/block_int-common.h for struct
BlockDriverState also states:
>     /* Accessed with atomic ops.  */
>     int quiesce_counter;

Should I rather add a patch to have the other readers use atomics too?

>> @@ -4522,6 +4516,14 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
>>                                      QDict *options, bool keep_old_opts)
>>  {
>>      GLOBAL_STATE_CODE();
>> +
>> +    if (bs_queue == NULL) {
>> +        /*
>> +         * paired with bdrv_drain_all_end() in bdrv_reopen_queue_free().
>> +         */
>> +        bdrv_drain_all_begin();
> 
> Having this comment is a good idea. It fits on a single line, though.

Ack.

> 
>> +    }
>> +
>>      GRAPH_RDLOCK_GUARD_MAINLOOP();
>>  
>>      return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, 0, false,
>> @@ -4534,12 +4536,16 @@ void bdrv_reopen_queue_free(BlockReopenQueue *bs_queue)
>>      if (bs_queue) {
>>          BlockReopenQueueEntry *bs_entry, *next;
>>          QTAILQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
>> -            bdrv_drained_end(bs_entry->state.bs);
>>              qobject_unref(bs_entry->state.explicit_options);
>>              qobject_unref(bs_entry->state.options);
>>              g_free(bs_entry);
>>          }
>>          g_free(bs_queue);
>> +
>> +        /*
>> +         * paired with bdrv_drain_all_begin() in bdrv_reopen_queue().
>> +         */
>> +        bdrv_drain_all_end();
> 
> This could be a single line comment, too.

Ack.

Best Regards,
Fiona


