Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7017C874B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:02:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIj6-00062X-Lf; Fri, 13 Oct 2023 10:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrIik-0005zK-FW
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:00:54 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrIih-00023p-I7
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:00:53 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9d3a21f7aso17454435ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697205650; x=1697810450;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E7Vc3qTVmptFByAlKFnHutdqMFxgn8L8vjQStdE0y/s=;
 b=QcyVasGMlLQzjFWRrD+nBzgMXezw8hBmLQvrnG5ta2zhao7+Gp132GL54v2DJ9JopW
 CzdiB5G7zsUyY23vRWIswbHqnYPXEL1iD8kOYeDKr47h7tw3r8YHvCpTOx7wSoiZE8MP
 w2nKJ1x2staBseAXZ66sZEK91zW3Lk1kr7Owg+8ew/2S0uzvp8X6i4HXxgbeBh6gI1I4
 EZO4Z3r4F3biyAnClmYasXkvr5SdmlLRj9Iv0vTOIHp7wHS/TQxOv572N8gzXxBxGd3k
 Uh+2/4++XnI2CvLt10mhFXjMtFe9qU8AJlixufhlkOkfRmgHse1wH+y9oPVKp22fJ/L4
 k1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697205650; x=1697810450;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E7Vc3qTVmptFByAlKFnHutdqMFxgn8L8vjQStdE0y/s=;
 b=PuEdywwOAH/9dLCz8H5ihZQ4cy+BV+rDuqoLR4DS1m0NPWOr40q7aCNiOlYC6jvHJI
 OGaew2d7Jkm+JMiZYS4CeIx9SLcbPq9vxFtH8Nsip225baFod0PsK8SZsh9g9SNZltD8
 z0NdG7s+C2iLsR8rHAjfDAZ9kMeEuIChsYhv8rtdb4klAtIrOjcMpZiX1Zfs+NvDmJug
 kR9+gdeaEVIQHqCIdiyqvNB6I3x2Mui99jh6rBC4rsyxlRr0u04VGPRkVM8IWBUPd9N5
 MKzmSzp7cmBkGOuZRva9JcT5QUZJxmK3cCXWwMdQycTVrvWi5wIp3iCEzNX4OnUhvAJq
 SMhA==
X-Gm-Message-State: AOJu0YzIcl5yjm6aNhGRgNOfqKWdKJmFd6o4PcTJAHNcuBMEIn78EOs6
 T2fyuhiwhgRx3sXBHlWvN31FMw==
X-Google-Smtp-Source: AGHT+IFskMEuUDkczMC3EbTywl8vr4pCxpyR5eq58j/7jmuQrigzMwKkTO3F47YeTKKbiP+Q6e3g5g==
X-Received: by 2002:a17:902:768c:b0:1c9:c93a:ca35 with SMTP id
 m12-20020a170902768c00b001c9c93aca35mr6989630pll.64.1697205649778; 
 Fri, 13 Oct 2023 07:00:49 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jj1-20020a170903048100b001c7443d0890sm3904667plb.102.2023.10.13.07.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 07:00:49 -0700 (PDT)
Message-ID: <17000717-22a6-4162-8131-cfaaef2389e8@daynix.com>
Date: Fri, 13 Oct 2023 23:00:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] tap: Remove tap_probe_vnet_hdr_len()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
 <20231011153944.39572-2-akihiko.odaki@daynix.com>
 <CACGkMEt-kR5EVozeO+Zcx9kxdLLggBM8V98YUKQKutb28TvgCQ@mail.gmail.com>
 <74139826-7e06-48c0-bb1c-0b5bf708c808@daynix.com>
 <20231013095407-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231013095407-mutt-send-email-mst@kernel.org>
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

On 2023/10/13 22:55, Michael S. Tsirkin wrote:
> On Fri, Oct 13, 2023 at 01:14:32PM +0900, Akihiko Odaki wrote:
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
>>> The project aims to support the most recent major version at all times
>>> for up to five years after its initial release. Support for the
>>> previous major version will be dropped 2 years after the new major
>>> version is released or when the vendor itself drops support, whichever
>>> comes first. In this context, third-party efforts to extend the
>>> lifetime of a distro are not considered, even when they are endorsed
>>> by the vendor (eg. Debian LTS); the same is true of repositories that
>>> contain packages backported from later releases (e.g. Debian
>>> backports). Within each major release, only the most recent minor
>>> release is considered.
>>>
>>> For the purposes of identifying supported software versions available
>>> on Linux, the project will look at CentOS, Debian, Fedora, openSUSE,
>>> RHEL, SLES and Ubuntu LTS. Other distros will be assumed to ship
>>> similar software versions.
>>
>> All of the previous major versions of these distributions ship far newer
>> kernels.
>>
>> CentOS Stream 8 and RHEL 8 ship 4.18.0.
> 
> Yes but RHEL7 is still in full support.

I don't think so. The downstream (Red Hat) may still support it, but 
it's not supported by QEMU upstream according to 
docs/about/build-platforms.rst.

> 
>> Debian bullseye ships 5.10.0.
>> Fedora 37 ships 6.5.6.
>> openSUSE Leap 15.4 ships 5.14.21.
>> SLES 12 ships 4.12.14.
>> Ubuntu 20.04 ships 5.4.
> 
> It does not matter that a newer version is shipped. What matters is
> whether older one is still supported.

These versions should be the oldest supported versions that match with 
the description in docs/about/build-platforms.rst.

