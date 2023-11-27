Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D87F9BC3
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 09:35:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7X3i-0005p1-AV; Mon, 27 Nov 2023 03:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1r7X3a-0005oM-8Y
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 03:33:30 -0500
Received: from mail.astralinux.ru ([217.74.38.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1r7X3X-0004h0-Nv
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 03:33:29 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id 54C00186511D;
 Mon, 27 Nov 2023 11:33:14 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id LktAmvwWZFJr; Mon, 27 Nov 2023 11:33:14 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id 18B7D1863D36;
 Mon, 27 Nov 2023 11:33:14 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id Dz317M_ptsSI; Mon, 27 Nov 2023 11:33:14 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.181.102])
 by mail.astralinux.ru (Postfix) with ESMTPS id DC0DC186511D;
 Mon, 27 Nov 2023 11:33:13 +0300 (MSK)
Received: from [10.177.20.58] (unknown [10.177.20.58])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4SdzPP1q7dzsR4B;
 Mon, 27 Nov 2023 11:33:13 +0300 (MSK)
Message-ID: <e5ef52f7-86d8-4d82-adc9-ad60a56a8466@astralinux.ru>
Date: Mon, 27 Nov 2023 11:32:31 +0300
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] l2tpv3: overwrite s->fd in net_l2tpv3_cleanup
Content-Language: ru
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
References: <20231018110917.4131-1-abelova@astralinux.ru>
From: =?UTF-8?B?0JDQvdCw0YHRgtCw0YHQuNGPINCb0Y7QsdC40LzQvtCy0LA=?=
 <abelova@astralinux.ru>
In-Reply-To: <20231018110917.4131-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=217.74.38.119; envelope-from=abelova@astralinux.ru;
 helo=mail.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


18/10/23 14:09, Anastasia Belova:
> It's better to overwrite freed pointer s->fd to avoid accessing an 
> invalid descriptor. Found by Linux Verification Center 
> (linuxtesting.org) with SVACE.

Just a friendly reminder.

Anastasia Belova

