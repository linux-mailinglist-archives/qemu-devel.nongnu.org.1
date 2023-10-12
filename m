Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A137C761D
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 20:44:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr0e7-0004zX-R5; Thu, 12 Oct 2023 14:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qr0e5-0004zE-Uk
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 14:42:53 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qr0e4-0008Iy-Eh
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 14:42:53 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo2227779a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697136170; x=1697740970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ASAniN18QZFRch4hHbbIvuqpTci7nid/Sw0rHmtrIM=;
 b=YW/xoAplozVnnwoA1z6Xcw/Lbnu1d2muSEok5fvkeHny9CfQX7VvneqmF3faF0sJvW
 aXzlEsAag5Q1xx1F8tAk/wlY9wu2+aFeqMSvjMebb2GYNBffYDHmqwVp0LJ6DRLZkmST
 tQYwLqK2E653Uf2LqouRZcltHod8clY4wUV5yHhcrDXPZ10HEr75V2REaY04EhsgG1bh
 C1DcRG7XW3htJ1y/HRoXjiLTsitWbHf0k+/F/f6tdm72sK5EMxKR+9H+ByhXLVNiSZj5
 azY8zGemFLVD66qmWCg+C1HpOnRUvUiCTjOR91hQu5uljfj5AfelVs6njzV75BI1IiuE
 4ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697136170; x=1697740970;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ASAniN18QZFRch4hHbbIvuqpTci7nid/Sw0rHmtrIM=;
 b=MHphTGRVn1ilYVIrl+VzP2y57qFHnburoFYh1L03swOYJVIf+LLBceaPVyJ0hDdn+3
 SsCzO7R5nBTQrkI0YYulbXfP+vGLAsEAboGfIcspDnDTKjM4oqdqAFN/MGjz23O7+tiF
 cXCVA6ZzqtN2FlytlGDnynMJpQhpA/Dl9V049S5v4tJzFVtID8wb5OR0VTWl3EQ112ZI
 wDoBkCOdV4Sbzdawefi76lQKNOm/XK5TxlJq5Q5U+VWxLfo9ltVDY1vhqALRSEJvJBUm
 Li/z/XdbF0xSNKLTOffCncC0RE0POfuNuy97kg7FntDhkMXCGkFHYgJJ3lRq97vAeUeN
 Ylvg==
X-Gm-Message-State: AOJu0YyKesO8ai+6v/8AZv7ib6SkZ8qmigoR8Zj1ZYyp/5vxbtrB2VyW
 Va9INTrVWTEUO1uXhl0XIL7rLZTbcpar1fSy2NU8Rg==
X-Google-Smtp-Source: AGHT+IFWtuhhigFSgsoSTkjgJ41qxJL6r4RxNHmtcIA3n3+G5XfBw7m3mAfLBOf7W8G8wl9JTbmGRg==
X-Received: by 2002:a05:6402:1cab:b0:53d:f180:3cc5 with SMTP id
 cz11-20020a0564021cab00b0053df1803cc5mr3854665edb.20.1697136170725; 
 Thu, 12 Oct 2023 11:42:50 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-232.abo.bbox.fr.
 [176.131.211.232]) by smtp.gmail.com with ESMTPSA id
 b25-20020aa7df99000000b0053808d83f0fsm10459023edy.9.2023.10.12.11.42.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 11:42:50 -0700 (PDT)
Message-ID: <b71e0108-b95e-1182-f0fb-d9aeddc3b3bf@linaro.org>
Date: Thu, 12 Oct 2023 20:42:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/4] target/ppc: Prohibit target specific KVM
 prototypes on user emulation
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20231003070427.69621-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003070427.69621-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 3/10/23 09:04, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Addressed Michael review comments,
> - Added Daniel R-b tag.
> 
> Implement Kevin's suggestion to remove KVM declarations
> for user emulation builds, so if KVM prototype are used
> we directly get a compile failure.
> 
> Philippe Mathieu-Daudé (4):
>    sysemu/kvm: Restrict kvmppc_get_radix_page_info() to ppc targets
>    hw/ppc/e500: Restrict ppce500_init_mpic_kvm() to KVM
>    target/ppc: Restrict KVM objects to system emulation
>    target/ppc: Prohibit target specific KVM prototypes on user emulation

Ping?


