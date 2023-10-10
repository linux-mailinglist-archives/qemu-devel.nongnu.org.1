Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD27C0319
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 19:57:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqGxo-0005yk-M5; Tue, 10 Oct 2023 13:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqGxm-0005wP-2J; Tue, 10 Oct 2023 13:56:10 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqGxg-00031T-Qt; Tue, 10 Oct 2023 13:56:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:4c13:0:640:3c7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id A11C5612D0;
 Tue, 10 Oct 2023 20:55:57 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7319::1:4] (unknown
 [2a02:6b8:b081:7319::1:4])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uthKPs0OdW20-p555Qx7z; Tue, 10 Oct 2023 20:55:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696960556;
 bh=8mDVF4JMtHGPSowfNsfTiMHuNr0mqYGggTjc5QMBBn8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ggv96Aa5RY/NZjNQx/skLbXj8z0vjAlY2SNdVWy7YFVkd7N0myFEpjFdiPMPkc8Dl
 2wx0810hpK3ewFRdu+rLxk5MJLciwnVF+85koytRvmAT2f1G0Sfq2W1lzEPELM4sJS
 hEvauV1ltLTKYneyT+qTkgk6OFi82b8RtRpWIPHM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
Date: Tue, 10 Oct 2023 20:55:51 +0300
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
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231009094619.469668-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 09.10.23 12:46, Fiona Ebner wrote:
> Changes in v2:
>      * move bitmap to filter which allows to avoid draining when
>        changing the copy mode
>      * add patch to determine copy_to_target only once
>      * drop patches returning redundant information upon query
>      * update QEMU version in QAPI
>      * update indentation in QAPI
>      * update indentation in QAPI (like in a937b6aa73 ("qapi: Reformat
>        doc comments to conform to current conventions"))
>      * add patch to adapt iotest output
> 
> Discussion of v1:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-02/msg07216.html
> 
> With active mode, the guest write speed is limited by the synchronous
> writes to the mirror target. For this reason, management applications
> might want to start out in background mode and only switch to active
> mode later, when certain conditions are met. This series adds a
> block-job-change QMP command to achieve that, as well as
> job-type-specific information when querying block jobs, which
> can be used to decide when the switch should happen.
> 
> For now, only the direction background -> active is supported.
> 
> The information added upon querying is whether the target is actively
> synced, the total data sent, and the remaining dirty bytes.
> 
> Initially, I tried to go for a more general 'job-change' command, but
> I couldn't figure out a way to avoid mutual inclusion between
> block-core.json and job.json.
> 

What is the problem with it? I still think that job-change would be better.

> 
> Fiona Ebner (10):
>    blockjob: introduce block-job-change QMP command
>    block/mirror: set actively_synced even after the job is ready
>    block/mirror: move dirty bitmap to filter
>    block/mirror: determine copy_to_target only once
>    mirror: implement mirror_change method
>    qapi/block-core: use JobType for BlockJobInfo's type
>    qapi/block-core: turn BlockJobInfo into a union
>    blockjob: query driver-specific info via a new 'query' driver method
>    mirror: return mirror-specific information upon query
>    iotests: adapt test output for new mirror query property
> 
>   block/mirror.c                 | 95 +++++++++++++++++++++++-----------
>   block/monitor/block-hmp-cmds.c |  4 +-
>   blockdev.c                     | 14 +++++
>   blockjob.c                     | 26 +++++++++-
>   include/block/blockjob.h       | 11 ++++
>   include/block/blockjob_int.h   | 10 ++++
>   job.c                          |  1 +
>   qapi/block-core.json           | 59 +++++++++++++++++++--
>   qapi/job.json                  |  4 +-
>   tests/qemu-iotests/109.out     | 24 ++++-----
>   10 files changed, 199 insertions(+), 49 deletions(-)
> 

-- 
Best regards,
Vladimir


