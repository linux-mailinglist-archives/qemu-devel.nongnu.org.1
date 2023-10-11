Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E77A07C4FF8
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:20:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWJ3-0004Ny-Fn; Wed, 11 Oct 2023 06:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qqWIy-0004NQ-LQ; Wed, 11 Oct 2023 06:19:04 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qqWIw-0001L8-BG; Wed, 11 Oct 2023 06:19:04 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0E1AD44A0F;
 Wed, 11 Oct 2023 12:18:52 +0200 (CEST)
Message-ID: <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
Date: Wed, 11 Oct 2023 12:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com,
 t.lamprecht@proxmox.com, alexander.ivanov@virtuozzo.com
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
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

Am 10.10.23 um 19:55 schrieb Vladimir Sementsov-Ogievskiy:
> On 09.10.23 12:46, Fiona Ebner wrote:
>>
>> Initially, I tried to go for a more general 'job-change' command, but
>> I couldn't figure out a way to avoid mutual inclusion between
>> block-core.json and job.json.
>>
> 
> What is the problem with it? I still think that job-change would be better.
> 

If going for job-change in job.json, the dependencies would be

job-change -> JobChangeOptions -> JobChangeOptionsMirror -> MirrorCopyMode

query-jobs -> JobInfo -> JobInfoMirror

and we can't include block-core.json in job.json, because an inclusion
loop gives a build error.

Could be made to work by moving MirrorCopyMode (and
JobChangeOptionsMirror, JobInfoMirror) to job.json or some place that
can be included by both job.json and block-core.json. Moving the
type-specific definitions to the general job.json didn't feel right to
me. Including another file with type-specific definitions in job.json
feels slightly less wrong, but still not quite right and I didn't want
to create a new file just for MirrorCopyMode (and
JobChangeOptionsMirror, JobInfoMirror).

And going further and moving all mirror-related things to a separate
file would require moving along things like NewImageMode with it or
create yet another file for such general things used by multiple block-jobs.

If preferred, I can try and go with some version of the above.

Best Regards,
Fiona


