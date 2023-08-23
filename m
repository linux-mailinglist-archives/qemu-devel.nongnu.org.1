Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A077852FB
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:47:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjV9-0008Pj-Hp; Wed, 23 Aug 2023 04:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYjV7-0008Pb-Vg
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:46:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYjV0-0006Qh-RN
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692780357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYCgD3FK4TPEmsEOeZqRhLkd2ClgPmKFVnN1x548baQ=;
 b=iDlus4+g0xgRdG6EpVNAJhES2svSp4hGhL6ANANuvkDhScTIB7AzzlzTXy85ZyvzsHRxaV
 IWv2qCMKcwP0zy0FV5lthWjDuQCMLN/bb4hl4nsW7qP1QDKnQruHohfVNGhY+iKSuLaV36
 NfTelXmfeOGA/wOLlLkYqGUnrHHMssU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-RTQaFDzyNhaaeN-VGOIK5g-1; Wed, 23 Aug 2023 04:45:55 -0400
X-MC-Unique: RTQaFDzyNhaaeN-VGOIK5g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so3472657f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 01:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692780354; x=1693385154;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eYCgD3FK4TPEmsEOeZqRhLkd2ClgPmKFVnN1x548baQ=;
 b=hB4L42tKMI8odJFX/XWZO1Re4A5pnO6lpld/GdV3gKdwW2nuL0MqezIRW7SGln2ZA6
 n+KxHelo5+7TGC2hkWtIa7lkHRjbqETUByfhJI2p72UERuYXRuu3m3eCubslrGkLVctR
 5kAz6fkVIkyCS4x7tY5Mn704HZIdJfDMqGlDpoR6ArToo1vduhYNPFOwjHwzShd16op9
 JrkbAp+EQA8MVQhO3Z6Mor0isvybNgekWEH0ZmK75OdxVMQUK/Cf/ApBRPDp+6vVmyB+
 D1EbYS/1SsrxzNgRZrkozkmdQVDrcllvOySp9KOva7KN5CTW/zvhsP5LUp0i2BJnzwc6
 Z88g==
X-Gm-Message-State: AOJu0Yxvfldco7U22LbvWQlqPqcWdjDhdQoYrCiTDQdFFMZvaOpKKYKJ
 M6mYM6CHP1XpUK269syOHF5TOKhiZKvTJZ+bwqNYOkvyhFfma9oxbiPr7A6LsM1fu9sDCXEpyOP
 IOQWqQvgPqDNiVmA=
X-Received: by 2002:a5d:414c:0:b0:31c:6591:d40d with SMTP id
 c12-20020a5d414c000000b0031c6591d40dmr2728844wrq.29.1692780354039; 
 Wed, 23 Aug 2023 01:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH98XApfJD+dECGiTEv/XFPxxn8Iep884yR1MX9+FEAaldHtn6ngQU+57LslP4abb5mb0Vjw==
X-Received: by 2002:a5d:414c:0:b0:31c:6591:d40d with SMTP id
 c12-20020a5d414c000000b0031c6591d40dmr2728827wrq.29.1692780353718; 
 Wed, 23 Aug 2023 01:45:53 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-178.web.vodafone.de.
 [109.43.177.178]) by smtp.gmail.com with ESMTPSA id
 q1-20020a056000136100b003180027d67asm18003933wrz.19.2023.08.23.01.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 01:45:53 -0700 (PDT)
Message-ID: <1b63fee8-ed0e-799b-d132-aec99e8b1e3b@redhat.com>
Date: Wed, 23 Aug 2023 10:45:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] meson: Use subprocess.check_output()
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
References: <20230812091111.13411-1-akihiko.odaki@daynix.com>
 <1415ac82-0769-a25d-1dbd-c8382b9c52b2@redhat.com>
 <ee9258a8-ee82-90b8-1e2e-7d13b04a05b1@tls.msk.ru>
 <0b87399c-a444-7743-dc1f-3e9520d17937@redhat.com>
In-Reply-To: <0b87399c-a444-7743-dc1f-3e9520d17937@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 23/08/2023 10.42, Thomas Huth wrote:
> On 23/08/2023 10.36, Michael Tokarev wrote:
>> 23.08.2023 11:33, Thomas Huth wrote:
>>> On 12/08/2023 11.11, Akihiko Odaki wrote:
>>>> subprocess.check_output() is a more concise way to execute a subprocess
>>>> here.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>> Based-on: <20230812061540.5398-1-akihiko.odaki@daynix.com>
>>>> ("[PATCH] meson: Fix MESONINTROSPECT parsing")
>>>
>>> Since that other patch has never been merged, this patch here does not 
>>> apply to master ... could you maybe respin it for the plain master branch?
>>
>> Both patches should be applied, that one first, this one second.
>> I don't think it needs a respin, just a proper patch series.
> 
> Ok, I'll try to pick both patches for my next pull request.

Ah, no, Akihiko said "Please do NOT merge this" on the other patch, so let's 
wait 'til the issue with Windows has been resolved first.

  Thomas



