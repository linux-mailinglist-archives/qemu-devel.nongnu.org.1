Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF137BB2DF
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:14:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qofyJ-0008NN-Ad; Fri, 06 Oct 2023 04:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qofxu-0008E5-Jh
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:13:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qofxs-0004Uq-Ox
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:13:42 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3226cc3e324so1788830f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 01:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696580018; x=1697184818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X2YdOIwzHjAEb0TrEKxq+hBuHjRK5jxNW6RAZL/T6v0=;
 b=tETXs7OREH6rPSiS+tbijQ7swv0l8A4XUQz6K8gnPB1Alm07ZA0aBi40zCOsW5kEGa
 2iekDN7+lVV5YzJCd/qfYe8IM1q75QanBG/Pw+R9i7qPLe/U/FhESjcRJwZuY0CgWowD
 /pV/9uLj7DHD3c3w/SBQruuvAmCoCi1Ki4d+dxLnFRPLrRjiefU9WG8JQxztAJu+TXtx
 WfGYSoQWQQEVWITSq/NOEkr1rIXjg/60nlOVZo6NSHj9GGFoon249njOzFKbZO4iFq8H
 4AKDPJoaczRSntbm1B6UAC2nYahOl/RBwSFvx3rATi0zGCp3aSTwRfoWdJaI55vqIFM0
 +PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696580018; x=1697184818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X2YdOIwzHjAEb0TrEKxq+hBuHjRK5jxNW6RAZL/T6v0=;
 b=svAo48eT8LF5f8nkCLwzt5h/SiWT2GleuJAOKYaPU3m0LCO3WnkSDE11XsENOeE9M4
 WfDPaijCBhXg3YCGX63Sqs3u2FI5C7kPlDMnJqIt8oI93gsJz5/byY5nPSF5eWEsbhGy
 nQ39mMMUksnnUj1hOpcwRkxiBy+X9WdWC4mS8TZ+kOjBs7hSDKejuYEXGrRf4sVN5PsA
 zt7vGwelGyDj6BU6ea6Ya7UiDIJSDDzI0ffwYdmtt9CJXr/6GCv/MVwqgsSQuPD0GVEs
 A16QzXglZkYNWmgAD4BN6Zgo8v/FASelRXhUypuTfjQOnlSoeDjlLGCCkfOa48d0+B4i
 RILA==
X-Gm-Message-State: AOJu0YzYkabrdirZAduOTb+7dHIxFuAB+oTJHSam/xAOK4AIoxmWeBpJ
 IJGv+HRlLU5iMmMF9MjG59DwSQ==
X-Google-Smtp-Source: AGHT+IE4C7xfOsM5BhCaf4MOND2mY4QLIKPAauZ/GwhSy0mhUls/ZrEip+TOcUPHsuWlKCkHjjryFA==
X-Received: by 2002:a5d:4106:0:b0:31a:dc58:cdd9 with SMTP id
 l6-20020a5d4106000000b0031adc58cdd9mr6329478wrp.60.1696580018574; 
 Fri, 06 Oct 2023 01:13:38 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.115.173])
 by smtp.gmail.com with ESMTPSA id
 j16-20020adff010000000b0032008f99216sm1036602wro.96.2023.10.06.01.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 01:13:38 -0700 (PDT)
Message-ID: <a0ea6d7c-1cc8-e233-21e5-b2c844b4f49f@linaro.org>
Date: Fri, 6 Oct 2023 10:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] docs/about: Mark the old pc-i440fx-2.0 - 2.3 machine
 types as deprecated
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20231006075247.403364-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231006075247.403364-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 6/10/23 09:52, Thomas Huth wrote:
> As we've seen in the past, it's useful for deprecating old machine
> types to finally be able to get of legacy code or do other clean-ups
> (see e.g. commit ea985d235b868047 that was used to drop the PCI code in
> the 128k bios binaries to free some precious space in those binaries).
> 
> So let's continue deprecating the oldest pc machine types. QEMU 2.3
> has been released 8 years ago, so that's plenty of time since such
> machine types have been used by default, thus deprecating pc-i440fx-2.0
> up to pc-i440fx-2.3 should be fine nowadays.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/about/deprecated.rst | 8 ++++++++
>   hw/i386/pc_piix.c         | 1 +
>   2 files changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


