Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0206A806A40
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 10:01:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAnkm-0001Re-EP; Wed, 06 Dec 2023 03:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rAnkj-0001R8-Cn; Wed, 06 Dec 2023 03:59:33 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rAnkg-0006qe-9f; Wed, 06 Dec 2023 03:59:32 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 37A1C424A5;
 Wed,  6 Dec 2023 09:59:19 +0100 (CET)
Message-ID: <cca30ea8-b548-46ee-89d4-ea6595bd0fce@proxmox.com>
Date: Wed, 6 Dec 2023 09:59:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2] ui/vnc-clipboard: fix inflate_buffer
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, kraxel@redhat.com,
 mcascell@redhat.com
References: <20231122125826.228189-1-f.ebner@proxmox.com>
 <CAJ+F1CLFAuKF7CgbiBYnKv+7sjkXfJ9tURNuMNGu9NLru059nQ@mail.gmail.com>
 <b5419999-625f-45a3-9a61-b6cb8356cdbe@proxmox.com>
 <CAJ+F1C+CV-PbMAhw9V+OzDHnFiSyFW8+kFBZZ-n_7usoNP_S5w@mail.gmail.com>
 <1bf79e54-d4de-4ac4-b75d-c79bd52c3eb0@proxmox.com>
 <CAJ+F1CK2KqnN2ZpZAz=kD7Pwn0SbZkmi_jMPxi4ePwPAubDmkg@mail.gmail.com>
 <b5e09800-1d75-4108-8222-72360b8144bf@proxmox.com>
 <CAJ+F1CJk4=7DL0NhC9fOG_QnykVOB_yv89PKr3KpeS5LmuuK3w@mail.gmail.com>
 <CAJ+F1CKPQ_6p8Lc3iBP-FM=ke1VS4bjL=JzHm+H-uiNR=x_R+A@mail.gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAJ+F1CKPQ_6p8Lc3iBP-FM=ke1VS4bjL=JzHm+H-uiNR=x_R+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
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

Am 04.12.23 um 08:30 schrieb Marc-André Lureau:
> Hi
> 
> On Tue, Nov 28, 2023 at 2:52 PM Marc-André Lureau
> <marcandre.lureau@gmail.com> wrote:
>>
>>
>> It's hard to make the best decision.
>>
>> We could return the uncompressed data so far, that would fix the
>> regression. But potentially, we have incomplete data returned. Clients
>> should be fixed to include Z_STREAM_END marker (using Z_FINISH).
>>
> 
> I'll queue your patch for 8.2. thanks
> 

Thanks to you for looking into the issue!

A colleague of mine now opened a bug report for noVNC and according to
the the maintainer there, the protocol does not require setting an end
marker: https://github.com/novnc/noVNC/issues/1820#issuecomment-1841014968

Best Regards,
Fiona


