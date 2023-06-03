Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B37210B6
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 17:05:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5SnK-0006Jz-Io; Sat, 03 Jun 2023 11:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1q5SnI-0006Jq-5T
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 11:03:52 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1q5SnG-0007JW-A2
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 11:03:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b0236ee816so23899555ad.1
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685804628; x=1688396628;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S880i68BELdhfr6YpXPt7oc+Z0I1qt0y5+ZTEi3yRQc=;
 b=WlY/2V+lDjfhU7xnT0DqxNpXc5N2CFmPmRF8EGaUeI8x2gHHojcX3iD6T9WmXoGgQ+
 rYLoHl1scpzk+1CsQJPbf9YY6I5ERSp2Ymr+UOIP0nkX7cQT7Q+ePAJnkhMhZZD2oGVx
 W0H2np88cvTr6ztnKTyS2enSoZNKe7S8Cx2jl5npE02UWknr0J7Zr5h6dXicPC0Cs6MN
 pkou+Dg0mbJ7IntADgjVEa7A8hchUuWRtY7wk5DVXZ6mRAhD9KfmQylZckT2JnOXtpoz
 MINIoNbAexIFZH0SfoyK2Yoc2AngL+H/9PQ2z9DkhykG8ijMIYllorgbsaEOUJVzO9M+
 LN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685804628; x=1688396628;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S880i68BELdhfr6YpXPt7oc+Z0I1qt0y5+ZTEi3yRQc=;
 b=CGfKN8K/XyXwRAkJbCSHGaCbi/kG/Qo9o7P38x5rN71RN1EGTiTMr25EdTatyCODmx
 Xy7ij3qVIFLAKZN+Uo8PFcgp5BMd4ig4OYAvHesyU5b3h8puTGd8Q1moiGfZJG1Zbev9
 csOlKUmw2cRv8I5a2aZdNTJ6U3HQrKmNjpa2zWojcvEbuhc4PR9mAcTqVYNKko8ovTsh
 pQ90aNTfECNyq1UPbc9bAS09l9YoACbugLswWqB0WigOuq4WYoak+fQFXwK4acbt49zf
 LcSygIVVTTxS6smWwOc7j31yfw/+xZPv7L6fS/ko9XILsfxoE4+uFI6qrGw90RPCar8a
 ZDrA==
X-Gm-Message-State: AC+VfDwRP717uFhbtBmWnKnZJVDn2xWBRJN2xjrBMoV5SCtRWNghmLWL
 52AEmx9/EU7l4RTipUK7xEZvBzb9UAU=
X-Google-Smtp-Source: ACHHUZ6idw3SgtR3J6g29qs8OVomy+l96r5AgkPoKasjpiOIJT7fisnYKNrf09f9Ca5RD0Rlv5dJ7g==
X-Received: by 2002:a17:902:c146:b0:1ae:6947:e63b with SMTP id
 6-20020a170902c14600b001ae6947e63bmr2367868plj.16.1685804627793; 
 Sat, 03 Jun 2023 08:03:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a170902ea0b00b001ae8b4dc49bsm3318103plg.13.2023.06.03.08.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 08:03:47 -0700 (PDT)
Date: Sat, 3 Jun 2023 08:03:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 31/35] hw/intc/allwinner-a10-pic: Don't use
 set_bit()/clear_bit()
Message-ID: <edc17818-6db5-4f95-a966-3a810804ea04@roeck-us.net>
References: <20230502121459.2422303-1-peter.maydell@linaro.org>
 <20230502121459.2422303-32-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230502121459.2422303-32-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,

On Tue, May 02, 2023 at 01:14:55PM +0100, Peter Maydell wrote:
> The Allwinner PIC model uses set_bit() and clear_bit() to update the
> values in its irq_pending[] array when an interrupt arrives.  However
> it is using these functions wrongly: they work on an array of type
> 'long', and it is passing an array of type 'uint32_t'.  Because the
> code manually figures out the right array element, this works on
> little-endian hosts and on 32-bit big-endian hosts, where bits 0..31
> in a 'long' are in the same place as they are in a 'uint32_t'.
> However it breaks on 64-bit big-endian hosts.
> 
> Remove the use of set_bit() and clear_bit() in favour of using
> deposit32() on the array element.  This fixes a bug where on
> big-endian 64-bit hosts the guest kernel would hang early on in
> bootup.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-id: 20230424152833.1334136-1-peter.maydell@linaro.org

In v8.0.2, the cubieboard emulation running Linux crashes during reboot
with a hung task error. Tested with mainline Linux (v6.4-rc4-78-g929ed21dfdb6)
and with v5.15.114. Host is AMD Ryzen 5900X.

Requesting system reboot
[   61.927460] INFO: task kworker/0:1:13 blocked for more than 30 seconds.
[   61.927896]       Not tainted 5.15.115-rc2-00038-g31e35d9f1b8d #1
[   61.928144] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   61.928419] task:kworker/0:1     state:D stack:    0 pid:   13 ppid:     2 flags:0x00000000
[   61.928972] Workqueue: events_freezable mmc_rescan
[   61.929739] [<c13734f0>] (__schedule) from [<c1373c98>] (schedule+0x80/0x15c)
[   61.930041] [<c1373c98>] (schedule) from [<c137ad64>] (schedule_timeout+0xd4/0x12c)
[   61.930270] [<c137ad64>] (schedule_timeout) from [<c137477c>] (do_wait_for_common+0xa0/0x154)
[   61.930523] [<c137477c>] (do_wait_for_common) from [<c1374870>] (wait_for_completion+0x40/0x4c)
[   61.930764] [<c1374870>] (wait_for_completion) from [<c1044cd0>] (mmc_wait_for_req_done+0x6c/0x90)
[   61.931012] [<c1044cd0>] (mmc_wait_for_req_done) from [<c1044e34>] (mmc_wait_for_cmd+0x70/0xa8)
[   61.931252] [<c1044e34>] (mmc_wait_for_cmd) from [<c10512a0>] (sdio_reset+0x58/0x124)
[   61.931478] [<c10512a0>] (sdio_reset) from [<c1046328>] (mmc_rescan+0x294/0x30c)
[   61.931692] [<c1046328>] (mmc_rescan) from [<c036be10>] (process_one_work+0x28c/0x720)
[   61.931924] [<c036be10>] (process_one_work) from [<c036c308>] (worker_thread+0x64/0x53c)
[   61.932153] [<c036c308>] (worker_thread) from [<c03753e0>] (kthread+0x15c/0x180)
[   61.932365] [<c03753e0>] (kthread) from [<c030015c>] (ret_from_fork+0x14/0x38)
[   61.932628] Exception stack(0xc31ddfb0 to 0xc31ddff8)

This was not seen with v8.0.0. Bisect points to this patch. Reverting it
fixes the problem.

Bisect log is attached.

Guenter

---
# bad: [f7f686b61cf7ee142c9264d2e04ac2c6a96d37f8] Update version for 8.0.2 release
# good: [c1eb2ddf0f8075faddc5f7c3d39feae3e8e9d6b4] Update version for v8.0.0 release
git bisect start 'v8.0.2' 'v8.0.0'
# bad: [21b54a683d14c0c6f9af35536d9059c60b7449ca] s390x/pv: Fix spurious warning with asynchronous teardown
git bisect bad 21b54a683d14c0c6f9af35536d9059c60b7449ca
# bad: [4dc5df865c482c6e8894964c7f300fa556c3b78e] softfloat: Fix the incorrect computation in float32_exp2
git bisect bad 4dc5df865c482c6e8894964c7f300fa556c3b78e
# good: [f0c5a780292bd405bbce818b63757313cafcf262] target/arm: Initialize debug capabilities only once
git bisect good f0c5a780292bd405bbce818b63757313cafcf262
# bad: [af08c70ef5204fedb2b974fbecaf65e1b6cc0a2f] hw/intc/allwinner-a10-pic: Don't use set_bit()/clear_bit()
git bisect bad af08c70ef5204fedb2b974fbecaf65e1b6cc0a2f
# good: [168f193c5be54fc9a6d725dbb9974c0d2815792a] hw/arm/boot: Make write_bootloader() public as arm_write_bootloader()
git bisect good 168f193c5be54fc9a6d725dbb9974c0d2815792a
# good: [975f12aa528d6cab5cc41efebaf05d7eb7296d94] hw/arm/raspi: Use arm_write_bootloader() to write boot code
git bisect good 975f12aa528d6cab5cc41efebaf05d7eb7296d94
# first bad commit: [af08c70ef5204fedb2b974fbecaf65e1b6cc0a2f] hw/intc/allwinner-a10-pic: Don't use set_bit()/clear_bit()

