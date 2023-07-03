Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 129DA745AD1
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 13:16:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGHW2-0006Sf-2T; Mon, 03 Jul 2023 07:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGHVy-0006SG-3l
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:14:44 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGHVw-0007JB-39
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:14:41 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fbb281eec6so1342261e87.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 04:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688382877; x=1690974877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySJXKuhXEL/tNUPusCqJODwZPlbC5Y0Eh275MYVs9Mo=;
 b=r41fT/e1JrPMctRDsU26LMVThna0t84mvEXLwzZ/6M6/j9grbj5Or7hN9ABWh/GHhg
 R0Z4+Yw+3pa2h2AlBTGFNuUsGosMbZqgn4MTiVAin/5mev7m0/dZed6NpTqKw9nQjOKt
 bacpF4Zx9daIgR2xEnf3+wnEx3Ld5zVKR+i99cV9X9MApCO7GLZ6x3ZNhEA5aSBBK98f
 6QXfOFnBpvira9FPC5WdzTirN3Tx/2qtvXT7G6IsmJdpuh7q8pC9JyyFyKQwSzFkh+P0
 G5pKUGM7Qws6GsemX9uiGubOKYx5Nrth0bJhPcjBhvgAEmSiFEiRASBzF1Nyv19dJ1RA
 binQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688382877; x=1690974877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ySJXKuhXEL/tNUPusCqJODwZPlbC5Y0Eh275MYVs9Mo=;
 b=amZ89LeJBCZ5PGooeHd5i84WzB+gUHDd/C4i44z2xC6CTMucc/Q1E9up3/yaKZ/mCp
 QML1TErGCAVTsZPvwinqUk/b2mAvvL34V37rmtqOrQK3qYWHw6N6iPQW/Vnmee7iaNav
 9nnpyXsPC136v1KSq+PvJdlh4236lR54Xy0HCMYEMXHKOvKb5hdJQKCPjCm6ztL3v4Lf
 hZFdl7J02tXYs4HzdyL/weYZXHIop9KkLhwpzSiKVYZVMAb+cyn4QAIEo0c6g0p4tjd6
 rJVn6gnbKuf4ykwzjKkM/fDhEQTX9FtT6ZHobseyqFTe7MWT6zQl84Ao2qROGLDGqr1X
 sM9g==
X-Gm-Message-State: ABy/qLbPvsa4b3zbhwBllfPA8eiZjibixl4Z6oY7oSdbtGopd4tGrjFy
 VrVrKZq9mOIIO5YnmZevLZyktawQyg3RM8Fcfj4X5hcdhKmwq/Si
X-Google-Smtp-Source: APBJJlH2eSd7pZj9CB/yzGvOoc7rgjZ9FHNGA8OqTF2c5W7Zw7ntQb9INn3anEGQXMDEI6nZtZ1EFFb7G7XyudICEc0=
X-Received: by 2002:a05:6512:716:b0:4f9:a232:f09c with SMTP id
 b22-20020a056512071600b004f9a232f09cmr5980315lfs.63.1688382877404; Mon, 03
 Jul 2023 04:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
 <20230606094814.3581397-19-peter.maydell@linaro.org>
 <280c57d2-9648-36ea-74e9-6ffc7f3b4388@redhat.com>
 <b954eaad-508c-2341-eaeb-8ec4111de664@163.com>
 <4f749512-a395-40e4-c20e-ed4928c2cb87@redhat.com>
 <f7d5a8eb-cd7f-e0f5-91cc-4b3840b5de2c@163.com>
 <be0b195b-101b-692c-672c-f16e41522853@redhat.com>
 <77ef230f-b896-9f18-e7b1-d9821a664e0a@163.com>
 <091ce590-1499-1aea-9cfa-67e4035615b4@redhat.com>
In-Reply-To: <091ce590-1499-1aea-9cfa-67e4035615b4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jul 2023 12:14:26 +0100
Message-ID: <CAFEAcA_3a7jzFQDg9G3uuBcayE1DRDYN2yjt=6xcrRU67j91CA@mail.gmail.com>
Subject: Re: [PULL 18/42] tests: avocado: boot_linux_console: Add test case
 for bpim2u
To: Thomas Huth <thuth@redhat.com>
Cc: qianfan <qianfanguijin@163.com>, qemu-devel@nongnu.org, 
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Fri, 30 Jun 2023 at 16:45, Thomas Huth <thuth@redhat.com> wrote:
>
> On 30/06/2023 11.04, qianfan wrote:
> >
> >
> > =E5=9C=A8 2023/6/30 16:53, Thomas Huth =E5=86=99=E9=81=93:
> >> On 30/06/2023 10.45, qianfan wrote:
> >>>
> >>>
> >>> =E5=9C=A8 2023/6/30 15:27, Thomas Huth =E5=86=99=E9=81=93:
> >>>> On 30/06/2023 08.15, qianfan wrote:
> >>>>>
> >>>>>
> >>>>> =E5=9C=A8 2023/6/29 19:35, Thomas Huth =E5=86=99=E9=81=93:
> >>>>>> On 06/06/2023 11.47, Peter Maydell wrote:
> >>>>>>> From: qianfan Zhao <qianfanguijin@163.com>
> >>>>>>>
> >>>>>>> Add test case for booting from initrd and sd card.
> ...
> >>>>>>
> >>>>>> FYI, the test_arm_bpim2u_gmac test just failed during one of my CI=
 runs:
> >>>>>>
> >>>>>> https://gitlab.com/thuth/qemu/-/jobs/4565108610#L300
> ...
> >>>> Oh, that's ugly, I think the problem is likely that the numbering
> >>>> of device names that are directly in /dev/ is never guaranteed by
> >>>> the Linux kernel.
> >>>>
> >>>> Could you please try whether this work more reliably for you
> >>>> instead:
> >>>>
> >>>> diff a/tests/avocado/boot_linux_console.py
> >>>> b/tests/avocado/boot_linux_console.py
> >>>> --- a/tests/avocado/boot_linux_console.py
> >>>> +++ b/tests/avocado/boot_linux_console.py
> >>>> @@ -869,7 +869,7 @@ def test_arm_bpim2u_gmac(self):
> >>>>          self.vm.set_console()
> >>>>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> >>>>                                 'console=3DttyS0,115200 '
> >>>> -                               'root=3D/dev/mmcblk0 rootwait rw '
> >>>> +                               'root=3Db300 rootwait rw '
> >>>>                                 'panic=3D-1 noreboot')
> >>>>          self.vm.add_args('-kernel', kernel_path,
> >>>>                           '-dtb', dtb_path,
> >>>>
> >>>> ?
> >>> Yes, this patch is useful.
> >>>
> >>> The rootfs can mount successful even if the mmc block enumed as mmcbl=
k1,
> >>> next is the
> >>> kernel logs:
> >>>
> >>> mmc1: new high speed SD card at address 4567
> >>> mmcblk1: mmc1:4567 QEMU! 64.0 MiB
> >>> EXT4-fs (mmcblk1): mounting ext2 file system using the ext4 subsystem
> >>> EXT4-fs (mmcblk1): mounted filesystem without journal. Opts: (null)
> >>> VFS: Mounted root (ext2 filesystem) on device 179:0.
> >>
> >> Great!
> >>
> >>> But the test scripts still fail due to it always waiting mmc0blk:
> >>>
> >>>      exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
> >>> 'mmcblk0')
> >>
> >> Ok, so the "0" likely got to be dropped here?
> >>
> >>> Could you please explain where is the "b300" come from?
> >>
> >> I ran the kernel once without the "root=3D/dev/mmcblk0 rootwait"
> >> part in its command line. Then it prints out something like this:
> >>
> >>  VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
> >>  Please append a correct "root=3D" boot option; here are the available
> >> partitions:
> >>  0100            4096 ram0
> >>  (driver?)
> >>  0101            4096 ram1
> >>  (driver?)
> >>  0102            4096 ram2
> >>  (driver?)
> >>  0103            4096 ram3
> >>  (driver?)
> >>  b300           65536 mmcblk0
> >>  driver: mmcblk
> >>  Kernel panic - not syncing: VFS: Unable to mount root fs on
> >> unknown-block(0,0)
> >>
> >> Seems like the "b300" is stable here, no matter whether
> >> its mmcblk0 or mmcblk1.
> > This way is really hack.
>
> Ack, it's not really nice - but it's still better than a flaky, unreliabl=
e
> test, isn't it?
>
> I'll send it as a proper patch for discussion.
>
> > And who case this issue, linux kernel or qemu? I
> > can't make sure.
>
> It's likely the Linux kernel - I think the numbering of entries in /dev/ =
is
> not guaranteed.

See the thread
https://lore.kernel.org/qemu-devel/01087628-44c0-2b15-61bc-8677b7d1b459@roe=
ck-us.net/
where Guenter concluded that this is a bug in the device tree:
it tells the kernel to probe all 3 MMC controllers in parallel
and doesn't give them specific names, so the order is always
random.

The fix is probably for the kernel to update its DT and then
our test case can be updated to use a fixed DT.

thanks
-- PMM

