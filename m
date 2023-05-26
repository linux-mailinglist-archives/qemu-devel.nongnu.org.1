Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB11E7125B5
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:38:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2VlW-0004tM-Bs; Fri, 26 May 2023 07:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1q2VlH-0004Qa-QI; Fri, 26 May 2023 07:37:36 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1q2VlD-0005cM-GC; Fri, 26 May 2023 07:37:35 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A514447379;
 Fri, 26 May 2023 13:37:24 +0200 (CEST)
Message-ID: <b1072885-8257-92a7-5328-6f3d40290196@proxmox.com>
Date: Fri, 26 May 2023 13:37:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 09/12] migration: Use migration_transferred_bytes() to
 calculate rate_limit
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Leonardo Bras <leobras@redhat.com>, David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Halil Pasic <pasic@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Peter Xu <peterx@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230518171304.95006-1-quintela@redhat.com>
 <20230518171304.95006-10-quintela@redhat.com>
 <5023cb18-9e9a-4666-e6b5-a7eb0e8dbd6c@proxmox.com>
 <877csv3215.fsf@secure.mitica>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <877csv3215.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.092,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 26.05.23 um 10:55 schrieb Juan Quintela:
> Fiona Ebner <f.ebner@proxmox.com> wrote:
>> Am 18.05.23 um 19:13 schrieb Juan Quintela:
>>> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
>>> index feec7d7369..97759a45f3 100644
>>> --- a/migration/migration-stats.c
>>> +++ b/migration/migration-stats.c
>>> @@ -24,7 +24,9 @@ bool migration_rate_exceeded(QEMUFile *f)
>>>          return true;
>>>      }
>>>  
>>> -    uint64_t rate_limit_used = stat64_get(&mig_stats.rate_limit_used);
>>> +    uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
>>> +    uint64_t rate_limit_current = migration_transferred_bytes(f);
>>> +    uint64_t rate_limit_used = rate_limit_current - rate_limit_start;
>>>      uint64_t rate_limit_max = stat64_get(&mig_stats.rate_limit_max);
>>>  
>>>      if (rate_limit_max == RATE_LIMIT_DISABLED) {
>>
>> Hi,
>> just wanted to let you know that the call to
>> migration_transferred_bytes(f) here can introduce a huge performance
>> penalty when taking a snapshot. I ran into the issue when testing
>> something else, with a single-disk snapshot. Without this call it takes
>> about two seconds, with the call about two minutes.
> 
> Ouch.
> 
> Now that everything is reviewed for that series I can sent the new set
> of patches.  As I drop the counter it should just get the speed back.
> 
> New series comming that removed rate_limit counter altogether.
> 
> Can you take a look after I send it?>

Sure. Please CC me, so I don't forget :)

> Thanks for the report.
> 
> And now that we are at it.  How are you testing this?

I ran into it while testing the "BQL during save setup" patch [0] on (at
that time current) master.

> As you appears to be the bigger user of snapshots (or at least the
> louder).

We do have quite a few users using snapshots, but it's actually not the
upstream snapshot-save, but a custom QMP command based on it and
migration code-wise. We do keep the VM running while taking the
snapshot, and write the state to a new raw file/block device. When it's
ready, the VM is stopped, the management software takes snapshots of the
disks (via QEMU for qcow2/RBD and via the storage layer for other
storages) and then the VM is resumed.

The caveat is that the saved state will be the one right before the
snapshot finished, not the one when the snapshot started (as with
background migration). If you really want to see the historically grown
details: [1].

It's much older than background-snapshot and we probably could switch to
using background-snapshot with some (minor) changes. I do plan to
evaluate that at some point, but haven't had the time yet.

> Creating tests/qtest/snapshot-test.c could be a good idea.

I can try to take a look at adding tests at some point, but I will be
very busy in the near future, because we have releases coming up. So if
anybody else wants to do it, don't wait for me :)

> 1st to check this kind of breakage.
> 2nd so I be sure that we don't "pesimize" your use case.
> 
> Hint, hint.
> 
> 2 seconds vs 2 minutes.
> 
> A more detailed explanation that what are you doing would be great.
> I.e. you are taking lots of snapshots by second or what?

No, it was just a single snapshot on a single drive for a VM with 2GiB
of RAM, nothing special. I also just "measured" it by counting, I
thought exact values won't matter when it's such a big difference.

Here's the command line:

> ./qemu-system-x86_64 \
>   -chardev 'socket,id=qmp,path=/var/run/qemu-server/106.qmp,server=on,wait=off' \
>   -mon 'chardev=qmp,mode=control' \
>   -pidfile /var/run/qemu-server/106.pid \
>   -smp '2,sockets=2,cores=1,maxcpus=2' \
>   -nodefaults \
>   -vnc 'unix:/var/run/qemu-server/106.vnc,password=on' \
>   -m 2048 \
>   -device 'VGA,id=vga,bus=pci.0,addr=0x2' \
>   -device 'virtio-scsi-pci,id=scsihw0,bus=pci.0,addr=0x5' \
>   -drive 'file=/var/lib/vz/images/106/vm-106-disk-1.qcow2,if=none,id=drive-scsi0,format=qcow2,cache=none,aio=io_uring,detect-zeroes=on,node-name=scsi0' \
>   -device 'scsi-hd,bus=scsihw0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0,bootindex=100' \
>   -machine 'type=pc'

and QMP params:

> 	    "snapshot-save",
> 	    'job-id' => "save$i",
> 	    tag => 'snap0',
> 	    vmstate => 'scsi0',
> 	    devices => ['scsi0'],


[0]: https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg06541.html
[1]:
https://git.proxmox.com/?p=pve-qemu.git;a=blob;f=debian/patches/pve/0018-PVE-add-savevm-async-for-background-state-snapshots.patch;h=d42d0f02f270934610b1ac90b2813b5ee617427d;hb=bd3c1fa52561e4a307e5b5b37754788408fc75a6

Best Regards,
Fiona


