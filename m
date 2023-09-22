Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A387ABC72
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 01:56:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjpzS-0005Ux-AG; Fri, 22 Sep 2023 19:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qjpzP-0005Ua-FW
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 19:55:15 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qjpzN-0004b3-5t
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 19:55:15 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 48B7C748FF4;
 Sat, 23 Sep 2023 01:54:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0F964745681; Sat, 23 Sep 2023 01:54:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0DBDA7456AA;
 Sat, 23 Sep 2023 01:54:50 +0200 (CEST)
Date: Sat, 23 Sep 2023 01:54:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, mkletzan@redhat.com
Subject: Re: [PATCH 6/9] vt82c686: Support machine-default audiodev with
 fallback
In-Reply-To: <CABgObfaz+kzZkx_Xb-3rB27fkrefmE_P5=gF_LU9gF=y-rATAw@mail.gmail.com>
Message-ID: <43743daa-892b-4c42-02e6-49ebca525692@eik.bme.hu>
References: <20230922094459.265509-1-pbonzini@redhat.com>
 <20230922094459.265509-7-pbonzini@redhat.com>
 <fa8a8e3f-b17c-f5fc-a4ae-13a0fa233fb7@eik.bme.hu>
 <CABgObfaz+kzZkx_Xb-3rB27fkrefmE_P5=gF_LU9gF=y-rATAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-497835468-1695426890=:40094"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-497835468-1695426890=:40094
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 22 Sep 2023, Paolo Bonzini wrote:
> On Fri, Sep 22, 2023 at 2:17 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("460exb");
>>>     mc->default_ram_size = 512 * MiB;
>>>     mc->default_ram_id = "ppc4xx.sdram";
>>> +
>>> +    machine_add_audiodev_property(mc);
>>
>> This hunk has nothing to do with vt82686 so probably should be in
>> previoius patch. Also sam460ex embedded sound part is not emulated and can
>> only use PCI sound cards. What this line is needed for?
>
> No, this line shouldn't be there.
>
>> If every machine
>> now needs this call, can it be added in some generic machine init func in
>> hw/core/machine.c instead?
>
> It is not needed by every machine, only by every machine that has
> embedded sound.
>
>> I'm not sure about this whole series. Looks like it gets rid of 71 lines
>> but adding 158 and makes the users' life harder by requireing them to
>> specify drivers they may not even know about. What's the point? Is there
>> still a default to use the normally used audiodev for the platform or
>> people will now get errors and no sound unless they change their command
>> lines?
>
> I think you're right, I should have sent this series without the last
> two patches.
>
> The first seven add more functionality, because they let you use
> -audiodev for configuration of embedded boards. This is why they add
> some lines of code.
>
> The last two patches instead are the ones that make -audio or
> -audiodev mandatory. They should be separate and they may not be a
> good idea without something like "-audio default". And if no "-audio
> default" is added, there is more code that can go (for example the
> --audio-drv-list option to configure and CONFIG_AUDIO_DRIVERS).

I still don't see the point, because it already works without these 
changes. With current master one can specify -audiodev for -M paegasos2 
and it gives a warning but does the right thing and sets the audiodev for 
via-ac97. I think the warning can be avoided by using -global to set the 
via-ac97 audiodev property but since it picks up the -audiodev there's no 
need to. Apart from the warning this is convenient for the user, what's 
proposed in this series seems less so. What is the issue this series tries 
to solve?

Regards,
BALATON Zoltan
--3866299591-497835468-1695426890=:40094--

