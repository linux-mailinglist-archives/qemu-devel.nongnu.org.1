Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 190A580D230
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 17:39:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCjJ7-0006Sf-Nn; Mon, 11 Dec 2023 11:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCjIR-0006Iw-Ef
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:38:22 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCjIM-00029c-Qa
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:38:19 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-54f4f7d082cso4705241a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 08:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702312692; x=1702917492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h+dVE4T5CJKL2zc1mU/JUkrygd/A6khW5COf8KfD0PM=;
 b=W9v2xCmdWnjvmWWkQsdKxFtmSHulx9L11tTuvQ8IWtfaXCjLuJL+ko7DJavNdcuoGx
 j9RdkWQSgzKFQlsHW+2IWoAvp8r2HTf3nVv+CRMmVVrSd4/Eon4RnMaWEoVlGamLge5b
 nxuhU9U9m8NKwFTgKgp9vdnZiodisLVlAk/0jDBixZQ3ChQ2paCe8cygBq0sH0PiLD5y
 FiAcgFt4/fxiIuNqVQ4BkRv5nObQSl9Bg6FAQw22GWoFfLoxHOM+T5hQLZkEpEiBTRQG
 EekceNcOG18qxi24TVHadSugkevKxju4yOlVDrblqb3fAExRSlOli8g2ZIaYF7y+NIL8
 RCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702312692; x=1702917492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h+dVE4T5CJKL2zc1mU/JUkrygd/A6khW5COf8KfD0PM=;
 b=m3i81d6O+b7P9oOp/uXrqGd5hUkQ2Zdv0wu0rHjAhcfw+NpNzEPuZGcUt0BPF8GY+6
 6ulSTItkCOAA0fzT7rSLQryaMFdqeIs3ja6bxi1oxqlIVH+/NrhVsAOxD97VhnR8RyF/
 IZ7f5jn9WwM+suLZ0IcWfna9ZVtAHtxEkGRHgSjQvrrfOKPy16BAF584Yqfvt5FircFL
 Bqz9dFyeQhcd+FiaOBHQ3zvMFc/OUFI3Mw9GvJbwtof6+kLkfheHWkzueqXTB/fnVKU0
 kiTqUGbgvEOxDALtmvPajEJvDR9hrXrFsIC/6H8n5IVU+0ecGxInYNWZVdX1cASQVmaz
 GIag==
X-Gm-Message-State: AOJu0Yxb7Xq6d/0Ple9YIjzpFK1mHycBN4hfmEheTY0T3hEp+Fu+al2u
 wQSSAjf0qpGb/sFFhxyakG/2FQ==
X-Google-Smtp-Source: AGHT+IEQ8W9Vm2+c85+H62mp9eZzxAoWOI3l+4PtdLhvJbr135OX6k8KiDy5Xcu45FvNSYJ8/sDKag==
X-Received: by 2002:a17:907:350e:b0:a1f:705b:3de7 with SMTP id
 zz14-20020a170907350e00b00a1f705b3de7mr2260838ejb.140.1702312692455; 
 Mon, 11 Dec 2023 08:38:12 -0800 (PST)
Received: from [192.168.69.100] (cor91-h02-176-184-30-150.dsl.sta.abo.bbox.fr.
 [176.184.30.150]) by smtp.gmail.com with ESMTPSA id
 rd12-20020a170907a28c00b00a097c5162b0sm4995159ejc.87.2023.12.11.08.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 08:38:12 -0800 (PST)
Message-ID: <f3b4c270-c03f-44c3-b868-3c68efadc37c@linaro.org>
Date: Mon, 11 Dec 2023 17:38:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] tests/avocado/boot_xen.py: use class attribute
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
 <20231208190911.102879-11-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231208190911.102879-11-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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
> Rather than defining a single use variable, let's just use the class
> attribute directly.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/avocado/boot_xen.py | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


