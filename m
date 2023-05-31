Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3C7179C6
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:17:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4H0k-0008DJ-Cj; Wed, 31 May 2023 04:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4Gyi-0007dj-3n
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4Gyg-0007lf-GA
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685520881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Vl90yiFXgfFxyyxhhhgET6S2W0dmF11XxmGmIPrWHM=;
 b=C96Miy9XA8rsjr+vtpzrKEBwkXlKzRaJxp1dRRkJw9QJKwhxp0XP9zN5Us+iJ+GwXYb61J
 bTp6JYDAECEKMVAm4Nqy26EBAgSSlpua85v/EQiEEkJZPvZPesO768scgIoURBfT1H3kFF
 HZ0HdoFGwoMy8+mPWk9CK7VDr++/TCc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-3dcUz1DXMouxNgo07ivc3g-1; Wed, 31 May 2023 04:14:40 -0400
X-MC-Unique: 3dcUz1DXMouxNgo07ivc3g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f61408d926so21711805e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 01:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685520879; x=1688112879;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Vl90yiFXgfFxyyxhhhgET6S2W0dmF11XxmGmIPrWHM=;
 b=UHPZHp8i6dmZKzDoJMZD7RCEmW12pm5A3w4A3gfNzLKSUNvyKaNgXq3xOmAd7Wcl94
 YCfsxV8vzv2738XjyaROv/eU7RL1aTpBgQOdLmoZKXZ4oBXJmWsxVcyXy7sOFKSOWxDi
 TnksCF0sJKW/NWirN29SZqw2/ug+26V3goGCX0/SS0U+xSeBbjoc8UK2iSmnEoDFKIWp
 VyFIpXxtJtLU9w30aD5p33OSmEsg+US1mhgJ6LENoBtiding0nN0AhfmmKOxv6c/EVkm
 n9AKr/nYWkcsIcsNjIfkIaItlUwUMxCHbCWEHWz824cdHnZgPI307rSGOi6V91B3q5WK
 l5YQ==
X-Gm-Message-State: AC+VfDyDUqg07wSwHZZKVu+AWNc0bRFj/tEd+H3MHbelLM4BJ6G+21Eo
 MRoerwDGCZ9CPZNf1y/uuP0jZVU4KfBOPSWIz7LzENYbtgf0dPKFcLPA/XJ8+Z+dOofl30lqnRD
 OICqA4lGx9rUrQO8=
X-Received: by 2002:a7b:c408:0:b0:3f6:536:a4b2 with SMTP id
 k8-20020a7bc408000000b003f60536a4b2mr3109942wmi.27.1685520878977; 
 Wed, 31 May 2023 01:14:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4PqGx9usVyFEzMEA7de9k8aUo38yAgMeY8FCx4ZR7QmdEJanYqXeS8c+n1ni6oC1gtyQoIlQ==
X-Received: by 2002:a7b:c408:0:b0:3f6:536:a4b2 with SMTP id
 k8-20020a7bc408000000b003f60536a4b2mr3109925wmi.27.1685520878626; 
 Wed, 31 May 2023 01:14:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:cb00:fc9f:d303:d4cc:9f26?
 (p200300cbc749cb00fc9fd303d4cc9f26.dip0.t-ipconnect.de.
 [2003:cb:c749:cb00:fc9f:d303:d4cc:9f26])
 by smtp.gmail.com with ESMTPSA id
 7-20020a05600c230700b003f60a9ccd34sm19950253wmo.37.2023.05.31.01.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 01:14:38 -0700 (PDT)
Message-ID: <af5f1cb9-65ee-874f-fa20-8d0ad6fc42d2@redhat.com>
Date: Wed, 31 May 2023 10:14:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2 3/5] virtio-balloon: Add QMP functions for Working
 Set
Content-Language: en-US
To: "T.J. Alumbaugh" <talumbau@google.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Yuanchu Xie <yuanchu@google.com>,
 Yu Zhao <yuzhao@google.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>
References: <20230525222016.35333-1-talumbau@google.com>
 <20230525222016.35333-4-talumbau@google.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230525222016.35333-4-talumbau@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26.05.23 00:20, T.J. Alumbaugh wrote:
>    - Adds QMP function 'working-set-config'
>    - Adds QMP function 'working-set-request'
>    - Retrieve working set via 'guest-working-set' property on balloon
> 
>>> cat script.py
> 
> NAME = "name"
> SOCKET = 'vm.sock'
> BALLOON =  "/machine/peripheral/balloon0"
> 
> import json
> import asyncio
> from qemu.qmp import QMPClient
> 
> async def main():
>      client = QMPClient(NAME)
>      await client.connect(SOCKET)
>      config = { "i0": 200, "i1": 800, "i2": 3000, "refresh": 750, "report": 1000 }
>      await client.execute('working-set-config', config)
>      await client.execute('working-set-request')
>      property = {"path":BALLOON, "property":"guest-working-set"}
>      res = await client.execute('qom-get', property)
>      return res
> 
> if __name__ == "__main__":
>      ret = asyncio.run(main())
>      print(json.dumps(ret, indent=2))
> 
>>> (Execute qemu with flag '-qmp unix:path=vm.sock,server=on,wait=off'
>>> (Perform normal activities on VM to exercise MM code)
> 
>>> python3 script.py
> {
>    "working_set": {
>      "ws3": {
>        "memory-size-bytes": {
>          "anon": 890478592,
>          "file": 1285832704
>        },
>        "idle-age": 4294967292
>      },
>      "ws2": {
>        "memory-size-bytes": {
>          "anon": 173465600,
>          "file": 83353600
>        },
>        "idle-age": 3000
>      },
>      "ws1": {
>        "memory-size-bytes": {
>          "anon": 44236800,
>          "file": 20889600
>        },
>        "idle-age": 800
>      },
>      "ws0": {
>        "memory-size-bytes": {
>          "anon": 14540800,
>          "file": 6963200
>        },
>        "idle-age": 200
>      }
>    }
> }

Would it be possible to model that as QOM property instead? Then, we 
could use qom-get/qom-set on the device instead of having to craft new 
QMP/HMP functions.

-- 
Thanks,

David / dhildenb


