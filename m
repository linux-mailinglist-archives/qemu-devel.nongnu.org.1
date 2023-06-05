Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9A7722267
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:42:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66iO-0007N4-8D; Mon, 05 Jun 2023 05:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q66i7-0007MW-BQ
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:41:11 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q66i4-0004yp-NG
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:41:11 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5149c51fd5bso6897952a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685958066; x=1688550066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LK1ZlwxyuLS97hgaddxvElcQgxjpsxQyAHtcGl6HGhM=;
 b=ztauLSubrQJViE94fQ1dIa4O/bQiWKK2tpxfodxOOH6CuSXXWLu4wRRLhIEikIVOAy
 zeqezXIYdj4VdHdW7vx0ErM35zIBXxo1LnOy9fglHPc+K5ux5UvURRbRHVTq+qyufO+Z
 6EJtdAmVI9+/IX06y6F2x8LFx5t3Q8HSZS4YkbIkmqvNpi/rD9ZZntVfqVyMmXm4kU19
 l2uxdZpc1dY8cRqUwV3mvtnYGzDYqaVqGNB9Adlb5wNzab9KGakBf9k+309jcPpaETlb
 GjpClo16hImJ9sI4LbZafsROC//C0TIwib/gGW0TWzNlS/zMbJPZN4uIz5oAH5xKAl3S
 FYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685958066; x=1688550066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LK1ZlwxyuLS97hgaddxvElcQgxjpsxQyAHtcGl6HGhM=;
 b=KFuytj8qwLI5gg5bzjg/1DazihSRJ6QSkDVH7XEgAUk9n/CBer6gEtt0gyju8Bs947
 DQjOHKYCFzYt9C1GKUYb2X6foth7WCIOXfDbjnNv9eX301nNhd8m2/PWG4HlKFqFcMyA
 wr+M8aDONpaWxSg0mjvaXlbKyT2xSRRCmKYN5c0wEwSkKEVCAICMWz0ShR5QGkJ28U1k
 fO/DgJPNDdbG/kwJLk3qqnKeAcqcp7/nS7oEbwfgF6uMwdZdbD+ikFo5xi+ZQZbCr4On
 HgOPNhWYmD+1lYfl0o3Yzto+vJoNn4vzMnZ0rZVIlzeREJG8kIV5GYpjHqgWb3R2YYH8
 nGsA==
X-Gm-Message-State: AC+VfDyzfdfrP49A8F8fgIvl7JBdMbFH4sn9XSLuB//q/EadJJduRfUt
 UJiUfsjuDRyFjP6r6P17ypZomHOxJ1gQuG2NPOjipg==
X-Google-Smtp-Source: ACHHUZ5V0koBXbDDU4upJg1KnquGNUo4h2oG6LcksqtpUu7G/Ie6aHTnt5x+RWychAWSkRGjvP0BPO6y0UdSIj5lJdo=
X-Received: by 2002:a05:6402:887:b0:50d:975f:3729 with SMTP id
 e7-20020a056402088700b0050d975f3729mr8489435edy.11.1685958066547; Mon, 05 Jun
 2023 02:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230502121459.2422303-1-peter.maydell@linaro.org>
 <20230502121459.2422303-32-peter.maydell@linaro.org>
 <edc17818-6db5-4f95-a966-3a810804ea04@roeck-us.net>
 <a77c864f-f571-b0a8-3c7f-dadbbf8c8185@tls.msk.ru>
 <4377a8d5-54d1-e0b3-e87a-0c04ec3b1360@roeck-us.net>
In-Reply-To: <4377a8d5-54d1-e0b3-e87a-0c04ec3b1360@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 10:40:33 +0100
Message-ID: <CAFEAcA_L8XCdRLGU_xeMC3JGzK_4h0LDWXz0VFLMgdkWigc1VQ@mail.gmail.com>
Subject: Re: [PULL 31/35] hw/intc/allwinner-a10-pic: Don't use
 set_bit()/clear_bit()
