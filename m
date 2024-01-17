Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2331830BA9
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:06:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ9M5-00005n-P1; Wed, 17 Jan 2024 12:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ9M0-0008V5-Dl
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:05:28 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ9Lw-00071h-MT
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:05:26 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a29058bb2ceso1194574066b.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705511122; x=1706115922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XMF8Gs2GpAnnoaKTfQdMjocYVJBTH7Am5MtFGxfUglo=;
 b=MheMMruFCgdV18j6HfdU7xBVDKlx7+yJzi5Qw3eUwreJikVAKMiFaoi1KLdf9TNwNX
 aVh6TgjTL6Jz49878hY3MUTfhTwtavVUzFA0fVioaCu5Vr6xjhg0yR683EJpjoWhawh/
 THwaW91hH++IJWnISVQge/5NAvl0aha5+2sz/u+sUbO69W8n7lWMzOoIMWr3h2aNc/Qn
 npg9k2b9wh/Pxne520LZeOGu8v3N3/dgP4UWL6ru/LWTgZQ2FiFUvo6G2ICFotI5RdIB
 yYyddPD810Y/LRZgp5OnwqRUu3CPnCRAUU7G2GuCLLxBZ/Hhci4sGuuRVm+8HKlq2ako
 Ds2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511122; x=1706115922;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XMF8Gs2GpAnnoaKTfQdMjocYVJBTH7Am5MtFGxfUglo=;
 b=Uiah18MOCgsJNbsTFNd7XS81/01YxFjEqHVwAUKvkTlaF601ZZuxnVz/8JbAdDzYY3
 /NaLhYqYoJxxjLkF+cJw0G1M8Oyiyk8ByWeEakkbTBK9VWiNh30Pyba9YWcBsca6V7JW
 Xt8l3gnyJ+sQZ5Fe9KKPaZ3A8YWsRi98ZWAuw8S3sqOBIDl3jWOpGjVnyzrYcxSyAE8q
 /IkWhd6GYCn3RPfCZshtTfG/ov+kGfj7iEQy38QGc8YYdAtfAe425SX/e9CTinWwCLYB
 lk/ZJDlxPv8Xil0X3f5eY1HVW0/xXkUApy/yB4xZ4JAfZRi/nI0uNsq/NXQQdEL7gnlA
 TiYA==
X-Gm-Message-State: AOJu0Yy0MwbQxrP8OeR2BdOcNOYUGzeNuG1QPRoL5pYGe1hhtAqH9QPk
 2MVe3ESVbuDdsHYFCXWmjLYGgr4wgDHrkR6DhbX4RXnigrU=
X-Google-Smtp-Source: AGHT+IGYNrrvCx1CbwCtXV56VWZrFp5VwkJzbcBQNSQDj8uY4sQNZzjriyESNjkjOCs0hNVk/1/+Rw==
X-Received: by 2002:a17:906:3a8a:b0:a2e:d4d8:5b3c with SMTP id
 y10-20020a1709063a8a00b00a2ed4d85b3cmr450577ejd.53.1705511122120; 
 Wed, 17 Jan 2024 09:05:22 -0800 (PST)
Received: from [192.168.69.100] ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a1709062c4300b00a2af287c6b8sm8099425ejh.16.2024.01.17.09.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 09:05:21 -0800 (PST)
Message-ID: <9b42b294-e2cf-406e-a21a-e2b99694a316@linaro.org>
Date: Wed, 17 Jan 2024 18:05:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: use matching sizeof type
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
References: <20240117160344.175872-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240117160344.175872-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 17/1/24 17:03, Paolo Bonzini wrote:
> Do not use uint64_t for the type of the declaration and __u64 when
> computing the number of elements in the array.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/vfio/common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



