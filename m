Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2017CEE6A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 05:26:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtJfL-0003s5-Ja; Wed, 18 Oct 2023 23:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtJfI-0003rB-DB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 23:25:40 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtJfG-0003ZJ-Jv
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 23:25:40 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-49dc95be894so2401309e0c.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 20:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697685937; x=1698290737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v1462p03Q0rmWq6Gz+9TQNhrvyXPDLv2+1Tt0NG3P9I=;
 b=cXFRtAWpKz/NHBs5aZzj27N3UgcBF61W44MQBj7rJI6h3Ld9h3+AC2FwdPJ0RLx8cz
 b/uK0J0Ma2l1NtrAhqCirwmrUPNxvZkKyW6EBrLSeDyM4JeMRyIlGT9jxCc/8/kwRp/D
 8qyf43bYhdyPA4RnMds9/9I5QQ7eDb1iprAvoyUfUJRk4ClrOCfMmOX1nSYACExuPd0B
 Ma6KhddOcvVpPc2fi9zxLnNXhPVS64ctFiZCoNQEb2/IhaOkyM4Ut+bjlhgWMLmLLbIa
 0j5YGv4nj8ih5ez668Kx/Xr7kA/56FOmYh69lpSSOkcF7wbJSqsMRwDONiXHfLieAKZl
 wAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697685937; x=1698290737;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v1462p03Q0rmWq6Gz+9TQNhrvyXPDLv2+1Tt0NG3P9I=;
 b=QCeCl4PmVP+BmuW5IibsvIOdgKrTzucPC748+F+jMU5ALMZI8py4QpHdIj5CBhEaUU
 Uz1VxHCKlwwA5ANzySHnsWwsIFYmmJZ2VOgeahHY4W6a48I5uvqmzBIEYquyRtFftCD/
 WnFDI8G27ffie8DgXPfSXehwCQ4awI13e61WFz5BjAyyrmpW95c9onwQj0fwRDY+JZJA
 DDbyGCajguBsTzXUAWD+oJ15Y8lW8eKcpeT2ZkRxzpVkmWF2Bik5n+mURDzmqxJ0xhwH
 X0yiZ77G6qCeR24yzhYXb9Rd4VfmG9XoKVdMTrs9crmwX+hj1GY834IkPygQ3Wa7wPpR
 Jpzg==
X-Gm-Message-State: AOJu0Yxm+Z1U5iH8ZqWSrbpj48s4ngKxXWlTobJRGY3inFD9I5DkB5F9
 Yfqkjctm/3h3pN9NpiEcNbSzAA==
X-Google-Smtp-Source: AGHT+IFO9Wpuv/YbKh2P4nxjctNwloE0u0GK06b0OUD/EhhUkewXkL4wq7h7ffWx1hstIc8yA58TOg==
X-Received: by 2002:a05:6122:311f:b0:49a:1dcf:21a8 with SMTP id
 cg31-20020a056122311f00b0049a1dcf21a8mr835543vkb.16.1697685937474; 
 Wed, 18 Oct 2023 20:25:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a056a0000c600b00690c0cf97c9sm4054612pfj.73.2023.10.18.20.25.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 20:25:37 -0700 (PDT)
Message-ID: <31213894-5b09-4025-bce4-f11af871934e@linaro.org>
Date: Wed, 18 Oct 2023 20:25:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] target/i386: adjust decoding of J operand
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-13-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=richard.henderson@linaro.org; helo=mail-vk1-xa32.google.com
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

On 10/14/23 03:01, Paolo Bonzini wrote:
> gen_jcc() has been changed to accept a relative offset since the
> new decoder was written.  Adjust the J operand, which is meant
> to be used with jump instructions such as gen_jcc(), to not
> include the program counter and to not truncate the result, as
> both operations are now performed by common code.
> 
> The result is that J is now the same as the I operand.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

