Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4919EB3E4
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Dec 2024 15:49:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL1XW-0003LC-B8; Tue, 10 Dec 2024 09:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tL1XL-0003Kp-2f
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:48:31 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tL1XG-00048n-8N
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:48:30 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3b05:0:640:71ba:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 83FF460AD1;
 Tue, 10 Dec 2024 17:48:17 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:1232::1:1d] (unknown
 [2a02:6b8:b081:1232::1:1d])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GmngFR3IfeA0-dQUefYdK; Tue, 10 Dec 2024 17:48:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1733842097;
 bh=xQBv1JBQharCY2anhIFn3nMg4UWT1fnkjzAxudu2pV0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=iKMklZBz5tVV15cPy0+BlUT456euS21Y55M55QbGAXOt3h106m/NtwUmTWTg9XV0/
 En+li0TPV6yZU48gJiETbOwg0Tw/7URtfgvYiutpJGxrBkeZMkQ553i8609kgEcSKI
 xpV78XbYMtp5yK9Dw8pS0b4nz80NQuUUNdmDkZy8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b091b2c0-8731-4b22-9871-05a7afa0a019@yandex-team.ru>
Date: Tue, 10 Dec 2024 17:48:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] overcommit: introduce mem-lock-onfault
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20241205231909.1161950-1-d-tatianin@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20241205231909.1161950-1-d-tatianin@yandex-team.ru>
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

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


