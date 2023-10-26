Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCAC7D7F9E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 11:33:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvwj6-00072q-OI; Thu, 26 Oct 2023 05:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1qvwj2-00072B-Ua
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 05:32:24 -0400
Received: from mail.astralinux.ru ([217.74.38.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1qvwiz-0001zO-NC
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 05:32:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id AA74C1865782;
 Thu, 26 Oct 2023 12:32:07 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id Qfv-LHqtAjox; Thu, 26 Oct 2023 12:32:07 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id 5F20818640F5;
 Thu, 26 Oct 2023 12:32:07 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id toi3FNP2veCD; Thu, 26 Oct 2023 12:32:07 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.181.102])
 by mail.astralinux.ru (Postfix) with ESMTPS id 1BD2A1865782;
 Thu, 26 Oct 2023 12:32:07 +0300 (MSK)
Received: from [10.177.20.58] (unknown [10.177.20.58])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4SGLD643f7zqSJJ;
 Thu, 26 Oct 2023 12:32:06 +0300 (MSK)
Message-ID: <95d0b238-8c5f-4cc8-8edc-94cc7f380694@astralinux.ru>
Date: Thu, 26 Oct 2023 12:31:34 +0300
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] hyperv: add check for NULL for msg
Content-Language: ru
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
References: <20230928132519.26266-1-abelova@astralinux.ru>
 <3f62b1a2-9e13-4d0c-9b47-eb0146a6c80d@maciej.szmigiero.name>
From: =?UTF-8?B?0JDQvdCw0YHRgtCw0YHQuNGPINCb0Y7QsdC40LzQvtCy0LA=?=
 <abelova@astralinux.ru>
In-Reply-To: <3f62b1a2-9e13-4d0c-9b47-eb0146a6c80d@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=217.74.38.119; envelope-from=abelova@astralinux.ru;
 helo=mail.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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


28/09/23 19:18, Maciej S. Szmigiero =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On 28.09.2023 15:25, Anastasia Belova wrote:
>> cpu_physical_memory_map may return NULL in hyperv_hcall_post_message.
>> Add check for NULL to avoid NULL-dereference.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 76036a5fc7 ("hyperv: process POST_MESSAGE hypercall")
>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>
> Makes sense to me, thanks.
>
> Did you run your static checker through the remaining QEMU files,
> too?
>
> I can see similar cpu_physical_memory_map() usage in, for example:
> target/s390x/helper.c, hw/nvram/spapr_nvram.c, hw/hyperv/vmbus.c,
> display/ramfb.c...
>
It seems that configurations for analysis do not contain these files
so the checker hasn't warned us. Additional time is needed to
analyze these pieces of code and form patches if necessary.

Anastasia Belova

