Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7C57BA8F6
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 20:21:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSyP-0006qe-Jt; Thu, 05 Oct 2023 14:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoSyJ-0006pc-LQ
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:21:17 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoSyI-0007aV-23
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:21:15 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C889F75723D;
 Thu,  5 Oct 2023 20:20:28 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 95EBF757233; Thu,  5 Oct 2023 20:20:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 93DE175721D;
 Thu,  5 Oct 2023 20:20:28 +0200 (CEST)
Date: Thu, 5 Oct 2023 20:20:28 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel <qemu-devel@nongnu.org>, 
 "P. Berrange, Daniel" <berrange@redhat.com>
Subject: Re: [PATCH 5/7] audio: do not use first -audiodev as default audio
 device
In-Reply-To: <CABgObfYvCQQwra=7oH9G5r0+s92JWBnNGztSx0y-zFAV5QsPGA@mail.gmail.com>
Message-ID: <512bb66a-528f-2000-0d7c-c26ec0eb8f8e@eik.bme.hu>
References: <20231005125815.66082-1-pbonzini@redhat.com>
 <20231005125815.66082-6-pbonzini@redhat.com>
 <d8327a5f-9a06-2c35-a0c8-372707ea0c4a@eik.bme.hu>
 <18a7de6d-b542-9bf6-2128-d005e2e08a64@eik.bme.hu>
 <CABgObfa9yfxr7LTKcCBeRN=KToE860sEdNGG5OjUD1CdVU4a0A@mail.gmail.com>
 <3b7e4811-aed2-474e-f6e0-d13bc4807af0@eik.bme.hu>
 <CABgObfYvCQQwra=7oH9G5r0+s92JWBnNGztSx0y-zFAV5QsPGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Thu, 5 Oct 2023, Paolo Bonzini wrote:
> Il gio 5 ott 2023, 17:40 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:
>
>> Much better, thanks. Maybe some more small clarifications as below:
>>
>>> ===================
>>> Using ``-audiodev`` to define the default audio backend (removed in 8.2)
>>> ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>>> If no audiodev property is specified, previous versions would use the
>>> first ``-audiodev`` command line option as a fallback.  Starting with
>>> version 8.2, audio backends created with ``-audiodev`` will only be
>>> used by clients (sound cards, machines with embedded sound hardware, VNC)
>>
>> machines with embedded sound hardware that can be set with the audiodev
>> machine property
>>
>
> -M audiodev needs to be documented in the release notes, not in removed
> features.

The more places it's documented the better, peopla don't read docs anyway.

> I'm still not sure users will get it without additional explanation
>> somewhere explicitly saying that if you now get an error with -audiodev
>> driver then you may now need to use -audio driver instead (hopefully the
>> error will say that)
>
>
> Currently the error says to add audiodev=, I can change that to propose
> both.

That would help as likely the error will be the only thing the users will 
come across so if it tells them what to do that's the least annoyance.

Regards,
BALATON Zoltan

