Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AF17EB7D8
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 21:32:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r303s-0003WE-7n; Tue, 14 Nov 2023 15:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r303q-0003W0-75; Tue, 14 Nov 2023 15:31:02 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r303n-0002PT-Dh; Tue, 14 Nov 2023 15:31:00 -0500
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:88b:0:640:d9e4:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 608E160F7B;
 Tue, 14 Nov 2023 23:30:51 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8917::1:1] (unknown
 [2a02:6b8:b081:8917::1:1])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oUqp9e75KCg0-55G1nl2r; Tue, 14 Nov 2023 23:30:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1699993851;
 bh=QkgIiotU3HtTdNMsGocUrfXHnh31D68cYNmH0QmtrB4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QYxf4T0rqtmrFCX1+5WWBTs/hJXcKfb1sm3cjzjuZR/KcHTsR3LhPeCV32MIO2KN9
 lxRb5xfxaK+y7ZdE+0T9Viy8+D1h09n4R7iKJ+jpCxitLiit0zGTItrqSjy6aXZ32w
 ezd/s4D5LSmFu06u1o1dJzDDRdiCZpNsKLT4fN8E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fede2648-e39d-4288-9389-ef491b27d5b1@yandex-team.ru>
Date: Tue, 14 Nov 2023 23:30:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial 20/21] util/filemonitor-inotify.c: spelling fix:
 kenel
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
 <20231114165834.2949011-21-mjt@tls.msk.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231114165834.2949011-21-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 14.11.23 19:58, Michael Tokarev wrote:
> Fixes: 2e12dd405c66 "util/filemonitor-inotify: qemu_file_monitor_watch(): assert no overflow"
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir


