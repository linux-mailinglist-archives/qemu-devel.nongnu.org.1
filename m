Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9457C590D
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 18:23:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqby7-0006uP-2d; Wed, 11 Oct 2023 12:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqby4-0006tu-MU
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 12:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqby2-0002lB-Sh
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 12:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697041309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BHCVOrokbVIUcJTzMk/gOURa0T9oMuRKCMmnDwJjAiY=;
 b=JtT6YBVd2Zylqafxanr4AU73BSAABMImGfJnWsw/qgdNwsMN09tzKkbfySB6BCIUwGB9Ut
 hSSDahOgzBRAzsxlchPUK1hH/l/leaqstqOHRvPkI1yAgFXvk22m2kAy/sLh/6dUbCGRLQ
 hbkxkBZAOqbWXWoLA73I+KYHC81BnCQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-fkc-5eJlMSSZ5joXv0vtoQ-1; Wed, 11 Oct 2023 12:21:36 -0400
X-MC-Unique: fkc-5eJlMSSZ5joXv0vtoQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-59f53027158so398137b3.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 09:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697041296; x=1697646096;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BHCVOrokbVIUcJTzMk/gOURa0T9oMuRKCMmnDwJjAiY=;
 b=rBRyD54Xqc6RwS3Hvk8eJkwCGmqIDSl57K0nm8KMx+XJ9uQOOLxlKd+p/w4IwtrgwL
 Szovo24kDeTqvuXxJtEo5RXnPNbDWcitn1ITTscwRnz/aat/aEUQkvDlIwqzJBm65IoX
 luAXzdEkk0xS9BXJQPzW3QHVjjYXUy7YuIp+GqVHxRdH69EwTW0lTKFMdRtKi2vFto6h
 fThOkiDWYK7X0H2Rz1S+VxJ7xtUKLw6zhE6PNwo0yiOFNBCXqtmrgwNgCxIc07lYSR7C
 V8NphKhlRCsYhaOuX0dwDxUUr5wDvGdQtmq3yjjNDryGLXD9ObtGPTfVsZSOrF3WiznA
 58Lw==
X-Gm-Message-State: AOJu0Yx/z+WbCggbEVYm0jE+cxNMAvg3JR/ARMucnqKpcQ/DO/6p3wgS
 Wy74pYqk8eMmeecO6sHEI553fvYiHQrTxK4aqSageSJbDZc5/T+FN2FXolkJPZgFkPXx1ASoMGt
 6sYp+9XpxoLgfmCs=
X-Received: by 2002:a81:7cc5:0:b0:599:b59f:5280 with SMTP id
 x188-20020a817cc5000000b00599b59f5280mr23106653ywc.28.1697041295809; 
 Wed, 11 Oct 2023 09:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYcOAFMpLaEyQQURU+y/8tdEyHAjWwILq/yLmZmHSM2HMjdsD2tbVb68QEfH9+zU+Crn4WrQ==
X-Received: by 2002:a81:7cc5:0:b0:599:b59f:5280 with SMTP id
 x188-20020a817cc5000000b00599b59f5280mr23106626ywc.28.1697041295526; 
 Wed, 11 Oct 2023 09:21:35 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 bs40-20020a05620a472800b0077703f31496sm3729626qkb.92.2023.10.11.09.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 09:21:35 -0700 (PDT)
Message-ID: <ffdd55c2-4ae9-4b1f-ac12-a9ad714c3f26@redhat.com>
Date: Wed, 11 Oct 2023 18:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 23/23] plugins: Support C++
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
 <20231011070335.14398-24-akihiko.odaki@daynix.com>
 <ZSZiAHtXGOZnZNas@redhat.com>
 <2c970c00-519c-4175-b0ca-9081c4aa0daf@daynix.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2c970c00-519c-4175-b0ca-9081c4aa0daf@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 11/10/2023 17.48, Akihiko Odaki wrote:
> On 2023/10/11 17:51, Daniel P. Berrangé wrote:
>> On Wed, Oct 11, 2023 at 04:03:09PM +0900, Akihiko Odaki wrote:
>>> Make qemu-plugin.h consumable for C++ platform.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   docs/devel/tcg-plugins.rst |  4 ++++
>>>   meson.build                |  2 +-
>>>   include/qemu/qemu-plugin.h |  4 ++++
>>>   tests/plugin/cc.cc         | 16 ++++++++++++++++
>>>   tests/plugin/meson.build   |  5 +++++
>>>   tests/tcg/Makefile.target  |  3 +--
>>>   6 files changed, 31 insertions(+), 3 deletions(-)
>>>   create mode 100644 tests/plugin/cc.cc
>>>
>>> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
>>> index c9f8b27590..984d8012e9 100644
>>> --- a/docs/devel/tcg-plugins.rst
>>> +++ b/docs/devel/tcg-plugins.rst
>>> @@ -283,6 +283,10 @@ run::
>>>     160          1      0
>>>     135          1      0
>>> +- contrib/plugins/cc.cc
>>> +
>>> +A pure test plugin to ensure that the plugin API is compatible with C++.
>>> +
>>
>> IMHO we don't need to be adding a test just to prove the
>> existance of the G_BEGIN_DECLS/G_END_DECLS macros in the
>> plugin header.
> 
> Strictly speaking, if you include this header file from C++, the code will 
> be interpreted as C++ instead of C but with C linkage. That worries me that 
> the header file may get something not allowed in C++ in the future.

I think it should be enough if you add the G_BEGIN_DECLS/G_END_DECLS macros 
here. QEMU is a C project, and it was quite difficult to get rid of the C++ 
code again, so please don't soften the check in meson.build and don't 
introduce new .cc files.
If you have some code somewhere that uses C++ for plugins, I think it would 
be better to add a regression test there instead.

  Thomas



