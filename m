Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B705A35B64
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Feb 2025 11:20:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tismq-0005aY-EE; Fri, 14 Feb 2025 05:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tisml-0005a4-Sb
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:19:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tismj-0007Et-Of
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739528339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vWsZAmVt/ayC/zlDSnFOsriQQwG+k+2D4Q0xaZbSRHE=;
 b=fmdm56YlW4itrrABhjoffs/K7SOB52CB5SMAwkN6IxS7/byTeGsUvGCH20fR3UQjWX3A9Z
 F1UK3bwzRIxn9e4vcB18afxwzpV839+vcI5UVnChtd6pxukYOc2uvfOi056utWaN8Sjmst
 D1uMvUowEkeiBY7nsYT4rXAN5j40v48=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-6JpeE2IpPRmmQq6t34QN9g-1; Fri, 14 Feb 2025 05:18:58 -0500
X-MC-Unique: 6JpeE2IpPRmmQq6t34QN9g-1
X-Mimecast-MFC-AGG-ID: 6JpeE2IpPRmmQq6t34QN9g_1739528337
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-438e4e9a53fso14080135e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 02:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739528337; x=1740133137;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWsZAmVt/ayC/zlDSnFOsriQQwG+k+2D4Q0xaZbSRHE=;
 b=jPZf8jLwBId+dkiROSjZ8rT6tR771rzNc1I86EIzSKVrgNtxQeFaUVHdTQf9sXUOQJ
 VVNpsxGBzrGaQXyQmZq3HMmCGrvHFktF8WKzLT9K9OAm0mbnEoZYUIiBnGtwuUTv+pGw
 HQwkKRRqaHtlZkIrZaKCM6FVmfoGsHIvHrOyq+RJTpDeZVwUoSB3GdXUfyEQLsSpVX18
 pX6w61aHIJrkoem42uaKIks+OnQWIawqixl6sNIxjcWEwDvBeTtb5GTM8hEbSdqN8vYV
 JM6YeTPOrYyW/OZI+X5cSDvgRkKPq8mbdrDU91bww53Yr5GLulCu9YFgIvBgD2NWrYfq
 Yx/A==
X-Gm-Message-State: AOJu0YybsXh4obnBhNYvEcmmhWbIaDtS0gkH6c5yLcJDK+FRpRM52Fas
 LN6kN6yoN8L/4Iwl+24RI8xupLWDt2cFKq9wT+7lAUxpq3GGOm0wuTzIENwCSfNQi6Gprxjrc0D
 3i5+9aD6fkyTzRSXzxbswmOIcmvza4hccFAmVlu4AjpirOf0627MY
X-Gm-Gg: ASbGncs+9VktLFz2ClnyARQ/rrp5g91z+cJX6I0rrYTQrCD968Do+1vM0XtExScRvV0
 rv7RFgIVT5O7AtaZx4ZSceoxrzae8g5rayB92DJhSXdrFi7b8qcWBR7CHKhjYAKEFK45lGsb+gO
 qqRTpiTW7+Qk4QVevJVDPueGxoVe8FkT7wogyItKzcC3JV4Ke5gf9bjdiv8A551yx474+WgUIKH
 ZwsJ/ooQShYW+2K/hhDYf3xDbLWi2SX2hGz7cvzv9WPt9MKxCWWmadcAGBNyWlTn54nkd4le6uD
 zavEnrrgTTYMKq3hxfRzifY5ZuJQZLtV1qYalV3IPRI=
X-Received: by 2002:a05:600c:4ecd:b0:439:6b12:e8b1 with SMTP id
 5b1f17b1804b1-4396b12ea01mr5829945e9.9.1739528336907; 
 Fri, 14 Feb 2025 02:18:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAcmByNMwXvoeIDjoefBnh67AMUJP04xg1ROFo19qBkasCV/snSroDXLh70gqmzjkOG6VTKg==
X-Received: by 2002:a05:600c:4ecd:b0:439:6b12:e8b1 with SMTP id
 5b1f17b1804b1-4396b12ea01mr5829645e9.9.1739528336506; 
 Fri, 14 Feb 2025 02:18:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43961884251sm39822255e9.31.2025.02.14.02.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2025 02:18:56 -0800 (PST)
Message-ID: <2c5358eb-1abe-4fce-8b28-7935c71f1cff@redhat.com>
Date: Fri, 14 Feb 2025 11:18:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: vhost-user: add QAPI events to report connection
 state
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laine Stump <laine@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250214072629.1033314-1-lvivier@redhat.com>
 <871pw07sdy.fsf@pond.sub.org>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <871pw07sdy.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/02/2025 11:06, Markus Armbruster wrote:
> Laurent Vivier <lvivier@redhat.com> writes:
> 
>> The netdev reports NETDEV_VHOST_USER_CONNECTED event when
>> the chardev is connected, and NETDEV_VHOST_USER_DISCONNECTED
>> when it is disconnected.
>>
>> The NETDEV_VHOST_USER_CONNECTED event includes the ChardevInfo
>> (label, filename and frontend_open).
>>
>> This allows a system manager like libvirt to detect when the server
>> fails.
>>
>> For instance with passt:
>>
>> { 'execute': 'qmp_capabilities' }
>> { "return": { } }
>>
>> [killing passt here]
>>
>> { "timestamp": { "seconds": 1739517243, "microseconds": 115081 },
>>    "event": "NETDEV_VHOST_USER_DISCONNECTED",
>>    "data": { "netdev-id": "netdev0" } }
>>
>> [automatic reconnection with reconnect-ms]
>>
>> { "timestamp": { "seconds": 1739517290, "microseconds": 343777 },
>>    "event": "NETDEV_VHOST_USER_CONNECTED",
>>    "data": { "netdev-id": "netdev0",
>>              "info": { "frontend-open": true,
>>                        "filename": "unix:",
>>                        "label": "chr0" } } }
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> Standard question for events: if a management application misses an
> event, say because it restarts and reconnects, is there a way to obtain
> the missed information with a query command?
> 

query-chardev could help but it doesn't provide the netdev id.

in HMP, "info network" has the information, but for QMP we had a try with a query-netdev 
in the past but the series has been reverted.

f9bb0c1f9862 ("Revert "qapi: net: Add query-netdev command"")
d32ad10a14d4 ("qapi: net: Add query-netdev command")

Thanks,
Laurent
Thanks
Laurent


