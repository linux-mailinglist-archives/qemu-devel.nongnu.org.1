Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C2C7A5C63
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:20:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiVyC-0003J8-64; Tue, 19 Sep 2023 04:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiVy8-0003Iz-Bd
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiVy6-0000aH-Cg
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695111625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRJyxaNCdh5UcI/31P9hieAgHH3op5LoYI7ipTFtsHE=;
 b=N/0sc+/YqGA+ZRHtRNvTQpeIFjuLFuIGzmO+Cz5Hcp70fNUjZv+inKSVNFX8qtTLUgcMvr
 PPqmhXTnoe4sL56BmjlFjZ0BG0p8jPKSWpUxJWycsNTNwrRz+aJlCMu07eiTsX+BMi4Dqt
 BAabopYF2ZhpG7k+eFkgfUbOJus2VZ0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-cgpppe2COOSiEPmFctmMtQ-1; Tue, 19 Sep 2023 04:20:24 -0400
X-MC-Unique: cgpppe2COOSiEPmFctmMtQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-502f46691b4so4744324e87.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 01:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695111623; x=1695716423;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GRJyxaNCdh5UcI/31P9hieAgHH3op5LoYI7ipTFtsHE=;
 b=biggtcO8n9HXfdwkiFS54bffFUH6E6T3Kqxw4N/UrwmubeO+TfoF4jheM6v/qHJu1a
 aCQDtFRV0gu4vMxf246GjCzbc2b0EHxxVh39wgyqSfR/E0La6hzuu4FAt+dubRMEr6nt
 wQHSzOkPR2XlEYopiBgCUEcgTXNEwmiVw5lco4HgX4Dwm8NQR6Rj2VEfJNxhUvVn8Jpg
 Xounyjv4cbUDxqFPPnCGTTg6xZIOw28KjV4mAJ979ipF7tO248hMaxPu7Td+6GtW6DDi
 un/sJdUtwnLiWT1IT79MnqkFD/YrZosINL9UNT0+9eCz1wNyKU4vvJGgm9+33rcnvonl
 vT3A==
X-Gm-Message-State: AOJu0YypWrOe43O9niJSCrh6m2Pg+LXErMoMndG4WuhqNLYMTQibMRve
 TtooCASpxbRXbd7Mk5RCXwfNzRg7xG/Tdsq8EAuPdyLd2WCnAkTvRZ2XEudGVdTNJ/EApJix+Nd
 WMsCdMT1by7AGk9ryhmRlvaqHrCgjILrnwpOIbXDN/i3MGJ2YT08JuQIkEB1XlQZGnLRyg8M=
X-Received: by 2002:a05:6512:2390:b0:502:f740:220 with SMTP id
 c16-20020a056512239000b00502f7400220mr11862971lfv.58.1695111622996; 
 Tue, 19 Sep 2023 01:20:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc41Tb6Foy5g1JTtZ7U0/DfIQOTmfhMsfTw2RpRAm0LCUxd+feKVGStpln1KWC8TLvLpMUhw==
X-Received: by 2002:a05:6512:2390:b0:502:f740:220 with SMTP id
 c16-20020a056512239000b00502f7400220mr11862926lfv.58.1695111622493; 
 Tue, 19 Sep 2023 01:20:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:1300:c409:8b33:c793:108e?
 (p200300cbc7021300c4098b33c793108e.dip0.t-ipconnect.de.
 [2003:cb:c702:1300:c409:8b33:c793:108e])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a1c7204000000b00402f713c56esm14476201wmc.2.2023.09.19.01.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 01:20:21 -0700 (PDT)
Message-ID: <90303827-7879-7b9e-836d-5026b2be73dd@redhat.com>
Date: Tue, 19 Sep 2023 10:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/16] virtio-mem: Expose device memory through
 multiple memslots
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, kvm@vger.kernel.org
References: <20230908142136.403541-1-david@redhat.com>
 <87e38689-c99b-0c92-3567-589cd9a2bc4c@redhat.com>
Organization: Red Hat
In-Reply-To: <87e38689-c99b-0c92-3567-589cd9a2bc4c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 11.09.23 09:45, David Hildenbrand wrote:
> @MST, any comment on the vhost bits (mostly uncontroversial and only in
> the memslot domain)?
> 
> I'm planning on queuing this myself (but will wait a bit more), unless
> you want to take it.

I'm queuing this to

https://github.com/davidhildenbrand/qemu.git mem-next

and plan on sending a PULL request on Friday.

So if anybody has objections, please let me know ASAP :)

-- 
Cheers,

David / dhildenb


