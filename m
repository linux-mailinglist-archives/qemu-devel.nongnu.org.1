Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 970587630AA
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 10:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOaMa-0004S7-KM; Wed, 26 Jul 2023 04:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOaMU-0004Rc-58; Wed, 26 Jul 2023 04:59:14 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOaMR-00066O-Jv; Wed, 26 Jul 2023 04:59:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9a90:0:640:d8ed:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 4430F605A3;
 Wed, 26 Jul 2023 11:58:55 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8924::1:1d] (unknown
 [2a02:6b8:b081:8924::1:1d])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id swGjK00Oo8c0-mhr2JJef; Wed, 26 Jul 2023 11:58:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1690361934; bh=1msk/cNi4EH1EbN5oN50+TvCvNVG+eCRvRbCoLWwo9k=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=G5mjbUP+wFZyZC2hfW6UDrbq7mc2K9/FdPEiQmLsOLIqO22mG1YXXgCePz8Wq/qDm
 RGaO8Pzvm0TBKAQpvV/MGXh8xKt0WKKxcBQOwvB0fiQb5oRgSngDDJ5sZRkONNiusU
 oZLUcOahmIiC0eMiEK5cwFYZ8JquliH14Zdftp8Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <98f13ad6-528c-6a22-9ea8-64c3536eb758@yandex-team.ru>
Date: Wed, 26 Jul 2023 11:58:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] block: add subcluster_size field to BlockDriverInfo
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org, 
 qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
 <20230711172553.234055-2-andrey.drobyshev@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230711172553.234055-2-andrey.drobyshev@virtuozzo.com>
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

On 11.07.23 20:25, Andrey Drobyshev wrote:
> This is going to be used in the subsequent commit as requests alignment
> (in particular, during copy-on-read).  This value only makes sense for
> the formats which support subclusters (currently QCOW2 only).  If this
> field isn't set by driver's own bdrv_get_info() implementation, we
> simply set it equal to the cluster size thus treating each cluster as
> having a single subcluster.
> 
> Reviewed-by: Eric Blake<eblake@redhat.com>
> Reviewed-by: Denis V. Lunev<den@openvz.org>
> Signed-off-by: Andrey Drobyshev<andrey.drobyshev@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


