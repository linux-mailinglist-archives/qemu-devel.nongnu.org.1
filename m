Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3029543A3
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Aug 2024 10:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1servp-0002U8-4l; Fri, 16 Aug 2024 04:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1servl-0002Mu-27
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1servj-0001Kw-BB
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723795405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=amsG1ZV5GwnBwAPmeVTiEl2SMD9eJd+8DnZOsm07hQM=;
 b=OYIUYRJ5BYjt4rTyNNuFpGfvulaGRQBnnqStD/5YFkF4dL4hDaQA8RDp1JJaVunr2+JQXn
 CPe9U6tf8khXZZLUqON/dLtgsr5S6+n0JZvmdRN98DwXAQaFDV/K5XTpnP87Cn9TMdMTB8
 kHJ3IUr1HUkyuFX927rnekl44nW46kk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-wnfvovdeODOIB2QCKzabag-1; Fri, 16 Aug 2024 04:03:23 -0400
X-MC-Unique: wnfvovdeODOIB2QCKzabag-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-428040f49f9so12777985e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 01:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723795402; x=1724400202;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amsG1ZV5GwnBwAPmeVTiEl2SMD9eJd+8DnZOsm07hQM=;
 b=Ub+AlfEJxKj6sFD+eYqwWtcX3gZYCFkh7C2xeZYvirzQo+4R4RTuHVj1M360vgWL+9
 WpBTKFcOqNg8Uxbl87Scu7I04fHAxfEF3sU5Y9mKKTk/ntbYhBmEXHleHRhMYXWcQ7A6
 1XUs7CPBMtaGHLETMm6E8KJxnZ7fy5+HabTYMd7qNGFpFeM1Hf8TaK7vgxUuWroiSboo
 woTvip5DnDKSnZCCKc1rk28WyojRgrC053oCLNbu4wTsy0r8cdN+6LfYZwKurCGl0yNu
 ReVcSVpZN/e80aFLri5dF2IPoui0BUd769B4u+K3W4HrqhLYJZ+8qte37ZAe/7w00tZ8
 yzjA==
X-Gm-Message-State: AOJu0Yy8onD6vzi1RQKoUpULg38fBZ2Mnh91+AefgrEnFUKV7HIPyZmn
 U5Z2hoqK0S8hAQaBOGd25n8rGocFOfQn9RpZS8p5D3KHNu8pm4oreS4C2MEKpTWzT44i7RrkWoA
 M9h47hid6AiO3g/H+1H4WHmNPaMrM8pp+JMiyHYhBALeeCG4k6RZO
X-Received: by 2002:a05:600c:a05:b0:426:554a:e0bf with SMTP id
 5b1f17b1804b1-429ed79f5camr13209525e9.16.1723795402063; 
 Fri, 16 Aug 2024 01:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG40J/+2cBCZxLuo0HTI0bNQWudtP1tzUwUqmAGCi5tJ08z2HcaEezA7tITEkTN8obkJ0P8TA==
X-Received: by 2002:a05:600c:a05:b0:426:554a:e0bf with SMTP id
 5b1f17b1804b1-429ed79f5camr13209255e9.16.1723795401564; 
 Fri, 16 Aug 2024 01:03:21 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-15.web.vodafone.de.
 [109.43.177.15]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded299a9sm68466815e9.18.2024.08.16.01.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 01:03:21 -0700 (PDT)
Message-ID: <a8ec0efa-0369-4f21-9234-e447b40c0973@redhat.com>
Date: Fri, 16 Aug 2024 10:03:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] meson: Use -fno-sanitize=function when available
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240816-function-v3-1-32ff225e550e@daynix.com>
 <3d417232-ba66-4781-8278-a6a31987b54c@redhat.com>
 <337e647e-3edf-475c-8e37-de3d28b30340@daynix.com>
 <bfd436ad-f76d-4bc3-b92f-cf9aaca9c7f5@redhat.com>
 <6d1949bc-a0c2-487c-8b6c-21db12f6a0af@daynix.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6d1949bc-a0c2-487c-8b6c-21db12f6a0af@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 16/08/2024 09.30, Akihiko Odaki wrote:
> On 2024/08/16 16:27, Thomas Huth wrote:
>> On 16/08/2024 09.12, Akihiko Odaki wrote:
>>> On 2024/08/16 16:03, Thomas Huth wrote:
>>>> On 16/08/2024 08.22, Akihiko Odaki wrote:
>>>>> Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
>>>>> -fno-sanitize=function in the clang-system job") adds
>>>>> -fno-sanitize=function for the CI but doesn't add the flag in the
>>>>> other context. Add it to meson.build for such. It is not removed from
>>>>> .gitlab-ci.d/buildtest.yml because -fno-sanitize=function in meson.build
>>>>> does not affect --extra-cflags due to argument ordering.
>>>>>
>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>> ---
>>>>> Changes in v3:
>>>>> - I was not properly dropping the change of .gitlab-ci.d/buildtest.yml
>>>>>    but only updated the message. v3 fixes this. (Thomas Huth)
>>>>> - Link to v2: 
>>>>> https://lore.kernel.org/r/20240729-function-v2-1-2401ab18b30b@daynix.com
>>>>>
>>>>> Changes in v2:
>>>>> - Dropped the change of: .gitlab-ci.d/buildtest.yml
>>>>> - Link to v1: 
>>>>> https://lore.kernel.org/r/20240714-function-v1-1-cc2acb4171ba@daynix.com
>>>>> ---
>>>>>   meson.build | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/meson.build b/meson.build
>>>>> index 5613b62a4f42..a4169c572ba9 100644
>>>>> --- a/meson.build
>>>>> +++ b/meson.build
>>>>> @@ -609,6 +609,7 @@ if host_os != 'openbsd' and \
>>>>>   endif
>>>>>   qemu_common_flags += cc.get_supported_arguments(hardening_flags)
>>>>> +qemu_common_flags += cc.get_supported_arguments('-fno-sanitize=function')
>>>>
>>>> As I mentioned in my last mail: I think it would make sense to move this 
>>>> at the end of the "if get_option('tsan')" block in meson.build, since 
>>>> this apparently only fixes the use of "--enable-sanitizers", and cannot 
>>>> fix the "--extra-cflags" that a user might have specified?
>>>
>>> Sorry, I missed it. It cannot fix --extra-cflags, but it should be able 
>>> to fix compiler flags specified by compiler distributor.
>>
>> Oh, you mean that there are distros that enable -fsanitize=function by 
>> default? Can you name one? If so, I think that information should go into 
>> the patch description...?
> 
> No, it is just a precaution.

Ok. I don't think any normal distro will enable this by default since this 
impacts performance of the programs, so it's either the user specifying 
--enable-sanitizers or the user specifying --extra-cflags="-fsanitize=...". 
In the latter case, your patch does not help. In the former case, I think 
this setting should go into the same code block as where we set 
-fsanitize=undefined in our meson.build file, so that it is clear where it 
belongs to.

  Thomas



