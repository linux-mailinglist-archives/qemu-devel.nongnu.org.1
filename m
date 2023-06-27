Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4E773F69C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 10:16:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE3r0-0007wP-AC; Tue, 27 Jun 2023 04:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE3qu-0007vH-Rs; Tue, 27 Jun 2023 04:15:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE3qs-0004zB-9A; Tue, 27 Jun 2023 04:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:Cc:To:From:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=te3X7NQwXzh9x5NgolpA7pMbN1IBEw4iUNQgTP2flio=; b=mVRW2JgyFCEtW+jTu6MqwZK0Zq
 V/mwPXH/tjXjTtjQvvQt75GI6dTNZ2KfP9PL15xJrDdTF5Do24EJfuCuorAK+RJDUVZ7Q3YKXqpPO
 lC/EjXbP3jpWy4d7DDWUKrcw1Lrbm61oKBI4HXk5iqeIVeVzSvsQaRVQkoWqRGJ/Pi8JRXdCGUvB2
 q5vGtajy2/MiQ/S/wQiP1zEYRVLDlrXKpPcmMrOH7ylC/K465H45RusDqfg/TUWUkl0g8/hL7n2du
 /C4WMh5U9VVb8j1IBKCxAytTlHo3oIv166AVZTpWF/XQBxQ27A86assi3J/C2QK0qnLxcsYjkHkdL
 roMZgxjqYJhaMcY/6l/MJUgWFNzu822xvUVaRmbzanlBTIWlg9u+Lt6BNO4vNKtzJKL9sMCJao8GM
 w1VhQSgUuizdzgPiT8sDA3VYPtZtNt7tUZBso5Zg31x9V3xZDRLWoeSQf90IN4r5KS2zg7rIRzZfE
 jlLwPik2cG+9fKK/2Lj0sTZYVC9y5cnqikKdFz+Y1YK1UB7NowSKulTxBWSXslIeBuY26LrTrAKh4
 VZskGrksmXocU/S4g9NvFX2UFJBMRfPH1zsoOEdC+n2z5xLRiqCENQzU7VxPGUG/hFmkiB1CXuzI/
 JKGpDigD+cCBuR3uWMJUn7e/9ElSUM7iILQFaUwCM=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE3qe-0002ZN-8U; Tue, 27 Jun 2023 09:14:52 +0100
Message-ID: <cefdeb3f-3442-ede4-3e5d-6a4a99b38293@ilande.co.uk>
Date: Tue, 27 Jun 2023 09:14:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
 <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
Content-Language: en-US
In-Reply-To: <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 26/06/2023 14:35, Cédric Le Goater wrote:

> On 6/23/23 14:37, Cédric Le Goater wrote:
>> On 6/23/23 11:10, Peter Maydell wrote:
>>> On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>>
>>>> ppc has always silently ignored access to real (physical) addresses
>>>> with nothing behind it, which can make debugging difficult at times.
>>>>
>>>> It looks like the way to handle this is implement the transaction
>>>> failed call, which most target architectures do. Notably not x86
>>>> though, I wonder why?
>>>
>>> Much of this is historical legacy. QEMU originally had no
>>> concept of "the system outside the CPU returns some kind
>>> of bus error and the CPU raises an exception for it".
>>> This is turn is (I think) because the x86 PC doesn't do
>>> that: you always get back some kind of response, I think
>>> -1 on reads and writes ignored. We added the do_transaction_failed
>>> hook largely because we wanted it to give more accurate
>>> emulation of this kind of thing on Arm, but as usual with new
>>> facilities we left the other architectures to do it themselves
>>> if they wanted -- by default the behaviour remained the same.
>>> Some architectures have picked it up; some haven't.
>>>
>>> The main reason it's a bit of a pain to turn the correct
>>> handling on is because often boards don't actually implement
>>> all the devices they're supposed to. For a pile of legacy Arm
>>> boards, especially where we didn't have good test images,
>>> we use the machine flag ignore_memory_transaction_failures to
>>> retain the legacy behaviour. (This isn't great because it's
>>> pretty much going to mean we have that flag set on those
>>> boards forever because nobody is going to care enough to
>>> investigate and test.)
>>>
>>>> Other question is, sometimes I guess it's nice to avoid crashing in
>>>> order to try to quickly get past some unimplemented MMIO. Maybe a
>>>> command line option or something could turn it off? It should
>>>> probably be a QEMU-wide option if so, so that shouldn't hold this
>>>> series up, I can propose a option for that if anybody is worried
>>>> about it.
>>>
>>> I would not recommend going any further than maybe setting the
>>> ignore_memory_transaction_failures flag for boards you don't
>>> care about. (But in an ideal world, don't set it and deal with
>>> any bug reports by implementing stub versions of missing devices.
>>> Depends how confident you are in your test coverage.)
>>
>> It seems it broke the "mac99" and  powernv10 machines, using the
>> qemu-ppc-boot images which are mostly buildroot. See below for logs.
>>
>> Adding Mark for further testing on Mac OS.
> 
> 
> Mac OS 9.2 fails to boot with a popup saying :
>          Sorry, a system error occured.
>          "Sound Manager"
>            address error
>          To temporarily turn off extensions, restart and
>          hold down the shift key
> 
> 
> Darwin and Mac OSX look OK.

My guess would be that MacOS 9.2 is trying to access the sound chip registers which 
isn't implemented in QEMU for the moment (I have a separate screamer branch 
available, but it's not ready for primetime yet). In theory they shouldn't be 
accessed at all because the sound device isn't present in the OpenBIOS device tree, 
but this is all fairly old stuff.

Does implementing the sound registers using a dummy device help at all?


diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 265c0bbd8d..e55f938da7 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -26,6 +26,7 @@
  #include "qemu/osdep.h"
  #include "qapi/error.h"
  #include "qemu/module.h"
+#include "hw/misc/unimp.h"
  #include "hw/misc/macio/cuda.h"
  #include "hw/pci/pci.h"
  #include "hw/ppc/mac_dbdma.h"
@@ -94,6 +95,7 @@ static bool macio_common_realize(PCIDevice *d, Error **errp)
  {
      MacIOState *s = MACIO(d);
      SysBusDevice *sbd;
+    DeviceState *dev;

      if (!qdev_realize(DEVICE(&s->dbdma), BUS(&s->macio_bus), errp)) {
          return false;
@@ -102,6 +104,14 @@ static bool macio_common_realize(PCIDevice *d, Error **errp)
      memory_region_add_subregion(&s->bar, 0x08000,
                                  sysbus_mmio_get_region(sbd, 0));

+    dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
+    qdev_prop_set_string(dev, "name", "screamer");
+    qdev_prop_set_uint64(dev, "size", 0x1000);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sbd = SYS_BUS_DEVICE(dev);
+    memory_region_add_subregion(&s->bar, 0x14000,
+                                sysbus_mmio_get_region(sbd, 0));
+
      qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
      qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
      qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 86df2c2b60..1894178a68 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -109,6 +109,7 @@ struct MacIOState {
      PMUState pmu;
      DBDMAState dbdma;
      ESCCState escc;
+    MemoryRegion screamer;
      uint64_t frequency;
  };



ATB,

Mark.

