Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B720E80D1CA
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 17:31:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCjAi-000317-GK; Mon, 11 Dec 2023 11:30:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCjAa-00030e-8G
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:30:13 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCjAY-0000qB-Dr
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:30:12 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33349b3f99aso4312997f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 08:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702312208; x=1702917008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lgQR+tJfnuE8VGMsbC6FBzjJNNEawrH+S2egV7A6WNM=;
 b=szddRfVXv0325wPb1sbRVgqis41B59emc+a8ZxSeLaXRJUwq2bPZIO1/ENNrHEzfRD
 cmeqD/4RSfjsBODI0JIIBkG7oDvPYJ9G+XfcBbajNpUaMHIdL7xdBgCP5ayrKCF7f15W
 W5X2u4CvAx3MZGLQvVYYEv70pFNprULI5ZjJA9sdpqq485e9QaQWAg/2pBva5eB7pc9A
 hslL83BBFdkJ0wJF7RHYouswGp4D2dZCOfDn8ark4FtajZn682xbqqt4kCBqeHwAAJGZ
 tmhWYKRF8c8VtVaDlRglvmLqaRN0rSJ38FjTMP26+cIhCHYfo976PLCQBpw7L3ptcaPu
 3GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702312208; x=1702917008;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lgQR+tJfnuE8VGMsbC6FBzjJNNEawrH+S2egV7A6WNM=;
 b=Go5ao8yRjoFMkBCooXGfgVVAxmYWc3O6e/z2Qr9jkm6xPxYEu5NVpbjXQ1k3UnpwAR
 L3rAS0PdbvRDwPy28uxJxungLFCSeCAMmV7zq/G8KZcjHEaRFbPE4bmk63jv7JihRj/X
 aguJJGvVsIheO9M9jxJxGVl5VKp0VvU9cazOngYdLLWtz+/MwGxz8kVXFXMLGXZv00Yr
 uhq8/MUOzPXyublHkCJ0II3/IEJmfbXz755Ct2v8fkXPyS7g6UptugubJvttHy27h2fA
 UBXlOrPFtR8z7Aps9VU4SM5Kdd1uawRd5+liokGhPFqGueCs27T59R7urc2Xk3C+bvLC
 K+XA==
X-Gm-Message-State: AOJu0YyQBGtxCjgn2i4g4YOhYXCQi9fvVdUruR1r2UPpkZkNNrW4zah0
 w4I2mxGOA+I6EKB39OK9mizr9g==
X-Google-Smtp-Source: AGHT+IFF9z/AOavNKv+0kQtxOnDAqtkj0yCuOY2JfT0TH7m9BaUGBEvIuEABRk5HwMgaIUjH3vYADw==
X-Received: by 2002:a5d:6685:0:b0:333:2fd2:51e5 with SMTP id
 l5-20020a5d6685000000b003332fd251e5mr2649904wru.94.1702312208133; 
 Mon, 11 Dec 2023 08:30:08 -0800 (PST)
Received: from [192.168.69.100] (cor91-h02-176-184-30-150.dsl.sta.abo.bbox.fr.
 [176.184.30.150]) by smtp.gmail.com with ESMTPSA id
 w7-20020a5d6807000000b0033334625bdbsm8962950wru.13.2023.12.11.08.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 08:30:07 -0800 (PST)
Message-ID: <bfa79c34-629b-474d-ba38-d73af157e25c@linaro.org>
Date: Mon, 11 Dec 2023 17:30:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] tests/avocado: use more distinct names for assets
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
 <20231208190911.102879-6-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231208190911.102879-6-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
> Avocado's asset system will deposit files in a cache organized either
> by their original location (the URI) or by their names.  Because the
> cache (and the "by_name" sub directory) is common across tests, it's a
> good idea to make these names as distinct as possible.
> 
> This avoid name clashes, which makes future Avocado runs to attempt to
> redownload the assets with the same name, but from the different
> locations they actually are from.  This causes cache misses, extra
> downloads, and possibly canceled tests.

Could it be clever to use the content hash for asset location?

> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/avocado/kvm_xen_guest.py  | 3 ++-
>   tests/avocado/netdev-ethtool.py | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)


