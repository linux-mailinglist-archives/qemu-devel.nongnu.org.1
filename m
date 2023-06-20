Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11102736887
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:58:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBY7T-0001ZB-8c; Tue, 20 Jun 2023 05:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBY7K-0001Yz-HC
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:57:42 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBY7J-0002Mc-1K
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:57:42 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-518ff822360so5523419a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687255058; x=1689847058;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oDkv5RtXmw3Mx7qrAOf5aRaR8yn04GUTirLk/+gkmVk=;
 b=Y4fDamwQNel9JS2gGurx3UG++330PUJfeG/NZzVhG8G7bue8PFPXiEzw/WDdxl7qnL
 IoFThLWq9vzOqzEqZe1dXaZ+x/qtyqEUwS0BFD5ZHWSokT8uJW4XNftdkh3hf0B5YClv
 MT8sESOLO/QUvN+ZrRDaP7n0q3VL0Bs6e2i/LauzaIr+PTALKiikwDJEs1+id+oDgzxp
 vK9vWtBsxk52Ld5Jnr9XEdD1XkH7VT4Lo/mF6SIRZLrdoc1mxOG/ncti6qAT2JyoSVDz
 usfpJe0b8gozhSghyJowy0i9CG/YDkIzthGU5xnNuOFGDek+veKUuogYsguE97EtsdXH
 uJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687255058; x=1689847058;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oDkv5RtXmw3Mx7qrAOf5aRaR8yn04GUTirLk/+gkmVk=;
 b=Uez7kpiV4SKfLfK4EcEIgXCQA5gUUdmsrUbpSZ3xhgnfYZvHN6r3hPglIXIEBiwot0
 KzjzuN43/IqPh6WuOIDFNebzX7YQicVBR/FYSQjYpJ/q7BHC1eomRMAC1LTn5e+NRT4Y
 rM6BcNHsxl0tLMzn1EzzjL68LAc3RbEePM2sPvv9RIJ4NUeh4I0bSkQ/gc6+het9qbJt
 Hf5tvOzc6Slvr7xaLA8IZhWFbzj9n/IJkdr6sgKblKzR6iNQgMBhNo0OfNnbWXbYr1fB
 CISMZPnm8L20uRohiR6ksoXnZTLrdO03ITRZdjEDosMGqOAiV4bP2/F4QFbOJpmO1Jox
 629Q==
X-Gm-Message-State: AC+VfDy1TrYLOSvflAIya/J6hNLk1yvWlN9y8uvYR+ZaN0RrLNdyyUBx
 XuIabwUIndx/BQnVnDp+e+0qaA==
X-Google-Smtp-Source: ACHHUZ6ns/cO+6XMmEmK9PjBCuxAOE6/j36p9kwgkpxP8XFX3pcRybCYiSj0F+JMkSUPCBafBcGE7A==
X-Received: by 2002:aa7:c98e:0:b0:518:73ee:c1a8 with SMTP id
 c14-20020aa7c98e000000b0051873eec1a8mr7685983edt.32.1687255058512; 
 Tue, 20 Jun 2023 02:57:38 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a056402061100b0051a53d7b160sm891765edv.80.2023.06.20.02.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:57:38 -0700 (PDT)
Message-ID: <9074a2b5-266d-936f-6754-6c8508509f83@linaro.org>
Date: Tue, 20 Jun 2023 11:57:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/5] docs/devel: add some front matter to the devel index
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>
References: <20230619171437.357374-1-alex.bennee@linaro.org>
 <20230619171437.357374-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619171437.357374-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 19:14, Alex Bennée wrote:
> +QEMU is a large and mature project with a number of complex subsystems
> +that can be overwhelming to understand. The development documentation
> +is not comprehensive but hopefully presents enough of a starting point
> +to get you started. If there are areas that are unclear please reach

"start" used twice -- "presents enough to get you started"?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

