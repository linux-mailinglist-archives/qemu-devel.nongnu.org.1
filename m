Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F717C4082
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 22:01:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqIuj-0001hp-9U; Tue, 10 Oct 2023 16:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqIug-0001h8-El; Tue, 10 Oct 2023 16:01:06 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqIue-0006Uv-LG; Tue, 10 Oct 2023 16:01:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 29E77612D7;
 Tue, 10 Oct 2023 23:01:02 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7319::1:4] (unknown
 [2a02:6b8:b081:7319::1:4])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 11kk441OfqM0-ACdPnk35; Tue, 10 Oct 2023 23:01:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696968061;
 bh=/2iqWX5XHav8BKIWwQ9EliB/l4JehtDVoAq7VQbk1Nw=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=ypR5v9BEQiQETv71c6wc8OZEcaonoRnUoCaY4or0YRQMJ7i1BIinEF8cILqsqeyj0
 zaTCD3Jye3s6KJxWuCx+hre7n45akoprQKAmnQnLv6B79+zNZL9KW3A9Z2/k4n8VSW
 pNkFNgPByHpQmaW8TKwt50VrD/33MM0FjrDiXcEo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d09dfe1e-a95e-480f-9959-52ab1f716932@yandex-team.ru>
Date: Tue, 10 Oct 2023 23:01:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com,
 t.lamprecht@proxmox.com, alexander.ivanov@virtuozzo.com
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
In-Reply-To: <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10.10.23 20:55, Vladimir Sementsov-Ogievskiy wrote:
> On 09.10.23 12:46, Fiona Ebner wrote:
>> Changes in v2:
>>      * move bitmap to filter which allows to avoid draining when
>>        changing the copy mode
>>      * add patch to determine copy_to_target only once
>>      * drop patches returning redundant information upon query
>>      * update QEMU version in QAPI
>>      * update indentation in QAPI
>>      * update indentation in QAPI (like in a937b6aa73 ("qapi: Reformat
>>        doc comments to conform to current conventions"))
>>      * add patch to adapt iotest output
>>
>> Discussion of v1:
>> https://lists.nongnu.org/archive/html/qemu-devel/2023-02/msg07216.html
>>
>> With active mode, the guest write speed is limited by the synchronous
>> writes to the mirror target. For this reason, management applications
>> might want to start out in background mode and only switch to active
>> mode later, when certain conditions are met. This series adds a
>> block-job-change QMP command to achieve that, as well as
>> job-type-specific information when querying block jobs, which
>> can be used to decide when the switch should happen.
>>
>> For now, only the direction background -> active is supported.
>>
>> The information added upon querying is whether the target is actively
>> synced, the total data sent, and the remaining dirty bytes.
>>
>> Initially, I tried to go for a more general 'job-change' command, but
>> I couldn't figure out a way to avoid mutual inclusion between
>> block-core.json and job.json.
>>
> 
> What is the problem with it? I still think that job-change would be better.

However, that's not a show-stopper. We have block-job-* commands, they are not deprecated, no problem to add one more.

-- 
Best regards,
Vladimir


