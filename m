Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C7F80E5AF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 09:19:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCxyR-00020T-PX; Tue, 12 Dec 2023 03:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCxyP-000204-5X
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 03:18:37 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCxyN-00079n-Fa
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 03:18:36 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d319a7a35bso16774415ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 00:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702369114; x=1702973914;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1T95QWqyyB3QrSdcTdS83OdNBFUN2mcUfmPVVpeEvD8=;
 b=DAstxVOmF87RaaHsfnHXMECjmuPn5IXkbqtBUtN7bICMvI53+0PORDEDX9Vic91Xys
 nEPiHBdguCZnxTvp3kI3ieGX5hhjGYeZto1r8ayWwr3sV+Fc1vjBL35P7/6hulqLViVG
 R4ZXrjArKMJvfhclEC195yiL1SuWGxbHtJPxJ+A/H1MRNUub2d4ww7vOXY+CzdrTguxl
 yzxxfPA0TwD1tHUZjfwHIRQV0q1whjd6DmtLsxiDpl41LjjEVrFxpYQtXFmt5Nz+3eiI
 y/mnIWsbQY0E1OwV0cAfCMYUt7RuGJY/WYwh70C+23Me5XCrKyOuPm97afqXiCPFKOAU
 D+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702369114; x=1702973914;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1T95QWqyyB3QrSdcTdS83OdNBFUN2mcUfmPVVpeEvD8=;
 b=QwyuYZ6QQ/wjs0nScLwqAL+Hr6UUoezDlNF5TGPWqU7XtW2TR49swF/3yL7+POVmjL
 REtoTRf+0BkerUq/Xm/ukzgbKR6i10pUEwZZwTWoHt0Yw3pxZxuYG1cAoNYhzzK0fvy2
 IElDbriEb2Q4Edbbl9wTNPXz5XltNk8yzcIMJkST6xexW5P9M0jUSN4YU3FG4mI9Ua42
 PUnWkEugjMcZkG26b8BDmc3AYwHMMgvmCVvD3SD4OhOGJtlm1z5dUIA+AtQ9znbCMm5q
 Z7JTF3E0gBqOrNBQ9LNixX4g9kQtGfEHxdnMSLz8jPPo6CcSHaQpMyBr3bavDXrHVIEw
 Y9AQ==
X-Gm-Message-State: AOJu0Ywb/QDOFXciNuDyOu0LY4GjGp+jEqtYGPykWvKENCvj+P8/Ah2d
 to0hD722h2/4wk+N+4i/9UIq/w==
X-Google-Smtp-Source: AGHT+IECl1GgbPZCq4cTTUNez9QilmNaeqnLGkNCJnpE9EtezYZ99xe6htdNeSY+PPh4Uk+g8xR7bg==
X-Received: by 2002:a17:902:b683:b0:1d0:6ffd:9e25 with SMTP id
 c3-20020a170902b68300b001d06ffd9e25mr5670806pls.119.1702369113973; 
 Tue, 12 Dec 2023 00:18:33 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a17090332c900b001d07b659f91sm7986764plr.6.2023.12.12.00.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 00:18:33 -0800 (PST)
Message-ID: <947ad8b2-14fe-456b-b914-6e1c86dc27e4@daynix.com>
Date: Tue, 12 Dec 2023 17:18:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] tests/avocado/intel_iommu.py: increase timeout
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Eric Auger <eric.auger@redhat.com>
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-4-crosa@redhat.com> <8734w8fzbc.fsf@draig.linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8734w8fzbc.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/12 2:01, Alex Bennée wrote:
> Cleber Rosa <crosa@redhat.com> writes:
> 
>> Based on many runs, the average run time for these 4 tests is around
>> 250 seconds, with 320 seconds being the ceiling.  In any way, the
>> default 120 seconds timeout is inappropriate in my experience.
> 
> I would rather see these tests updated to fix:
> 
>   - Don't use such an old Fedora 31 image
>   - Avoid updating image packages (when will RH stop serving them?)
>   - The "test" is a fairly basic check of dmesg/sysfs output
> 
> I think building a buildroot image with the tools pre-installed (with
> perhaps more testing) would be a better use of our limited test time.

That's what tests/avocado/netdev-ethtool.py does, but I don't like it 
much because building a buildroot image takes long and results in a 
somewhat big binary blob.

I rather prefer to have some script that runs mkosi[1] to make an image; 
it downloads packages from distributor so it will take much less than 
using buildroot. The CI system can run the script and cache the image.

[1] https://github.com/systemd/mkosi

