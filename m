Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF087BD7B2
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:52:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmw9-0002ip-EN; Mon, 09 Oct 2023 05:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpmvr-0002VG-UR
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpmvn-0006dt-DF
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696845124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tY1fx0oUl83Px2HKTUKE+lWEYLrGHv0bqjRaJqw5zxk=;
 b=LcfSeK9TUGAqZzkWvI1ClNdMxUqYpZ80Tx6LAPALCm8v1i3vJe6MMxGxBaRGN21mNFxF02
 e9zb6iczqHQSRWR8dOCiNiXLUv4KCwTmtDos5aWkjXt+juNd5VwiLgsNVF+rZ2lgeDTCno
 CzHTWJ+VpzmLiNWPHED/deW4BbhqIjs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-YksONppUMGm3bE35wyQLNQ-1; Mon, 09 Oct 2023 05:52:01 -0400
X-MC-Unique: YksONppUMGm3bE35wyQLNQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41b000137e9so43366401cf.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845121; x=1697449921;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tY1fx0oUl83Px2HKTUKE+lWEYLrGHv0bqjRaJqw5zxk=;
 b=kZQsesA4Le9PVU4wTFAsQ7dE+CKSXN2FI6bOzCJ6fy0DySHMNfkvz8OykwoKjFCuk5
 q5yuPD+CC+kFo/PWdUG/e5yX/i5cM0B/bmd21n2PPTUsN46zuREY1C8TPqhKthNKOnTo
 eAyJBIRsBKq3QFlS+ypU8Dg3EMxhcvEme3IvvSqkZM17Ofn/3O/n33GNQPAqW0gx9IBE
 kfZAPQes/47OjO3Dd367KakAMG3T20y09XJ4nq4Emnht3DNTJncOJUn6EZ0pk9bHs0Je
 83IhdW+gnI68zImp/kQIXTxLqjYSYjKf96LMsTaQNcDIY8PKjauKTzsr5OKkzhLq5zFE
 eHwA==
X-Gm-Message-State: AOJu0YwLXKcjfkTMdM3ECsDaO2gG/cNRvP+wMKUT9mtz7jsuAoA3VAJA
 iD0DaA1VCuu9RZI2KAZkzRB3ntD2Oh29GPs6I0VidrLHR7QwWG++WSmS03IXHqxR//cy+wbA+v1
 W+oGJlB4Nnf+Ga78=
X-Received: by 2002:a05:622a:1014:b0:410:840c:def7 with SMTP id
 d20-20020a05622a101400b00410840cdef7mr17919712qte.25.1696845121234; 
 Mon, 09 Oct 2023 02:52:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVwrf1WF69RXgd6VMgul35LlJANIE+RO9K/t6X+NYoi2NgBR7V3o5qssLgdouCKBBfTdHZ2w==
X-Received: by 2002:a05:622a:1014:b0:410:840c:def7 with SMTP id
 d20-20020a05622a101400b00410840cdef7mr17919691qte.25.1696845120984; 
 Mon, 09 Oct 2023 02:52:00 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 8-20020ac85648000000b00419792c1be7sm3562271qtt.30.2023.10.09.02.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 02:52:00 -0700 (PDT)
Message-ID: <b76ce5e9-bd99-6e4b-c6fe-361e7d45fd35@redhat.com>
Date: Mon, 9 Oct 2023 11:51:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/6] hw/s390x: Clean up global variable shadowing in
 quiesce_powerdown_req()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, David Hildenbrand <david@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20231009094747.54240-1-philmd@linaro.org>
 <20231009094747.54240-7-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231009094747.54240-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 09/10/2023 11.47, Philippe Mathieu-Daudé wrote:
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

Reviewed-by: Thomas Huth <thuth@redhat.com>


