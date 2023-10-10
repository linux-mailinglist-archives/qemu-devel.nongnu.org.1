Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 016867BF521
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:59:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7eW-0006ti-74; Tue, 10 Oct 2023 03:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7eU-0006s9-FC
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:59:38 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7eS-0006vq-V8
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:59:38 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-533d6a8d6b6so9490068a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 00:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696924775; x=1697529575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1EwwaCwTkFO/gl5ZqfujaRctr3JXiNWgrGlPq3RQy0M=;
 b=pI5t675mWp0ICE++5NwBSo4jrVKzYw7yflP1v+cvZN5PCN3OZ6SRXMoXW02XLZoIkZ
 ZSqd1R7ZUd+i692cAQCD5mA2767oYSQlMZhT1QXPpkC/45RorrhhREuP42GceDMFr2XY
 x4D/ZPNk3vy526Dghbc5mheEJkp+UQGadp6b4vBd1hBGFQ0O5E+srS1JlbOlffOzppoj
 5IdlUhgSYEaJ+CASzfHy2y9BseuV/jKrDAoyWNasdg0x84xGyC5nQDvMArvzVRhEskH0
 ZriEfSrZ6ofEAU4/A4iPUblO1pgiZlWGb45TRvtDcTn++jM3IMGRGa9LZgeBXngYcyU7
 R2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924775; x=1697529575;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1EwwaCwTkFO/gl5ZqfujaRctr3JXiNWgrGlPq3RQy0M=;
 b=kQho/KvpitFRpWGriAkcxkKx7udNK/HF8tbyRUoFEjuaSafgalHjip0YI3cQBh1+5B
 prfgORdfH6S1fdutexUqZyXlsoZXxNhBoO3wZp0GfHNv3JbhoR1M44QSBCi0+WwJCvos
 bGqvxeoWlVf+/J+TAJUCkbbNT3RlYJdgWJQ+NHaLOEXRSumduE45mQvD8uiTPhcd0OjF
 exhhoIKmkumciSCyBrttNcK0/TWHuCd0nLUyPCbn8JOalbn6VKsdUAaqJnLFt81fhoQ5
 gXEZqTLWV61cjdvUIDWvWZZM4am1K0RtlBYhDh8eZeUcBb47UTvnCCaFt5Ofu4+lT7XS
 FwrA==
X-Gm-Message-State: AOJu0YyR9jZ9T8RhK6sqdEZK2GOTvJuF5mPlkQ6ApxfcaKBUavnvn7pU
 AX5CllR0E7H+ugHA3PRCNVmL9Q==
X-Google-Smtp-Source: AGHT+IGwSaiYGDRR8vTZW6um7xbOwpoiEZJrWE/6jc1r/xYIOLYEB9k8pGPGJ4KtNAnBnG57IQhcaA==
X-Received: by 2002:a17:906:7389:b0:9ae:406c:3420 with SMTP id
 f9-20020a170906738900b009ae406c3420mr14578852ejl.30.1696924775526; 
 Tue, 10 Oct 2023 00:59:35 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a170906c40e00b009920a690cd9sm8005600ejz.59.2023.10.10.00.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 00:59:35 -0700 (PDT)
Message-ID: <c0ecdfbf-f471-edec-ebfe-290158f00a9c@linaro.org>
Date: Tue, 10 Oct 2023 09:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 00/11] ppc: avocado test additions and new defaults
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
References: <20231010075238.95646-1-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231010075238.95646-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/10/23 09:52, Nicholas Piggin wrote:
> Sorry for going missing for a while, had a few things on but have
> been working on figuring out testing and git setup to get some
> things merged.
> 
> To start with I'd like to add a few more tests. Since most of my
> own tests for missing bits (like KVM backend) are mostly just
> ad hoc scripts, I thought adding them to avocado is a better idea.
> Comments on those in particular from CI gurus would be welcome,
> 
> patch 4, because it boots a Alpine distro image and installs a
> QEMU package via its package manager.
> 
> patch 5, because it grabs some Linux kernel images I put up on
> another gitlab page.
> 
> patch 6, because it adds a FreeBSD boot test.
> 
> patch 7/8, because they add tests for non-public images (flames
> welcome).

IANAL but I don't see license infringement, so personally I'm in
favor of these tests.

> Thanks,
> Nick


