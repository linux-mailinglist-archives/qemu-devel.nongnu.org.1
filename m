Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE6D7C51E3
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 13:23:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqXIR-0008Ro-Gu; Wed, 11 Oct 2023 07:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qqXI4-0008Ji-DH; Wed, 11 Oct 2023 07:22:13 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qqXI1-000148-U8; Wed, 11 Oct 2023 07:22:12 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3909345206;
 Wed, 11 Oct 2023 13:22:07 +0200 (CEST)
Message-ID: <cc727bee-b9aa-4493-b26e-1ea93d15f8eb@proxmox.com>
Date: Wed, 11 Oct 2023 13:22:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] mirror: implement mirror_change method
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com,
 t.lamprecht@proxmox.com, alexander.ivanov@virtuozzo.com
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <20231009094619.469668-6-f.ebner@proxmox.com>
 <f6987c95-b1c4-4bfa-ae05-931c4f946151@yandex-team.ru>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <f6987c95-b1c4-4bfa-ae05-931c4f946151@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 10.10.23 um 21:37 schrieb Vladimir Sementsov-Ogievskiy:
> On 09.10.23 12:46, Fiona Ebner wrote:
>>   +static void mirror_change(BlockJob *job, BlockJobChangeOptions *opts,
>> +                          Error **errp)
>> +{
>> +    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
>> +    BlockJobChangeOptionsMirror *change_opts = &opts->u.mirror;
>> +
>> +    if (s->copy_mode == change_opts->copy_mode) {
>> +        return;
>> +    }
>> +
>> +    if (s->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING) {
>> +        error_setg(errp, "Cannot switch away from copy mode
>> 'write-blocking'");
>> +        return;
>> +    }
>> +
>> +    assert(s->copy_mode == MIRROR_COPY_MODE_BACKGROUND &&
>> +           change_opts->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING);
>> +
>> +    s->copy_mode = MIRROR_COPY_MODE_WRITE_BLOCKING;
>> +}
> 
> So, s->copy_mode becomes shared between main thread and iothread.
> 
> We should either use mutex or atomic operations.
> 
> Note, that the only realization of .set_speed uses thread-safe API.
> 

Can it be an issue if it's only ever set from the main thread?

But sure, I'm implicitly relying on that, which is not ideal. The
mirror_change() function does multiple checks based on the current
value, and only then changes it, so I suppose it would actually need a
mutex rather than just changing to atomic accesses? Otherwise, the
current value can't be guaranteed to be the same in the different checks
if we ever add something that can change the value from another thread.

I suppose, I should re-use the job mutex then?

Best Regards,
Fiona


