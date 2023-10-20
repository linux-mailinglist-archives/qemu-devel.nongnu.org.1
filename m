Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B977D1087
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:30:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpY6-0000Lu-Aj; Fri, 20 Oct 2023 09:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtpY1-0000LS-MI
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtpXj-0004TZ-0Z
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697808475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ei2BXbSKKfyPAct6Qs7nNfSSIk7DW8avrmk79V+1FW8=;
 b=CqoUtEr6Liw9RnixuSuzhfUFxUKpJ164iIF5flUpHG5Mrxne12upJhbzo16vXdbQ/6U+Lu
 DxLILXSszxVT40Oc2SBVeUzGYhEa8FdSSOWnMpCW2kCyYrt+HaT8NWNAkUrz3z3hlKkpXn
 /G/61tHeR0ToMZdKJFEObElzBhFUrDk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-wWMCB_kUOtKE7pxq9EQCiQ-1; Fri, 20 Oct 2023 09:27:52 -0400
X-MC-Unique: wWMCB_kUOtKE7pxq9EQCiQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66216e7385fso9027676d6.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 06:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697808470; x=1698413270;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ei2BXbSKKfyPAct6Qs7nNfSSIk7DW8avrmk79V+1FW8=;
 b=UhsYxGvm5Z+O68j3x6DaL+cRKdxEe0960TfEmuoub0+nR3K5By6SWj3VSdINw8Ldwp
 /Vf6gTRNafBweGP+Ij4jlAqGziktknp4EaQ9baR1JPlyK6VkPL9A5NYmT5Ow8z+q8HVL
 FvAwVX0TIGf5lFr5mkl2zTkddhC+b++t9MRP8G0pBrV9ziMJH0dOAa9etv9x82xWZRLL
 qhCdjEUPh8t4rdHjMy0KP/fRTi/iLnoT3JC2BC3PTc2blDm6RT/IbyUEoVUwJphZkP1I
 BxuK6+VQh0Fc0Km97/OE4/rl4hS4PXke8C30v1OBn5ihstT4eXXAs8Kt8FrtnwjoyXN/
 sUDQ==
X-Gm-Message-State: AOJu0YxLpiLSrrBOtLaJgbgBp0ZvKNDnLOsSIkZ701s1kpkQizrlAlx5
 q7Iv/uZNAMsqFbhD84j70EFi0izEUL3dTnE6aYJrW4WQZ8je7Bme9db/kzHO7KKlJFp0lj3dT6e
 wkmxAeWkQn0gwWGAHlyt+PxaRJ6VEglAU6QjkY4p9G11gEUhHwJ+odiNP2fdnW2YpKJrp0mQ=
X-Received: by 2002:ad4:5ca9:0:b0:66d:2813:fd18 with SMTP id
 q9-20020ad45ca9000000b0066d2813fd18mr2079572qvh.52.1697808470707; 
 Fri, 20 Oct 2023 06:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH259nMjaI+r0DlZaHPHiz78Z5GYYNos6TtYOgEt8/Jfc7IvMeCW0gebq5a4HPpVbCOJhbXzA==
X-Received: by 2002:ad4:5ca9:0:b0:66d:2813:fd18 with SMTP id
 q9-20020ad45ca9000000b0066d2813fd18mr2079545qvh.52.1697808470331; 
 Fri, 20 Oct 2023 06:27:50 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 t16-20020a0cef10000000b0065afbb39b2dsm679620qvr.47.2023.10.20.06.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 06:27:50 -0700 (PDT)
Message-ID: <ce07caaa-f6c0-42db-af76-f89f80db83a5@redhat.com>
Date: Fri, 20 Oct 2023 15:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/s390x/s390-stattrib: Don't call
 register_savevm_live() during instance_init()
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>
References: <20231020125728.579747-1-thuth@redhat.com>
 <20231020125728.579747-4-thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231020125728.579747-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/10/2023 14.57, Thomas Huth wrote:
> We must not call register_savevm_live() from an instance_init() function
> (since this could be called multiple times during device introspection).
> Move this to the realize() function instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-stattrib.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index 52f9fc036e..3217263418 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -331,6 +331,17 @@ static const TypeInfo qemu_s390_stattrib_info = {
>   
>   /* Generic abstract object: */
>   
> +static SaveVMHandlers savevm_s390_stattrib_handlers = {
> +    .save_setup = cmma_save_setup,
> +    .save_live_iterate = cmma_save_iterate,
> +    .save_live_complete_precopy = cmma_save_complete,
> +    .state_pending_exact = cmma_state_pending,
> +    .state_pending_estimate = cmma_state_pending,
> +    .save_cleanup = cmma_save_cleanup,
> +    .load_state = cmma_load,
> +    .is_active = cmma_active,
> +};
> +
>   static void s390_stattrib_realize(DeviceState *dev, Error **errp)
>   {
>       bool ambiguous = false;
> @@ -339,6 +350,9 @@ static void s390_stattrib_realize(DeviceState *dev, Error **errp)
>       if (ambiguous) {
>           error_setg(errp, "storage_attributes device already exists");
>       }
> +
> +    register_savevm_live(TYPE_S390_STATTRIB, 0, 0,
> +                         &savevm_s390_stattrib_handlers, sas);
>   }

Oh, drat, I forgot to "git commit --amend" one remaining change: it should 
be "dev" instead of "sas" in above line, sorry for the confusion!

  Thomas


