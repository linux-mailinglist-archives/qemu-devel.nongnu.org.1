Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEA67CA9CB
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:39:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsNnZ-0005bl-OD; Mon, 16 Oct 2023 09:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsNnX-0005bN-Fw
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:38:19 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsNnS-00022N-CS
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:38:19 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9adca291f99so704535866b.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 06:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697463492; x=1698068292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JPAWYrw8wf1TjNLVSnWYNs45JloOe4OwbVNO3aD/7lI=;
 b=Xe3JAVjZqJoBVdrcWWk2u9dBMvQ6komv3dVhns61Fg7i3JJ3zmsYesexV6cTF+BDBk
 yhLnI2I9496WAEJ4NrNlXsGtwVy3Efa9Q4VBq6HvWmBz28pVuaJkin51LJbJV6MRffC0
 hXgdVP6l7+GomMj3wWMi10UixJJ5JCDjnj47vowaJo1JA3N3QJhuESVqavkSOWbuGAVY
 j9xYqApl2fsO6gI3tUNUvY7M3VdCOMaKx3khv9p2Ab0u25C5BsPUymS0C/PEL7Qof5gi
 IHFcuZW+dgGMSjQrMmufCG2rVdrCo5uwbiAaYVpe4AHAYUlUUHc83HgIRjt/wibWS4E5
 W+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697463492; x=1698068292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JPAWYrw8wf1TjNLVSnWYNs45JloOe4OwbVNO3aD/7lI=;
 b=EqtzwAXHyokTwS7PaiJYj0cicdkjzHJjR+uX2knkvctVwf5pkMxBRAm0eB9VHbMx8k
 1MKHR+8DKL3Ifkg4suiLDi8cGo1p41FjUdbhwkR7UOGnpu2SjJe9tSD4ZGw7CDAlv0Jl
 fC9sdmAT4LImGNyT5zwNcItxv9vhzng9PW6vVym4HV6XVoqrdhq85OsW0ICDKNQlNL4d
 XTbw2fnFz5c4BO3pZvN4AG8Aurbn71oxJ7tY90N/f+zgrOgGAIjOtiCvWvK60PK0bl+d
 ueQFXCKUgp6bEOoLK2g7BX4MbYSoN5xmxs0uP1Kp/Skp+vl2ruFw6c+rkM7HOo3eiSfq
 HwJQ==
X-Gm-Message-State: AOJu0Yw5JmZZARuNRL/YSJu0PgM1alEU8d7mmKIj8hXYWQyJmQdSCxq1
 u4T5HNDY34SUlvgx+g5awoZbYg==
X-Google-Smtp-Source: AGHT+IHuXGFtDpAC+s8Psept7dldK/tKE1Z/BgZTBh6eHaQVaXF0p0A09tStH0dMhwe7xyj6aTfoxg==
X-Received: by 2002:a17:907:7205:b0:9c4:d19:4a64 with SMTP id
 dr5-20020a170907720500b009c40d194a64mr2612863ejc.25.1697463492599; 
 Mon, 16 Oct 2023 06:38:12 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-186.dsl.sta.abo.bbox.fr. [176.171.211.186])
 by smtp.gmail.com with ESMTPSA id
 jl25-20020a17090775d900b00992e265495csm4048740ejc.212.2023.10.16.06.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 06:38:12 -0700 (PDT)
Message-ID: <0184aa1d-bca7-d174-9a1a-2a5496f13e39@linaro.org>
Date: Mon, 16 Oct 2023 15:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 1/9] Add Rust SEV library as subproject
Content-Language: en-US
To: Tyler Fanelli <tfanelli@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, marcandre.lureau@gmail.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Mike Frysinger <vapier@gentoo.org>, WANG Xuerui <xen0n@gentoo.org>,
 =?UTF-8?Q?Andreas_K=2e_H=c3=bcttel?= <dilfridge@gentoo.org>,
 Sergei Trofimovich <slyfox@gentoo.org>, YunQiang Su <syq@debian.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-discuss <qemu-discuss@nongnu.org>,
 Joelle van Dyne <j@getutm.app>, Stefan Weil <sw@weilnetz.de>
References: <20231004203418.56508-1-tfanelli@redhat.com>
 <20231004203418.56508-2-tfanelli@redhat.com>
 <20231005155448.GA1342722@fedora>
 <bdca3b98-7c22-4732-adfc-dc51c93c5eca@redhat.com>
 <CAAjaMXZb1Les+5Q2uhtpm1dgCm11qfs=Rfcq-6dUvQJj2+HQ3w@mail.gmail.com>
 <60c1bcc0-9b96-4c37-afee-484ffbe40431@redhat.com>
 <ZSz/dxLsHPt2+2XN@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZSz/dxLsHPt2+2XN@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 16/10/23 11:16, Daniel P. Berrangé wrote:
> On Fri, Oct 13, 2023 at 02:20:16PM -0400, Tyler Fanelli wrote:
>> Hi Manos,
>>
>> Thanks for the heads up, I was using rust 1.71.1. Will update the series
>> with 1.72.1
>>
>> Stefan, Philippe, or Daniel: is there a specific policy for the Rust version
>> we should be developing on for crates in qemu?
> 
> There are a couple of dimensions to this.
> 
> First is the matter of what operating system and architecture pairs are
> supported as targets for the Rust toolchain, and the standard library.
> We'll need both to work of course.
> 
> Second there is the matter of what versions of Rust are shipped in the
> various operating systems currently.
> 
> In a previous discussion there was a wiki page fleshed out with this
> info:
> 
>     https://wiki.qemu.org/RustInQemu
> 
> but the min versions are certainly out of date now.
> 
> Third there is the question of whether distros have facility for pulling
> in newer toolchain versions, and if so should we be willing to use them.
> This is relevant for the long life distros like RHEL, which might ship
> with a variety of Rust versions. Historically we've been very conservative
> but with Python last year we adopted a more aggressive policy of being
> willing to take any newer version available from the distro vendor, not
> merely the oldest baseline. I suspect we'll want a similar approach with
> rust.

Cc'ing distrib package maintainers to have their feedback on this.

> Anyhow, I think you could probably start by updatnig that RustInQemu
> wiki page so that it reflects the current state of the world in terms
> of support tiers and versions.


