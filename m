Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2290A7699F2
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:44:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQU7b-0003T2-UA; Mon, 31 Jul 2023 10:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQU7Z-0003Rk-18
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQU7X-0004Zl-ER
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690814614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07N8W+n1zUkJf9RP7p5KK8eqqmMM4/BXcUOJFBYrcUY=;
 b=e0uOV2MlOaPwmdrGinV2xBt460O7kIWdzS/eCwdleyZPEVhKLylqwRt+xUMMllETRifenv
 KZ6FosuXcAkAbZ6iI7v+53Ur4mxW06Aw9eNheZ9Ml+9A00ubLqKAtnPJD6UHmAoqIhIcjF
 lL3p85urn+vueSKaRnl6V/cDpw/F5r8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-D7hIJoNIOd-AcBW6EBrB7A-1; Mon, 31 Jul 2023 10:43:33 -0400
X-MC-Unique: D7hIJoNIOd-AcBW6EBrB7A-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63cf53a33a3so58199696d6.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690814612; x=1691419412;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=07N8W+n1zUkJf9RP7p5KK8eqqmMM4/BXcUOJFBYrcUY=;
 b=geM++HjRk28gXfujLZNzNNobOwPpBVfKg/B6F6epv5IOhfjqmq35RlvORk6psos9yr
 7WSXn4KqPRsY8oTLfQY6m6ToJRZGXoXj6+e4WeZ7juBqUlG9/yqvcDLiIHkTacbuQF6C
 ocIHwrdR+VF4IRfVtQKCT/1+gSpgTunJvjnRlTQ+rJHfTnW/sGJD/2bjaJ1fSNB5rUal
 3Z6WH5/lBXhA0uDc1ME2+rfN6Ri3qU0E64PxTmbZqkW6+VGjGNku94va83hv3LFrSUXF
 MyHC+Q+SHekdu0a4lrlw8qzQC/NSQ0DSIOhzFYQgpRxYxzVTnWjkqkwCcrn/usp5lLHS
 ugwg==
X-Gm-Message-State: ABy/qLYJ75ICayibkRFMIP+Lif/L57u0FJHWChz4anGpxFmAE8OaYB9V
 Cv4Yw8fnoESS2wYrXxB98siS49Ushd+bukGNaUMgMCurEjfiKc+5mdI1v/UL6aFU7H6QI5Muumf
 1SVHuk2AOn1JM34s=
X-Received: by 2002:a0c:f3c8:0:b0:631:f426:a4ab with SMTP id
 f8-20020a0cf3c8000000b00631f426a4abmr9812372qvm.49.1690814612813; 
 Mon, 31 Jul 2023 07:43:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEmXjXa/Jlrwiv5N7b3aKrPnvNcPmxycewj/nmv2IyxT4wKEbJHjaBTdtg/dXjpN6GJrzfCaw==
X-Received: by 2002:a0c:f3c8:0:b0:631:f426:a4ab with SMTP id
 f8-20020a0cf3c8000000b00631f426a4abmr9812360qvm.49.1690814612592; 
 Mon, 31 Jul 2023 07:43:32 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-20.web.vodafone.de.
 [109.43.178.20]) by smtp.gmail.com with ESMTPSA id
 w13-20020a0c8e4d000000b006360931c12fsm2916488qvb.96.2023.07.31.07.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 07:43:32 -0700 (PDT)
Message-ID: <a45f5f3a-2139-da7b-0323-a32fa69f1788@redhat.com>
Date: Mon, 31 Jul 2023 16:43:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 6/6] gitlab-ci.d/windows: Use Clang for compiling in
 the 64-bit MSYS2 job
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-7-thuth@redhat.com>
 <62b923c2-5c22-44c5-99cd-95351fd200db@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <62b923c2-5c22-44c5-99cd-95351fd200db@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31/07/2023 16.23, Philippe Mathieu-Daudé wrote:
> On 28/7/23 16:27, Thomas Huth wrote:
>> We are struggeling with timeouts in the 64-bit MSYS2 job. Clang seems
>> to be a little bit faster, so let's use this compiler now instead.
>>
>> There is a problem with compiling the spice headers with Clang, though,
>> so we can only test this in the 32-bit builds with GCC now. And we have
>> to disable dbus-display - otherwise the compilation aborts in the CI.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   .gitlab-ci.d/windows.yml | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
>> index f086540e40..ff9e9af4bb 100644
>> --- a/.gitlab-ci.d/windows.yml
>> +++ b/.gitlab-ci.d/windows.yml
>> @@ -43,7 +43,6 @@
>>         $MINGW_TARGET-curl
>>         $MINGW_TARGET-cyrus-sasl
>>         $MINGW_TARGET-dtc
>> -      $MINGW_TARGET-gcc
>>         $MINGW_TARGET-glib2
>>         $MINGW_TARGET-gnutls
>>         $MINGW_TARGET-gtk3
>> @@ -63,9 +62,9 @@
>>         $MINGW_TARGET-SDL2
>>         $MINGW_TARGET-SDL2_image
>>         $MINGW_TARGET-snappy
>> -      $MINGW_TARGET-spice
>>         $MINGW_TARGET-usbredir
>> -      $MINGW_TARGET-zstd "
>> +      $MINGW_TARGET-zstd
>> +      $EXTRA_PACKAGES "
>>     - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
>>     - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
>>     - mkdir build
>> @@ -77,13 +76,15 @@
>>   msys2-64bit:
>>     extends: .shared_msys2_builder
>>     variables:
>> -    MINGW_TARGET: mingw-w64-x86_64
>> -    MSYSTEM: MINGW64
>> +    MINGW_TARGET: mingw-w64-clang-x86_64
>> +    MSYSTEM: CLANG64
> 
> OK to use Clang, but I'm tempted to keep the GCC job in manual mode...

Why? We still have the 32-bit job with GCC, and the MinGW cross-compiler job 
with GCC, so that's already quite a bit of coverage, isn't it?

  Thomas



