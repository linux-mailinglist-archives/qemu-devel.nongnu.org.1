Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7357C7C7F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 06:15:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9ZR-0004Yz-A4; Fri, 13 Oct 2023 00:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qr9ZO-0004Yo-Sk
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:14:38 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qr9ZN-0006kI-4m
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:14:38 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b36e1fcee9so106271b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697170475; x=1697775275;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fSXBczkfX5qYlFi8Yas43fNOmuAIuN3EYGhc1mW+0eg=;
 b=n9pSfcR52+FnxmKCOl9eF6sVgh+CgTViksFPlmo8mYyGkfMGQYkHohlMhRHVGqSInp
 AU09YSyly0fk10Wub4JK83fyBOdsqxQcykXE+7909EySpq8zomlF6qpPYcDxk4c17K3E
 F4Drjm/97TsnXp9dFR4PqwTQ51vbamGJx2tFkS8RJuoJoB6uLvL/f7dDgcIsKEmN8DRH
 y+PCUdz4fGrXmJD0xV1mVB3Xa8wZ2pqGpagmez8DyOBmY3aoOPAcmHGfb6WCUgBPPF+B
 wGR9c69FtqQtXDWXzHti/6wx2qPWHfIc9uKls5nOV/Kvyu3boHclW2jMQ3EAgqH1MDeu
 MyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697170475; x=1697775275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fSXBczkfX5qYlFi8Yas43fNOmuAIuN3EYGhc1mW+0eg=;
 b=G4Rcb0qEH8KcjkNvC3bmM6xYHduS/vPnJN02yerGfUQDFIITj5SB5xFFEDP20an4f/
 AK7w8c8zLORvWbV/1Sy0a0z3zmG/MugF7iYv3jPDtQQnb0TmxrbXCpvd9bwvyYs5G93X
 eSR2uFMjZiLHwHRUwm5Cf7aDXX5dvFVf/h67IO9wo1KzLf/zCw5N1WlnjcVm+qZs7j+1
 X8f8hGYHPfHfM++eXyhtkIwSuHx1LSBWWgYAxGdPgtMEDx9nA15QrltrPMInZOpO/cST
 aSWqnJE/qvkCMiCdht2ATvqEzy7e+SJnbG6WlTmtAYop703YFkrW/SRBt17WZjDlt6dF
 t9Eg==
X-Gm-Message-State: AOJu0YwV67TRLOR3etEDuR0DUrDNBvb7Ow+NB2e4K49t6lIZrT9wiJD6
 gQC6SIpvgkd8syCiN1bmtfBoxg==
X-Google-Smtp-Source: AGHT+IE84baJT1/qDJhP8/dN0FC/zAVV0KBX2zFexig/B+0eK/CK/oy/xLRBtcixqIy+7GSgXVQWTA==
X-Received: by 2002:a05:6a20:ce8f:b0:15a:290:d833 with SMTP id
 if15-20020a056a20ce8f00b0015a0290d833mr21607214pzb.53.1697170475361; 
 Thu, 12 Oct 2023 21:14:35 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 9-20020a17090a018900b002775281b9easm2865358pjc.50.2023.10.12.21.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 21:14:34 -0700 (PDT)
Message-ID: <74139826-7e06-48c0-bb1c-0b5bf708c808@daynix.com>
Date: Fri, 13 Oct 2023 13:14:32 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEt-kR5EVozeO+Zcx9kxdLLggBM8V98YUKQKutb28TvgCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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

On 2023/10/13 10:38, Jason Wang wrote:
> On Wed, Oct 11, 2023 at 11:40 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> It was necessary since an Linux older than 2.6.35 may implement the
>> virtio-net header but may not allow to change its length. Remove it
>> since such an old Linux is no longer supported.
> 
> Where can I see this agreement?

docs/about/build-platforms.rst says:
 > The project aims to support the most recent major version at all times
 > for up to five years after its initial release. Support for the
 > previous major version will be dropped 2 years after the new major
 > version is released or when the vendor itself drops support, whichever
 > comes first. In this context, third-party efforts to extend the
 > lifetime of a distro are not considered, even when they are endorsed
 > by the vendor (eg. Debian LTS); the same is true of repositories that
 > contain packages backported from later releases (e.g. Debian
 > backports). Within each major release, only the most recent minor
 > release is considered.
 >
 > For the purposes of identifying supported software versions available
 > on Linux, the project will look at CentOS, Debian, Fedora, openSUSE,
 > RHEL, SLES and Ubuntu LTS. Other distros will be assumed to ship
 > similar software versions.

All of the previous major versions of these distributions ship far newer 
kernels.

CentOS Stream 8 and RHEL 8 ship 4.18.0.
Debian bullseye ships 5.10.0.
Fedora 37 ships 6.5.6.
openSUSE Leap 15.4 ships 5.14.21.
SLES 12 ships 4.12.14.
Ubuntu 20.04 ships 5.4.

