Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F2D7937D6
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:15:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdocI-0000bp-Ne; Wed, 06 Sep 2023 05:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdocH-0000bb-0O
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdocE-00056d-U1
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693991665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWuC4wtKekDBaTR4wMG6G7iw0F2/8ouR7UMsRlO8DjU=;
 b=MIoTmY9Fg/prLZXjq+1j93F7w8bNJQZc5bVvwpf7iXDlLSHG4vbDYqZK2ibIg0EQyNQlNk
 TaCtptFPS7c2yrZXTnEZ2BLfH/JoGW9na/ZCivnFu3LWspiZR+qZA9ZTjXJ44UiIcA84lR
 EtFzaEYdfxGUxbSh7O4Ea1AippnN3mM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-rqss_j6YP--QKG41EaFi1w-1; Wed, 06 Sep 2023 05:14:22 -0400
X-MC-Unique: rqss_j6YP--QKG41EaFi1w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31aecb86dacso1734896f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693991662; x=1694596462;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RWuC4wtKekDBaTR4wMG6G7iw0F2/8ouR7UMsRlO8DjU=;
 b=iVvPamQBISSnybzoLAxO1M5AZZmp8t+eqrkZAwupjLpmlgBYR+F1t8Jjhu1ZbOMzd4
 i6SJfcwX9XRJa4iG0A5JfZUjLBvNrzKsoOJAPfp1LYsw5BNbeZ6ztd6wpaKDJuV9haKO
 N4AMAC9ShRaRt5B2yASUMJG/t/GrM8kkJLy55VzIBInBGUh1oxZX44J8gS9nVTuP8vXR
 7sesBa16mPzslHRtue3SPL0WKsxQNn4/5R4KdgvHmNaV+QUI5JgFZnzdyA6iOEp9J4uY
 cgYWkVpCkiB8TwrMfD7E7UwY+Z4SCpYXxar4ZyuyUMqr4dZNByj2fZBiCWTrMfcA8KRQ
 hADQ==
X-Gm-Message-State: AOJu0YzUn14wv65lSqsEWJ2K+TuB5GL+FACTtPeYoAEC50N/T6WbnvZu
 WCB4dJu+b/VfSkk39AFR/BRInenrEVVNPbhwaE19eBsmUnUX67sXC+UnBCnQpvtuSyrS5qrCZ6R
 +sL4IBkq2aIvD9I8=
X-Received: by 2002:adf:ef52:0:b0:319:55bc:4416 with SMTP id
 c18-20020adfef52000000b0031955bc4416mr1676010wrp.5.1693991661845; 
 Wed, 06 Sep 2023 02:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1EwSWifb5IAGKkrhNiDVo5oHDUJH/3qKu0AJGWTWwtxKcWDs+MIBY76wVNbAFcKk9m1+Umg==
X-Received: by 2002:adf:ef52:0:b0:319:55bc:4416 with SMTP id
 c18-20020adfef52000000b0031955bc4416mr1675984wrp.5.1693991661431; 
 Wed, 06 Sep 2023 02:14:21 -0700 (PDT)
Received: from [10.33.192.187] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a5d4ac3000000b003141a3c4353sm19832736wrs.30.2023.09.06.02.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 02:14:20 -0700 (PDT)
Message-ID: <ef804f8b-3295-df6b-7dec-b2f5d9c9a394@redhat.com>
Date: Wed, 6 Sep 2023 11:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v22 10/20] machine: adding s390 topology to info
 hotpluggable-cpus
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-11-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230901155812.2696560-11-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 01/09/2023 17.58, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> S390 topology adds books and drawers topology containers.
> Let's add these to the HMP information for hotpluggable cpus.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   hw/core/machine-hmp-cmds.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index c3e55ef9e9..9a4b59c6f2 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -71,6 +71,12 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
>           if (c->has_node_id) {
>               monitor_printf(mon, "    node-id: \"%" PRIu64 "\"\n", c->node_id);
>           }
> +        if (c->has_drawer_id) {
> +            monitor_printf(mon, "    drawer-id: \"%" PRIu64 "\"\n", c->drawer_id);
> +        }
> +        if (c->has_book_id) {
> +            monitor_printf(mon, "    book-id: \"%" PRIu64 "\"\n", c->book_id);
> +        }
>           if (c->has_socket_id) {
>               monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n", c->socket_id);
>           }

Reviewed-by: Thomas Huth <thuth@redhat.com>


