Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2757F5DDA
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:30:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r67sy-0005re-Uy; Thu, 23 Nov 2023 06:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r67sw-0005qE-LU
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:28:42 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r67sv-0008KJ-60
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:28:42 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40839652b97so4607505e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 03:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700738919; x=1701343719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UyMuzeKQlkMkiXHA22dh3EGYz2PY3+2bNe87FQxQC9g=;
 b=ZHtj/o4ANX2hfIDtXWZoZ7wnKv9qMIR/pMsmM+MHSHi6yIvkqInIHWQMeiEcVR6gWD
 jLXpw6VqEBU+Wqrm15F/HpPPPoOr3bsV8DU81rzrWOZx0EOgEkzd2DPuroW5yRxDhCte
 4lgjhjPSUsSNQGSU8FbmXvDMIcdLp8gFKtMxGN2M2WaXJv4uBbhyT4ke+ZPvB1fE5fyL
 +5xSvJWNTOARKjvfHfn8rBhHIQQlFcVUYMFpQ1piVnuXgFMdyQ7SxIrXs1IzBn2TVejg
 Iwq8d3E1KA6u5IMyZuh2ZczlS2H5NaXAuNsXVkkYA972xPDuiq0KI/DEDGoVmmGr3hKb
 s/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700738919; x=1701343719;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UyMuzeKQlkMkiXHA22dh3EGYz2PY3+2bNe87FQxQC9g=;
 b=H1MZLKyDx1GzA7wpX9z8hozasveNGnhN+jAM8qMXFb8Y1P64s5qEgNkkzzEiqlKdQl
 vCAnddsqEyx6C0MvtDRA+hukul9pOl7Tz4XdAVN9RVfwY+HVP0/E7DKLrpnGYKD9m/GS
 Zqs4p40mfwDWYSiG77tJ7kn3sW5apuN4I5r4hhTejaFQXdmjdNaDEwxs6llYi3BWzRuY
 6viRfHhrbmyExsB8Cdaxs2OSh906l0evw0UiyaJIqikjC0IuF9ReK3VwpxWF5zdwE1HW
 14djZGxaUE/zPBB+F5bPpphi+/vxbX2UvWEN6Rp0i1pZ3xVecAqZLiESfYPy3VXN+ZBl
 tYHQ==
X-Gm-Message-State: AOJu0YxK7r+HBfQ1pSJBs2zlWAULh/EHKIlEG6bjxZGOSEb1+ZtdHaRe
 mzoPpYV8mTyn8391O6E4TplAAA==
X-Google-Smtp-Source: AGHT+IFTRaoEwj+8UhhxRdmzcC10659Nr9sN3Iq9rvWGs7wFN5fxruySdgwhwPGeEi/i0fL0PvChAw==
X-Received: by 2002:a05:600c:3c85:b0:406:872d:7725 with SMTP id
 bg5-20020a05600c3c8500b00406872d7725mr4238877wmb.1.1700738918874; 
 Thu, 23 Nov 2023 03:28:38 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 t20-20020adfa2d4000000b00332cbece829sm1406297wra.59.2023.11.23.03.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 03:28:38 -0800 (PST)
Message-ID: <77a23a59-1d36-4112-9716-6839a7d0df21@linaro.org>
Date: Thu, 23 Nov 2023 12:28:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386: Rename kvmvapic.c -> vapic.c
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost
 <eduardo@habkost.net>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230905145159.7898-1-philmd@linaro.org>
 <CABgObfbaAhOki7--tdMu-59Sv+k8aCDG0N-vrCGpbwwBj-f45A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfbaAhOki7--tdMu-59Sv+k8aCDG0N-vrCGpbwwBj-f45A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 23/11/23 11:14, Paolo Bonzini wrote:
> 
> 
> Il mar 5 set 2023, 16:52 Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> ha scritto:
> 
>     vAPIC isn't KVM specific, so having its name prefixed 'kvm'
>     is misleading. Rename it simply 'vapic'. Rename the single
>     function prefixed 'kvm'.
> 
>     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org
>     <mailto:philmd@linaro.org>>
>     ---
>     Interestingly there is a strong dependency on (Kconfig) APIC,
>     but I couldn't get a single x86 machine building without the
>     Kconfig 'APIC' key.
> 
> 
> In theory ISAPC could be built without APIC. But it isn't quite there.

Ah I see, I'll keep that in mind.

> You can go ahead and queue it, thanks!

Thanks!

