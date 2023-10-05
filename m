Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD157BA291
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQTE-00038U-Fd; Thu, 05 Oct 2023 11:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoQTB-000384-BN
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:40:57 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoQT8-0001tm-Sj
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:40:56 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 53F07757239;
 Thu,  5 Oct 2023 17:40:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1C30575721D; Thu,  5 Oct 2023 17:40:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 19B1D757234;
 Thu,  5 Oct 2023 17:40:07 +0200 (CEST)
Date: Thu, 5 Oct 2023 17:40:07 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 5/7] audio: do not use first -audiodev as default audio
 device
In-Reply-To: <CABgObfa9yfxr7LTKcCBeRN=KToE860sEdNGG5OjUD1CdVU4a0A@mail.gmail.com>
Message-ID: <3b7e4811-aed2-474e-f6e0-d13bc4807af0@eik.bme.hu>
References: <20231005125815.66082-1-pbonzini@redhat.com>
 <20231005125815.66082-6-pbonzini@redhat.com>
 <d8327a5f-9a06-2c35-a0c8-372707ea0c4a@eik.bme.hu>
 <18a7de6d-b542-9bf6-2128-d005e2e08a64@eik.bme.hu>
 <CABgObfa9yfxr7LTKcCBeRN=KToE860sEdNGG5OjUD1CdVU4a0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-225728736-1696520407=:49051"
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

--3866299591-225728736-1696520407=:49051
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 5 Oct 2023, Paolo Bonzini wrote:
> On Thu, Oct 5, 2023 at 3:39 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>> QEMU does not create default audio backends anymore if any of the
>>>> ``-audiodev``, ``-audio`` or ``-nodefaults`` options are used on the
>>>> command line.
>>>
>>> Maybe this needs further updating because -audio can now define the default
>>> and is what should be used instead of -audiodev but this is not clear from
>>> this documentation.
>>
>> And while at it, maybe also mention machine audiodev property here as a
>> way to set audiodev of embedded devices.
>
> Sure, here is my next attempt:

Much better, thanks. Maybe some more small clarifications as below:

> ===================
> Using ``-audiodev`` to define the default audio backend (removed in 8.2)
> ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> If no audiodev property is specified, previous versions would use the
> first ``-audiodev`` command line option as a fallback.  Starting with
> version 8.2, audio backends created with ``-audiodev`` will only be
> used by clients (sound cards, machines with embedded sound hardware, VNC)

machines with embedded sound hardware that can be set with the audiodev 
machine property

> that refer to it in an ``audiodev=`` property.
>
> In order to configure a default audio backend, use the ``-audio``
> command line option without specifying a ``model``; while previous
> versions of QEMU required a model, starting with version 8.2

required a model for -audio but starting with version 8.2

I'm still not sure users will get it without additional explanation 
somewhere explicitly saying that if you now get an error with -audiodev 
driver then you may now need to use -audio driver instead (hopefully the 
error will say that) but this is now detailed enough to at least try to 
explain that.

Regards,
BALATON Zoltan

> QEMU does not require a model and will not create any sound card
> in this case.
>
> Note that the default audio backend must be configured on the command
> line if the ``-nodefaults`` options is used.
> ===================
>
>
--3866299591-225728736-1696520407=:49051--

