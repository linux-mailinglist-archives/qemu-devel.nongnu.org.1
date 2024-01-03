Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E958233C4
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:49:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5LB-0001xz-Lf; Wed, 03 Jan 2024 12:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL5Ky-0001e1-52
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:47:30 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL5Ku-0004CM-Dj
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:47:27 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3368ae75082so430013f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704304042; x=1704908842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aZn5H3BibQIjCm6XCuZSPBoWZOto2pSlAUY4r4Wn5U8=;
 b=JEasv5ddiBg8uKEg4RD5uBp3kZEyFsiKnYSGWS42iXEzR3x5PaUrRfVEG/vHFPrktA
 hyQBe3ZiuKXRJFVDb83w4qHwXiw3oiiyI00Xw7c/3H9ONj/tkPGFqUvEABh6k+ulJOZW
 5yCzTvFrsGzlk378KEWfx9rSPErOhiW37l/IJFHKLfJNSdsdT3wOZ0C0K/ON2PzwR57p
 AYwtupOSZen1aIijc7R+LA7gIuzv4hV1W4khc1dp3VwSKQZqeNzyOJi5jtZh6dSscFi+
 XfdIztcR0l7rMI8r2qJMBiXuB2g7Ycq+0DGB0Lg+7fPhB8Vg+AfDOyuQb9r9AyOqfzMy
 glDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704304042; x=1704908842;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aZn5H3BibQIjCm6XCuZSPBoWZOto2pSlAUY4r4Wn5U8=;
 b=VQ2ac6p2lrvSHqBeGcGaUWcRGalYrqVnCAg5PIXH+UShW94EVCj2TqRdz+UtU2u2Ja
 QKU/BKoQkJFjL5bNr08FWV2jnLmaxdMUVC1oqoLF3X/Y+EVvgwf6y9q8aer3bk4jPS7X
 Yb6alkFWEdZMvpJjIGjVBazPDC5yrAwBi44anwEWuAVE4i8l/jF4CxOhr/N8o75xJt5k
 KZPlU/WDXXS5O+1+G++4xyNPQzGUyjh/MjiO7O9hgcDDMDtXOcX7wQq62N1Sru2uWd5O
 Gv1iScQqm0mgEKZVkLyIoXdb6XqDrTVfU/+0F66eLlfTdk/4bk3V2tY4lseCGhArFqkY
 goFA==
X-Gm-Message-State: AOJu0Ywz39KJjHzt30f228In+hdWFgvr1ES4aE1gF3fXTi31TdDFHY8j
 ZGBOQUQNqT2gYpbK+HY/PlR+LKIGrrP/jQ==
X-Google-Smtp-Source: AGHT+IEWSmwKYOBNA3zud+Rn8MIOuM7s/OmpOblX5Yr8XMRSMzRdlO4xFHDFR+JcT+JP+VwaTeY4Dw==
X-Received: by 2002:a05:600c:4b27:b0:40d:81bd:9d12 with SMTP id
 i39-20020a05600c4b2700b0040d81bd9d12mr743994wmp.147.1704304042639; 
 Wed, 03 Jan 2024 09:47:22 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 t16-20020a05600c199000b0040d5fcaefcesm2946862wmq.19.2024.01.03.09.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 09:47:21 -0800 (PST)
Message-ID: <f0fb7562-9af1-4448-b33a-ededd8072aef@linaro.org>
Date: Wed, 3 Jan 2024 18:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 39/43] contrib/plugins: fix imatch
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <lvivier@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, David Woodhouse <dwmw2@infradead.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, Paul Durrant <paul@xen.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, John Snow <jsnow@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
 <20240103173349.398526-40-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240103173349.398526-40-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 3/1/24 18:33, Alex Bennée wrote:
> We can't directly save the ephemeral imatch from argv as that memory
> will get recycled.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   contrib/plugins/execlog.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> index 82dc2f584e2..f262e5555eb 100644
> --- a/contrib/plugins/execlog.c
> +++ b/contrib/plugins/execlog.c
> @@ -199,7 +199,7 @@ static void parse_insn_match(char *match)

Could 'match' become const?

>       if (!imatches) {
>           imatches = g_ptr_array_new();
>       }
> -    g_ptr_array_add(imatches, match);
> +    g_ptr_array_add(imatches, g_strdup(match));
>   }
>   
>   static void parse_vaddr_match(char *match)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


