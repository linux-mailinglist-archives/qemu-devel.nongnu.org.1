Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE457AB291
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 15:14:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjfxo-00048n-EK; Fri, 22 Sep 2023 09:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjfxm-00048Z-5M
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:12:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjfxk-0003q9-E7
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:12:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-405361bba99so16703645e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695388370; x=1695993170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MUOIKBUB4c3+iZVb9Uxr+PtbJJdynO5hs/C8XB6GJSU=;
 b=kpaBazQ4nojH8RHTo0oiCrbpjsEGsFNN3yQHHFFlHHlFgerZ5FQwdJ4iEImjaPzsDd
 gRYtG2bmlLpUQAPC2t2lxEVdy4scL5C1k9iYJQROi2wdeI1x/8g0OHdRXq8v+E3yNkZu
 3tkwokfnKTYyFtVokWRx+701YsoCEoRouGxWrVdYF3u0tuEKUCuvkS1/XaIrNOYFEOGE
 VTuuh51j3eR4CRayw8xU5E+DZFfK/qn5RqWRovOrZmMvKa5m2JOOj5PaNOrmuSLpUxYd
 ubVz9R1BxhFv75+Ehwlnrbs4KluP7y14cUJGuM9vyT8xHTW5jMFXNR9WL3DXA3XDr1lm
 G30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695388370; x=1695993170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MUOIKBUB4c3+iZVb9Uxr+PtbJJdynO5hs/C8XB6GJSU=;
 b=H17hkRTxvzxs1chhKQ84Rq10WjdGF+24pCOK+XJkfZFCIKI49mhig9xnzJyaVtNaxX
 jCbqxyzT31Xn5KhvOCX5rO3X9hzxi315OUp9sM0ktN1rAnWxPpVRF4dv9D64lquPNnsG
 /2E8O4BfBowZhBwF3Qi0wLwa7FVIclmuTHPoyxbnu+bhj6YAOQzJPf0w5dGk3OHjXGIC
 dKt7CwXCgeftF2iiw+KVtwUauK5Pam6CE8kMlJCIiXRn+EF1F7fv1QDX32Vw6us7sE5A
 AVxSUo9sIlVY7I7ccL4xIRWz/ArBUu0kZ7/TNwnhP2RALzTQIZKl3Okpd9CO+Wm3HFr9
 25gA==
X-Gm-Message-State: AOJu0YzBXPxIyfChZnCE2TIVYIRwu4SlqVavFDthWG9TRyZqtj7soGrE
 /Xj16QP4nyt/Ain7ms40NjeR0C/FLt09rLoNNpXpzA==
X-Google-Smtp-Source: AGHT+IGS61Glo0Vt2OIHy4uDhT5RDzZISHfi44vZTIAyHBYL43m59ucA1vTjIOKX9KqS5yyO7qhONQ==
X-Received: by 2002:a05:600c:4f50:b0:405:3d83:2b76 with SMTP id
 m16-20020a05600c4f5000b004053d832b76mr1824897wmq.13.1695388370491; 
 Fri, 22 Sep 2023 06:12:50 -0700 (PDT)
Received: from [192.168.211.175] ([77.205.47.127])
 by smtp.gmail.com with ESMTPSA id
 23-20020a05600c229700b00403b63e87f2sm4657582wmf.32.2023.09.22.06.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 06:12:50 -0700 (PDT)
Message-ID: <6875fff1-fda9-5bab-2356-406193c2bb5a@linaro.org>
Date: Fri, 22 Sep 2023 13:17:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 8/9] audio: Make AUD_register_card fallible and require
 audiodev=
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mkletzan@redhat.com
References: <20230922094459.265509-1-pbonzini@redhat.com>
 <20230922094459.265509-9-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922094459.265509-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 22/9/23 11:44, Paolo Bonzini wrote:
> From: Martin Kletzander <mkletzan@redhat.com>
> 
> Now that all callers support error reporting with errp and all machine-default
> devices use an explicit audiodev, this can be changed.  To make the detection
> easier make AUD_register_card() return false on error.
> 
> Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   audio/audio.c        | 7 +++++--
>   audio/audio.h        | 2 +-
>   hw/arm/omap2.c       | 2 +-
>   hw/audio/ac97.c      | 6 +++++-
>   hw/audio/adlib.c     | 6 ++++--
>   hw/audio/cs4231a.c   | 6 ++++--
>   hw/audio/es1370.c    | 5 ++++-
>   hw/audio/gus.c       | 6 ++++--
>   hw/audio/hda-codec.c | 5 ++++-
>   hw/audio/lm4549.c    | 8 +++++---
>   hw/audio/pcspk.c     | 4 +---
>   hw/audio/sb16.c      | 6 ++++--
>   hw/audio/via-ac97.c  | 6 ++++--
>   hw/audio/wm8750.c    | 5 ++++-
>   hw/display/xlnx_dp.c | 6 ++++--
>   hw/input/tsc210x.c   | 2 +-
>   hw/usb/dev-audio.c   | 5 ++++-
>   17 files changed, 59 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


