Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 186307F5A71
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 09:48:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r65ML-0001q3-BQ; Thu, 23 Nov 2023 03:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1r65ME-0001pj-9C; Thu, 23 Nov 2023 03:46:46 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1r65MC-0005Bw-An; Thu, 23 Nov 2023 03:46:46 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B56E042CA3;
 Thu, 23 Nov 2023 09:46:40 +0100 (CET)
Message-ID: <1bf79e54-d4de-4ac4-b75d-c79bd52c3eb0@proxmox.com>
Date: Thu, 23 Nov 2023 09:46:35 +0100
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
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAJ+F1C+CV-PbMAhw9V+OzDHnFiSyFW8+kFBZZ-n_7usoNP_S5w@mail.gmail.com>
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

Am 23.11.23 um 07:52 schrieb Marc-André Lureau:
> Hi
> 
> On Wed, Nov 22, 2023 at 5:25 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
>>
>> Am 22.11.23 um 14:06 schrieb Marc-André Lureau:
>>> Hi
>>>
>>> On Wed, Nov 22, 2023 at 5:00 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
>>>>
>>>> Commit d921fea338 ("ui/vnc-clipboard: fix infinite loop in
>>>> inflate_buffer (CVE-2023-3255)") removed this hunk, but it is still
>>>> required, because it can happen that stream.avail_in becomes zero
>>>> before coming across a return value of Z_STREAM_END in the loop.
>>>
>>> Isn't this an error from the client side then?
>>>
>>
>> In my test just now I get Z_BUF_ERROR twice and after the second one,
>> stream.avail_in is zero. Maybe if you'd call inflate() again, you'd get
>> Z_STREAM_END, but no such call is made, because we exit the loop.
> 
> It should exit the loop after calling inflate() again though.
> 
> Or do you mean that it goes to Z_BUF_ERROR a second time with
> stream.avail_in == 0, thus exit the loop quickly after ?

Yes, sorry if I wasn't clear. After the second inflate() call,
stream.avail_in == 0. See below.

> 
> That could mean that the input buffer is not complete.
> 
> "Note that Z_BUF_ERROR is not fatal, and inflate() can be called again
> with more input..."
> 
> Something is fishy.. Is it easy to reproduce?
> 

Yes, always. For example when entering "foobar" in the clipboard on the
host side:

> Thread 1 "qemu-system-x86" hit Breakpoint 2, inflate_buffer (in=0x555557a2980c "x^b```O\313\317OJ,b", in_len=19, size=0x7fffffffd058) at ../ui/vnc-clipboard.c:44
> 44	    ret = inflateInit(&stream);
> (gdb) n
> [Thread 0x7ffec7c166c0 (LWP 20918) exited]
> 45	    if (ret != Z_OK) {
> (gdb) p stream
> $18 = {next_in = 0x555557a2980c "x^b```O\313\317OJ,b", avail_in = 19, total_in = 0, next_out = 0x555557173d20 "\303\337:\002PU", avail_out = 8, total_out = 0, msg = 0x0, state = 0x555557654200, 
>   zalloc = 0x7ffff7bc1560, zfree = 0x7ffff7bc1570, opaque = 0x0, data_type = 0, adler = 1, reserved = 0}
> (gdb) c
> Continuing.
> [New Thread 0x7ffec7c166c0 (LWP 21011)]
> 
> Thread 1 "qemu-system-x86" hit Breakpoint 3, inflate_buffer (in=0x555557a2980c "x^b```O\313\317OJ,b", in_len=19, size=0x7fffffffd058) at ../ui/vnc-clipboard.c:50
> 50	        ret = inflate(&stream, Z_FINISH);
> (gdb) n
> [Thread 0x7ffec7c166c0 (LWP 21011) exited]
> 51	        switch (ret) {
> (gdb) p ret
> $19 = -5
> (gdb) p stream
> $20 = {next_in = 0x555557a29818 "b", avail_in = 7, total_in = 12, next_out = 0x555557173d28 "", avail_out = 0, total_out = 8, msg = 0x0, state = 0x555557654200, zalloc = 0x7ffff7bc1560, zfree = 0x7ffff7bc1570, 
>   opaque = 0x0, data_type = 5, adler = 72352174, reserved = 0}
> (gdb) c
> Continuing.
> [New Thread 0x7ffec7c166c0 (LWP 21131)]
> 
> Thread 1 "qemu-system-x86" hit Breakpoint 3, inflate_buffer (in=0x555557a2980c "x^b```O\313\317OJ,b", in_len=19, size=0x7fffffffd058) at ../ui/vnc-clipboard.c:50
> 50	        ret = inflate(&stream, Z_FINISH);
> (gdb) n
> [Thread 0x7ffec7c166c0 (LWP 21131) exited]
> 51	        switch (ret) {
> (gdb) p ret
> $21 = -5
> (gdb) p stream
> $22 = {next_in = 0x555557a2981f "", avail_in = 0, total_in = 19, next_out = 0x555557173d2b "", avail_out = 5, total_out = 11, msg = 0x0, state = 0x555557654200, zalloc = 0x7ffff7bc1560, zfree = 0x7ffff7bc1570, 
>   opaque = 0x0, data_type = 128, adler = 190907009, reserved = 0}
> (gdb) p out + 4
> $23 = (uint8_t *) 0x555557173d24 "foobar"
> (gdb) p *size
> $24 = 0

Now we exit the loop and without the hunk this patch re-adds, we don't
update *size and don't return 'out'.

Best Regards,
Fiona


