Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F71D7C701E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwPA-0006SQ-Rt; Thu, 12 Oct 2023 10:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqwP5-0006O7-Ds; Thu, 12 Oct 2023 10:11:07 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqwP1-0000sW-4R; Thu, 12 Oct 2023 10:11:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:201e:0:640:d29a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 206FC6109D;
 Thu, 12 Oct 2023 17:10:59 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a401::1:4] (unknown
 [2a02:6b8:b081:a401::1:4])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vAgVqY6OqOs0-4wTmpzMT; Thu, 12 Oct 2023 17:10:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697119858;
 bh=GimmIGhfge0j3wDrDx60jiCF69tOxcFGKzZhqxAaoKA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0NOGzGUetc34IoY1TxkMktgK5D01fiJf0kpxxyfqhDdjKz4ZTrSIBDL+bTSHe+2ks
 MplolT/7IIdhpvIfI/gOgjG/L/L1xipkpltZWsbNTKI/GB4HleIg5TVABcpsO1Uj6F
 69RDN1jom8UOP7YLbWLENDUozCOuM1r3XGKOASs8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru>
Date: Thu, 12 Oct 2023 17:10:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com,
 t.lamprecht@proxmox.com, alexander.ivanov@virtuozzo.com
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
 <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 11.10.23 13:18, Fiona Ebner wrote:
> Am 10.10.23 um 19:55 schrieb Vladimir Sementsov-Ogievskiy:
>> On 09.10.23 12:46, Fiona Ebner wrote:
>>>
>>> Initially, I tried to go for a more general 'job-change' command, but
>>> I couldn't figure out a way to avoid mutual inclusion between
>>> block-core.json and job.json.
>>>
>>
>> What is the problem with it? I still think that job-change would be better.
>>
> 
> If going for job-change in job.json, the dependencies would be
> 
> job-change -> JobChangeOptions -> JobChangeOptionsMirror -> MirrorCopyMode
> 
> query-jobs -> JobInfo -> JobInfoMirror
> 
> and we can't include block-core.json in job.json, because an inclusion
> loop gives a build error.
> 
> Could be made to work by moving MirrorCopyMode (and
> JobChangeOptionsMirror, JobInfoMirror) to job.json or some place that
> can be included by both job.json and block-core.json. Moving the
> type-specific definitions to the general job.json didn't feel right to
> me. Including another file with type-specific definitions in job.json
> feels slightly less wrong, but still not quite right and I didn't want
> to create a new file just for MirrorCopyMode (and
> JobChangeOptionsMirror, JobInfoMirror).
> 
> And going further and moving all mirror-related things to a separate
> file would require moving along things like NewImageMode with it or
> create yet another file for such general things used by multiple block-jobs.
> 
> If preferred, I can try and go with some version of the above.
> 

OK, I see the problem. Seems, that all requires some good refactoring. But that's a preexisting big work, and should not hold up your series. I'm OK to proceed with block-job-change.

-- 
Best regards,
Vladimir


