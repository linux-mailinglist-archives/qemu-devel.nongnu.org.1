Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A827596F8
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:34:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7JI-0002H9-NE; Wed, 19 Jul 2023 09:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qM7J3-0002Gn-Vu
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:33:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qM7J1-0000tk-Ov
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689773603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fklS9RQvYJ+aKnJpqu++H1SUm+YLuz8LhBELrhBmxjg=;
 b=eMOACWOK/IS6onJjIR6g/MVMuSCtD8348c1z1qFPsabL2iFym7gkzZxjuB3gAd9EujxEyB
 hChPff/B3Q9UVHVn/TEMZAh1WI6yZ2QEv/tyXMdRfCQdrb+CSd7uYHamRoSUrmf/+uRSyN
 nSlaN+Vh90nsOs5n9tZErVrfxdOKQn8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-qqs5DqcLOrGH6l3HIDzVWA-1; Wed, 19 Jul 2023 09:33:19 -0400
X-MC-Unique: qqs5DqcLOrGH6l3HIDzVWA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9932e8e76b9so406183466b.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 06:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689773591; x=1692365591;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fklS9RQvYJ+aKnJpqu++H1SUm+YLuz8LhBELrhBmxjg=;
 b=gQMqiYOp5WpOeoWEv2L3dnU/QiM0phQTQoKhIDuR0LOgvFiIiAxpeomwu65QTI2MTi
 AhofJ1S7CqWRfO/MMxRrbcnm2OK6UOHUQPS/J3xkpYeEUV8XdqD3qjVqsowSZFyLBYw3
 Ni5Cr1RQiDrI6GvghKxup/iXrjN+qyu6Tovg7meZNalWK+rZ/jAZGzcGA1z3y4yGx3tj
 yB4iT1gCvSl7hf0RoEH7OARMk10DiPu6wGW5Dc/86g5mFU4n+mbF4dLRmEveh8pYZ4NJ
 3HcARq9txvsVJUX6PRzinw20hR4DiCqRw7kcbChlgPZclRHrd8kWz6MHT5nxpmB8EQSd
 qxmQ==
X-Gm-Message-State: ABy/qLZ9xI5pqhKE5j/iPKW2+HnjBVYVJkKM6MTUM9+/X/gh/leD4kbW
 cj7JOVPxtXIeW4KMmH4kPKAcyokZyal1PqGn+TgfDG0SD6ArRjDFDG9wko8KaeGXwU4U6BmY2Tx
 r0+XlCD8ZwSEvtfI=
X-Received: by 2002:a17:907:7eaa:b0:979:dad9:4e9 with SMTP id
 qb42-20020a1709077eaa00b00979dad904e9mr2654219ejc.50.1689773591456; 
 Wed, 19 Jul 2023 06:33:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHYJF8hsKxu0Cubu6CeIOs+ihnwbSynWamQqoGRj7jgZaSF/ZpKkC3+4nk13JTzKTxloVA2kg==
X-Received: by 2002:a17:907:7eaa:b0:979:dad9:4e9 with SMTP id
 qb42-20020a1709077eaa00b00979dad904e9mr2654198ejc.50.1689773591100; 
 Wed, 19 Jul 2023 06:33:11 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 n14-20020a170906700e00b0098733a40bb7sm2352923ejj.155.2023.07.19.06.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 06:33:10 -0700 (PDT)
Message-ID: <5576e59a-55c4-97bc-7fe7-e2d22cded8e8@redhat.com>
Date: Wed, 19 Jul 2023 15:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] vhost-user.rst: Clarify enabling/disabling vrings
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>
References: <20230712091704.15589-1-hreitz@redhat.com>
 <20230718152607.GI44841@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230718152607.GI44841@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 18.07.23 17:26, Stefan Hajnoczi wrote:
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
>>
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
> What is the purpose of this statement? Rings cannot be used before
> feature negotiation (with the possible exception of legacy devices that
> allowed this to accomodate buggy drivers).

Perfect :)

> To me this statement complicates things and raises more questions than
> it answers.

OK.  The context for the statement is as follows: When the back-end 
supports F_PROTOCOL_FEATURES, it is supposed to initialize all vrings in 
a disabled state, so that when the flag is indeed negotiated, that will 
be the state they’re in.  In contrast, older back-ends that don’t 
support that flag will initialize them in an enabled state (because they 
won’t have support for disabled vrings).

The statement was intended to make it clear that this difference in 
behavior is OK, and that the front-end must not rely on either of the 
two.  Only after SET_FEATURES will and must the state be well-defined.

But if you find it just confusing because enabled/disabled has no 
meaning before a virt queue is started anyway, and they mustn’t be 
started before negotiating features, I’m happy to drop it without 
replacement.

>> +
>> +If ``VHOST_USER_SET_FEATURES`` does not negotiate
>> +``VHOST_USER_F_PROTOCOL_FEATURES``, each ring, when started, will be
>> +enabled immediately.
> This sentence can be simplified a little:
> "each ring, when started, will be enabled immediately" ->
> "rings are enabled immediately when started"

Sure!

Hanna


