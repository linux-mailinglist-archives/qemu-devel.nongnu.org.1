Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E17357C7CFC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 07:27:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrAgf-0001sm-Gg; Fri, 13 Oct 2023 01:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrAgd-0001sU-4h
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 01:26:11 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrAga-0001iH-Eg
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 01:26:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c888b3a25aso13759255ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 22:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697174766; x=1697779566;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RQxQjF22KqPO4JYB1AieJ4K6t4JcBwHZUV1mRFyJxz0=;
 b=TLZxMx61hLi44yPRLUDqvofJeVDaFBS/puWQDBHoMlRDoC9GCh6EOx2IddTKL2pm6L
 Kz9DDAFDjNTx4neXCxkXfdQz01iunkAINMN1tZUGu6WUuMLN2sAnV4JYLywLfxX8owgA
 s+fZ0REbI7JJRbJeezSw8nRRdOtzEFWIiiHyaUpGcoaAN+c6dJ7e7+PHbYB4V3F5dppD
 oj4R3ThOJZojIAHPQxczNk8vUgzo8lea31FElidDQ0DTNMjkBqgEdvGtEEZ3eRAtjF+A
 tiND7oaSxXLOxE6ZfYk9ROt5y59XzVLzXNRM3dP0ic4w5f81o3T/IBb2hbbUtptyHFZ0
 3g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697174766; x=1697779566;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RQxQjF22KqPO4JYB1AieJ4K6t4JcBwHZUV1mRFyJxz0=;
 b=vXmqeBi7p2Z981HGTr4hoehv+WCn+DQORdL4nszFzItzBJY37YpAEwyVgF5sXj2G7o
 HbTOje7pxcjkulRuOvx0i43Z827QNKL4OUvQ5sHb9YuKCwr++gmuTo0Rek15aO0o3gE9
 R8UUFry5LGi420K2KzzqHLht5eRCp6zyccIqwCVc4wRnTt2mJ21vtCpA+m8gIeaQZgYd
 1r7sUbCpSbQ1kLPs6kUG88fyg7n3wTCOFlcL35DCmatP2qscMcQWFhNZv7BYTcRNdpVM
 4kaQ7ra2q7EFZcP5/lJ0SoPcWRdmlGLGgrBD9yKHMK/bNg12h+fkssvibLbbpzJhLu4/
 hy0w==
X-Gm-Message-State: AOJu0Yzkp7BWtCvU+Uhs9vyJymQ3jBLYMSjuSBfQOZjV9XvikPGIdYod
 QhfzMVoPknjTVkhSU1QXIVCHtQ==
X-Google-Smtp-Source: AGHT+IGI4xxJPSSIyKys8sN8yyo52O2Kjx3ly30gwS6DMOF+fZdS4iRcS0942IIiw06KbFWZPi15Vw==
X-Received: by 2002:a17:903:2790:b0:1c9:ccbc:4c98 with SMTP id
 jw16-20020a170903279000b001c9ccbc4c98mr5307139plb.37.1697174766583; 
 Thu, 12 Oct 2023 22:26:06 -0700 (PDT)
Received: from [157.82.206.197] ([157.82.206.197])
 by smtp.gmail.com with ESMTPSA id
 ju9-20020a170903428900b001c9d6c0faa3sm2923544plb.226.2023.10.12.22.26.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 22:26:06 -0700 (PDT)
Message-ID: <12412f11-4395-460f-9523-930ad9270188@daynix.com>
Date: Fri, 13 Oct 2023 14:26:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] tap: Remove tap_probe_vnet_hdr_len()
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
 <20231011153944.39572-2-akihiko.odaki@daynix.com>
 <CACGkMEt-kR5EVozeO+Zcx9kxdLLggBM8V98YUKQKutb28TvgCQ@mail.gmail.com>
 <74139826-7e06-48c0-bb1c-0b5bf708c808@daynix.com>
 <CACGkMEuEs2MLJYKMB9qAgT2ixkKLC8LPPE6DsBvfwx0CEaCA_A@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEuEs2MLJYKMB9qAgT2ixkKLC8LPPE6DsBvfwx0CEaCA_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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

On 2023/10/13 14:00, Jason Wang wrote:
> On Fri, Oct 13, 2023 at 12:14 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/10/13 10:38, Jason Wang wrote:
>>> On Wed, Oct 11, 2023 at 11:40 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> It was necessary since an Linux older than 2.6.35 may implement the
>>>> virtio-net header but may not allow to change its length. Remove it
>>>> since such an old Linux is no longer supported.
>>>
>>> Where can I see this agreement?
>>
>> docs/about/build-platforms.rst says:
>>   > The project aims to support the most recent major version at all times
>>   > for up to five years after its initial release. Support for the
>>   > previous major version will be dropped 2 years after the new major
>>   > version is released or when the vendor itself drops support, whichever
>>   > comes first. In this context, third-party efforts to extend the
>>   > lifetime of a distro are not considered, even when they are endorsed
>>   > by the vendor (eg. Debian LTS); the same is true of repositories that
>>   > contain packages backported from later releases (e.g. Debian
>>   > backports). Within each major release, only the most recent minor
>>   > release is considered.
>>   >
>>   > For the purposes of identifying supported software versions available
>>   > on Linux, the project will look at CentOS, Debian, Fedora, openSUSE,
>>   > RHEL, SLES and Ubuntu LTS. Other distros will be assumed to ship
>>   > similar software versions.
> 
> Well it also says:
> 
> """
> If a platform is not listed here, it does not imply that QEMU won't
> work. If an unlisted platform has comparable software versions to a
> listed platform, there is every expectation that it will work.
> """
> 
> A lot of downstream have customized build scripts.

Still Linux versions older than 2.6.35 do not look like "comparable 
software versions to a listed platform" in my opinion.

> And is something similar to such removal that has been done for other
> subsystems?

With commit c42e77a90d ("qemu/osdep: Remove fallback for 
MAP_FIXED_NOREPLACE"), I remove the support for glibc older than 2.28. 
Linux 2.6.35 is even older.

