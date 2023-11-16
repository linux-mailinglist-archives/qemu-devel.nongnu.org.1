Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2647A7EDE6E
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 11:28:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Zb3-0007cb-TI; Thu, 16 Nov 2023 05:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r3Zb1-0007ai-UR; Thu, 16 Nov 2023 05:27:40 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r3Zay-00055F-Vw; Thu, 16 Nov 2023 05:27:39 -0500
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1bac:0:640:75a2:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 43ED56192E;
 Thu, 16 Nov 2023 13:27:30 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8814::1:30] (unknown
 [2a02:6b8:b081:8814::1:30])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QRiop30IkeA0-RV9KiI2T; Thu, 16 Nov 2023 13:27:29 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1700130449;
 bh=YUcvMxyw95e8oY5oAilKxTRkP9mabyoyUzqnI3gz1YY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=bXh0XNYFDln8R9j8dRrnS6niULorX9fOlwF7iqFJkhBKUPPeAfeBhlJnM5LmsX28r
 6DvzSUxl6tewbEG8+km4X2+KWQmoglC/rhAw9D2L2W68LJxc4qb+t1Fa+HdGn2zgnf
 NwRtDzNjUTDOzF9Jj7GIsh31METaTqNiiFBIsP2Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <08ff54f1-670b-4ae8-b876-f35dce86f0ce@yandex-team.ru>
Date: Thu, 16 Nov 2023 13:27:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block-backend: per-device throttling of BLOCK_IO_ERROR
 reports
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, yc-core@yandex-team.ru,
 zeil@yandex-team.ru, xeor@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org
References: <20231107085842.602188-1-vsementsov@yandex-team.ru>
 <87r0krnn88.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87r0krnn88.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

On 15.11.23 16:46, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>  writes:
> 
>> From: Leonid Kaplan<xeor@yandex-team.ru>
>>
>> BLOCK_IO_ERROR events comes from guest, so we must throttle them.
> Really?  Can you describe how a guest can trigger these errors?

When disk (for examaple vhost-user) is unavailable, every Guest request may map into BLOCK_IO_ERROR, as I understand.

-- 
Best regards,
Vladimir


