Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C3B7AEE45
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 15:55:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql8WK-0007GY-6T; Tue, 26 Sep 2023 09:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1ql8WG-00078l-Oh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1ql8W8-000221-25
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695736461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omMxtZlxYmHSaKiNBg8QkkaBBc55aVLo9Dv7tF+WlA8=;
 b=eIjZwKjhgtPRCU1OPDkn369WnFVbTqMtYpTEO9D7dRmpm6DRI0DZc1Op6Av4osrh8hhLBg
 qPM39my8sCsFXaShfYU5cxBaMKKAHan7JRueDovc4mTTnEV4tMGjIhw7yXag3ELL9VlRaw
 yRoM3/CvaL+jD/Bd+lGlOdiiuAs624M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-IFgQLErWPGicATYyAsOFRg-1; Tue, 26 Sep 2023 09:54:20 -0400
X-MC-Unique: IFgQLErWPGicATYyAsOFRg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b274cc9636so444616766b.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 06:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695736458; x=1696341258;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=omMxtZlxYmHSaKiNBg8QkkaBBc55aVLo9Dv7tF+WlA8=;
 b=ILQPdwIN1weYngCPYiQraJGKodGPAQYKT6CvQ+7siSFpoAzQug4ymQfLV2q+M41Ba7
 onBONZ1FNxGYbVkaPTBu9EbPi0V+OQ1FCkeieGjYQvvK6RHzU67jC0GJkH+XKtYCkUkH
 sWzr9+oHgI38+OPN5cDV+j9yDpLwai6RPDSUNwXkW0eTfdB12czqMyqHK6LdLQ8K+wMV
 ZHWnyhUoGjxxV/9b85IfGCV04Ix91zbnLTX83ljto/j+AxJxeLmluc2mR5IJ6Zx7MQ0O
 2POn4aRzT6yaIT9pVDM6yOIeibHt+78hHhk2QvmQCilBcPMVmYL6NE+WcG53DaTlpmUk
 n4CQ==
X-Gm-Message-State: AOJu0YyfhqKSbOViJZNkMtG60Grus1YAmF4LvSCHyG+8Wfpdw3dR1hSy
 luEvg6uyhfK//Co/m26IJLt13ehhZM08bSFSbypwRy9Q9cttBIHNOt/RqMw6kJtuf2K5G1aRTTD
 nXwlKX3DRy+bTFfA=
X-Received: by 2002:a17:906:1bb1:b0:9ae:3d17:d5d0 with SMTP id
 r17-20020a1709061bb100b009ae3d17d5d0mr8909239ejg.31.1695736457823; 
 Tue, 26 Sep 2023 06:54:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1Kr7WQeMdfGAJEk/awW5vKauqptxa5MYq/sLd3ZzJNI3tbGAZS/GijQnUmC1zKjqoGlMDYA==
X-Received: by 2002:a17:906:1bb1:b0:9ae:3d17:d5d0 with SMTP id
 r17-20020a1709061bb100b009ae3d17d5d0mr8909222ejg.31.1695736457396; 
 Tue, 26 Sep 2023 06:54:17 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a170906a38800b0099bc2d1429csm7828772ejz.72.2023.09.26.06.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 06:54:16 -0700 (PDT)
Message-ID: <de0387fc-0342-a3bf-7d72-3130e94c50cd@redhat.com>
Date: Tue, 26 Sep 2023 15:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/5] vhost-user.rst: Clarify enabling/disabling vrings
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>, German Maglione <gmaglione@redhat.com>
References: <20230915102531.55894-1-hreitz@redhat.com>
 <20230915102531.55894-3-hreitz@redhat.com> <20230925191508.GC323580@fedora>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230925191508.GC323580@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 25.09.23 21:15, Stefan Hajnoczi wrote:
