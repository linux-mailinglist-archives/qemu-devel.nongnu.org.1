Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C67DF94CCCE
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Aug 2024 11:01:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLUI-00089g-HV; Fri, 09 Aug 2024 05:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scLUD-00081Z-63
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:00:38 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scLU9-0004sM-Pf
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:00:36 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a156557029so2300240a12.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 02:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723194030; x=1723798830; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NmYyzHtVTcDjPEdEVArsEoK0VXoPUGExEsdo4wzUW1I=;
 b=xPIZJWJgXojFRjWIc8OlGwusSL7EwbLDanOthUdh4HLpbGbX98zpVpXpErSqUIooWU
 5+FvCWV0sxMAhNGXDpk8hRYv7ZAUm6CoBDBt6B+n3mxJBJO0utdpVsBnFGauqzQfJyye
 ldq/KEfOaR/3JO9JCt2SQN/wWpOghDFINXM0G6D8CP1G61OWPYHBuGJ1Ug7bynS4SVsU
 fQ6rslzweTDXRBBotu3jK2BJCBt9Pq/GNlc9Q8iLj+50JLEHqt4DULR2jSCI3PSA4VAz
 8byKR0CY7vbnyWAkZdSFEUzRRYwgHxReO8FfRRQwxAWczIUZqTEksMkFizRBcmM9/yhg
 OxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723194030; x=1723798830;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NmYyzHtVTcDjPEdEVArsEoK0VXoPUGExEsdo4wzUW1I=;
 b=LTjvPPdoC3xiunbv9jCL8YqXVWO2D5PpVExBiL1DxQqiKjjO1UzF5JTXJ14rNd3A4u
 OTKv604OyfMW/hQ1nhJR6OpX03wZmgEni7jC4b9nb1+1DZ5TSal1ba58b+bkIi0p+QCH
 0z5f47wbSuOE1D2rqAN/rM0q/I1YCXOYTPWeQVckcZDvdEhpux2RfOmEkgdQG1lDluJP
 7dZt7KkK3xDdipMrE4Wp+0GG5TFSDEo2JaQdXlLkEGKCp2gW4nWpI+nvj6A+E32l9c3X
 SYkuh6BmrxnNuA84oSW1nHxJuPOlVknbS2eN4dBaBy0DWLz/7gLYmv3cCEScV3kuxJdP
 k8jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+VOCRLID5TwDOcaYInUuoGSdOqf5qlf18zuLpT/auQcg4NfmObWoaaQb2GC6Qsd3k5ncNTMIOzo8VesCW4G1v8LOwRxA=
X-Gm-Message-State: AOJu0YwY2ISuVWAJCe1PE1+tuI0hg/cEuYiDxQUJylH0USXrE4KXWQUT
 6AN8phAl7aKoGBsyDqFRmUQTkW1Y3kobv3pt2GAa9ccroN+lJm6VACS7XggQAvG0/23cD49lTds
 T+FMCVqgVa7DwjpJSB+B98nXbkeGx2xDMWE4ptg==
X-Google-Smtp-Source: AGHT+IEcacQw0rTLRKticfxpM9yHIXSPPocRvm32QjBHjkHkc79cCYTYym/+rGoeYWnlw+E2X6PJULbIDW+RHg34Vnw=
X-Received: by 2002:a05:6402:358a:b0:5a4:2c8:abda with SMTP id
 4fb4d7f45d1cf-5bd0a50a533mr680806a12.3.1723194003311; Fri, 09 Aug 2024
 02:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240809035134.699830-1-gshan@redhat.com>
 <20240809035134.699830-4-gshan@redhat.com>
In-Reply-To: <20240809035134.699830-4-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Aug 2024 09:59:52 +0100
Message-ID: <CAFEAcA_bfBNFBeJ-cMS+KACaC6Sw2VAAdg_gb5xn6-TE5C-7nA@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/arm/virt: Use kvm_arch_get_default_type()
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, 
 philmd@linaro.org, richard.henderson@linaro.org, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 9 Aug 2024 at 04:52, Gavin Shan <gshan@redhat.com> wrote:
>
> kvm_arch_get_default_type() and kvm_arm_get_max_vm_ipa_size() are
> interchangeable since the type is equivalent to IPA size (bits)
> with one exception that IPA size (bits) is 40 when the type is zero.

Well, sort of, but they're conceptually different.

kvm_arch_get_default_type() is the API for "give me the value
I need to pass to kvm_ioctl(s, KVM_CREATE_VM, type)"; it's
architecture independent and different architectures do
different things. In the future Arm might need to do something
other than "just pass in the IPA size".

kvm_arm_get_max_vm_ipa_size() does exactly what it says on the
tin: it is an Arm specific function that returns the maximum
supported IPA size.

I would prefer not to conflate the two.

thanks
-- PMM

