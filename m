Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01983945CF5
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Aug 2024 13:12:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZqBf-0001EJ-0Y; Fri, 02 Aug 2024 07:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZqBV-0001C6-Ia; Fri, 02 Aug 2024 07:10:57 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZqBS-0004mK-UY; Fri, 02 Aug 2024 07:10:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4F81460B52;
 Fri,  2 Aug 2024 14:10:50 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b725::1:34] (unknown
 [2a02:6b8:b081:b725::1:34])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nAWlw38IcCg0-dMoKrgoX; Fri, 02 Aug 2024 14:10:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1722597049;
 bh=XGWR8kuofwt84k9I/kYRha2MxzC+QzNYpbmNvp4lHnk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=f+gZaFcsaaVG24fD1/tzMqzRBEUnQXo6HD5BjZBEsECdQVpVNGiGPIhM4yFLSGUyY
 gly8HsNqTnB9SoeBXe7kX2zT+dWoHc/mpkxNrSZppXmxVwCYtanRiObzM8KQH/3o0k
 WhnF+7usD6SGSUzyrJ4Gi/wxfU6XEf2dFxSgNxHg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2ee88d14-98a0-4189-96fe-be737f915744@yandex-team.ru>
Date: Fri, 2 Aug 2024 14:10:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] qapi/block-core: derpecate block-job-change
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
References: <20240626110124.374336-1-vsementsov@yandex-team.ru>
 <20240626110124.374336-7-vsementsov@yandex-team.ru>
 <87frs7x8tm.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87frs7x8tm.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 18.07.24 14:01, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> That's a first step to move on newer job-* APIs.
>>
>> The difference between block-job-change and job-change is in
>> find_block_job_locked() vs find_job_locked() functions. What's
>> different?
>>
>> 1. find_block_job_locked() do check, is found job a block-job. This OK
> 
> Do you mean something like find_block_job_locked() finds only block
> jobs, whereas find_job_locked() finds any kind of job?

Yes

> 
>>     when moving to more generic API, no needs to document this change.
>>
>> 2. find_block_job_locked() reports DeviceNotActive on failure, when
>>     find_job_locked() reports GenericError. Still, for block-job-change
>>     errors are not documented at all, so be silent in deprecated.txt as
>>     well.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 

-- 
Best regards,
Vladimir


