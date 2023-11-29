Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546277FD6FE
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 13:41:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Js4-0003Vp-2V; Wed, 29 Nov 2023 07:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r8Js0-0003Rm-Hb
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 07:40:50 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r8Jry-0003uV-KV
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 07:40:48 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7673E75A4C3;
 Wed, 29 Nov 2023 13:40:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 5n_ieyo_utam; Wed, 29 Nov 2023 13:40:40 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8DAEF75A4C2; Wed, 29 Nov 2023 13:40:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8AD17756094;
 Wed, 29 Nov 2023 13:40:40 +0100 (CET)
Date: Wed, 29 Nov 2023 13:40:40 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Bernhard Beschow <shentey@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, vr_qemu@t-online.de
Subject: Re: [PATCH v3 0/4] Fix IRQ routing in via south bridge
In-Reply-To: <ccc89939-8f8f-4c0d-b401-46f463d0db5f@tls.msk.ru>
Message-ID: <ad822769-d035-56f4-744a-3a3ebd254045@eik.bme.hu>
References: <cover.1701035944.git.balaton@eik.bme.hu>
 <ccc89939-8f8f-4c0d-b401-46f463d0db5f@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Wed, 29 Nov 2023, Michael Tokarev wrote:
> 27.11.2023 01:49, BALATON Zoltan:
>> Philippe,
>> 
>> Could this be merged for 8.2 as it fixes USB on the amigaone machine?
>> This would be useful as usb-storage is the simplest way to share data
>> with the host with these machines.
>> 
>> This is a slight change from v2 adding more comments and improving
>> commit messages and clean things a bit but otherwise should be the
>> same as previous versions. Even v1 worked the same as this one and v2,
>> the additional check to avoid stuck bits is just paranoia, it does not
>> happen in practice as IRQ mappings are quite static, they are set once
>> at boot and don't change afterwards.
>
> Should this patchset be picked up for stable-8.1?

The amigaone machine was added now in 8.2 so the problem does not occur in 
8.1 yet (the different usage of this chip by amigaone firmware uncovered 
the issue that made this fix necessary). So 8.1 should still work without 
this therefore I don't think this is needed in stable.

Regards,
BALATON Zoltan

