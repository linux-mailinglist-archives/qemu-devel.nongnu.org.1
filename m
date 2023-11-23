Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 012947F6257
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:10:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6BKX-0002bo-8Z; Thu, 23 Nov 2023 10:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r6BKT-0002Zt-0B
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:09:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r6BKQ-0006oR-8Z
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700752156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/7w03HAUfqnH3zSti8p2cbx4r5RRAUUrEAR67Sb6X1w=;
 b=YI+6LvhxrnlJE4idBxhGlQTz/2ldKXuFSPDxU8L1YRYCdnuhZLgs3ev3w/Z7PgDZve5B0q
 /RRnVS8j+HwDMutMx7nHeM9iQigFxIE9WELGpgfeSK0RoOagdBklsaPkZbCqIjNarutw6o
 STa1PItl4Mndta2NiG29de8FfZJFRik=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-rDSEqmGbMi2WSmrlxxQ_gQ-1; Thu, 23 Nov 2023 10:09:15 -0500
X-MC-Unique: rDSEqmGbMi2WSmrlxxQ_gQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d155fc53eso11586276d6.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:09:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700752155; x=1701356955;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/7w03HAUfqnH3zSti8p2cbx4r5RRAUUrEAR67Sb6X1w=;
 b=qMM22CBMXtzjLtqGz6Ug5zNUrZd4As6/XurDhZeD2pUMPE2z43ZqUMgvUvO/GZM8y+
 QDvCr2tsRZSfeUZbe6mEpdXIvmXQ9RUk1pVY7mdYWR5ra417/CKSz/oa+zFwFRQ8Yp82
 MzCpLQju2t3hpYQK+jEBpP1i89y9NVOq7VdySEYUuCceNhuX6L+fWInVGMtZsVneBoQp
 1ALaqPUDviOMAXeJ+HND+br/hM0yI5Bg6KYic2imWbXDP65UHNsl8m7D5A05AOOmvUZS
 nsGy/P4IeLAMFnhzr47vMtQbymIVZu5UOIGRqHlvyyxXRBTTXccqTmc+CDTGLhjZdZM2
 G4xg==
X-Gm-Message-State: AOJu0YzsFFhczaAEYuHNMSUxXLnGjQqEfAbuO5crUwcP5wgNMwbgfmm/
 OPPWh+LFF8xl1p3EJFducknkCyBU1zsRXXlHmBb/1qqsqUR6pf4zQUyjD9KgAnAZJhebdbJObI4
 djrruXOY2ylISVE0=
X-Received: by 2002:a0c:cdcb:0:b0:67a:ffd:eb51 with SMTP id
 a11-20020a0ccdcb000000b0067a0ffdeb51mr61749qvn.35.1700752154758; 
 Thu, 23 Nov 2023 07:09:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrQ5FYxe0PYG+PEE316DVh7ahPdVhHSR93mmKRUhJnYToMnk8fMKsEtyRBTvu+FoYADAcxsg==
X-Received: by 2002:a0c:cdcb:0:b0:67a:ffd:eb51 with SMTP id
 a11-20020a0ccdcb000000b0067a0ffdeb51mr61727qvn.35.1700752154508; 
 Thu, 23 Nov 2023 07:09:14 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-233.web.vodafone.de.
 [109.43.176.233]) by smtp.gmail.com with ESMTPSA id
 u16-20020a0cf1d0000000b00679d8235a60sm563736qvl.135.2023.11.23.07.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 07:09:14 -0800 (PST)
Message-ID: <dc8664c2-c1d4-4e11-8bcd-9465a2d97174@redhat.com>
Date: Thu, 23 Nov 2023 16:09:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.0 01/11] qom: Introduce the
 TypeInfo::can_register() handler
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
 <20231122183048.17150-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231122183048.17150-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22/11/2023 19.30, Philippe Mathieu-Daudé wrote:
> Add a helper to decide at runtime whether a type can
> be registered to the QOM framework or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qom/object.h | 4 ++++
>   qom/object.c         | 3 +++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index afccd24ca7..0d42fe17de 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -372,6 +372,8 @@ struct Object
>    * struct TypeInfo:
>    * @name: The name of the type.
>    * @parent: The name of the parent type.
> + * @can_register: This optional function is called before a type is registered.
> + *   If it exists and returns false, the type is not registered.

The second sentence is quite hard to parse, since it is not quite clear what 
"it" refers to (type or function) and what "registered" means in this 
context (you don't mention type_register() here).

Maybe rather something like:

If set, type_register() uses this function to decide whether the type can be 
registered or not.

?

>    * @instance_size: The size of the object (derivative of #Object).  If
>    *   @instance_size is 0, then the size of the object will be the size of the
>    *   parent object.
> @@ -414,6 +416,8 @@ struct TypeInfo
>       const char *name;
>       const char *parent;
>   
> +    bool (*can_register)(void);
> +
>       size_t instance_size;
>       size_t instance_align;
>       void (*instance_init)(Object *obj);
> diff --git a/qom/object.c b/qom/object.c
> index 95c0dc8285..f09b6b5a92 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -150,6 +150,9 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
>   TypeImpl *type_register(const TypeInfo *info)
>   {
>       assert(info->parent);
> +    if (info->can_register && !info->can_register()) {
> +        return NULL;
> +    }

I have to say that I don't like it too much, since you're trying to fix a 
problem here in common code that clearly belongs to the code in hw/arm/ instead.

What about dropping it, and changing your last patch to replace the 
DEFINE_TYPES(raspi_machine_types) in hw/arm/raspi.c with your own 
implementation of type_register_static_array() that checks the condition there?

  Thomas



