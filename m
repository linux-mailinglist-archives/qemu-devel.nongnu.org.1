Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E2473FBEF
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:24:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7kI-0003g5-5f; Tue, 27 Jun 2023 08:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qE7kD-0003fp-9Q
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qE7kB-00048J-Pi
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687868666;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ik4yNkgjvDAnpWrrhvwfo0lYDp79+FNNq43gUIzY6P0=;
 b=Rid/uVuV8UKlMhrYfL+EK7BYDTfgNwbkn+rY8cgqkk7kte984vVKyRjGjn6b0hX8hvl8zx
 ww2tt0V+RP234ItadYxa3tjPKsNo0oRfi+42y1DMKD9ihpK/09G+VnDrh2KCu1APQxwN57
 SXRrLQe7+SU9fH5RHcu+ZIjjXWcuxew=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-UIu1WGyINJSbflko6StHKA-1; Tue, 27 Jun 2023 08:24:23 -0400
X-MC-Unique: UIu1WGyINJSbflko6StHKA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7659924cf20so251551485a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687868663; x=1690460663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ik4yNkgjvDAnpWrrhvwfo0lYDp79+FNNq43gUIzY6P0=;
 b=VtSHrG26sq+8hpvVYgqsW3HGvaCAQj7rlZP/Gi5xjiN/FGWNhtoWUYl+We9M+nR3Dc
 qAE1/K5c2ANJWnGOM4Cnemf/JQm0iLYiHkSTlqgP1vzm23LUU9jZoabT4TKhw4olQhS/
 sPHWQON1xzA7ZRiWM6Gnsy4saZ4+XrKiU86dJDyvKVXHBS6aQZ1a6Ltn5eQVtL7PYEwf
 zJ1Wfxim1UaFl1apre+4s1xrfTXNWczEgCY6Rnpf1ag9RpJ2BfBKP6x/twG29UqUtiXO
 NKbex9fKNwSMGPJoMmDEPHJKG/VKYcXrR+vOGYzL+2ydzt3BPHyBbRl5aTS20SmEPmDj
 y3/Q==
X-Gm-Message-State: AC+VfDx33VPZ944lzmoNlT8NGO8EUZ/PPYiZ2G4wUqRZx0boDeb2a4sb
 dxmircKZvyjk/67sUgRtLtqUklxK38su2PUaS6Qz/4ZrQwet5aTDeA0Fcp4QouUY8om2N3VouTI
 yzBgDyX7gJ1er9rk=
X-Received: by 2002:a05:620a:25cd:b0:765:6782:cafd with SMTP id
 y13-20020a05620a25cd00b007656782cafdmr8166862qko.69.1687868662743; 
 Tue, 27 Jun 2023 05:24:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5zUol7rOE58BaS17fQeDU2moP+xoZB2mY301+mT3xABCbFwt/iqjdDWk6Trt2fhl45Cpl60g==
X-Received: by 2002:a05:620a:25cd:b0:765:6782:cafd with SMTP id
 y13-20020a05620a25cd00b007656782cafdmr8166852qko.69.1687868662508; 
 Tue, 27 Jun 2023 05:24:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a05620a034700b007651047d620sm3873542qkm.125.2023.06.27.05.24.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 05:24:21 -0700 (PDT)
Message-ID: <a80354b1-584a-d233-8a4b-d429161e452e@redhat.com>
Date: Tue, 27 Jun 2023 14:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] target/arm: Add raw_writes ops for register whose
 write induce TLB maintenance
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org
References: <20230228093619.342575-1-eric.auger@redhat.com>
 <27fd657b-02e7-658c-4cc4-07a6c374a1b9@redhat.com>
 <CAFEAcA_y2WHGU8xQ0Tw-UfdXF-FPbAV=mHA0vHYzoSz66VBoJQ@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA_y2WHGU8xQ0Tw-UfdXF-FPbAV=mHA0vHYzoSz66VBoJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.103, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Peter,

On 6/27/23 14:23, Peter Maydell wrote:
> On Fri, 23 Jun 2023 at 17:43, Eric Auger <eric.auger@redhat.com> wrote:
>> Hi Peter,
>>
>> On 2/28/23 10:36, Eric Auger wrote:
>>> Some registers whose 'cooked' writefns induce TLB maintenance do
>>> not have raw_writefn ops defined. If only the writefn ops is set
>>> (ie. no raw_writefn is provided), it is assumed the cooked also
>>> work as the raw one. For those registers it is not obvious the
>>> tlb_flush works on KVM mode so better/safer setting the raw write.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> If I am not wrong this patch fell into the cracks. Is it in a decent
>> state now?
> Oops, sorry about that. Yes, I think v3 looks good; I've
> applied it to target-arm.next.

no problem. thanks!

Eric
>
> thanks
> -- PMM
>


