Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2243F73A7A2
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:49:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOQL-0007pe-JS; Thu, 22 Jun 2023 13:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCOQE-0007ml-I1
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:48:42 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCOQ9-0006SF-Eg
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:48:42 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b46f5d236dso81977431fa.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687456114; x=1690048114;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dqzSwhmIqLC0pNAcU2LtSNI/E1J8NE7gvDvKGn+6LZQ=;
 b=zuKhnA4x/RPSFsbRDJ0d4Ftiske/KmneH55J9Sv9/ZNVVwbQ3icFYY8MVzx8/+V+SR
 4px+9lMVNc6S6yvGsRMvceKngfoW5pSqqDQQYha/GLw6t5fgE82RkgNXPjSfLlIUq2S8
 74Gy4qNIB83KfhY9VgP7FhCVfKwLiYQM5/Gq9OuvUnzhr4ChZp+/8xcqVOjBMc5OMnXL
 7lZZUBotN2tra15w4fQs0CKbHFSzkmjl5gWKDqCI6yat/f3cTNUnlkQKgFQcHajMXIlS
 Rc93JrOx+coCGdYDTXciBqhdaAn9GSwr36eB+HAU5RTRzwbNQhV9G5MhDRblA/3DLi9f
 Wsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687456115; x=1690048115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dqzSwhmIqLC0pNAcU2LtSNI/E1J8NE7gvDvKGn+6LZQ=;
 b=kydWv3rWhdTAmhm6aIoEHdjgbQU7j9KKda1USuLZvxYsR3x9ZBqqGCCuBFHSl/x7vl
 v3j8IK7thpn6ofoVmGPUrpALD83vif918Coeg3+J0AbxLzejoqPGaVDWU8BcMUwLOS0i
 bWv4XTXHWl59Tzj2XmhIygoOfEVyg54e3wgRi3R7iYim7sOi6JgqImonz6r/21AWI+8S
 voqYjcgM51ytSS3zRiGhmtNunSue8acwIy3vpJUKD2kY0vFqJgxy/4V0NnANSwwCmFWD
 IVK6XV3sC09g+w64XSBGwzXY53bZWV2EI/NY+mHBntBVMuD9s6zlX3UdmjIXtnEdGNOQ
 EeDQ==
X-Gm-Message-State: AC+VfDzx0UiBGoQ+Z02KZVYRuYpvcNDfSdjnMLCerM/hzFwfaQPL1f7G
 T6rWsevsxlmmazO+DqFPS/tUNg==
X-Google-Smtp-Source: ACHHUZ4yU6Z4OBHWNZinbZubWOW6GhuB/jEGytDVFOrPmlBXaknK7EKzwKrqWJRARRFro1oeE4SvtQ==
X-Received: by 2002:a2e:834b:0:b0:2af:25cf:92ae with SMTP id
 l11-20020a2e834b000000b002af25cf92aemr12328492ljh.22.1687456114734; 
 Thu, 22 Jun 2023 10:48:34 -0700 (PDT)
Received: from [192.168.157.227] ([91.223.100.47])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a05651c020300b002b4832d0c8esm1421362ljn.118.2023.06.22.10.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 10:48:34 -0700 (PDT)
Message-ID: <d1d63ac7-b0dc-4d8d-73ff-9b693ca163c2@linaro.org>
Date: Thu, 22 Jun 2023 19:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 12/16] accel: Remove WHPX unreachable error path
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 xen-devel@lists.xenproject.org, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>
References: <20230622160823.71851-1-philmd@linaro.org>
 <20230622160823.71851-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230622160823.71851-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/22/23 18:08, Philippe Mathieu-Daudé wrote:
> g_new0() can not fail. Remove the unreachable error path.
> 
> https://developer-old.gnome.org/glib/stable/glib-Memory-Allocation.html#glib-Memory-Allocation.description
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/whpx/whpx-all.c | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

