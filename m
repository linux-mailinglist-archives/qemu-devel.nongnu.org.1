Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 897187BBBAA
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 17:20:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qombI-0003qu-NM; Fri, 06 Oct 2023 11:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qombG-0003qa-Ry
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 11:18:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qombF-0006QV-Ad
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 11:18:46 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40535597f01so20213885e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696605522; x=1697210322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hJEOZpwkHmVtNYt07ls/jHKrkkiG4vDwfVuupARRP8=;
 b=GFJ34OuIoGv/dfJ0rxBM4WKOTXV/ANm6i2ho/TSEqLw90zwLY6j9oCJjf8D2LYNH/7
 oBVLLERvSr1l3KI02Yor9IZcKOuRLP9W44CaTdL48DfgVSzXcG9yzwcnQ+aOf7ojLi9F
 ThiFv4x2LPIh4ssKl7Hu+fOgvKAvzJY0Ahl9x3S4O9U9AKwF1gQxXmkTOtpl78myrh22
 2ZHf45RTCz1QNPiukhqCE6YnAMuNdgywMZ2u5Ac3GJ46kj9XUf8dYUa7fzLQwoajwVXZ
 xSwR8ULwW/7lpImm9VGfGL/MVk09lajUpjDu85UZqKFsPeyyJumKOniy2IBrKsb+sMT9
 2vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696605522; x=1697210322;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2hJEOZpwkHmVtNYt07ls/jHKrkkiG4vDwfVuupARRP8=;
 b=QCrvACFmVDUR1A8BR5D1FwFZkvDuBezzOqmRswilRbY6s5ZEqldlTDy7SfTVCNuLvN
 ObWtSqgYZz0W//AVsc9CZS/AdQ+iWEZAsHBJe+W/lUfnixyPkjH6eyT22zTTYCztf4oB
 TYmq/9Glqx3a0Nu9OAI9CFrc5xk+q/iVm87QtYNA9pGQy9S7pke9NvjitD/xrENaTVm0
 hnad4R/ffBed0/qGXz5EOVhl7lW0VMFvaAvQD9zRbNXxDfn/2MHYTFsjn+SQ9WaEDDAE
 zHJL8pV85Jkj1GrlH6omISxT7JuswJPs9U5naD+7oLD+qcyQ8li7V2EMYFaV4f+C08d4
 EwCQ==
X-Gm-Message-State: AOJu0YzEZdGP0QFb+PcQGQwJTUeC9PG8aV/+SeU4CjAxx+Kd7ijl6wPf
 1ra1v/W/A0IbofWIxu7YQsBRQJ9Us7pOFYkpeFY=
X-Google-Smtp-Source: AGHT+IFHrMQkXRWfvA3uHkJ3CU+aAhAL+X4x6Ke4+uYCdZucfwyEKH71vmP5QA2ITAmhvzusweOe4g==
X-Received: by 2002:a05:600c:b59:b0:401:b1c6:97dc with SMTP id
 k25-20020a05600c0b5900b00401b1c697dcmr7675991wmr.23.1696605522405; 
 Fri, 06 Oct 2023 08:18:42 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a1c7909000000b00401b242e2e6sm6185904wme.47.2023.10.06.08.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 08:18:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5E2221FFBB;
 Fri,  6 Oct 2023 16:18:41 +0100 (BST)
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com>
 <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
 <20231006051802-mutt-send-email-mst@kernel.org>
 <a4af0357-12ee-fc7f-e249-239da34409b0@redhat.com>
 <20231006055229-mutt-send-email-mst@kernel.org>
 <d9c2d2c4-5ab3-a3f3-8925-155e1c4ff73a@redhat.com>
User-agent: mu4e 1.11.21; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-fs@redhat.com, Eugenio
 =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>, Anton Kuchin
 <antonkuchin@yandex-team.ru>,
 Yajun Wu <yajunw@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [Virtio-fs] (no subject)
Date: Fri, 06 Oct 2023 16:17:34 +0100
In-reply-to: <d9c2d2c4-5ab3-a3f3-8925-155e1c4ff73a@redhat.com>
Message-ID: <87il7jg4oe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Hanna Czenczek <hreitz@redhat.com> writes:

> On 06.10.23 12:34, Michael S. Tsirkin wrote:
>> On Fri, Oct 06, 2023 at 11:47:55AM +0200, Hanna Czenczek wrote:
>>> On 06.10.23 11:26, Michael S. Tsirkin wrote:
>>>> On Fri, Oct 06, 2023 at 11:15:55AM +0200, Hanna Czenczek wrote:
>>>>> On 06.10.23 10:45, Michael S. Tsirkin wrote:
>>>>>> On Fri, Oct 06, 2023 at 09:48:14AM +0200, Hanna Czenczek wrote:
>>>>>>> On 05.10.23 19:15, Michael S. Tsirkin wrote:
>>>>>>>> On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
>>>>>>>>> On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
<snip>
>>> What I=E2=80=99m saying is, 923b8921d21 introduced SET_STATUS calls tha=
t broke all
>>> devices that would implement them as per virtio spec, and even today it=
=E2=80=99s
>>> broken for stateful devices.=C2=A0 The mentioned performance issue is l=
ikely
>>> real, but we can=E2=80=99t address it by making up SET_STATUS calls tha=
t are wrong.
>>>
>>> I concede that I didn=E2=80=99t think about DRIVER_OK.=C2=A0 Personally=
, I would do all
>>> final configuration that would happen upon a DRIVER_OK once the first v=
ring
>>> is started (i.e. receives a kick).=C2=A0 That has the added benefit of =
being
>>> asynchronous because it doesn=E2=80=99t block any vhost-user messages (=
which are
>>> synchronous, and thus block downtime).
>>>
>>> Hanna
>>
>> For better or worse kick is per ring. It's out of spec to start rings
>> that were not kicked but I guess you could do configuration ...
>> Seems somewhat asymmetrical though.
>
> I meant to take the first ring being started as the signal to do the
> global configuration, i.e. not do this once per vring, but once
> globally.
>
>> Let's wait until next week, hopefully Yajun Wu will answer.
>
> I mean, personally I don=E2=80=99t really care about the whole SET_STATUS
> thing.=C2=A0 It=E2=80=99s clear that it=E2=80=99s broken for stateful dev=
ices.=C2=A0 The fact
> that it took until 6f8be29ec17d to fix it for just any device that
> would implement it according to spec to me is a strong indication that
> nobody does implement it according to spec, and is currently only used
> to signal to some specific back-end that all rings have been set up
> and should be configured in a single block.

I'm certainly using [GS]ET_STATUS for the proposed F_TRANSPORT
extensions where everything is off-loaded to the vhost-user backend.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

