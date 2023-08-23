Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 987AD7852EA
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:43:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjSC-0006qK-In; Wed, 23 Aug 2023 04:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYjS2-0006pl-LQ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYjRz-0005XS-9D
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692780170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0j1upsoJ3MjaVVepHUOU5G1PlXgElap/JdZphv6nsRc=;
 b=YH0yzgglTLnk5p1FjvziV8/XRHxLPigDN+u4jJAQL+UN0FZ/xmcBNuxmLCCzhO2pPnLxMp
 6LNsDNLUyZO0DmSoy9M+VVSCqYU+/XNABM6MkJ/QBp9wNEv7YyQAyelRTm0Cq9t+cyaS/J
 rUIgnOctQXdkp+70Rf++VME8syrOFzU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-WxLJfeVSNT2HTrc_w-k3eQ-1; Wed, 23 Aug 2023 04:42:48 -0400
X-MC-Unique: WxLJfeVSNT2HTrc_w-k3eQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe1cdf2024so34393065e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 01:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692780167; x=1693384967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0j1upsoJ3MjaVVepHUOU5G1PlXgElap/JdZphv6nsRc=;
 b=kFd38GnC+I1/QIpr8bRRC8ph3G2bg0wEI6RHVHMuvZOZv8DIYf0Pp4HfNJhNcjWXcn
 6aznujK8cESuxlW+UR6hA33nU76msvvMpRCL0Aqpnh6nHrf5gdRsNvukSPMH/okZLMHi
 qlowsl5rM2Rv3zo3JY0EhqsDONNwQKVhDjUng6g7Vcr/Br9QRKAoTyoKvYoWQR2J9xRW
 p3M9j35LGgyLtonK8511d5hZtr2+Ox/Q5B6ZJNq+/TpPyCBHFGArApDIzRLz1Mh4NbEI
 t2QsOwhSslKBlrmFzOtdfwwN0OCBUJJr0cR/ROPMgcQfOV/ap15V6oCD6F+7eO2eTjL1
 2ESg==
X-Gm-Message-State: AOJu0YxvLqta0USCW50L1hdbwk9K/Ta2ZZWwYAo+NIBSSuxIJYEqCrPH
 864m0buD1dy6aBcVEYBTHTMucrrXrF+IhmteG5DfY2RC2UBdEwm3L5YK1r7N9rBGdn0Va4RmFSN
 q3IFQ7YNd6lqkj/E=
X-Received: by 2002:a7b:ce06:0:b0:3fb:ffa8:6d78 with SMTP id
 m6-20020a7bce06000000b003fbffa86d78mr9316970wmc.36.1692780166957; 
 Wed, 23 Aug 2023 01:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCq+1Xg9mOuBUPy09XKrn9d4nBpIVwmHJYqx7iiN2h27v/NTvvOvjGK5iqs9/rCKlPHrGafw==
X-Received: by 2002:a7b:ce06:0:b0:3fb:ffa8:6d78 with SMTP id
 m6-20020a7bce06000000b003fbffa86d78mr9316958wmc.36.1692780166704; 
 Wed, 23 Aug 2023 01:42:46 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-178.web.vodafone.de.
 [109.43.177.178]) by smtp.gmail.com with ESMTPSA id
 k15-20020a7bc40f000000b003feef9a6cb2sm9920498wmi.28.2023.08.23.01.42.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 01:42:46 -0700 (PDT)
Message-ID: <0b87399c-a444-7743-dc1f-3e9520d17937@redhat.com>
Date: Wed, 23 Aug 2023 10:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] meson: Use subprocess.check_output()
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
References: <20230812091111.13411-1-akihiko.odaki@daynix.com>
 <1415ac82-0769-a25d-1dbd-c8382b9c52b2@redhat.com>
 <ee9258a8-ee82-90b8-1e2e-7d13b04a05b1@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ee9258a8-ee82-90b8-1e2e-7d13b04a05b1@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 23/08/2023 10.36, Michael Tokarev wrote:
> 23.08.2023 11:33, Thomas Huth wrote:
>> On 12/08/2023 11.11, Akihiko Odaki wrote:
>>> subprocess.check_output() is a more concise way to execute a subprocess
>>> here.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>> Based-on: <20230812061540.5398-1-akihiko.odaki@daynix.com>
>>> ("[PATCH] meson: Fix MESONINTROSPECT parsing")
>>
>> Since that other patch has never been merged, this patch here does not 
>> apply to master ... could you maybe respin it for the plain master branch?
> 
> Both patches should be applied, that one first, this one second.
> I don't think it needs a respin, just a proper patch series.

Ok, I'll try to pick both patches for my next pull request.

  Thomas



