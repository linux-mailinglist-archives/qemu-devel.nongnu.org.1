Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DBA80AD7F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 21:04:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBh4K-0008D0-Bs; Fri, 08 Dec 2023 15:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rBh4I-0008CQ-3e
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 15:03:26 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rBh4G-0003ed-HO
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 15:03:25 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-54dcfca54e0so2946368a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 12:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702065802; x=1702670602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YwnbFYwpV3LUVIj6IokP8OukY70Ms4xhebL0+HoyxDw=;
 b=nSAOI8FW4rmN79ah5hRD2ZPHStoZzv/AuTCWd72yNLjkLBdx01hKVHR8OWWBpHYiAm
 2g3I0ZHjVeX+1S1xs+sXwKbsp08wWW5YPg3KlowsoRn67r56r2xR+ZkpQIkGzCkMN9Io
 gyyJ0s/khXIBFn34P+VIuKg1FDH7MO0I1Cojj8fBIOVkUIG0CA8W5P80eitLVAv7KQk3
 XHfWzWNqAMGegB2/BPJ3YlKaZZFHiVP5tt59GupzfhJLLEuV8Yihy+Pvo6Vb5wIDPBOy
 ktrTzIeAnx5r4zm+d6AjOP9IgeIgLicz524nrUmZZJP7Y/ZgUscRuziiS/jGfoapKch7
 anyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702065802; x=1702670602;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YwnbFYwpV3LUVIj6IokP8OukY70Ms4xhebL0+HoyxDw=;
 b=BRFaUpZZMw6aaRhuDDUFGWLEwKEabkL/LTBTXHVVFuFXtz0n38W3uQTq5Aw4HAUsIZ
 7n7mOoeuJXgedy+6NXEd+OIuFihIUp1MIN0uUvA46FDY1OmmlwA1tYtgcQLruzNITH8g
 J/AdXRZP+ZKQl2Gk6tmUjjNX4GM1Q9KmryaYYFfqmQlEz/Y2ST1RkNr2/hCTV+beX7ek
 S3U8jGnxd6b4APIWhXpV/BEy/VlRuoK9V/Y/7Sqir51QTCWi0y6W9m6LeWIrs+x8Oj7i
 db4PuBKqEmE9XmubQHHSSXMkPdb8TyVX3gr4+ABwNkmMShgHrhYQZXtyRvAG90tYCBLZ
 A6ZA==
X-Gm-Message-State: AOJu0YzJReZz2kSysCu4UssMauPYSm81fFd3AHLX57Gh7kM2TIwk38GZ
 8sb4oGQuCoECPhvV/+S/wVgipw==
X-Google-Smtp-Source: AGHT+IHiBMv5Qcs8uwg/olNKskwGDaAfdVabppOUwYMzz64eFH3pWfXjLgRZqoQpcDstHTtDsCpEAg==
X-Received: by 2002:a05:6402:2313:b0:54c:4837:a640 with SMTP id
 l19-20020a056402231300b0054c4837a640mr416396eda.45.1702065802371; 
 Fri, 08 Dec 2023 12:03:22 -0800 (PST)
Received: from [192.168.200.206] (83.21.112.88.ipv4.supernova.orange.pl.
 [83.21.112.88]) by smtp.gmail.com with ESMTPSA id
 a4-20020a509e84000000b0054ccc3b2109sm1087187edf.57.2023.12.08.12.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 12:03:21 -0800 (PST)
Message-ID: <2972842d-e4bf-49eb-9d72-01b8049f18bf@linaro.org>
Date: Fri, 8 Dec 2023 21:03:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] tests/avocado: machine aarch64: standardize
 location and RO/RW access
Content-Language: pl-PL, en-GB, en-HK
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 David Woodhouse <dwmw2@infradead.org>
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-5-crosa@redhat.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20231208190911.102879-5-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x536.google.com
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

W dniu 8.12.2023 o 20:09, Cleber Rosa pisze:
> The tests under machine_aarch64_virt.py do not need read-write access
> to the ISOs.  The ones under machine_aarch64_sbsaref.py, on the other
> hand, will need read-write access, so let's give each test an unique
> file.
> 
> And while at it, let's use a single code style and hash for the ISO
> url.
> 
> Signed-off-by: Cleber Rosa<crosa@redhat.com>

It is ISO file, so sbsa-ref tests should be fine with readonly as well.

Nothing gets installed so nothing is written. We only test does boot works.

