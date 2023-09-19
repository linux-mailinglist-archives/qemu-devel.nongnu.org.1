Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A2A7A5E12
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiX8c-0002uL-M1; Tue, 19 Sep 2023 05:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiX8K-0002pd-EB
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiX8I-0004GI-IU
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695116099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPR96Ino/qT336oazWqMngmq6HsgDYc3ttnsN9zP/FQ=;
 b=OGvZyO21UA14rQHhXsw1s45gP34jYSuhFUSZjHaIa70aSlrQ88cL3XmYKm2GSZKv25x9lh
 v2jN42SESegdrAh5FiTLYEN0KOdp7uLMMu/2WiHnHYZsjJRX64kHmEYVeHGGXcSULPRgR0
 zTNQdAzerqhAv2/PPNBPvbXTjatkR2k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-ByKVrV3lOJ2GCBL6jdF0QA-1; Tue, 19 Sep 2023 05:34:56 -0400
X-MC-Unique: ByKVrV3lOJ2GCBL6jdF0QA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40469bcd1eeso37491415e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 02:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695116096; x=1695720896;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KPR96Ino/qT336oazWqMngmq6HsgDYc3ttnsN9zP/FQ=;
 b=Wv354KYqokXzqnXvm68WWX3iJCtIWyUYuqdQRBRegawdLnAgehx7s3QH9Yin2lBeda
 hWt+JDq/kc93sPbwBBPJ6//U7TdSf4vwdbbmgi2Rh6mTkyB6l1R2tEIl3mPD3i+uKnn9
 YV76rr0ewZHUVAmnaAwLBZ7S6kZ1YFeg1B6UqSVQv7rd35N2Y845+PCF1sLXsmlGLISa
 xrwWq5LBjEIaeVgNAfyldv2Lrw3zxr5I42Fg2ejcCgHqrvi2pHKW9DelpmueQmyjt546
 MTEvp0cmAzS3JOTI3HB7jDx0xKArBA3OhyR0+Lv7kTDYO7XtxsJ5wt6dqtu0AxNpKaCl
 FwKw==
X-Gm-Message-State: AOJu0YytDjN1VR+WG4p0NwZdXO4G9ogEn81Fzp6FcLyMWedjeZT0hrMS
 hpEWeWuVjBCnVsTHt2wAfc8/AdZYrOe2nLG/945KnRcWCbjDMOQjda2UiN5lTvj3eosxidjzYfw
 mmPrQM+wjTK2ic79hQDZQwUtNorHZK8z416gE570aacwa6T25kw1iH+GcWKvQLaL2Eqtv0oM=
X-Received: by 2002:a7b:c4cb:0:b0:401:b53e:6c56 with SMTP id
 g11-20020a7bc4cb000000b00401b53e6c56mr11412930wmk.3.1695116095838; 
 Tue, 19 Sep 2023 02:34:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh1b95ySDTxVNVqccpxTqPuEHUzr58Fl6Hb7D0bbeRcDlZIBfNAdbbcqTsXYpZs//RQv6EMQ==
X-Received: by 2002:a7b:c4cb:0:b0:401:b53e:6c56 with SMTP id
 g11-20020a7bc4cb000000b00401b53e6c56mr11412888wmk.3.1695116095291; 
 Tue, 19 Sep 2023 02:34:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:1300:c409:8b33:c793:108e?
 (p200300cbc7021300c4098b33c793108e.dip0.t-ipconnect.de.
 [2003:cb:c702:1300:c409:8b33:c793:108e])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a7bc856000000b00402f7e473b7sm14562093wml.15.2023.09.19.02.34.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 02:34:54 -0700 (PDT)
Message-ID: <b6b088fa-621b-1017-9d71-5757f81bf1ec@redhat.com>
Date: Tue, 19 Sep 2023 11:34:53 +0200
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
 <90303827-7879-7b9e-836d-5026b2be73dd@redhat.com>
Organization: Red Hat
In-Reply-To: <90303827-7879-7b9e-836d-5026b2be73dd@redhat.com>
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

On 19.09.23 10:20, David Hildenbrand wrote:
> On 11.09.23 09:45, David Hildenbrand wrote:
>> @MST, any comment on the vhost bits (mostly uncontroversial and only in
>> the memslot domain)?
>>
>> I'm planning on queuing this myself (but will wait a bit more), unless
>> you want to take it.
> 
> I'm queuing this to
> 
> https://github.com/davidhildenbrand/qemu.git mem-next
> 
> and plan on sending a PULL request on Friday.
> 
> So if anybody has objections, please let me know ASAP :)
> 

.... and I dropped it again after realizing that migration needs care 
(activate memslots on migrationd estination). I'll look into that and 
resend once that is fixed.

-- 
Cheers,

David / dhildenb