To: Guenter Roeck <linux@roeck-us.net>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Sat, 3 Jun 2023 at 19:06, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 6/3/23 10:46, Michael Tokarev wrote:
> > 03.06.2023 18:03, Guenter Roeck wrote:
> >> Hi,
> >>
> >> On Tue, May 02, 2023 at 01:14:55PM +0100, Peter Maydell wrote:
> >>> The Allwinner PIC model uses set_bit() and clear_bit() to update the
> >>> values in its irq_pending[] array when an interrupt arrives.  However
> >>> it is using these functions wrongly: they work on an array of type
> >>> 'long', and it is passing an array of type 'uint32_t'.  Because the
> >>> code manually figures out the right array element, this works on
> >>> little-endian hosts and on 32-bit big-endian hosts, where bits 0..31
> >>> in a 'long' are in the same place as they are in a 'uint32_t'.
> >>> However it breaks on 64-bit big-endian hosts.
> >>>
> >>> Remove the use of set_bit() and clear_bit() in favour of using
> >>> deposit32() on the array element.  This fixes a bug where on
> >>> big-endian 64-bit hosts the guest kernel would hang early on in
> >>> bootup.
> >>>
> >>> Cc: qemu-stable@nongnu.org
> >>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>> Message-id: 20230424152833.1334136-1-peter.maydell@linaro.org
> >>
> >> In v8.0.2, the cubieboard emulation running Linux crashes during reboo=
t
> >> with a hung task error. Tested with mainline Linux (v6.4-rc4-78-g929ed=
21dfdb6)
> >> and with v5.15.114. Host is AMD Ryzen 5900X.
> >>
> >> Requesting system reboot
> >> [   61.927460] INFO: task kworker/0:1:13 blocked for more than 30 seco=
nds.
> >> [   61.927896]       Not tainted 5.15.115-rc2-00038-g31e35d9f1b8d #1
> >> [   61.928144] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disa=
bles this message.
> >> [   61.928419] task:kworker/0:1     state:D stack:    0 pid:   13 ppid=
:     2 flags:0x00000000
> >> [   61.928972] Workqueue: events_freezable mmc_rescan
> >> [   61.929739] [<c13734f0>] (__schedule) from [<c1373c98>] (schedule+0=
x80/0x15c)
> >> [   61.930041] [<c1373c98>] (schedule) from [<c137ad64>] (schedule_tim=
eout+0xd4/0x12c)
> >> [   61.930270] [<c137ad64>] (schedule_timeout) from [<c137477c>] (do_w=
ait_for_common+0xa0/0x154)
> >> [   61.930523] [<c137477c>] (do_wait_for_common) from [<c1374870>] (wa=
it_for_completion+0x40/0x4c)
> >> [   61.930764] [<c1374870>] (wait_for_completion) from [<c1044cd0>] (m=
mc_wait_for_req_done+0x6c/0x90)
> >> [   61.931012] [<c1044cd0>] (mmc_wait_for_req_done) from [<c1044e34>] =
(mmc_wait_for_cmd+0x70/0xa8)
> >> [   61.931252] [<c1044e34>] (mmc_wait_for_cmd) from [<c10512a0>] (sdio=
_reset+0x58/0x124)
> >> [   61.931478] [<c10512a0>] (sdio_reset) from [<c1046328>] (mmc_rescan=
+0x294/0x30c)
> >> [   61.931692] [<c1046328>] (mmc_rescan) from [<c036be10>] (process_on=
e_work+0x28c/0x720)
> >> [   61.931924] [<c036be10>] (process_one_work) from [<c036c308>] (work=
er_thread+0x64/0x53c)
> >> [   61.932153] [<c036c308>] (worker_thread) from [<c03753e0>] (kthread=
+0x15c/0x180)
> >> [   61.932365] [<c03753e0>] (kthread) from [<c030015c>] (ret_from_fork=
+0x14/0x38)
> >> [   61.932628] Exception stack(0xc31ddfb0 to 0xc31ddff8)
> >>
> >> This was not seen with v8.0.0. Bisect points to this patch. Reverting =
it
> >> fixes the problem.
> >
> > Does this happen on master too, or just on stable-8.0 ?
> >
>
> It does. Tested with v8.0.0-1542-g848a6caa88.
>
> Here is my command line in case you want to give it a try:
>
> qemu-system-arm -M cubieboard -kernel arch/arm/boot/zImage -no-reboot \
>      -initrd rootfs-armv5.cpio -m 512 \
>      --append "panic=3D-1 rdinit=3D/sbin/init earlycon=3Duart8250,mmio32,=
0x1c28000,115200n8 console=3DttyS0" \
>      -dtb arch/arm/boot/dts/sun4i-a10-cubieboard.dtb -nographic \
>      -monitor null -serial stdio
>
> initrd is https://github.com/groeck/linux-build-test/blob/master/rootfs/a=
rm-v7/rootfs-armv5.cpio.gz
>
> This is with multi_v7_defconfig with some debug options added. If necessa=
ry
> I'll be happy to provide the exact configuration.

If you can provide a link to the zImage and the dtb to reproduce
as well, that would be helpful.

thanks
-- PMM

