Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B26187ADC89
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:59:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknzN-0006TA-JP; Mon, 25 Sep 2023 11:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qknzE-0006RH-SE
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qknzB-00062t-Jt
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695657540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XfSFeC0dQHha1Gohv2QqNWFo6jsw5IC/9dUeY2uagEY=;
 b=FomX6HaddLJ6ipxSYKpb2ZxdF9wMnv76fRTqsn4r/9l7x8bvoxaPIie6SUZRvJx3f9NJGU
 JsoELl6+IsUQy3cLwmxpbBZrYLRxCUG7p36rPyGpakcALnqAI2q6hZowV8evUIVZFR0B6r
 wGGaqotYRcrlCKEYOQnRJNUeRwa76N4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-6tWpV9x4NByxqH6hObuCLg-1; Mon, 25 Sep 2023 11:58:58 -0400
X-MC-Unique: 6tWpV9x4NByxqH6hObuCLg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40540179bcdso46054005e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 08:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695657537; x=1696262337;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XfSFeC0dQHha1Gohv2QqNWFo6jsw5IC/9dUeY2uagEY=;
 b=GhFitNTDHzebBoSUKDjQmj8cooU0Pr4IS+kH7ws4tqtG1iq/ovHjFwrrNqEMC89Fcl
 uoLADyWwbSMpmB5hucxTc1xtK3JEfy5DhEDMfDd2pPn0Ohkv3ABYnRgMdKo0tulRtICm
 wxiAV/gV+9X0s8RXoqA7dN7Sg17Vv1SZiD3efrAfbDQS9c8Mu4aMeTCLDSTTUihvYFME
 yDTGHQLxAXRULo/Ydew+dzTMAFUo/7uMWt/Za63wsgrlnrSg/43q7u5p5ILwr6JJKO9K
 0jXLMbSlwDjmNW/hQ8W9oO64NO1W4Wf3R91jB/e5GiX21IO3kc8YJEsSYYR2syLmS7GR
 Brfw==
X-Gm-Message-State: AOJu0Yz3SvsDuFXhSe5/qx+5QenX1G3a4VrR+jXBkphL5mQ/zwfFHyvY
 aGx5t0OqzhJE0zcJpv08hEtlvA3kuSaxJ+8EnbdU6XSjd+m2CmczcOg09xHWZt0IvBp26rMk4PL
 9mxbsYyzmDsUzVa8cqd4Ak4o=
X-Received: by 2002:a05:600c:24d:b0:404:737a:17d with SMTP id
 13-20020a05600c024d00b00404737a017dmr7039197wmj.9.1695657536998; 
 Mon, 25 Sep 2023 08:58:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaksWt/xlP96sFgFxuFtd5ZJNGUhqsLjU1xdLVCJwWux5cUKvglF1cUoYNnDu8fDKHIhs/3A==
X-Received: by 2002:a05:600c:24d:b0:404:737a:17d with SMTP id
 13-20020a05600c024d00b00404737a017dmr7039185wmj.9.1695657536578; 
 Mon, 25 Sep 2023 08:58:56 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 v21-20020a7bcb55000000b00404719b05b5sm12633897wmj.27.2023.09.25.08.58.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Sep 2023 08:58:55 -0700 (PDT)
Message-ID: <ae977ae6-4822-9a25-a09f-06cecdedbc65@redhat.com>
Date: Mon, 25 Sep 2023 17:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ui/vnc: fix enabling of VNC_FEATURE_XVP
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20230925145034.530623-1-pbonzini@redhat.com>
 <ZRGqvdAa8OGTpH9t@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZRGqvdAa8OGTpH9t@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On 9/25/23 17:43, Daniel P. Berrangé wrote:
> On Mon, Sep 25, 2023 at 04:50:34PM +0200, Paolo Bonzini wrote:
>> VNC_FEATURE_XVP was not shifted left before adding it to vs->features,
>> so it was never enabled.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   ui/vnc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> /facepalm
> 
> I definitely tested this code, because I had to use QEMU to
> validate the GTK-VNC client implementation....
> 
> 
>>
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index 6fd86996a54..3d13757b72b 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -2205,7 +2205,7 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
>>               break;
>>           case VNC_ENCODING_XVP:
>>               if (vs->vd->power_control) {
>> -                vs->features |= VNC_FEATURE_XVP;
>> +                vs->features |= VNC_FEATURE_XVP_MASK;
>>                   send_xvp_message(vs, VNC_XVP_CODE_INIT);
>>               }
>>               break;
> 
> ....I made the same screwup when processing messages:
> 
> 
>      case VNC_MSG_CLIENT_XVP:
>          if (!(vs->features & VNC_FEATURE_XVP)) {
>              error_report("vnc: xvp client message while disabled");
>              vnc_client_error(vs);
>              break;
>          }
> 
> so the bugs (kinda) cancelled out. So you'll need to fix
> both places

Doh, I "assumed" it was a thinko coming from usage of vnc_has_feature 
elsewhere.  I will send v2.

Paolo


