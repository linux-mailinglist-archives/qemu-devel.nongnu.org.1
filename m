Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C6D7AB1E2
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 14:11:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjezC-0001I2-E7; Fri, 22 Sep 2023 08:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1qjez4-0001HI-3R
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 08:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1qjeyz-0005Is-CU
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 08:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695384603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uuWiaManMtBBSMjg6XtohxhxpYJP4xrlEQR3HAEe07M=;
 b=ZGN+CeBxTuBess2Y1y1xd+wyrFK+5Hb5Oht7kzFUPnjWQ23ZfJ8cTjNd7GuA9RHXlKyz3t
 Bkt/WDK0vV90UvZg+dXhR9oaS15M5/e6fPOVa9neuCVkpCiD0u5fjIOYcrfX6WQclx2Ks7
 xVCtJ8VkmKfABdjBp+Q+eQLOFicoEKc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-TPrBc5E7NeCeFWyxtn3hBg-1; Fri, 22 Sep 2023 08:08:28 -0400
X-MC-Unique: TPrBc5E7NeCeFWyxtn3hBg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9adc78b386cso145484266b.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 05:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695384507; x=1695989307;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uuWiaManMtBBSMjg6XtohxhxpYJP4xrlEQR3HAEe07M=;
 b=Ghm4gzkCmF73Nti45+imYXU7YVrNkRJ0grCYlwruhJyDN0DUuIKrMjXsrMnkSPcZCx
 +pNX+Bk2qjW0p8knuTUGkddnlQJ1oPaSrm2CMZrndZi7gnk1MWIq+849Duf0GYLTn6zC
 SBPd9NwBoy2MEM82dArOAi8rYm85Ms2AG8eodrb1/tSArLUwiuCiq4TRu5K1cMsnwHcx
 j7zSm3lNR6fRokMjQ8ovf4RPfMUQiMgb2DpwWgco9MuBQWXOINd/tipmcrGB6gV7CN55
 oXLcJ3u3kBahPERusq/CrGCIkh32L3pBulwam+ndOMhtCLz6JycNB5glqByKbibFZg2h
 1R6g==
X-Gm-Message-State: AOJu0YzYH4w1+gg9Swgexkn8MF7jzPIY6cIQMhKNhZ3F3mQPSbcdxn8a
 YnQ5ZGs5v7+AKF37Hb6LfZG2Yv6OCIaanxhhq60CyptR5HjUrgQq2uDCOkW2X0+fcTNR/br3hCj
 rFEnYlF5TUkP2mgc=
X-Received: by 2002:a17:906:314e:b0:9a2:1b05:24c6 with SMTP id
 e14-20020a170906314e00b009a21b0524c6mr6801200eje.22.1695384507396; 
 Fri, 22 Sep 2023 05:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMay0AeBO+YDYuSaifgli8IjBzsTkAzYMsJiG1UQRF90XKttOWMfVT6n9RpEu83wkriHpdIA==
X-Received: by 2002:a17:906:314e:b0:9a2:1b05:24c6 with SMTP id
 e14-20020a170906314e00b009a21b0524c6mr6801189eje.22.1695384507120; 
 Fri, 22 Sep 2023 05:08:27 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a170906050800b009934855d8f1sm2591418eja.34.2023.09.22.05.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 05:08:25 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/2] i386: Fix Hyper-V Gen1 guests stuck on boot with
 'hv-passthrough'
In-Reply-To: <87mszgmd9j.fsf@redhat.com>
References: <20230612084201.294248-1-vkuznets@redhat.com>
 <875y79paq6.fsf@redhat.com> <87mszgmd9j.fsf@redhat.com>
Date: Fri, 22 Sep 2023 14:08:24 +0200
Message-ID: <87ediqcsw7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>
>> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>>
>>> Hyper-V Gen1 guests are getting stuck on boot when 'hv-passthrough' is
>>> used. While 'hv-passthrough' is a debug only feature, this significantly
>>> limit its usefullness. While debugging the problem, I found that there are
>>> two loosely connected issues:
>>> - 'hv-passthrough' enables 'hv-syndbg' and this is undesired.
>>> - 'hv-syndbg's support by KVM is detected incorrectly when !CONFIG_SYNDBG.
>>>
>>> Fix both issues; exclude 'hv-syndbg' from 'hv-passthrough' and don't allow
>>> to turn on 'hv-syndbg' for !CONFIG_SYNDBG builds. 
>>>
>>> Vitaly Kuznetsov (2):
>>>   i386: Fix conditional CONFIG_SYNDBG enablement
>>>   i386: Exclude 'hv-syndbg' from 'hv-passthrough'
>>>
>>>  docs/system/i386/hyperv.rst | 13 +++++++++----
>>>  target/i386/cpu.c           |  2 ++
>>>  target/i386/kvm/kvm.c       | 18 ++++++++++++------
>>>  3 files changed, 23 insertions(+), 10 deletions(-)
>
> Monthly ping)

Turns out these patches were never merged and honestly I forgot about
them myself. Will resend shortly.

-- 
Vitaly


