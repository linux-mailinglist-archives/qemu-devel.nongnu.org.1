Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD507D8614
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2Ow-0006hi-IJ; Thu, 26 Oct 2023 11:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qw2Ou-0006h4-Ov
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qw2Os-0004Rg-Fu
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698334556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5Qh35c9c5z9vLgTiIFfl9j6up82I/dDNDvBApoL3zmE=;
 b=Eg/xdIReKOY3LP8+II13GmNDNRFijlkPrFoZVyQfsvQLv1uZqGzqbXh6AtTXrGm3KKUNNC
 5S5wARIHy2gmARvr1GVv9PgHNpEIlTn+n9X3xp2AgXZJOa3LRrkSuoIb9ZpSRYtfT/0uBu
 /KBMSqyJKdepNLQkg98PZWuJD7Q28SI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-TvhQoftOPsSc5qpX0Y2Ndg-1; Thu, 26 Oct 2023 11:35:55 -0400
X-MC-Unique: TvhQoftOPsSc5qpX0Y2Ndg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b65c46bca8so73903766b.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698334554; x=1698939354;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Qh35c9c5z9vLgTiIFfl9j6up82I/dDNDvBApoL3zmE=;
 b=RBwJUHhsa4fdA2/oTrhbJAsHRwsOb4TQZfL/xpGCoc8h6ffoBBuSpBMarHI7bjExUU
 hvEQwvqX+yIwD2aHqYQ/UR1YOoXVdYs49+xwGoytqispIL6oUJTe7nBiJFEED4Fw33B2
 u0C0I1hwsAulK2ihsKkTvaZv0jts+KE0ctsTKXbVqcxOwZ+30Xb3XjlHQJlQS9la8o+7
 wA34Y7xPDHsTWA21iCiQ7GpTlZ5GEPIqv/YAauJ6hdHG5gEFIhMybQMOM6QaW9LKZTM7
 gZaGEOjq9cqtv0Ez7ikYu+TCMm19vyszeWheelgZ1HkhUptYXpKOAgXOIjOjvFNmVkWd
 GONw==
X-Gm-Message-State: AOJu0YwU9zbEBFPM9WhuyO/+KFX7gvGx7erchDpyTNzj6lySU0IWu/l3
 A+WdQ34rop0mnF+7v33oCDgeYwl53GlQ4NXHxSvpAnU9d/GQmiMc6y9Pds2RgtHJVzSIzyaZBh2
 J+pvtEe9FTFQg5FA=
X-Received: by 2002:a17:906:c150:b0:9bf:63b2:b6f0 with SMTP id
 dp16-20020a170906c15000b009bf63b2b6f0mr19070ejc.29.1698334554090; 
 Thu, 26 Oct 2023 08:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENjKaRA1rML5KGXs5qGIasq0EWe/2kcUc1rJzPYXL1oKJ1ZRASxHVRWpV02H0yf5req3MWBg==
X-Received: by 2002:a17:906:c150:b0:9bf:63b2:b6f0 with SMTP id
 dp16-20020a170906c15000b009bf63b2b6f0mr19037ejc.29.1698334553715; 
 Thu, 26 Oct 2023 08:35:53 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-238.web.vodafone.de.
 [109.43.176.238]) by smtp.gmail.com with ESMTPSA id
 h11-20020a1709063b4b00b009b9aa8fffdasm11819659ejf.131.2023.10.26.08.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 08:35:53 -0700 (PDT)
Message-ID: <8e83c7e4-f595-463b-91d1-f5112392461a@redhat.com>
Date: Thu, 26 Oct 2023 17:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 19/39] hw/s390x/s390-skeys: Don't call
 register_savevm_live() during instance_init()
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Li Zhijian <lizhijian@fujitsu.com>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Corey Minyard <minyard@acm.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 David Hildenbrand <david@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-ppc@nongnu.org
References: <20231024131305.87468-1-quintela@redhat.com>
 <20231024131305.87468-20-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231024131305.87468-20-quintela@redhat.com>
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

