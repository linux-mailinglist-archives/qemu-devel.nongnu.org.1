Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F577F9DF3
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 11:53:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ZE2-0001x9-Iy; Mon, 27 Nov 2023 05:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1r7ZDz-0001we-L6; Mon, 27 Nov 2023 05:52:23 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1r7ZDw-00057e-MZ; Mon, 27 Nov 2023 05:52:23 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E1FE444BC0;
 Mon, 27 Nov 2023 11:52:10 +0100 (CET)
Message-ID: <b5e09800-1d75-4108-8222-72360b8144bf@proxmox.com>
Date: Mon, 27 Nov 2023 11:51:58 +0100
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
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAJ+F1CK2KqnN2ZpZAz=kD7Pwn0SbZkmi_jMPxi4ePwPAubDmkg@mail.gmail.com>
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

Am 27.11.23 um 10:15 schrieb Marc-André Lureau:
> 
> It seems like a bug in tigervnc then. For some reason, the compressed
> data doesn't trigger Z_STREAM_END on the decompression side. Have you
> investigated or reported an issue to them?
> 

This was with noVNC. A colleague tested with TigerVNC. I haven't stepped
through with GDB there, but it might be similar. No, I haven't
reported/investigated for the VNC clients yet. Unfortunately, I've got
my hands full with other things at the moment, so it will be a while
until I can do that.

Even if it's a bug in the clients, this was working before d921fea338
("ui/vnc-clipboard: fix infinite loop in inflate_buffer
(CVE-2023-3255)") so I still feel like it might be worth handling in QEMU.

But is it really a client error? What I don't understand is why the
return value of inflate() is Z_BUF_ERROR even though all the input was
handled.

From https://www.zlib.net/manual.html

"inflate() returns [...] Z_BUF_ERROR if no progress was possible or if
there was not enough room in the output buffer when Z_FINISH is used."

> 51	        ret = inflate(&stream, Z_FINISH);
> (gdb) p stream
> $23 = {next_in = 0x555557652708 "", avail_in = 5, total_in = 12, next_out = 0x555557627378 "", avail_out = 8, total_out = 8, msg = 0x0, state = 0x5555578df5c0, zalloc = 0x7ffff7bc1560, zfree = 0x7ffff7bc1570, 
>   opaque = 0x0, data_type = 5, adler = 71434672, reserved = 0}
> (gdb) n
> 52	        switch (ret) {
> (gdb) p stream
> $24 = {next_in = 0x55555765270d "", avail_in = 0, total_in = 17, next_out = 0x555557627379 "", avail_out = 7, total_out = 9, msg = 0x0, state = 0x5555578df5c0, zalloc = 0x7ffff7bc1560, zfree = 0x7ffff7bc1570, 
>   opaque = 0x0, data_type = 128, adler = 99746224, reserved = 0}
> (gdb) p ret
> $25 = -5
> (gdb) p out + 4
> $26 = (uint8_t *) 0x555557627374 "fish"

Progress was made and there was enough space for the output (avail_out =
7 after the call), so it really shouldn't return Z_BUF_ERROR, right?

zlib version is 1:1.2.13.dfsg-1 (Debian 12 Bookworm)

Best Regards,
Fiona


