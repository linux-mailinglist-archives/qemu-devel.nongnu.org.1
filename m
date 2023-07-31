Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED967768EA3
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNHr-0007o5-Co; Mon, 31 Jul 2023 03:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQNHp-0007na-19
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQNHm-0008Qb-Bs
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690788345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NeJ0W7HCvVK0huM1Y8r6Mxi9XEmZB3mtKJyMhRaHWqM=;
 b=Mu2ahiJ8w3ZW7wfe9AD3HAMfYGdIpysMJyNG/WQ9wwbdYVss9B7dNN2Onub4inswoUZqI0
 GDnNor4MeWgjoOt6W0QKlZ4Y6ZNPPMAzVg+PdnB6jY7pZyjSNmaQpO07t+zT9eogPVzmQl
 3ahin5uC3fK6OAi0RtyfdlAbAqWaN08=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-RWNEVgE_PVuH8GJAFo6S8g-1; Mon, 31 Jul 2023 03:25:43 -0400
X-MC-Unique: RWNEVgE_PVuH8GJAFo6S8g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76c7e6b9e16so187015885a.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 00:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690788342; x=1691393142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NeJ0W7HCvVK0huM1Y8r6Mxi9XEmZB3mtKJyMhRaHWqM=;
 b=ddiJs1YwvffVXGn2OlU1kn5hSVpR4UaKepUEK7Eps6002+xJgHVuWLamJd5e2C/1Dj
 gmvuwZVSXQKxTwQXZzthgUoKS67SEtL0ICkuOJQEe6GTLkoAXISnPxdQWN0QFy7JUytP
 5VbsKm00d5Nqj7CC/TvJYEbr01LZvyECb9Z6wvuXWL+swL7nzEIaDLkQ+OII4Sck/tqj
 b83uwU/wHeq8UrABGpKBcDa9L4ucaSdV6haurW/crprci+3/uaZhF6MMnlO0RPonMEOn
 16daRSk/Dvsm8mzVYXf4CT5jDVsHCUcjfbYtYUquzMRA6QzMAcRKGYOm9gqZ9b98fmvW
 vg9Q==
X-Gm-Message-State: ABy/qLaAdC3hp5eEkJQ0MFhFXjkODqiBvkiVsmbrRZjGlCvbviIWX6ui
 igurre+4rf8LjhxkhCvsDUg/nIIivHKA4vUQYIrl4LxeVwbHtmW+hMqfyestsidjis0DDRFe8qt
 zHWsur/7cPoxjV18=
X-Received: by 2002:a05:620a:410a:b0:75e:bdee:367e with SMTP id
 j10-20020a05620a410a00b0075ebdee367emr7768689qko.47.1690788342756; 
 Mon, 31 Jul 2023 00:25:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEOIr3QoUDJm/l3eM9XiVePEXrxvnyYm2/VRwBeBIPlQpTet7OsIt2VSc+bmXW7KVyv9P0l7A==
X-Received: by 2002:a05:620a:410a:b0:75e:bdee:367e with SMTP id
 j10-20020a05620a410a00b0075ebdee367emr7768680qko.47.1690788342471; 
 Mon, 31 Jul 2023 00:25:42 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a0ce3d2000000b00635efe2f65csm3522394qvl.30.2023.07.31.00.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 00:25:42 -0700 (PDT)
Message-ID: <6187ba85-5082-02e9-159b-1abb6b6371e9@redhat.com>
Date: Mon, 31 Jul 2023 09:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Content-Language: en-US
To: "Liu, Jing2" <jing2.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-2-jing2.liu@intel.com>
 <841b1ff1-0a50-e9c9-d405-256a16ffdf8c@redhat.com>
 <DS0PR11MB8114B633ED8814B272673415A906A@DS0PR11MB8114.namprd11.prod.outlook.com>
 <8e44b87f-c22c-9071-1ffe-7d16cff58869@redhat.com>
 <DS0PR11MB8114EDC8682BC265FFFA34C8A905A@DS0PR11MB8114.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <DS0PR11MB8114EDC8682BC265FFFA34C8A905A@DS0PR11MB8114.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/31/23 05:57, Liu, Jing2 wrote:
> Hi C.
> 
>> On July 28, 2023 4:44 PM, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> [ ... ]
>>
>>> Sorry I didn't quite understand "info.flags be tested against
>> VFIO_IRQ_INFO_NORESIZE".
>>> I saw kernel < 6.4 simply added NORESIZE to info.flags and latest kernel adds
>> if has_dyn_msix.
>>> Would you please kindly describe more on your point?
>>
>> I was trying to find the conditions to detect safely that the kernel didn't have
>> dynamic MSI-X support. Testing VFIO_IRQ_INFO_NORESIZE seems enough.
>>
> Oh, I see.
> 
>>>> In that case, QEMU should report an error and the trace event is not
>> needed.
>>>
>>> I replied an email with new error handling draft code based on my
>>> understanding, which reports the error and need no trace. Could you please
>> help review if that is what we want?
>>
>> yes. It looked good. Please send a v1 !
> 
> Thanks for reviewing that. I guess you mean v2 for next version 😊

Well, if you remove the RFC status, I think you should, this would
still be a v1.

Thanks,

C.


