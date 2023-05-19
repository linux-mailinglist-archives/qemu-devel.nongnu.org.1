Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B509709C0C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 18:10:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q02eo-00009A-R8; Fri, 19 May 2023 12:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q02el-000090-CK
 for qemu-devel@nongnu.org; Fri, 19 May 2023 12:08:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q02ej-0005AB-2h
 for qemu-devel@nongnu.org; Fri, 19 May 2023 12:08:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f41dceb9d4so33308515e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684512515; x=1687104515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cat+2JbmIcdnoRXO4DRR0sI+LIw48V1Dt9TYcqnKnJs=;
 b=IgBB13P455nBhQT3dDr/Q+PFuTqi3+mAL7UJADa0gS+9DWSxGii6E+QpEZ1LO3Al9j
 f2CEoNsGjH1KbjVET2k7S87Cn4JT6VUNNwzeZ7qhO2y+evvUINCuadMSupwiLjI1Yv9d
 SaXftf0o2ILyktm22Qva/r2w/YrcfkWj/bFMU7TLmvV3kp7wvxx8PsmKVlzy0upMf6YV
 afbKXTfy19Iw8O0XDRAtjk3irzgYzxqWKUFnJ41RgflGWHuAqOKiSMPfQdKOl1SSj8qj
 9/27fWJVf4iuvTBJ/baqPXX8dSKU715mIRaJkokJuO+JGwFP6miOeqWHpOFHC5e4mHVp
 yiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684512515; x=1687104515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cat+2JbmIcdnoRXO4DRR0sI+LIw48V1Dt9TYcqnKnJs=;
 b=NIEyMFPDEV/01pGPSjgpBsL/rLkGqExN5EnXFX/dBOEfsaREHt2lOvVvtNPv12WHIo
 GUO6yPv5g/mTimAjNVNjpvPZzR2BlbZccucIVm31BYWdjEfwLLNc+Abfqa3HaAq5hwMS
 kpau3+BUWl/LVxH/mdZGA6LkepGSk53uNdw+hzsDwXgg8lswOu6OCVqbWGj033MO/7xH
 DGodLIrjSG7jGI5tzLwUpaIbsZhkB6gLdJGAiJM1pSIS3vnQxDnY5Kk/EOZi9v7DGjfR
 zNn4meKwiXCdbV/DtBkFBaLl4uVLcfULqoOpfg0m8iFoBazWLEJo+JSWa5sE/DcZ/6Cq
 YGxA==
X-Gm-Message-State: AC+VfDzlwnxJvExYviKwqEFw2UndEi/MAXN0jG51vJmzDv3KKppdmVwC
 wP85RbIU4yryLSjcE8Afzq5Xaw==
X-Google-Smtp-Source: ACHHUZ5TIf9PbUqcfpYdP35gTIAuSo3PzhFV1RJf3U2xr8S4r2+Ac8P49/FwbP42VFwjyhR9uxnczA==
X-Received: by 2002:a7b:cb8f:0:b0:3f1:7bac:d411 with SMTP id
 m15-20020a7bcb8f000000b003f17bacd411mr1722139wmi.39.1684512515272; 
 Fri, 19 May 2023 09:08:35 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr.
 [176.184.41.228]) by smtp.gmail.com with ESMTPSA id
 i3-20020adff303000000b0030795b2be15sm5648287wro.103.2023.05.19.09.08.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 09:08:34 -0700 (PDT)
Message-ID: <27f9ad4f-bdde-f548-860b-34e52493faa2@linaro.org>
Date: Fri, 19 May 2023 18:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned 24
 bit field
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>
Cc: linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
 <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

On 19/5/23 16:18, Jonathan Cameron wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> specified as little endian.
> 
> Define st24_le_p() and the supporting functions to store such a field
> from a 32 bit host native value.
> 
> The use of b, w, l, q as the size specifier is limiting.  So "24" was
> used for the size part of the function name.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   docs/devel/loads-stores.rst |  1 +
>   include/qemu/bswap.h        | 27 +++++++++++++++++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index d2cefc77a2..82a79e91d9 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
>   ``size``
>    - ``b`` : 8 bits
>    - ``w`` : 16 bits
> + - ``24`` : 24 bits
>    - ``l`` : 32 bits
>    - ``q`` : 64 bits
>   
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 15a78c0db5..f546b1fc06 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -8,11 +8,25 @@
>   #undef  bswap64
>   #define bswap64(_x) __builtin_bswap64(_x)
>   
> +static inline uint32_t bswap24(uint32_t x)
> +{
> +    assert((x & 0xff000000U) == 0);

Asserting here is a bit violent. In particular because there is no
contract description that x should be less than N bits for bswapN()
in "qemu/bswap.h" API.

But if you rather to assert ...

> +
> +    return (((x & 0x000000ffU) << 16) |
> +            ((x & 0x0000ff00U) <<  0) |
> +            ((x & 0x00ff0000U) >> 16));
> +}
> +
>   static inline void bswap16s(uint16_t *s)
>   {
>       *s = __builtin_bswap16(*s);
>   }
>   
> +static inline void bswap24s(uint32_t *s)
> +{
> +    *s = bswap24(*s & 0x00ffffffU);

... and sanitize the value here ...

> +}
> +
>   static inline void bswap32s(uint32_t *s)
>   {
>       *s = __builtin_bswap32(*s);
> @@ -26,11 +40,13 @@ static inline void bswap64s(uint64_t *s)
>   #if HOST_BIG_ENDIAN
>   #define be_bswap(v, size) (v)
>   #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
> +#define le_bswap24(v) bswap24(v)

... then shouldn't you sanitize also here?

Personally I'd just drop the assertion.

>   #define be_bswaps(v, size)
>   #define le_bswaps(p, size) \
>               do { *p = glue(__builtin_bswap, size)(*p); } while (0)
>   #else
>   #define le_bswap(v, size) (v)
> +#define le_bswap24(v) (v)
>   #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
>   #define le_bswaps(v, size)
>   #define be_bswaps(p, size) \
> @@ -176,6 +192,7 @@ CPU_CONVERT(le, 64, uint64_t)
>    * size is:
>    *   b: 8 bits
>    *   w: 16 bits
> + *   24: 24 bits
>    *   l: 32 bits
>    *   q: 64 bits
>    *
> @@ -248,6 +265,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
>       __builtin_memcpy(ptr, &v, sizeof(v));
>   }
>   
> +static inline void st24_he_p(void *ptr, uint32_t v)
> +{
> +    __builtin_memcpy(ptr, &v, 3);
> +}
> +
>   static inline int ldl_he_p(const void *ptr)
>   {
>       int32_t r;
> @@ -297,6 +319,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
>       stw_he_p(ptr, le_bswap(v, 16));
>   }
>   
> +static inline void st24_le_p(void *ptr, uint32_t v)
> +{
> +    st24_he_p(ptr, le_bswap24(v));
> +}
> +
>   static inline void stl_le_p(void *ptr, uint32_t v)
>   {
>       stl_he_p(ptr, le_bswap(v, 32));

Conditional to removing the assertion in bswap24():
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


