Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7844E7C5A0F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 19:09:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqci8-00061L-Sm; Wed, 11 Oct 2023 13:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qqci6-00060B-Lm
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 13:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qqci5-0004aQ-1j
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 13:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697044164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hvrIZgYNj3sVael50j4xmnKg0Gf8HTpgroeN/fbyP/0=;
 b=YtG1LoQPhNmY335mpK2GFZkB8Sq1YBkbZv/WwqLZBpJWHFk1J6bJ3mOH4gjkhhIAtqn4wx
 hLQieF+xrVBWH+9s+amR9GbXWmKDGxilpp5YbblCz+Ml4msSnIEP0JU4kKSngU73y70m2I
 b+bcZOPGhvY0GtUKUP25RCNlaUMCBns=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-OsbvDOhiPf-hkIfNhEE9dw-1; Wed, 11 Oct 2023 13:09:22 -0400
X-MC-Unique: OsbvDOhiPf-hkIfNhEE9dw-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6c64edaa361so70440a34.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 10:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697044162; x=1697648962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hvrIZgYNj3sVael50j4xmnKg0Gf8HTpgroeN/fbyP/0=;
 b=SAsJDX/MBoqgrTzua063sFRD/W2cHQ7CPnTIxbAm/KjE62An8JZm8saD20KRUcbPb+
 fwuBHHhCxGxbBqie8/XQaXSSeh9RLkf3pIv7Kcmki3XxyfHKsf2h7rA5rpuyPBam9N50
 02JLmBqLMnHEVohtN497t2QoW7FZrrONKUIzrPxxHwXArtB7NqK8bAZA2+kbppoyu/6L
 O7oRyA39b2R2QIwODFHLtpYtWx0TPAdeFoT+4kNy/M0ufDirA1pvK2G3dAwB0RcAq87J
 4aqY2k/j60K6lBS2vfsEghXDvhrlbzQekuvonUJahIKdDeIOJAPBgWkiSlWBZOvJm1qM
 6IDw==
X-Gm-Message-State: AOJu0YxxC8DnDgz3iOEWpdgJnzbq9vQxvZmQ4C227V7oVeIpiz0hNLcU
 8CWXCwfVO+2bbab07yj2Bl6QF6gvNQufASxWZLvB13i3ZZm1lVS3tngo4TdKVFEhroRR/fwmXRo
 cMIgSOBeoj8t363w=
X-Received: by 2002:a9d:798f:0:b0:6bd:c7c3:aabc with SMTP id
 h15-20020a9d798f000000b006bdc7c3aabcmr22928889otm.19.1697044162076; 
 Wed, 11 Oct 2023 10:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD0TRDke8f0RGYv/+MPNNydLEcagd8/gTVOoV8Q2ZG+HoURd4r1EhslmiTS1LyL5trUtaTjw==
X-Received: by 2002:a9d:798f:0:b0:6bd:c7c3:aabc with SMTP id
 h15-20020a9d798f000000b006bdc7c3aabcmr22928875otm.19.1697044161853; 
 Wed, 11 Oct 2023 10:09:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 fy11-20020a05622a5a0b00b004198d026be6sm5520043qtb.35.2023.10.11.10.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 10:09:21 -0700 (PDT)
Message-ID: <346b5a63-b477-5de8-fc93-65904b8ceda6@redhat.com>
Date: Wed, 11 Oct 2023 19:09:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 0/3] ramfb: migration support
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
References: <20231009063247.119333-1-marcandre.lureau@redhat.com>
 <0cdcd25f-9ed5-cbfe-1633-213bd6a2c82f@redhat.com>
 <CAJ+F1CJ+yKL8aSg=OdBBHzdfsaRj+fvD8y1QLgxT4UbjxAbUZg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <CAJ+F1CJ+yKL8aSg=OdBBHzdfsaRj+fvD8y1QLgxT4UbjxAbUZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/10/23 15:46, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Oct 10, 2023 at 4:49 PM Cédric Le Goater <clg@redhat.com> wrote:
>>
>> Hello,
>>
>> On 10/9/23 08:32, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Hi,
>>>
>>> Implement RAMFB migration, and add properties to enable it only on >= 8.2
>>> machines, + a few related cleanups.
>>
>> Should this series go in vfio-next ?
>>
> 
> That's a good option for me.

Gerd, fine with you ?

Thanks,

C.



