Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A1578C787
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaziB-0004Tp-Ch; Tue, 29 Aug 2023 10:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazi9-0004N6-Ag
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:28:53 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazi7-0005pC-6m
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:28:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401bdff4cb4so33494305e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693319330; x=1693924130;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vlzw+Gf1YSNMnPpw1eqXi9uJ3W0Edzbg0Mqhy53cCCA=;
 b=lCgfgSed7NzCXlP4AA0n69zs5SwPkhizv1cYS9A+dGEv99OHCK7uREsRdWa7a4nT89
 6f7LTzNfKZXQUPQPYHqEcVHDEX/RnMstG9G2P0IjsRqQw+7DF+0iVAp4X4z5bQrB2nAe
 JmOHvFCwnDQGyxIN1Gzf1/6D4Afy+qUYyvfHiVoDd/sSY8OaowFLVKzFnsvIc0hYeAeQ
 NBZBDezc5YC38v8qOLRdueIpgJWULF0GguDgJfna+AcgDOHFok3YMBiwJpnWT6nSMTIT
 +B798vnINEBnWUZrJ/8TIm9x8A8ofZbVawet/kV8baU8t+/qWslUPIOeYPw7MjWIwpq6
 Ejrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693319330; x=1693924130;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vlzw+Gf1YSNMnPpw1eqXi9uJ3W0Edzbg0Mqhy53cCCA=;
 b=VbHRend33uM5bJsi/9XnvlKqPfYpRDzlSP0hlzL1g0n6oeHzJBikYkevQxbWuaaeNP
 fApsV88xrKf7LRk/nrh/ev9iD2kER/8KE1ibWgvAPiJxD1LTbcJMrGmTe9vMRle5INlR
 fjFfHHc9AJjnvF5nFQ2m8AL+KU9GpWhokj+hcJRJ6cS/hypJ2ShWp4lJ8tIW2ljO8ani
 dyzYTDocR7N6NH08FMLlPzqDcI8lnx34i6a2x6hgb+Ykmc2zIeDFwmexHPzwuIH9oG+d
 +0C1VUAnL5EKeIpiYxwMCJWiB8jk4TNHuupDPXKqWkGtJiNFlk2SnVY751FYcY7u8aeL
 AOEQ==
X-Gm-Message-State: AOJu0Yz9DPf2WfXO5Qt0vaMbwMkE2s+GITuRGOwzRehifFjMSWDtS+Ak
 K2zvqIK9XmFSOvoQYxFpgAN35WdMDy2gaV4ezfI=
X-Google-Smtp-Source: AGHT+IFULGa+PLiP4HBpcqFv0yPv3MFQRFa8vsX1mmHVJ4JOKx7KjJzaRer1c6yzUjdMkKKuiNrm4A==
X-Received: by 2002:a05:600c:3653:b0:401:b0f2:88cf with SMTP id
 y19-20020a05600c365300b00401b0f288cfmr9935975wmq.40.1693319329761; 
 Tue, 29 Aug 2023 07:28:49 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 13-20020a05600c024d00b003fe2bea77ccsm14178083wmj.5.2023.08.29.07.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:28:49 -0700 (PDT)
Message-ID: <7ec9ae6e-d886-5775-f8a4-0abff1e423e2@linaro.org>
Date: Tue, 29 Aug 2023 16:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 09/10] configure: remove $linux and $mingw32 variables
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-10-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829082931.67601-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 29/8/23 10:29, Paolo Bonzini wrote:
> Just use $targetos always.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


