Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF9180D1D4
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 17:32:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCjCa-0003pv-UG; Mon, 11 Dec 2023 11:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCjCZ-0003pM-Nh
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:32:15 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCjCY-00016T-0j
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:32:15 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c2d50bfbfso21890755e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 08:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702312332; x=1702917132; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZC/Ru++AKfDAVSthl0Gn/YW8p3YyY3iWJ4FjPBiS+m4=;
 b=FDaeOozeoQD+rfAf7zqbqH68L7ZzJRyoeIP82Ak5VpHtrEcLwK2ChNEVNFnn75g7IC
 /ik6P6Kc0FMjClrIaNCL7ZBIY/HyYZIz1766RZ1jKQ0PxgRVCT1QjE0koPtkgzAMGZ19
 iR6YyDZNJ8q7z7ssULCyCFiM8Kn7cPovBSJaUl8wyjRpYdwzE3LuzYh/vEsUsWLHvETF
 9adawrY4241PIrUQAsXNWMYfvUgYtuf+UQyhgzf2iOoYXIdnuSbqkutxQShloJPJ72WI
 5mroPdfO+anfh919SPN9Znc60Jm76IG89ax0CkTPwfJ5uqVYj1PkuRp+9LvxtK8lfhCw
 EGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702312332; x=1702917132;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZC/Ru++AKfDAVSthl0Gn/YW8p3YyY3iWJ4FjPBiS+m4=;
 b=f8K7i2c6xjFBT4qnCF8R+fIJHJeh0vD9Mx32OAR+Y+9Qqi/aQLFcQVLIH4gioxWe+x
 SxgSSh3YY6oDrbxev7wVFamBbmuKZKqEuepDnBGMydWAx5CB7BVm68EM5vVncruh4l2H
 MgeiGL6reOisgliEjAiRn0T+e0lhNc4n3vMTKJIHSFMk71vMmA3Zud8kxJ3O78r0G0Cm
 nXYYBUgt/AbMewzM77IRG33srjSl8V5rzy5aCp7tGPr1e/uwFzdSNLVLoVymH6N1ebMA
 bo5YetMhTvFjg8oUvylcF8RN9GAKtMmyBcFEAhC+W3G00DGkVm4cmXiCXtylesUsZI2J
 1gMQ==
X-Gm-Message-State: AOJu0YzNUw20GC4gr3+2Et2tN0pDrJOzWAz9T4cWCV/Q32PjbRPs7DSE
 JfcmWpMOFcjB4NMRxA1A0tzobw==
X-Google-Smtp-Source: AGHT+IHEkecFyJiUoNupMT3GCGJUuJeN3CABNN+TbWlp8hRrybeIODmqtc3ZAp/SDvGTaHa2punOvQ==
X-Received: by 2002:a05:600c:2a41:b0:40b:5e56:7b6a with SMTP id
 x1-20020a05600c2a4100b0040b5e567b6amr2163621wme.179.1702312332190; 
 Mon, 11 Dec 2023 08:32:12 -0800 (PST)
Received: from [192.168.69.100] (cor91-h02-176-184-30-150.dsl.sta.abo.bbox.fr.
 [176.184.30.150]) by smtp.gmail.com with ESMTPSA id
 he10-20020a05600c540a00b0040b3829eb50sm13346844wmb.20.2023.12.11.08.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 08:32:11 -0800 (PST)
Message-ID: <20efca0c-982c-4962-8e0c-ea4959557a5e@linaro.org>
Date: Mon, 11 Dec 2023 17:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] tests/avocado/kvm_xen_guest.py: cope with asset RW
 requirements
Content-Language: en-US
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-7-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231208190911.102879-7-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 8/12/23 20:09, Cleber Rosa wrote:
> Some of these tests actually require the root filesystem image,
> obtained through Avocado's asset feature and kept in a common cache
> location, to be writable.
> 
> This makes a distinction between the tests that actually have this
> requirement and those who don't.  The goal is to be as safe as
> possible, avoiding causing cache misses (because the assets get
> modified and thus need to be dowloaded again) while avoid copying the
> root filesystem backing file whenever possible.

Having cache assets modified is a design issue. We should assume
the cache directory as read-only.

> This also allow these tests to be run in parallel with newer Avocado
> versions.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/avocado/kvm_xen_guest.py | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)


