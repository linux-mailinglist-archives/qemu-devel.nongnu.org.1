Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC86A5058D
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Mar 2025 17:48:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprud-0002T3-Py; Wed, 05 Mar 2025 11:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpruc-0002Sp-2i
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:48:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tprua-0005Be-FK
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741193278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mNrAkQbWUpX9epv1XXpVgOHoJffeOielqlztSb2sB+U=;
 b=dzjN3Nc3Bz55Zfa/B2eV1DJHtWpgr2Ob3imqQZiUWzL0L0V4u6u1sdGXP9fShg+9S+ovLZ
 BlJ9ikW80enqqhh7Hy/FPyS2UrT3ssfJQu+4xVTndw9I5rj7YPA1JPViOV5WPnXR+bDeNa
 IE9k2SxLLMrZQh+DocrlRlSoo9lXFvw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-tA1hKy70MDy6Ir6RIES8ug-1; Wed, 05 Mar 2025 11:47:57 -0500
X-MC-Unique: tA1hKy70MDy6Ir6RIES8ug-1
X-Mimecast-MFC-AGG-ID: tA1hKy70MDy6Ir6RIES8ug_1741193276
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so51418475e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193276; x=1741798076;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNrAkQbWUpX9epv1XXpVgOHoJffeOielqlztSb2sB+U=;
 b=G1K7ra2YOIcxf/EFHWLaixqYbAyoZX6MWKCudjmJ+YK2rqZbj0EJtXqihiyUro/F1m
 AyZwTeHJzJ7Xx7p8VIIB2W64xU8b3rBPFr0VuMmA5QrVu7Bi5kBNmPDeldZKynRYtUgF
 +lObT7IrShpIl81H1m+X9vYcSTGQdrCmvB58LbzdvqkVjv4h9byXyDfS+NoWIVXPYfiv
 QRdNtyHTKTHo7V2c+AQiU+Xww2UD+MQO8nbXE3LmJS/Cujx80VZVqDzRgbJQhjcPSS3G
 4auoidSrtQ6AnO25JBsnz3qjQAWZftXAwVHXFOZXMO2KJw7xYZRfwA5ZcgmX7vbv8v+W
 p6Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8Dm3bXOtMNy07MPJmC9ah+OUStNJdOlPY37yL/iUF8YQo2oVT8UkmvjWAyk4vnL+XX2jaZRKNoI/p@nongnu.org
X-Gm-Message-State: AOJu0YyuiyNELV8XwC6hAT9v7AQQpBmLU5AbOPgYVArk7clYx08oF4qB
 dbA1g8BfZm0Vd0J+HPpWVQO+Fe5jK34doBR4u2cXxrv0CGPSJZ0MDHePB6srb6qxy9Loo+85O/r
 X9d9xq0gMsRI7tqhIXg0WsmZPcse43jayrWb8vu9pmSjHKloNczSR
X-Gm-Gg: ASbGnctk8+AtVXbsXO+mNhfCfD18VwQiYNZnbiJYPardaS+c6PoHVsZItsWVSNrRN08
 0nC8K2rQj1O3bhChSp2b5Wf7+Y6jUin4z5vQXir9khDDT+nXJS1m/R4iI0revOdjWm2tqc2lDLu
 FQBtPnbGAeahFNLyoz7lyF7Nzu+v7fzIFm91H0LLv0Y6RxMlfeAPYcLCmFu/9HaoQVflUtjq+9P
 w84Um0tfdn2KbB7uqCW1wNiMpV4DKggj6SjC7mhCyO6ba6ukVrg/Sw4iYr7Fdxfp8wpAXEf9xBY
 WVaZnabWAOEDNL4QP39S0kHEjq7qsdN2QKHEMQrHglaa+rmQsbBOzg==
X-Received: by 2002:a05:600c:3b2a:b0:43b:d251:7aff with SMTP id
 5b1f17b1804b1-43bd29d71c3mr27119955e9.23.1741193276084; 
 Wed, 05 Mar 2025 08:47:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnKVSK0xBAJImg9F4Y/kZdNac+vUK0fRevh0iOO7V2I9yjj5eyeXV3pV4ICSLiVheNEox7DQ==
X-Received: by 2002:a05:600c:3b2a:b0:43b:d251:7aff with SMTP id
 5b1f17b1804b1-43bd29d71c3mr27119815e9.23.1741193275741; 
 Wed, 05 Mar 2025 08:47:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd426c16dsm22928615e9.6.2025.03.05.08.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 08:47:55 -0800 (PST)
Message-ID: <6e86a490-15a5-42f9-a50c-3a1042cfe43b@redhat.com>
Date: Wed, 5 Mar 2025 17:47:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 25/36] vfio/migration: Setup and cleanup multifd
 transfer in these general methods
To: Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <b1f864a65fafd4fdab1f89230df52e46ae41f2ac.1741124640.git.maciej.szmigiero@oracle.com>
 <Z8h6LGGrw82RgA_Y@x1.local>
 <068929b1-6a07-4dc0-a807-77152d6d7160@maciej.szmigiero.name>
 <Z8h-Oy2eT6dJZ-WM@x1.local>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z8h-Oy2eT6dJZ-WM@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/5/25 17:39, Peter Xu wrote:
> On Wed, Mar 05, 2025 at 05:27:19PM +0100, Maciej S. Szmigiero wrote:
>> On 5.03.2025 17:22, Peter Xu wrote:
>>> On Tue, Mar 04, 2025 at 11:03:52PM +0100, Maciej S. Szmigiero wrote:
>>>> @@ -509,6 +513,9 @@ static void vfio_save_cleanup(void *opaque)
>>>>        Error *local_err = NULL;
>>>>        int ret;
>>>> +    /* Currently a NOP, done for symmetry with load_cleanup() */
>>>> +    vfio_multifd_cleanup(vbasedev);
>>>
>>> So I just notice this when looking at the cleanup path.  It can be super
>>> confusing to cleanup the load threads in save()..  IIUC we should drop it.
>>>
>>
>> It's a NOP since in the save operation migration->multifd is going to be
>> NULL so that "g_clear_pointer(&migration->multifd, vfio_multifd_free)"
>> inside it won't do anything.
>>
>> Cedric suggested calling it anyway since vfio_save_setup() calls
>> vfio_multifd_setup() so to be consistent we should call
>> vfio_multifd_cleanup() on cleanup too.
>>
>> I think calling it makes sense since otherwise that vfio_multifd_setup()
>> calls looks unbalanced.
> 
> IMHO we should split vfio_multifd_setup() into two functions:
> 
>    - vfio_multifd_supported(): covering the first half of the fn, detect
>      whether it's supported all over and return the result.
> 
>    - vfio_load_setup_multifd(): covering almost only vfio_multifd_new().
> 
> Then:
> 
>    - the 1st function should be used in both save_setup() and
>      load_setup(). Meanwhile vfio_load_setup_multifd() should only be
>      invoked in load_setup().
> 
>    - we rename vfio_multifd_cleanup() to vfio_multifd_load_cleanup(),
>      because that's really only about load..
> 
>    - vfio_multifd_setup() (or after it renamed..) can drop the redundant
>      alloc_multifd parameter.
  
I think this is close to the initial proposal of Maciej in v5 and
I asked to do it that way in v6, moslty because we don't agree on
the need of 'bool multifd_transfer'.

Since it's minor, we can refactor afterwards. For now, let's keep
it as it is please.

Thanks,

C.


