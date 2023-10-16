Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 511587C9EC2
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 07:31:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsGC5-0005k9-1o; Mon, 16 Oct 2023 01:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsGC1-0005jj-1z
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 01:31:05 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsGBx-0004ZR-Oy
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 01:31:04 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c88b467ef8so27494435ad.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 22:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697434260; x=1698039060;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uEhDGBOEHZtCIJzR2bpthJpEIkwVwuX6ztAmFYYzwjY=;
 b=BIfOoP3x5rYVnFrBxwLuCRRLGAFJutqtktgsrb/+tJ+QyDApXHW0jCdGTgw1aMHNPR
 UXdwYMe5C1ciEINVF04gHrps2F97d4EduwO6miS3+xZL0pIwZOaBlJcNwSbSf3mGI284
 1lH7ssiypiDnLmCs7mk40X5iDYgGj03gwe9uarG/TjftFdfOsj8f2gE2pAMkuZ14v+fQ
 t2j6/TkHQOwLCpPxHtzN8seheO+r4sevSWsnuIcH4+DP7FYSs5y/bRCcjdLjUVCv/rK8
 lDQWKAOsENGfUNgAp0UFDssxVMQ5YqKXeaPZK7N9+rYMMPGDsgwPTxr3SJgFvPVfTugs
 P3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697434260; x=1698039060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uEhDGBOEHZtCIJzR2bpthJpEIkwVwuX6ztAmFYYzwjY=;
 b=kn0FnnZumrqNHfVtwfMLVRk6WTf6/UXWm3JTcKhkACiofy/ng5y2uCYmxI6babHQwu
 2SMORH70GUxYQTCnR/fk7ZAoqMtG4WTwGdbpMdbvemVcT9HFeWFNYYAByQ/4l/+8PS1O
 +ZVZbo0S1Md/8L+88ewEawB/1y7RuI2cRC0xfutH/ixnqRrUG9aX85HE7cG5w2p2ZMKG
 wOVfWcikzRLDg5uwyn67nAoHjX5qunC1m5t1b+Sy36G9NaL1S0SCRtskNmpJodAxuu7r
 WC9JPgqUJuYe5duLCwF1kb31QsT1+iEc+MCXau/ooNirpZo7osC9TxAAzQP10Kb6yJK8
 z3jA==
X-Gm-Message-State: AOJu0YxlP4DqPsLMx2MpxUmYtlHh6x+eylOoghTzGtBB+W23FY4jTmEu
 qYiTKw41wA3M0ZYccd8YAtplLw==
X-Google-Smtp-Source: AGHT+IHtF6RdPBZ0S1eh6kBKDqX1KHxwA/BdUriaKU08tjfRk7+6ZceEh+e0S5I4HwNlTC4yTq6EeA==
X-Received: by 2002:a17:903:4043:b0:1c9:e072:3398 with SMTP id
 n3-20020a170903404300b001c9e0723398mr6912976pla.41.1697434260362; 
 Sun, 15 Oct 2023 22:31:00 -0700 (PDT)
Received: from [157.82.206.197] ([157.82.206.197])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a170902c70b00b001b0358848b0sm7678096plp.161.2023.10.15.22.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 22:30:59 -0700 (PDT)
Message-ID: <75aa685f-4ced-4e24-864b-e0cbb4bec73a@daynix.com>
Date: Mon, 16 Oct 2023 14:30:57 +0900
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
 <12412f11-4395-460f-9523-930ad9270188@daynix.com>
 <CACGkMEvg37na-2rUAjUoJOhLrKg+mz+O_D_=UnMJr-qoxPSkLQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvg37na-2rUAjUoJOhLrKg+mz+O_D_=UnMJr-qoxPSkLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

On 2023/10/16 14:25, Jason Wang wrote:
> On Fri, Oct 13, 2023 at 1:26 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
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
>> Still Linux versions older than 2.6.35 do not look like "comparable
>> software versions to a listed platform" in my opinion.
> 
> Linux provides ABI compatibility so I don't know why, unless there is
> a strong dependency on a specific new syscall introduced after 2.6.35.

This patch drops a pre-check for ioctl introduced with 2.6.35.

> 
>>
>>> And is something similar to such removal that has been done for other
>>> subsystems?
>>
>> With commit c42e77a90d ("qemu/osdep: Remove fallback for
>> MAP_FIXED_NOREPLACE"), I remove the support for glibc older than 2.28.
>> Linux 2.6.35 is even older.
>>
> 
> Ok, this explains things a little bit. Btw, we also have soliars
> support for TAP, time to drop that as well?

Do you mean Solaris? Honestly I don't know. I don't think anyone dares 
to use QEMU on Solaris (or to use Solaris at all), but apparently Oracle 
has not abandoned it yet.

