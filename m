Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7027F7469
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 13:57:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Vjt-0001CO-0y; Fri, 24 Nov 2023 07:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6Vjq-0001CB-0w
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:56:54 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6Vjn-000077-V1
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:56:53 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c503dbe50dso22819221fa.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 04:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700830609; x=1701435409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYh9ttpZExkVPVkQ28/dpWEwBabZM3xCVfwqKkfGpoE=;
 b=LloDCJKPgVmTCQ2fbOqL8aOt9wOobhBoVpYFgDJ/7iYO+sIFTWx4TQq2k3eoKrq4Tj
 eHLK88I17Zqqrc6xRTcuBbty8ZYPFHIWN35TDmTdB7C3qEibTIi8drd5H+NqyxF4K8pp
 zf/t5nUV2nTmdmN8k7juHZzyUp3yUNeYOlxJf0kiwilc5lQpHO9hoHRMPlDNdUkngISm
 92JQJce5waI/zXU1MkBBqhweNj1wmBU8wOwiKKwpQBwAWxRI13gW5BLhE1bqzzlYPQm6
 N/TO4IfV8oA0y09R+FxeFVQjalJbc2lhFSz0f4Vg1PMayOy7RigcSs2Q1OOQ/oMursQd
 fyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700830609; x=1701435409;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rYh9ttpZExkVPVkQ28/dpWEwBabZM3xCVfwqKkfGpoE=;
 b=o5ihwg5UMf0Pc9Cdc+ZxriFTS4rSfs8KLYwUxU3GfjyHxEWC1iiuY/OXA5naxVcE+I
 z7TjSTQp/2PAVq9WdcCHYzvfoULIpLX6OA17GM8QiInjc6f+NktzCIGILamRoqV9mHgC
 iXupOWb9HqwB2lvDnNflrdNVA7eEo0ro4bJn1sP3zWIkKD9rUsozH8nBiLHTV1qFVWis
 H+3z9Q3KMAYf8oZwELBblK+bav/2SGI+b0GKmW/i7bBC8K8vQSKvQdEyOBXSvLT/0Ut6
 GRdfjIBFE0yIp2cbsy18S9UAjD1a+T+P4AHbHCWB28geFndl2YBKPl4/R43a3OGp1LWq
 29gw==
X-Gm-Message-State: AOJu0Yy8tCtVY71qkOqjFgi6pk3WDpLY9SRUIiGyTToQFmxqGQzCIYmJ
 vRDJBczvdKkx8GzeKGnCvbBZdw==
X-Google-Smtp-Source: AGHT+IEW4oaIEl4UKl/xCLKHHE+a9oAX7cxDG0m2YWIUUGXEoUOvuMm1aEI6exCQqWi9qOF1bBvvNg==
X-Received: by 2002:a05:6512:3a85:b0:50b:a6c7:e8b0 with SMTP id
 q5-20020a0565123a8500b0050ba6c7e8b0mr212264lfu.26.1700830608786; 
 Fri, 24 Nov 2023 04:56:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m18-20020a05600c3b1200b00405959469afsm5051474wms.3.2023.11.24.04.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 04:56:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 11B775F7AA;
 Fri, 24 Nov 2023 12:56:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: David Woodhouse <dwmw2@infradead.org>,  Stefano Stabellini
 <sstabellini@kernel.org>,  "paul@xen.org" <paul@xen.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  Julien Grall
 <julien@xen.org>,  Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Anthony Perard <anthony.perard@citrix.com>,  "open list:X86 Xen CPUs"
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 4/6] xen_pvdev: Do not assume Dom0 when creating a
 directory
In-Reply-To: <87cyw1z61i.fsf@epam.com> (Volodymyr Babchuk's message of "Thu,
 23 Nov 2023 00:07:05 +0000")
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-5-volodymyr_babchuk@epam.com>
 <b04daedc-ba6a-4109-8e23-fbcd023bcfec@xen.org>
 <alpine.DEB.2.22.394.2311221428570.2053963@ubuntu-linux-20-04-desktop>
 <ce719f35e72a9387fc04af098e6d688f9bbdca4e.camel@infradead.org>
 <alpine.DEB.2.22.394.2311221508270.2424505@ubuntu-linux-20-04-desktop>
 <a4e6a62a7cfe756344a1efcb8b2c3cfb1e50817e.camel@infradead.org>
 <alpine.DEB.2.22.394.2311221515010.2424505@ubuntu-linux-20-04-desktop>
 <87r0khz6zj.fsf@epam.com> <87cyw1z61i.fsf@epam.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Fri, 24 Nov 2023 12:56:48 +0000
Message-ID: <87wmu7b97z.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
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

Volodymyr Babchuk <Volodymyr_Babchuk@epam.com> writes:

> Hi,
>
> Volodymyr Babchuk <volodymyr_babchuk@epam.com> writes:
>
>> Hi Stefano,
>>
>> Stefano Stabellini <sstabellini@kernel.org> writes:
>>
>>> On Wed, 22 Nov 2023, David Woodhouse wrote:
>>>> On Wed, 2023-11-22 at 15:09 -0800, Stefano Stabellini wrote:
>>>> > On Wed, 22 Nov 2023, David Woodhouse wrote:
>>>> > > On Wed, 2023-11-22 at 14:29 -0800, Stefano Stabellini wrote:
>>>> > > > On Wed, 22 Nov 2023, Paul Durrant wrote:
>>>> > > > > On 21/11/2023 22:10, Volodymyr Babchuk wrote:
>>>> > > > > > From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
<snip>
>>>> The -xen-domid argument on the QEMU command line today is the *guest*
>>>> domain ID, not the domain ID in which QEMU itself is running.
>>>>=20
>>>> Or were you thinking of something different?
>>>
>>> Ops, you are right and I understand your comment better now. The backend
>>> domid is not on the command line but it should be discoverable (on
>>> xenstore if I remember right).
>>
>> Yes, it is just "~/domid". I'll add a function that reads it.
>
> Just a quick question to QEMU folks: is it better to add a global
> variable where we will store own Domain ID or it will be okay to read
> domid from Xenstore every time we need it?
>
> If global variable variant is better, what is proffered place to define
> this variable? system/globals.c ?

Hmm maybe, I see Xen already has some but the comment:

  "Global variables that (mostly) should not exist"

I think it to dissuade the file growing more than it should.

I think generally the best pattern to use if a global can't be avoided
is to have a "static global" in the main .c file for the module and then
provide a helper access function for other files to read it. That also
makes re-factoring easier if things like locking need to be added down
the line.

We still do have a few true global variables which need "extern"
declarations in the headers but if we can avoid adding more that would
be good.

Of course ideally this sort of data would be wrapped up in QOM
structures but I can see the argument for the host domain ID.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

