Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9E27CEC48
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:49:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtGGT-0003Ua-0r; Wed, 18 Oct 2023 19:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtGGO-0003U3-D6
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:47:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtGGM-0005Ij-Mz
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:47:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso175954b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697672860; x=1698277660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VFcySX4HVLN4VTmQe1z4Y+xyMXQ9kxDCJmkafmz00p4=;
 b=V+rq+qzVTifvW0QANvo83BLeDn4370ZWKh/5Z/+v7E//1L6KxTlZj2hoDxLWoI4mBm
 FD3HHOnAXqsJhjmqGLsTYOtkVRVe2tjnaLS0zCkF/ON1MyjcEdPVWA77koe5iocDRHw1
 foMUkxu9SBih5YEKZmisVt2Nhdu+yPTkAaCcRc/EhStyKqw05S0I93evFauhmWMDYQ0L
 pg70g3SFXXKQkwiAHHp/wkgcOOD3Od2HwZFZwIv2F6Y4g8/UM1g9PMRInof02UTVhUoC
 QoTJpSIUzWsbOo6XNWTdFWty0ZOIUdO4J/idD7tCUr1dYAp+PUEy2XbxDrT6GWFWbH0c
 eP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697672860; x=1698277660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VFcySX4HVLN4VTmQe1z4Y+xyMXQ9kxDCJmkafmz00p4=;
 b=VbPC7arX0gQpSxgyG8wCfSPCZx7xUbSfiarT8PpwZhPmlFGLC59c0hlNoTwfor3+qC
 xiqbaXH8nWGQvn5Z/2CxEW3VHtcKeGoC233lgC+DdkqJWO93uy1BGvwvvpnso87HiPOC
 tn6ztFDPkC0N6ITDNY6njq8aLiHlWJhvsnlf/4NbajJe66i/+LQvrMPivmLksG9QdHfO
 U5fnxeGrdm2i7f3srMQwSwkdL3DLoIC/5W8UiJ/MzWisn+8gKQ80Nbff2V31W3zy5t3d
 fsE7jGQJqlO82b0EeJBsDpl+CZhmhgLywtnd2YiCo0Wfr0JQ+/69i+W2c28QespK/Jom
 DIrQ==
X-Gm-Message-State: AOJu0YxP+hEK66NGnTRAjUj84yI9Op9KLo7s54KMYKa0AgZRGd6Cc9PT
 FWM3tqXZ1zCiz5A2H5813C7BjQ==
X-Google-Smtp-Source: AGHT+IHEJYucTm+l4gDU4tL0A05X0V8NJvMrFjZg7WHIjAQWxY4iOJmVK0Fwxw+TTe506SXpgoHGCg==
X-Received: by 2002:a05:6a00:4788:b0:68f:c4a2:fb1f with SMTP id
 dh8-20020a056a00478800b0068fc4a2fb1fmr474848pfb.8.1697672860174; 
 Wed, 18 Oct 2023 16:47:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a625ec5000000b006bb45a6a011sm4018038pfb.128.2023.10.18.16.47.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 16:47:39 -0700 (PDT)
Message-ID: <88eb5431-9183-4619-8049-2910544f6b68@linaro.org>
Date: Wed, 18 Oct 2023 16:47:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] target/loongarch: Allow user enable/disable
 LSX/LASX features
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, peter.maydell@linaro.org, eblake@redhat.com,
 armbru@redhat.com, maobibo@loongson.cn
References: <20231018085908.3327130-1-gaosong@loongson.cn>
 <20231018085908.3327130-3-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231018085908.3327130-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/18/23 01:59, Song Gao wrote:
> Some users may not need LSX/LASX, this patch allows the user
> enable/disable LSX/LASX features.
> 
>   e.g
>   '-cpu max,lsx=on,lasx=on'   (default);
>   '-cpu max,lsx=on,lasx=off'  (enabled LSX);
>   '-cpu max,lsx=off,lasx=on'  (error, need lsx=on);
>   '-cpu max,lsx=off'          (disable LSX and LASX).

...

> +    /* CPU has LSX */
> +    bool has_lsx;
> +    /* CPU has  LASX */
> +    bool has_lasx;

Why do you need these variables?

I suspect that you've copied them from one of the more complex Arm cases where we need to 
resolve multiple properties simultaneously during realize.

You'll get identical behaviour in your current code if you drop these and rely only on the 
CPUCFG2 bits.

If you wanted to do something more complex, you could use OnOffAuto, so that you can 
detect conflicting settings (such as #3 above), but not generate an error for

   -cpu foo,lasx=on

where 'foo' is some cpu model which does *no* default lsx=on.  You would see that 
has_lsx==AUTO && has_lasx==ON and then set lsx=ON.


r~

