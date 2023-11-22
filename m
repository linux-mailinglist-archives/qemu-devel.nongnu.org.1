Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EC87F47CA
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 14:26:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5nEN-0002Wc-Aq; Wed, 22 Nov 2023 08:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1r5nEJ-0002WA-BN; Wed, 22 Nov 2023 08:25:23 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1r5nEG-0004zz-7j; Wed, 22 Nov 2023 08:25:22 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D3E4A429A9;
 Wed, 22 Nov 2023 14:25:16 +0100 (CET)
Message-ID: <b5419999-625f-45a3-9a61-b6cb8356cdbe@proxmox.com>
Date: Wed, 22 Nov 2023 14:25:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2] ui/vnc-clipboard: fix inflate_buffer
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, kraxel@redhat.com,
 mcascell@redhat.com
References: <20231122125826.228189-1-f.ebner@proxmox.com>
 <CAJ+F1CLFAuKF7CgbiBYnKv+7sjkXfJ9tURNuMNGu9NLru059nQ@mail.gmail.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAJ+F1CLFAuKF7CgbiBYnKv+7sjkXfJ9tURNuMNGu9NLru059nQ@mail.gmail.com>
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

Am 22.11.23 um 14:06 schrieb Marc-André Lureau:
> Hi
> 
> On Wed, Nov 22, 2023 at 5:00 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
>>
>> Commit d921fea338 ("ui/vnc-clipboard: fix infinite loop in
>> inflate_buffer (CVE-2023-3255)") removed this hunk, but it is still
>> required, because it can happen that stream.avail_in becomes zero
>> before coming across a return value of Z_STREAM_END in the loop.
> 
> Isn't this an error from the client side then?
> 

In my test just now I get Z_BUF_ERROR twice and after the second one,
stream.avail_in is zero. Maybe if you'd call inflate() again, you'd get
Z_STREAM_END, but no such call is made, because we exit the loop.

Would it be better/more correct to ensure that inflate is called again
in such a scenario?

Best Regards,
Fiona


