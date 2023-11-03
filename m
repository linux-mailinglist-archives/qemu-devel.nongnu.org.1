Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF337E01B2
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 11:57:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyrrQ-0008P8-A5; Fri, 03 Nov 2023 06:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qyrrN-0008N2-SM
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qyrrL-0004yk-WE
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699009022;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RicE5iIE043jU1ebmInnj8acUzF/kHFAP41x3kwHJKE=;
 b=NeswKQKS8VMLxko7YgJzgssLL/iE8LYbRQ+YGaDLBhnhEdl2fpt2Jinws4hr8w/RlbBkIh
 qSsNe0qHtnt/5qRhy4kaiBkLAEnQDhLkYyP4sTnHlK86BeJv8CiQoXLB0aJvmJtUjBPI8L
 pekCiFFpx9zQu76HQhH1DjyC5YdMvUA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-JuR_qi7uPQ-xss5gYrAy2A-1; Fri, 03 Nov 2023 06:57:01 -0400
X-MC-Unique: JuR_qi7uPQ-xss5gYrAy2A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32dceab634dso824765f8f.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 03:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699009020; x=1699613820;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RicE5iIE043jU1ebmInnj8acUzF/kHFAP41x3kwHJKE=;
 b=cd3oEZJBibY9qIH7JG6n5w/xVS4sFrkPwg/Du31Hp2mTFCoZqrlXvql/0UmVVfkNkO
 ei3Dk2CgTq01ejmEicI+oFCb2HP+SnEXB3hCEjmb3tkXbV/fCQzBE1pXWh1tMfVtZZ9t
 mJPCC5b5K/qxJX/hN/SWSFZ8Ft6T7HLcccy5QDkCI/E0j+RFBh6QsjwkzmJvfAxkZi1m
 RYunSOfhczyoqzKTJ2/Kg8OHbNeQsNPcVM8ftgMhCUuSAgq9OtDkINFbLXID6PAmbftG
 K2dKSBbSeG8iWs4yn5q3KAKCEIIj73ZvLSBZArScd17p2Bl0/BiHl7eXqarOCM+pnMYV
 +KcQ==
X-Gm-Message-State: AOJu0YzKMKVx/+5b+6XsZzCbaZ+/B37uGrZIqyay2ogNZ6zVbiiZtV8h
 xeX+KQxM9cbTCYrLsMbm0LOuP3T6eafXDtKKyQwMR5N2ws6LWqB83PvmzfGfhGg+JRCdZDGVgQw
 G/S9TZW0YzlWM0q0=
X-Received: by 2002:adf:d1e3:0:b0:32f:7cb7:f66 with SMTP id
 g3-20020adfd1e3000000b0032f7cb70f66mr18478812wrd.20.1699009020397; 
 Fri, 03 Nov 2023 03:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP6N7aK4EuPHrJKe3mKJ42sNzeDCuAUVgIhT6IvEu5QieIBYVUQOUeH+auO5DBHz0l87fLdw==
X-Received: by 2002:adf:d1e3:0:b0:32f:7cb7:f66 with SMTP id
 g3-20020adfd1e3000000b0032f7cb70f66mr18478797wrd.20.1699009020051; 
 Fri, 03 Nov 2023 03:57:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a5d56cd000000b0030647449730sm1560722wrw.74.2023.11.03.03.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 03:56:59 -0700 (PDT)
Message-ID: <5a481c02-d9ef-4c46-bee1-f17dbd387545@redhat.com>
Date: Fri, 3 Nov 2023 11:56:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Any plans to implement more ARM SMMUv3 features?
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Kunkun Jiang <jiangkunkun@huawei.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Simon Veith <sveith@amazon.de>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joe Komlodi <joe.komlodi@xilinx.com>,
 Prem Mallappa <prem.mallappa@broadcom.com>,
 Leonardo Garcia <leonardo.garcia@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Nicolin Chen <nicolinc@nvidia.com>
References: <87il6n0zlw.fsf@draig.linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87il6n0zlw.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Alex,

On 10/31/23 13:02, Alex Bennée wrote:
> Hi All,
>
> Since 8.1 we enabled the FEAT_RME CPU feature to allow for Arm CCA
> guests to be run under QEMU's Arm emulation. While this is enough for
> pure software guests eventually we would want to support modelling
> systems with "real" hardware. One part of that is updating the SMMU
> emulation to make it RME aware.
>
> The recently published F.a spec is available on the Arm site:
>
>   https://developer.arm.com/documentation/ihi0070/latest/
>
> As we have a keen interest on tracking (and implementing!) Arm features
> we have coded up the various sub-features as stories under an EPIC for
> each level of SMMU feature on our public JIRA:
>
>   https://linaro.atlassian.net/browse/QEMU-533 (SMMUv3.0)
>   https://linaro.atlassian.net/browse/QEMU-553 (SMMUv3.1)
>   https://linaro.atlassian.net/browse/QEMU-558 (SMMUv3.2)
>   https://linaro.atlassian.net/browse/QEMU-566 (SMMUv3.3)
>   
> I think the state of the cards currently represents what has been
> implemented and what is left to do. As you can see it adds up to a fair
> bit of stuff. As a lot of people have been hacking on the SMMU code over
> the last few years I thought it would be useful to reach out and see who
> else is interested in further enhancing the SMMU emulation support?
>
> If anyone has any patches/branches cooking or is intending to implement
> any particular bits please do let me know and I can update the cards to
> reflect the current state of work. As ever we will do our best to help
> review and smooth the up-streaming process for all Arm related feature
> enhancements.

At the moment I have no plan to work on any of those features besides
following "Nested Translation Support for SMMUv3" works ([PATCH v2
00/17] Add Nested Translation Support for SMMUv3
<https://lore.kernel.org/all/cover.1683688960.git.nicolinc@nvidia.com/#r>).
Adding Nicolin in CC by the way.

However I will take some cycles to review patches when they come.

Thanks

Eric
>
> Thanks,
>