> On Fri, Sep 15, 2023 at 12:25:27PM +0200, Hanna Czenczek wrote:
>> Currently, the vhost-user documentation says that rings are to be
>> initialized in a disabled state when VHOST_USER_F_PROTOCOL_FEATURES is
>> negotiated.  However, by the time of feature negotiation, all rings have
>> already been initialized, so it is not entirely clear what this means.
>>
>> At least the vhost-user-backend Rust crate's implementation interpreted
>> it to mean that whenever this feature is negotiated, all rings are to
>> put into a disabled state, which means that every SET_FEATURES call
>> would disable all rings, effectively halting the device.  This is
>> problematic because the VHOST_F_LOG_ALL feature is also set or cleared
>> this way, which happens during migration.  Doing so should not halt the
>> device.
>>
>> Other implementations have interpreted this to mean that the device is
>> to be initialized with all rings disabled, and a subsequent SET_FEATURES
>> call that does not set VHOST_USER_F_PROTOCOL_FEATURES will enable all of
>> them.  Here, SET_FEATURES will never disable any ring.
>>
>> This interpretation does not suffer the problem of unintentionally
>> halting the device whenever features are set or cleared, so it seems
>> better and more reasonable.
>>
>> We should clarify this in the documentation.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   docs/interop/vhost-user.rst | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index bb4dd0fd60..9b9b802c60 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -409,12 +409,20 @@ and stop ring upon receiving ``VHOST_USER_GET_VRING_BASE``.
>>   
>>   Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
>>   
>> -If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated, the
>> -ring starts directly in the enabled state.
>> -
>> -If ``VHOST_USER_F_PROTOCOL_FEATURES`` has been negotiated, the ring is
>> -initialized in a disabled state and is enabled by
>> -``VHOST_USER_SET_VRING_ENABLE`` with parameter 1.
>> +If ``VHOST_USER_SET_FEATURES`` does not negotiate
>> +``VHOST_USER_F_PROTOCOL_FEATURES``, rings are enabled immediately when
>> +started.
>> +
>> +If ``VHOST_USER_SET_FEATURES`` does negotiate
>> +``VHOST_USER_F_PROTOCOL_FEATURES``, each ring will remain in the disabled
>> +state until ``VHOST_USER_SET_VRING_ENABLE`` enables it with parameter 1.
>> +
>> +Back-end implementations that support ``VHOST_USER_F_PROTOCOL_FEATURES``
>> +should implement this by initializing each ring in a disabled state, and
>> +enabling them when ``VHOST_USER_SET_FEATURES`` is used without
>> +negotiating ``VHOST_USER_F_PROTOCOL_FEATURES``.  Other than that, rings
>> +should only be enabled and disabled through
>> +``VHOST_USER_SET_VRING_ENABLE``.
> The "Ring states" section starts by saying there are three states:
> "stopped", "started but disabled", and "started and enabled". But this
> patch talks about a "disabled state". Can you rephrase this patch to use
> the exact state names defined earlier in the spec?

I would not want to do that.  We had the exact problem that the spec 
wanted to remain high-level, and was not reflecting exactly what 
existing implementations did, which resulted in confusion (at least for 
me and the vhost Rust crates authors).

Notably, the existing implementations I’m aware of track 
enabled/disabled even before the ring is started, exactly as formulated 
here.

If we changed this to read something like “If VHOST_USER_SET_FEATURES is 
ever called without negotiating VHOST_USER_F_PROTOCOL_FEATURES, the ring 
must be enabled immediately when it is started; otherwise, when the ring 
is started and VHOST_USER_F_PROTOCOL_FEATURES has always been set in 
every VHOST_USER_SET_FEATURES call, the ring should be disabled when 
started.” then this would conflict with the existing implementations:

We never disallow VHOST_USER_SET_VRING_ENABLE when the ring is stopped.  
Existing implementations track enabled/disabled before the rings are 
started, and they initialize this state to “disabled”, setting it to 
“enabled” on receiving VHOST_USER_SET_FEATURES without 
VHOST_USER_F_PROTOCOL_FEATURES, as described above.  Therefore, if you 
call VHOST_USER_SET_VRING_ENABLE 1 before the ring is started, the ring 
will start enabled even with VHOST_USER_F_PROTOCOL_FEATURES.  This is 
not possible if you only have three states.

Maybe we should rather clarify that enabled/disabled is tracked even 
while the ring is stopped.

Hanna


