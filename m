Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2186750733
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 13:54:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJXgd-0000VU-HH; Wed, 12 Jul 2023 07:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJXgb-0000Tn-FB
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:07:09 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJXgY-0007D6-GS
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:07:08 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51e5da79223so3682907a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689160022; x=1691752022;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lKB0Z8yDb82ct+9Vw6fDVOxr003ueGssa3zQ/4WvU1A=;
 b=YH39EZaEWYA31Ly/aX0AR9TbgmN7lUYUluiPfK9OSApzcVaSUyNYo9SE2R3U0evs+o
 MBJSvpUmj/z8YCmg7yzGGozV13QzMQbADgnm+cd6jWxPy+pKTkpTJ4dJLOJ4ATXagjbl
 Sk33Qcpr+6VGSxx162aWX19O7/P1YkMLJksprQE8hXyq3UK7RdsXrgbreAgPzE/PmILV
 6ejViEy+c9Y8oqPZruriXC6mnAJ8uXve6CE8WseW4Xw5GNqiZ+yqKH93y6IGT1BqhdAN
 rGRa/wf7Y6+WjIBbLV6LIILWWcmagieY2EW9QsjXmo1YBymcch0yYcMDhZH81Gblr+8Q
 T9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689160022; x=1691752022;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lKB0Z8yDb82ct+9Vw6fDVOxr003ueGssa3zQ/4WvU1A=;
 b=VOAT3RBADY0EGDmUcdAa+9gVtR9PDermDY7Bbup6V+fuQeBrFRmJ3zcXAinXY4Td94
 ClzDxcNJARSrg8pe/n2E6jKU7W4ycw4P61emclwVeEkYoh1HJ4VYIMg4cs2xoGyAyJ/A
 mMgMqFZIS31m99mSxSf4D4/KGQHNu/7mQugoc9j9Bku/KqteQPCtT0h6gZahJlO51GSv
 i8rhlvkxIGHj12D781OHoTx3L6EUWNyiRvFuLZBAzbKAknF2CHLme87iX5lfvwzQe3lQ
 fA23Ac6byw8bZ7hH1EWixOv2wjb0OXIGRzUeDcnHlNDoqeOZOT3Q3+F5C68Aal/XNuAD
 R7jw==
X-Gm-Message-State: ABy/qLb6svQR1Z4TIRbL5TZMUgEL2jSflIk/ldRXrqM0y7lVld+gTxd+
 cfBnrqpn1kEa9HcQDkYmdZPTgw==
X-Google-Smtp-Source: APBJJlGAsXfscIYKYkaieytgoHdKR4LC2KGhvuWz9djRmgcoVhjsxgYkdI+p8HqA+sLegS8rnh28Ag==
X-Received: by 2002:aa7:cb97:0:b0:51d:f5bd:5a88 with SMTP id
 r23-20020aa7cb97000000b0051df5bd5a88mr16445611edt.38.1689160022680; 
 Wed, 12 Jul 2023 04:07:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.150.242])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a50ed04000000b0051e2a6cef4fsm2599097eds.36.2023.07.12.04.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 04:07:02 -0700 (PDT)
Message-ID: <68f79db8-b241-0ad6-353f-11bd68e3ffd9@linaro.org>
Date: Wed, 12 Jul 2023 13:07:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/4] tests/lcitool: Generate distribution packages list
 in JSON format
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
References: <20230711144922.67491-1-philmd@linaro.org>
 <20230711144922.67491-2-philmd@linaro.org>
 <CANCZdfptsrH6vXCtjxWyjSFu4CG92xmOuQ9i1uGs3301QmxC=g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CANCZdfptsrH6vXCtjxWyjSFu4CG92xmOuQ9i1uGs3301QmxC=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
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

On 11/7/23 21:39, Warner Losh wrote:
> On Tue, Jul 11, 2023 at 8:49 AM Philippe Mathieu-Daudé 
> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 
>     Add the generate_pkglist() helper to generate a list of packages
>     required by a distribution to build QEMU.
> 
>     Since we can not add a "THIS FILE WAS AUTO-GENERATED" comment in
>     JSON, create the files under tests/vm/generated/ sub-directory;
>     add a README mentioning the files are generated.
> 
>     Suggested-by: Erik Skultety <eskultet@redhat.com
>     <mailto:eskultet@redhat.com>>
>     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org
>     <mailto:philmd@linaro.org>>
> 
> 
> Reviewed-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>
> 
> also, FreeBSD 14 branches next month... do I just grep for FreeBSD-13 to 
> find all the places to update for 14.0?

Per docs/about/build-platforms.rst:

   Linux OS, macOS, FreeBSD, NetBSD, OpenBSD
   -----------------------------------------

   The project aims to support the most recent major version at all
   times for up to five years after its initial release. Support
   for the previous major version will be dropped 2 years after the
   new major version is released or when the vendor itself drops
   support, whichever comes first. [...]

We want to be able to test the oldest/newest releases.

Maybe we can add a pair of definitions, so we'd have to only
change 2 lines in a single place when releases occur?


>     @@ -191,6 +197,11 @@ try:
>           generate_cirrus("freebsd-13")
>           generate_cirrus("macos-12")
> 
>     +    #
>     +    # VM packages lists
>     +    #
>     +    generate_pkglist("freebsd", "freebsd-13")


