Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3453E7BD7B4
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:53:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmwc-0004Q6-JJ; Mon, 09 Oct 2023 05:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpmwa-0004NF-2k
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpmwY-0006kG-KQ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696845173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=En75g29PkojWFhu+j4pAcgz3uJFORG/4ykVQBjlGczQ=;
 b=cgDI8sFoATMz47rt96yvuNsH0UuSdUeg0bQzlHNWcU9znIn7WSLdVuUaaMJFueTpZF2JlD
 tft4LEUxCmG5Z/OPGunW/SuMrftW12bhh25VH3MgbUCvVK9O6+Dpj6LIaLfsKWIvF6edYE
 yWR+CVgQPa20OB91ZW9theFFup4NsD0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-YnZmbF8tNmKFFo8tV0WUfw-1; Mon, 09 Oct 2023 05:52:41 -0400
X-MC-Unique: YnZmbF8tNmKFFo8tV0WUfw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4055ce1e8c4so23981555e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845160; x=1697449960;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=En75g29PkojWFhu+j4pAcgz3uJFORG/4ykVQBjlGczQ=;
 b=FsExNKp9U9Klb3JanJVEdqEz15Z3dzIstW5weaMt4W9XXTQQvoiw8FwwkRfJA91Onz
 Zv0E6pqJMGJy6V5evhbVEc6U02GrbTjGQGBG9DB+aCWVIQ3+4ROtz8ugsolsx3GqGYMW
 s2sot+LPAP+XFmMQKsKbiv5wxw+5pHsesbEhgHOcyI9TRSG9Yd4J+6jQoRhfc3ntvh2o
 AtatM5/Uqhg4vkizzqZtPCFx8be76+JCkQc9nUarEpsN3WY99XDomHHo+5qfVt9YdxJQ
 rIBlFX6rZoUu4x7nDeT8AS89+Q6WITH0AbONDknQSllnycFrdDeL2TuQV6dO+pAbHRXC
 X59Q==
X-Gm-Message-State: AOJu0YwmvSoW5EijFm5p5Ng2TiFdfgVclit1A086YZQpUv8A5y65spsi
 jZURX+s8TlTwOx5ZaroKgYo0Q7XriDrThCXEJxyrPbjlz0Q803SltGPNwGlYFWWxvxb+xl+g3UR
 8nqKijNJ1d80fy9g=
X-Received: by 2002:a05:600c:1c96:b0:405:3622:382c with SMTP id
 k22-20020a05600c1c9600b004053622382cmr9631272wms.17.1696845160075; 
 Mon, 09 Oct 2023 02:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg8Rzc6APCwOav22QZTJSSJwTxSNf4VLWv0e9UnJX3Y6cbNg0264OC5ojRTw/iVQNhUVwaeA==
X-Received: by 2002:a05:600c:1c96:b0:405:3622:382c with SMTP id
 k22-20020a05600c1c9600b004053622382cmr9631238wms.17.1696845159604; 
 Mon, 09 Oct 2023 02:52:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548?
 (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de.
 [2003:cb:c733:6400:ae10:4bb7:9712:8548])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c470a00b00407460234f9sm5133793wmo.21.2023.10.09.02.52.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 02:52:39 -0700 (PDT)
Message-ID: <24a020d0-3e9f-b1f0-5729-84d66b066b96@redhat.com>
Date: Mon, 9 Oct 2023 11:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/6] hw/s390x: Clean up global variable shadowing in
 quiesce_powerdown_req()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20231009094747.54240-1-philmd@linaro.org>
 <20231009094747.54240-7-philmd@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231009094747.54240-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 09.10.23 11:47, Philippe Mathieu-Daudé wrote:
> Fix:
> 
>    hw/s390x/sclpquiesce.c:90:22: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>        QuiesceNotifier *qn = container_of(n, QuiesceNotifier, notifier);
>                         ^
>    hw/s390x/sclpquiesce.c:86:3: note: previous declaration is here
>    } qn;
>      ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/s390x/sclpquiesce.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
> index ce07b16884..a641089929 100644
> --- a/hw/s390x/sclpquiesce.c
> +++ b/hw/s390x/sclpquiesce.c
> @@ -78,12 +78,10 @@ static const VMStateDescription vmstate_sclpquiesce = {
>        }
>   };
>   
> -typedef struct QuiesceNotifier QuiesceNotifier;
> -
> -static struct QuiesceNotifier {
> +typedef struct QuiesceNotifier {
>       Notifier notifier;
>       SCLPEvent *event;
> -} qn;
> +} QuiesceNotifier;
>   
>   static void quiesce_powerdown_req(Notifier *n, void *opaque)
>   {
> @@ -97,6 +95,8 @@ static void quiesce_powerdown_req(Notifier *n, void *opaque)
>   
>   static int quiesce_init(SCLPEvent *event)
>   {
> +    static QuiesceNotifier qn;
> +
>       qn.notifier.notify = quiesce_powerdown_req;
>       qn.event = event;
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


