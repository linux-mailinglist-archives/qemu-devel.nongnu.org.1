Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4357C87C0
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:23:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJ3T-0000xK-Jx; Fri, 13 Oct 2023 10:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrJ3Q-0000wY-VB
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:22:17 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrJ3P-0006hP-8c
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:22:16 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso78682b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697206933; x=1697811733;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5glnqy6yOW+hs3BsPmUXmDCR/OoXC1maRixftqiFBq8=;
 b=m5mO7SgVzcfQYW9TamSorbH+H1jEeA7B/0bjI/0zNywE47E48NbXvQG2dHZvObPn8T
 EIyEwPMamTN4ScerB99CsKTyy1fmcWEg+SPPPxwnNo1f4Ng1/Z/H24k9pbDiQRDnodnM
 pw1sCxSE2e9081Y2CmhsGCYkU8NLhtt3CbBSEgOkxocQ8VAKqJ8J0Vs68CCclMeIbh39
 btydqJ7tHuNTaQ9nKIeA9qkvATPTig8k3uFFMRs8TEDuNGDHG8DcsIcQyPcc3Vlb5788
 NzIhJ7/+YcD7Ptdd1GNTAGBY9jEmgeAs+AOmYj0EdxVWRwoA0qr7IiCU56OmUn8TAfra
 bFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697206933; x=1697811733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5glnqy6yOW+hs3BsPmUXmDCR/OoXC1maRixftqiFBq8=;
 b=fbjGhAiP8FmiSITX81OiKWN6xHkE5FOJavg3ly3kKPAtx7yvpzZUZ6SymRWENyHBBE
 +P1mPF/hmABhdFOfjtrYExRDzRkTuaWzLQx2adZt3ziiqK4x22UFXg/kygWd8BFCcQid
 HQT5FH0YxjFJUAnd83rRJf11vD0fNzoxmL1LkKzEOfowgvJUWWPlIe62Y4NG2sK0wZyM
 PJfWVO9f76TR47pY6BuUKNuyaj8uM2kE0dUcEei+IATdR4BHXuNsY+GYh0X6mb9Op1br
 MQDZnSxTFb9l3tc6Dq7zbPgGVKY2Xnwsv5veSob2FhJZ9ILcsfAvLzVZ3eUdwoNAuNZz
 9kuw==
X-Gm-Message-State: AOJu0Yw/EGJHH8G+2VJmm05lFrc0GM9idhq+vUen0zEUnqiQw54oq0SV
 SXeZBKMxoU0Pq8/89Bn15o9ZVll/3eykp5Uk00WV7g==
X-Google-Smtp-Source: AGHT+IF9+FyeE44MWgDDGsppfvB9yYKaxUdg0xPiLLoKYjv0luFAYjk5+pBbXd8hypdj6iyBp9doaw==
X-Received: by 2002:a05:6a00:44cd:b0:6b3:80f8:7e91 with SMTP id
 cv13-20020a056a0044cd00b006b380f87e91mr497835pfb.9.1697206933467; 
 Fri, 13 Oct 2023 07:22:13 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 y8-20020aa78f28000000b006926a2c9eb7sm1542699pfr.119.2023.10.13.07.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 07:22:13 -0700 (PDT)
Message-ID: <29fef0dd-86b6-4cd6-bbbc-812b832d8fcf@daynix.com>
Date: Fri, 13 Oct 2023 23:22:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] tap: Remove tap_probe_vnet_hdr_len()
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
 <20231011153944.39572-2-akihiko.odaki@daynix.com>
 <CACGkMEt-kR5EVozeO+Zcx9kxdLLggBM8V98YUKQKutb28TvgCQ@mail.gmail.com>
 <74139826-7e06-48c0-bb1c-0b5bf708c808@daynix.com>
 <CACGkMEuEs2MLJYKMB9qAgT2ixkKLC8LPPE6DsBvfwx0CEaCA_A@mail.gmail.com>
 <12412f11-4395-460f-9523-930ad9270188@daynix.com>
 <20231013101508-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231013101508-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/13 23:17, Michael S. Tsirkin wrote:
> On Fri, Oct 13, 2023 at 02:26:03PM +0900, Akihiko Odaki wrote:
>> On 2023/10/13 14:00, Jason Wang wrote:
>>> On Fri, Oct 13, 2023 at 12:14 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2023/10/13 10:38, Jason Wang wrote:
>>>>> On Wed, Oct 11, 2023 at 11:40 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> It was necessary since an Linux older than 2.6.35 may implement the
>>>>>> virtio-net header but may not allow to change its length. Remove it
>>>>>> since such an old Linux is no longer supported.
>>>>>
>>>>> Where can I see this agreement?
>>>>
>>>> docs/about/build-platforms.rst says:
>>>>    > The project aims to support the most recent major version at all times
>>>>    > for up to five years after its initial release. Support for the
>>>>    > previous major version will be dropped 2 years after the new major
>>>>    > version is released or when the vendor itself drops support, whichever
>>>>    > comes first. In this context, third-party efforts to extend the
>>>>    > lifetime of a distro are not considered, even when they are endorsed
>>>>    > by the vendor (eg. Debian LTS); the same is true of repositories that
>>>>    > contain packages backported from later releases (e.g. Debian
>>>>    > backports). Within each major release, only the most recent minor
>>>>    > release is considered.
>>>>    >
>>>>    > For the purposes of identifying supported software versions available
>>>>    > on Linux, the project will look at CentOS, Debian, Fedora, openSUSE,
>>>>    > RHEL, SLES and Ubuntu LTS. Other distros will be assumed to ship
>>>>    > similar software versions.
>>>
>>> Well it also says:
>>>
>>> """
>>> If a platform is not listed here, it does not imply that QEMU won't
>>> work. If an unlisted platform has comparable software versions to a
>>> listed platform, there is every expectation that it will work.
>>> """
>>>
>>> A lot of downstream have customized build scripts.
>>
>> Still Linux versions older than 2.6.35 do not look like "comparable software
>> versions to a listed platform" in my opinion.
> 
> 
> This is fine - I would be ok to replace support with an error message
> and failure. Not checking that a capability is supported however
> isn't a good idea. And once we do - do we still gain anything by
> not working around that?

tap does still check if setting the header length succeeds so it should 
be fine.

