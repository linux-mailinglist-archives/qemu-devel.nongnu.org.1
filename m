Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1727D2E58
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:33:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurHg-0001nZ-D9; Mon, 23 Oct 2023 05:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qurHd-0001mU-0L; Mon, 23 Oct 2023 05:31:37 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qurHZ-0004Qm-7o; Mon, 23 Oct 2023 05:31:36 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id EA1AE444F5;
 Mon, 23 Oct 2023 11:31:19 +0200 (CEST)
Message-ID: <64667e64-0b32-4cb4-b76a-4bd444964e3d@proxmox.com>
Date: Mon, 23 Oct 2023 11:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] blockjob: introduce block-job-change QMP command
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
References: <20231013092143.365296-1-f.ebner@proxmox.com>
 <20231013092143.365296-2-f.ebner@proxmox.com> <ZS//MVrI7XeJT0Bq@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ZS//MVrI7XeJT0Bq@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Am 18.10.23 um 17:52 schrieb Kevin Wolf:
> Am 13.10.2023 um 11:21 hat Fiona Ebner geschrieben:
>> which will allow changing job-type-specific options after job
>> creation.
>>
>> In the JobVerbTable, the same allow bits as for set-speed are used,
>> because set-speed can be considered an existing change command.
>>
>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
>> diff --git a/job.c b/job.c
>> index 72d57f0934..99a2e54b54 100644
>> --- a/job.c
>> +++ b/job.c
>> @@ -80,6 +80,7 @@ bool JobVerbTable[JOB_VERB__MAX][JOB_STATUS__MAX] = {
>>      [JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0},
>>      [JOB_VERB_FINALIZE]             = {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
>>      [JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
>> +    [JOB_VERB_CHANGE]               = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
>>  };
> 
> I'm not sure if I would have included JOB_STATUS_CREATED, i.e. before
> the job has even started, but it's not necessarily a problem. The
> implementation just need to be careful to work even in early stages. But
> probably the early stages include some part of JOB_STATUS_RUNNING, too,
> so they'd have to do this anyway.
> 

As mentioned in the commit message, I copied the bits from
JOB_VERB_SET_SPEED, because that seemed to be very similar, as it can
also be seen as a change operation (and who knows, maybe it can be
merged into JOB_VERB_CHANGE at some point in the future). But I can
remove the bit if you want me to.

Best Regards,
Fiona


