Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E06C797D31
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 22:12:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeLLO-0001mf-Ml; Thu, 07 Sep 2023 16:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeLLK-0001lV-Q4; Thu, 07 Sep 2023 16:11:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeLLI-0008IO-3R; Thu, 07 Sep 2023 16:11:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 33E5D1FE21;
 Thu,  7 Sep 2023 23:11:50 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 43A98266F3;
 Thu,  7 Sep 2023 23:11:02 +0300 (MSK)
Message-ID: <775f32c9-6068-9481-9ae2-fb259ce5bde7@tls.msk.ru>
Date: Thu, 7 Sep 2023 23:11:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 0/3] block: align CoR requests to subclusters
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org, 
 qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com, den@openvz.org
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

11.07.2023 20:25, Andrey Drobyshev via wrote:
> v1 --> v2:
>   * Fixed line indentation;
>   * Fixed wording in a comment;
>   * Added R-b.
> 
> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00606.html
> 
> Andrey Drobyshev (3):
>    block: add subcluster_size field to BlockDriverInfo
>    block/io: align requests to subcluster_size
>    tests/qemu-iotests/197: add testcase for CoR with subclusters
> 
>   block.c                      |  7 +++++
>   block/io.c                   | 50 ++++++++++++++++++------------------
>   block/mirror.c               |  8 +++---
>   block/qcow2.c                |  1 +
>   include/block/block-common.h |  5 ++++
>   include/block/block-io.h     |  8 +++---
>   tests/qemu-iotests/197       | 29 +++++++++++++++++++++
>   tests/qemu-iotests/197.out   | 24 +++++++++++++++++
>   8 files changed, 99 insertions(+), 33 deletions(-)

So, given the size of patch series and amount of time the series
were sitting there.. I'm hesitating to apply it to -stable.
The whole issue, while real, smells like somewhat unusual case.

Any comments on this?

Thanks,

/mjt

