Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F62F7C87EF
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:36:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJGA-0002al-AK; Fri, 13 Oct 2023 10:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrJFl-0002Ww-Fw
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:35:02 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrJFj-0000iB-4d
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:35:00 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5ae99bb5ccdso156072a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697207697; x=1697812497;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RSDBchcgLI5vIkrmDk9hld5fa+kJbqhINuxX4r14Wxo=;
 b=KC9gw5D7bN591/e/GFX0oLJEYuQ1+GpamVOHJwOUPvr0NWa95OyojY+b4AoYNAy9bn
 TNogkaMf4g8CEGb7L4bO/dTwaQH0uNKMGF39g00mcny8SCd7xWVi2zzE0czdBWOzzPcQ
 HrR7lZVyTLmXK5DGyiC535++G3EFTb2h8ET6/ZiivUb+YtgwOrDRn4lSoB+2TeK2pe3z
 Es7KJ/J21vRkP1xyJk0fvuSl9Ze/vVnH2XWL3qG9FjiXGe/npIudKvIr2XLcfKqu3QTX
 4Gg1p5IIA3xRf6PTYE940UoOp177N7/NeXxHbuGk4KdeyVjEjSyQKrs0fc5b6YeZecYi
 Folg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697207697; x=1697812497;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RSDBchcgLI5vIkrmDk9hld5fa+kJbqhINuxX4r14Wxo=;
 b=hThbArnEBO69le8BTvH7T4tLNfBQiXvtLeH8DhIofNqsVyQzgMk8cALsV0IqkczAdK
 mjz0/Vi4yDcOUxn7UN6PTKg3TzmKuxvEato1EGrQMfj+zC1Ape4tkfhvWP0xIp9rmNoi
 J1YbBAKJ8h3GWyW7JevUhpIsZwAoc2VPjaAt+3ssElqmszLZZruMUtYrHayQ6dlCJlpF
 h5pl4fw5EdJltvVWJWq6g6FxxYCLeb6xrEHz7FimqX1oAilFNEHXEKKA+NjceLAM0/Kn
 5xu9faVKDONrHmqjSUakFJISepocL9EyvH1MBlj5FftM/oszhHqEAi0vK1vOCG+wPXkN
 /t0Q==
X-Gm-Message-State: AOJu0YxUsBk3nXK9bbxSFhSeAWrM467Kn+iM6iNlO5+NpF5bEP9EAtUg
 YqE8gbKK8bsAtYslvxdECh0LwyQZBUt8grIGsiUtRQ==
X-Google-Smtp-Source: AGHT+IHqVIBwVyXp3j0CLn3rU4CNBCQ6SvZ+Jji8+tNOS870sAt5ULG/TE6C3ySBsu0VDlz5pN7JTA==
X-Received: by 2002:a05:6a20:918d:b0:16b:9b5d:155d with SMTP id
 v13-20020a056a20918d00b0016b9b5d155dmr19544468pzd.30.1697207697383; 
 Fri, 13 Oct 2023 07:34:57 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a636f01000000b0058901200bbbsm3557200pgc.40.2023.10.13.07.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 07:34:57 -0700 (PDT)
Message-ID: <fd3ddb90-83e2-4f48-bf31-227f632af027@daynix.com>
Date: Fri, 13 Oct 2023 23:34:54 +0900
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
 <29fef0dd-86b6-4cd6-bbbc-812b832d8fcf@daynix.com>
 <20231013103151-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231013103151-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
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

On 2023/10/13 23:32, Michael S. Tsirkin wrote:
> On Fri, Oct 13, 2023 at 11:22:10PM +0900, Akihiko Odaki wrote:
>> On 2023/10/13 23:17, Michael S. Tsirkin wrote:
>>> On Fri, Oct 13, 2023 at 02:26:03PM +0900, Akihiko Odaki wrote:
>>>> On 2023/10/13 14:00, Jason Wang wrote:
>>>>> On Fri, Oct 13, 2023 at 12:14 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2023/10/13 10:38, Jason Wang wrote:
>>>>>>> On Wed, Oct 11, 2023 at 11:40 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> It was necessary since an Linux older than 2.6.35 may implement the
>>>>>>>> virtio-net header but may not allow to change its length. Remove it
>>>>>>>> since such an old Linux is no longer supported.
>>>>>>>
>>>>>>> Where can I see this agreement?
>>>>>>
>>>>>> docs/about/build-platforms.rst says:
>>>>>>     > The project aims to support the most recent major version at all times
>>>>>>     > for up to five years after its initial release. Support for the
>>>>>>     > previous major version will be dropped 2 years after the new major
>>>>>>     > version is released or when the vendor itself drops support, whichever
>>>>>>     > comes first. In this context, third-party efforts to extend the
>>>>>>     > lifetime of a distro are not considered, even when they are endorsed
>>>>>>     > by the vendor (eg. Debian LTS); the same is true of repositories that
>>>>>>     > contain packages backported from later releases (e.g. Debian
>>>>>>     > backports). Within each major release, only the most recent minor
>>>>>>     > release is considered.
>>>>>>     >
>>>>>>     > For the purposes of identifying supported software versions available
>>>>>>     > on Linux, the project will look at CentOS, Debian, Fedora, openSUSE,
>>>>>>     > RHEL, SLES and Ubuntu LTS. Other distros will be assumed to ship
>>>>>>     > similar software versions.
>>>>>
>>>>> Well it also says:
>>>>>
>>>>> """
>>>>> If a platform is not listed here, it does not imply that QEMU won't
>>>>> work. If an unlisted platform has comparable software versions to a
>>>>> listed platform, there is every expectation that it will work.
>>>>> """
>>>>>
>>>>> A lot of downstream have customized build scripts.
>>>>
>>>> Still Linux versions older than 2.6.35 do not look like "comparable software
>>>> versions to a listed platform" in my opinion.
>>>
>>>
>>> This is fine - I would be ok to replace support with an error message
>>> and failure. Not checking that a capability is supported however
>>> isn't a good idea. And once we do - do we still gain anything by
>>> not working around that?
>>
>> tap does still check if setting the header length succeeds so it should be
>> fine.
> 
> It asserts though doesn't it? Hardly user friendly ...

It prints an error message so the user should be able to figure out 
what's missing:
         fprintf(stderr, "TUNSETVNETHDRSZ ioctl() failed: %s. Exiting.\n",
                 strerror(errno));

