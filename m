Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D517D8618
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:38:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2Qa-0008OT-9C; Thu, 26 Oct 2023 11:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qw2QX-0008MR-PU
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qw2QU-0004yy-Q5
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698334658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=b0lWmI6nbzjgwyZxcZf4c8A5eVUumY2WAtySOEGC8Qc=;
 b=YC1AHHRp3L3dhJhfRODPEkUxtoodX51CRztjA4kRFXUZMr2O2D449VWbMxwBep5LuLLN9W
 taCCx263CUXaGPQ4hQgD5AJ80FdIcBUeezf7sazlcODuEdaX/lH0fShwbJC06jHmmG7WmT
 PfcTAcMmydh72Bf2nvR/tQFG+A5fRq0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-gR0DR7RZMM22dbRxPOtPfg-1; Thu, 26 Oct 2023 11:37:36 -0400
X-MC-Unique: gR0DR7RZMM22dbRxPOtPfg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b2cf504e3aso74397966b.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698334655; x=1698939455;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b0lWmI6nbzjgwyZxcZf4c8A5eVUumY2WAtySOEGC8Qc=;
 b=eo/vi/vkSpIjIragO5nBes+z6w+otxjhJX4ESrWjD8HvaHsKQ5PQ9bNLEN0GqVn8YN
 MC33CC+moIchDIjGBMA62+OPlQuSO8i1xW+qxbCyaN6+UQnmAfcNRi+mjkewjCe/rJZH
 7HgBuZ2AdUm2nHZ2wxtsYJIAeVZXhXI2buPKSrwL8ej382bkEUSH/quabEAlqFyXrR72
 MESKO+GyaSvtl68QuK6o07ARdUqq7gGHqAkctHRBhCzNBVyZBwtwqaDbo07wOb4JGUct
 f/b7ZqtDHWwPZQ79qCyPfSJ4anbrAAjIFd+1K+63c6DqGvPELZqHLZPyAzfRoGB+qihk
 Ybxw==
X-Gm-Message-State: AOJu0YxvRvokjwLiV8MsSGu/h5CEiZxeUSDtkWUnilm3RG0Nw3qzt7k4
 pV2Pw+UGuG2s1J+syilILFjVclLlOEyuHfvozu+n6kG7KvXc8skdqlPdcQx2zzECEqpAcr6n5O3
 9Rju1anZeZzsXHK0=
X-Received: by 2002:a17:907:7ba2:b0:9ae:82b4:e306 with SMTP id
 ne34-20020a1709077ba200b009ae82b4e306mr22348ejc.62.1698334655405; 
 Thu, 26 Oct 2023 08:37:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2C0+1Scb0uJKpfl24hw4+Ur62cxz3VhC3SRbvR/MVndk4zAClVYvUR8V9GThPq2f0jf1guA==
X-Received: by 2002:a17:907:7ba2:b0:9ae:82b4:e306 with SMTP id
 ne34-20020a1709077ba200b009ae82b4e306mr22306ejc.62.1698334654979; 
 Thu, 26 Oct 2023 08:37:34 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-238.web.vodafone.de.
 [109.43.176.238]) by smtp.gmail.com with ESMTPSA id
 h11-20020a1709063b4b00b009b9aa8fffdasm11819659ejf.131.2023.10.26.08.37.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 08:37:34 -0700 (PDT)
Message-ID: <b17732f1-cc45-4c46-bbfc-56268630e7f6@redhat.com>
Date: Thu, 26 Oct 2023 17:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/39] hw/s390x/s390-stattrib: Simplify handling of the
 "migration-enabled" property
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Corey Minyard <minyard@acm.org>, Li Zhijian <lizhijian@fujitsu.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann
 <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 libvir-list@redhat.com, Stefan Weil <sw@weilnetz.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org
References: <20231024131305.87468-1-quintela@redhat.com>
 <20231024131305.87468-21-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20231024131305.87468-21-quintela@redhat.com>
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
> There's no need for dedicated handlers here if they don't do anything
> special.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Acked-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-ID: <20231020150554.664422-3-thuth@redhat.com>
> ---
>   hw/s390x/s390-stattrib.c | 26 ++++++--------------------
>   1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index 220e845d12..52f9fc036e 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -13,6 +13,7 @@
>   #include "qemu/units.h"
>   #include "migration/qemu-file.h"
>   #include "migration/register.h"
> +#include "hw/qdev-properties.h"
>   #include "hw/s390x/storage-attributes.h"
>   #include "qemu/error-report.h"
>   #include "exec/ram_addr.h"
> @@ -340,6 +341,10 @@ static void s390_stattrib_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> +static Property s390_stattrib_props[] = {
> +    DEFINE_PROP_BOOL("migration-enabled", S390StAttribState, migration_enabled, true),

This needs a  DEFINE_PROP_END_OF_LIST() here, too ... sorry for that!
/me is looking for his brown paper-bags...

  Thomas

> +};
> +
>   static void s390_stattrib_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -347,22 +352,7 @@ static void s390_stattrib_class_init(ObjectClass *oc, void *data)
>       dc->hotpluggable = false;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       dc->realize = s390_stattrib_realize;
> -}
> -
> -static inline bool s390_stattrib_get_migration_enabled(Object *obj,
> -                                                       Error **errp)
> -{
> -    S390StAttribState *s = S390_STATTRIB(obj);
> -
> -    return s->migration_enabled;
> -}
> -
> -static inline void s390_stattrib_set_migration_enabled(Object *obj, bool value,
> -                                            Error **errp)
> -{
> -    S390StAttribState *s = S390_STATTRIB(obj);
> -
> -    s->migration_enabled = value;
> +    device_class_set_props(dc, s390_stattrib_props);
>   }
>   
>   static SaveVMHandlers savevm_s390_stattrib_handlers = {
> @@ -383,10 +373,6 @@ static void s390_stattrib_instance_init(Object *obj)
>       register_savevm_live(TYPE_S390_STATTRIB, 0, 0,
>                            &savevm_s390_stattrib_handlers, sas);
>   
> -    object_property_add_bool(obj, "migration-enabled",
> -                             s390_stattrib_get_migration_enabled,
> -                             s390_stattrib_set_migration_enabled);
> -    object_property_set_bool(obj, "migration-enabled", true, NULL);
>       sas->migration_cur_gfn = 0;
>   }
>   


