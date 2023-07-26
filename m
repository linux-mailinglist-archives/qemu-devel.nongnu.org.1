Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D85D67631EA
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 11:26:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOamo-0004Pa-Ko; Wed, 26 Jul 2023 05:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOamh-0004NA-Fd; Wed, 26 Jul 2023 05:26:20 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOamf-0001hI-5R; Wed, 26 Jul 2023 05:26:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2c24:0:640:73f8:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 9A76960BE7;
 Wed, 26 Jul 2023 12:26:03 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8924::1:1d] (unknown
 [2a02:6b8:b081:8924::1:1d])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0QH4m00OgiE0-Z2TjQVMW; Wed, 26 Jul 2023 12:26:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1690363560; bh=jPawcRtMMHfdKnMBZfVk7XkKUV+cp5jBmINmegju02Y=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QZHNyb25N5wkuD4rXQh6HfshpbTK8y1dRsDOhkegJkw6kbxDgxZFaoig1yIsRseLA
 tabrOfwuFZxxTMA6+G8FPpn/S2J5JnSnu4rv8rqZzXra7gYO2eVbi1yz0oX2kSKRfY
 lKPfUCprujfdO45ecmo5afEgGS5hDIExQHi64OLk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0275fd7f-3ebe-4d8c-a2f7-d543c5b66393@yandex-team.ru>
Date: Wed, 26 Jul 2023 12:26:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/3] tests/qemu-iotests/197: add testcase for CoR with
 subclusters
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org, 
 qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
 <20230711172553.234055-4-andrey.drobyshev@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230711172553.234055-4-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11.07.23 20:25, Andrey Drobyshev via wrote:
> Add testcase which checks that allocations during copy-on-read are
> performed on the subcluster basis when subclusters are enabled in target
> image.
> 
> This testcase also triggers the following assert with previous commit
> not being applied, so we check that as well:
> 
> qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.
> 
> Reviewed-by: Eric Blake<eblake@redhat.com>
> Reviewed-by: Denis V. Lunev<den@openvz.org>
> Signed-off-by: Andrey Drobyshev<andrey.drobyshev@virtuozzo.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