On 24/10/2023 15.12, Juan Quintela wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Since the instance_init() function immediately tries to set the
> property to "true", the s390_skeys_set_migration_enabled() tries
> to register a savevm handler during instance_init(). However,
> instance_init() functions can be called multiple times, e.g. for
> introspection of devices. That means multiple instances of devices
> can be created during runtime (which is fine as long as they all
> don't get realized, too), so the "Prevent double registration of
> savevm handler" check in the s390_skeys_set_migration_enabled()
> function does not work at all as expected (since there could be
> more than one instance).
> 
> Thus we must not call register_savevm_live() from an instance_init()
> function at all. Move this to the realize() function instead. This
> way we can also get rid of the property getter and setter functions
> completely, simplifying the code along the way quite a bit.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Acked-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-ID: <20231020150554.664422-2-thuth@redhat.com>
> ---
>   hw/s390x/s390-skeys.c | 35 ++++++++---------------------------
>   1 file changed, 8 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index 5024faf411..8e9d9e41e8 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -12,6 +12,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
>   #include "hw/boards.h"
> +#include "hw/qdev-properties.h"
>   #include "hw/s390x/storage-keys.h"
>   #include "qapi/error.h"
>   #include "qapi/qapi-commands-misc-target.h"
> @@ -432,58 +433,38 @@ static int s390_storage_keys_load(QEMUFile *f, void *opaque, int version_id)
>       return ret;
>   }
>   
> -static inline bool s390_skeys_get_migration_enabled(Object *obj, Error **errp)
> -{
> -    S390SKeysState *ss = S390_SKEYS(obj);
> -
> -    return ss->migration_enabled;
> -}
> -
>   static SaveVMHandlers savevm_s390_storage_keys = {
>       .save_state = s390_storage_keys_save,
>       .load_state = s390_storage_keys_load,
>   };
>   
> -static inline void s390_skeys_set_migration_enabled(Object *obj, bool value,
> -                                            Error **errp)
> +static void s390_skeys_realize(DeviceState *dev, Error **errp)
>   {
> -    S390SKeysState *ss = S390_SKEYS(obj);
> -
> -    /* Prevent double registration of savevm handler */
> -    if (ss->migration_enabled == value) {
> -        return;
> -    }
> -
> -    ss->migration_enabled = value;
> +    S390SKeysState *ss = S390_SKEYS(dev);
>   
>       if (ss->migration_enabled) {
>           register_savevm_live(TYPE_S390_SKEYS, 0, 1,
>                                &savevm_s390_storage_keys, ss);
> -    } else {
> -        unregister_savevm(VMSTATE_IF(ss), TYPE_S390_SKEYS, ss);
>       }
>   }
>   
> -static void s390_skeys_instance_init(Object *obj)
> -{
> -    object_property_add_bool(obj, "migration-enabled",
> -                             s390_skeys_get_migration_enabled,
> -                             s390_skeys_set_migration_enabled);
> -    object_property_set_bool(obj, "migration-enabled", true, NULL);
> -}
> +static Property s390_skeys_props[] = {
> +    DEFINE_PROP_BOOL("migration-enabled", S390SKeysState, migration_enabled, true),

This needs a  DEFINE_PROP_END_OF_LIST() here ... mea culpa!

  Thomas


> +};
>   
>   static void s390_skeys_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
>   
>       dc->hotpluggable = false;
> +    dc->realize = s390_skeys_realize;
> +    device_class_set_props(dc, s390_skeys_props);
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>   }
>   
>   static const TypeInfo s390_skeys_info = {
>       .name          = TYPE_S390_SKEYS,
>       .parent        = TYPE_DEVICE,
> -    .instance_init = s390_skeys_instance_init,
>       .instance_size = sizeof(S390SKeysState),
>       .class_init    = s390_skeys_class_init,
>       .class_size    = sizeof(S390SKeysClass),


