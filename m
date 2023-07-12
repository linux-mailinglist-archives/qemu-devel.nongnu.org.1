Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AAD750608
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 13:28:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJY03-00085q-F1; Wed, 12 Jul 2023 07:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJXzz-00085Q-Ut
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJXzx-00071E-HX
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689161228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1bwS9NevsrA9+EOCyvTurZWOc4mUVyfsETIl8LLyX0=;
 b=a0Y0FwwVHAkWCYDDt/fm0jnq7FBWTAQ7MWwZmtbu4eV6oz10ney+tkzn67PNkKhTr+iIqp
 xCagPOKOxe9j+gLmBLXLDmCmmDHIfixDsPhckgEiMFZf5UfrmAFjgDCV6nMDGBBrQ/mKvo
 OxOXpG0Zkt29L/JwLZ1WZ6O431IoPhk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-7xqwDc-lMoyH_TzpwD541g-1; Wed, 12 Jul 2023 07:27:07 -0400
X-MC-Unique: 7xqwDc-lMoyH_TzpwD541g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a355cf318so445659366b.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 04:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689161226; x=1691753226;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I1bwS9NevsrA9+EOCyvTurZWOc4mUVyfsETIl8LLyX0=;
 b=iyJLVmr9YEc7bswdgU8yYkt0tSSrcDuo8gpTGGKsiNdv8JLX+jvWhfmzBi1tpkErXu
 kr+81+oA6u29n4/r8OZOiWvcvq5/P5kU26OfQ4M7sp83swE6bwoitP7+tioHYjjaFwXf
 VRLvqOp4JospPOVv3c5W8wsI2xg0e4VnQIxkSIajtrB3mo/KhgBPu1ZyN1ZeS/nGb3Hz
 u6SyJrSVhyoBLdEBAeCAFP/8y3COVciZ7zbF9UtlFY9LyDffnja1pmamxmf6+7F5K5R6
 7ithAh6V0DbwA5FK47IrWCWGukKUrNWFcQPeDTt3ooc4gpcQrqJnpLXUnPcb6sCxn3GN
 VjSw==
X-Gm-Message-State: ABy/qLalsePqllZkBxwNLmFCYWWcKVEwgItYtqEGhiJl7zshmCIIRYE8
 bp2aABLXQyjBZPGDfnL/NokminZrdSs0dx0bvnE5Vc6oMvC8XOUrWT0t4ThSoECq9UYg+smQxsI
 F5rTQ21qYCEYOlcE=
X-Received: by 2002:a17:906:2202:b0:994:3395:942f with SMTP id
 s2-20020a170906220200b009943395942fmr147957ejs.17.1689161226031; 
 Wed, 12 Jul 2023 04:27:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGP/oit2p+pq5m+uzlLtWEHNs3I277gyMTyxdyyqf4rXmB6UwkAzQ7/ANUX/q4Xl8XJxwMVdQ==
X-Received: by 2002:a17:906:2202:b0:994:3395:942f with SMTP id
 s2-20020a170906220200b009943395942fmr147942ejs.17.1689161225756; 
 Wed, 12 Jul 2023 04:27:05 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:dd11:f574:b001:d931?
 (p200300cfd71af311dd11f574b001d931.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:dd11:f574:b001:d931])
 by smtp.gmail.com with ESMTPSA id
 rk2-20020a170907214200b00992e5e5f8a5sm2488329ejb.14.2023.07.12.04.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 04:27:04 -0700 (PDT)
Message-ID: <6abb08f4-091c-08e8-9854-f600e1cff030@redhat.com>
Date: Wed, 12 Jul 2023 13:27:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] vhost-user.rst: Clarify enabling/disabling vrings
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 German Maglione <gmaglione@redhat.com>
References: <20230712091704.15589-1-hreitz@redhat.com>
 <20230712071357-mutt-send-email-mst@kernel.org>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230712071357-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12.07.23 13:17, Michael S. Tsirkin wrote:
> On Wed, Jul 12, 2023 at 11:17:04AM +0200, Hanna Czenczek wrote:
>> Currently, the vhost-user documentation says that rings are to be
>> initialized in a disabled state when VHOST_USER_F_PROTOCOL_FEATURES is
>> negotiated.  However, by the time of feature negotiation, all rings have
>> already been initialized, so it is not entirely clear what this means.
>>
>> At least the vhost-user-backend Rust crate's implementation interpreted
>> it to mean that whenever this feature is negotiated, all rings are to be
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
> Huh. I don't know why we don't set VHOST_USER_F_PROTOCOL_FEATURES
> on all calls though. I think it's a bug. Let's fix that first of all?
> Then we can still document behaviour of existing buggy QEMU.

To my knowledge we (i.e. qemu) do.  I think we’d only not set it if the 
back-end just doesn’t support it.

In the above paragraph, I just meant to describe how back-end 
implementations other than the Rust one behave (when they support 
F_PROTOCOL_FEATURES): They disable all vrings from the start.  If 
SET_FEATURES is called without F_PROTOCOL_FEATURES (which qemu won’t 
do), they’ll enable them.  But outside of SET_VRING_ENABLE, they’ll 
never disable them after initialization.

I.e. the case where a back-end supports F_PROTOCOL_FEATURES but the 
front-end doesn’t set it is just hypothetical, and not meant to describe 
the behavior of any current qemu version.

Hanna

>> This other interpretation does not suffer the problem of unintentionally
>> halting the device whenever features are set or cleared, so it seems
>> better and more reasonable.
>>
>> We should clarify this in the documentation.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   docs/interop/vhost-user.rst | 23 +++++++++++++++++------
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index 5a070adbc1..ca0e899765 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -383,12 +383,23 @@ and stop ring upon receiving ``VHOST_USER_GET_VRING_BASE``.
>>   
>>   Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
>>   
>> -If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated, the
>> -ring starts directly in the enabled state.
>> -
>> -If ``VHOST_USER_F_PROTOCOL_FEATURES`` has been negotiated, the ring is
>> -initialized in a disabled state and is enabled by
>> -``VHOST_USER_SET_VRING_ENABLE`` with parameter 1.
>> +Between initialization and the first ``VHOST_USER_SET_FEATURES`` call, it
>> +is implementation-defined whether each ring is enabled or disabled.
>> +
>> +If ``VHOST_USER_SET_FEATURES`` does not negotiate
>> +``VHOST_USER_F_PROTOCOL_FEATURES``, each ring, when started, will be
>> +enabled immediately.
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
>>   
>>   While processing the rings (whether they are enabled or not), the back-end
>>   must support changing some configuration aspects on the fly.
>> -- 
>> 2.41.0


