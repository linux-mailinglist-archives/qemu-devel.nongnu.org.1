Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD199AD204A
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Jun 2025 15:57:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOczX-0007cw-Lp; Mon, 09 Jun 2025 09:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uOczU-0007Za-Rx; Mon, 09 Jun 2025 09:56:44 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uOczS-0004Mr-CT; Mon, 09 Jun 2025 09:56:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:160f:0:640:ffb2:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4168960B5F;
 Mon,  9 Jun 2025 16:56:37 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a98::1:26] (unknown
 [2a02:6bf:8080:a98::1:26])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id auhjOG5FiSw0-7PwrOLiV; Mon, 09 Jun 2025 16:56:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1749477396;
 bh=FQG43B4Eb18E8h4Ndl/14L1EmcmrjjC88bg4CGGAIQw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=su35hlv290zeHHRP4SdRRbCX43lQg3a2sgxmdQYINmvIO1+omwtUrF9oWkbGuo8XQ
 rrcjU0YhRGR+JWYKpQMG3PgTRNsouITM++cf+CQbFwrI7vEMnigT0/YZJD4oZLZXPQ
 WbCbFUn97/UgMJDufFSlceLthb5HS4yNdsesuXtM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <db069049-b055-4d47-ae36-89b3748c7b2c@yandex-team.ru>
Date: Mon, 9 Jun 2025 16:56:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hbitmap: introduce hbitmap_inverse()
To: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, eblake@redhat.com
Cc: qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
References: <20250528120732.2247150-1-andrey.zhadchenko@virtuozzo.com>
 <20250528120732.2247150-3-andrey.zhadchenko@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250528120732.2247150-3-andrey.zhadchenko@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 28.05.25 15:07, Andrey Zhadchenko wrote:
> and bdrv_dirty_bitmap_inverse() helper
> 
> Signed-off-by: Andrey Zhadchenko<andrey.zhadchenko@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


