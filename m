Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 533347C587E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:50:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbSi-0000kO-Tc; Wed, 11 Oct 2023 11:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbSO-0000cX-Mv
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:49:15 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbSD-0003wC-Ev
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:49:06 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-57b64731334so4043646eaf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697039336; x=1697644136;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eA1Se7dOBB1kh9FKSToDGjQbsNfJbJcnnnap3Ky0lYk=;
 b=HYnGFyjUFZS088ZwTNqJR3Q9qT5A2gVnifHmDGdVyD50QcX6tEFB18UBedsQo75Dhw
 FqDjCNYPUR8F4zYu414bG23qlvNBJuzW9/abfQ5+4VJ6Q1lrPZ3dGCESXtSxaCfHQwb3
 nZ/TYUszTV9Way01kvNrlKKiycoxIPPs8RlYc3OWv0QycRlDSAj1OwvleB1cX3SSygNz
 7rt7oq+iFOICV9/EIsf8YPlkFeSKFhxhnQ0+PZtbiMXlCMY7FgqLweoUR+FuvGg1UVKe
 jaquUPAXt65R7fkwlymYJyulfGpvMPtNDzI6sLSfdj/QG6zJax/xt776G6dQxxbe/2YG
 VN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697039336; x=1697644136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eA1Se7dOBB1kh9FKSToDGjQbsNfJbJcnnnap3Ky0lYk=;
 b=MA7Sj+jp6pfauwo6q89gdJ9AOSMxmEcqG0m01vmYVA+BGhLMURqR+NYBQ35L9jx/aY
 iDl6i7tghXvTRGkDYxRqGFHDNO+07nGvdSIYYo+feCEAHMq/v3re52plEmTu96g8KBt4
 K1opuI06DHVf6M5AilZxl5jH1XSgD559xCbXh3FrcB+aiSU+IAnfXJN08VFLb/WQABrG
 wxj+jQVYlZ/Dn6KRNniFzL4qPHPPbN+VAnAznCN65RMf8UjbQXD+WSnHIOAY3aASiQXR
 15wK9w17YU4knGH/1tOwRbDmWpr78cFxvpSDYWD9E3DzKDg+8ee74j7CEhrAzi87tuWA
 VIiw==
X-Gm-Message-State: AOJu0Yzb1mZlQGI3ov2wkbu84oKFitWla1K0Ik0J1fhaigBClzt4nsVL
 sUUYLnOY3xbFIVQdcbkWQEwhAA==
X-Google-Smtp-Source: AGHT+IGrEpPXqUU1G8yThqgdAZH5KQchyLzKTUGkVtODYcRm03/ugQPZ0zNwHwvTBvc10hC1VHvPYw==
X-Received: by 2002:a05:6358:52c4:b0:133:291:f9ac with SMTP id
 z4-20020a05635852c400b001330291f9acmr25574859rwz.25.1697039336129; 
 Wed, 11 Oct 2023 08:48:56 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 o22-20020a056a001b5600b00692aea7fb29sm10322760pfv.88.2023.10.11.08.48.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 08:48:55 -0700 (PDT)
Message-ID: <2c970c00-519c-4175-b0ca-9081c4aa0daf@daynix.com>
Date: Thu, 12 Oct 2023 00:48:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 23/23] plugins: Support C++
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
 <20231011070335.14398-24-akihiko.odaki@daynix.com>
 <ZSZiAHtXGOZnZNas@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZSZiAHtXGOZnZNas@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c32;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/11 17:51, Daniel P. Berrangé wrote:
> On Wed, Oct 11, 2023 at 04:03:09PM +0900, Akihiko Odaki wrote:
>> Make qemu-plugin.h consumable for C++ platform.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   docs/devel/tcg-plugins.rst |  4 ++++
>>   meson.build                |  2 +-
>>   include/qemu/qemu-plugin.h |  4 ++++
>>   tests/plugin/cc.cc         | 16 ++++++++++++++++
>>   tests/plugin/meson.build   |  5 +++++
>>   tests/tcg/Makefile.target  |  3 +--
>>   6 files changed, 31 insertions(+), 3 deletions(-)
>>   create mode 100644 tests/plugin/cc.cc
>>
>> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
>> index c9f8b27590..984d8012e9 100644
>> --- a/docs/devel/tcg-plugins.rst
>> +++ b/docs/devel/tcg-plugins.rst
>> @@ -283,6 +283,10 @@ run::
>>     160          1      0
>>     135          1      0
>>   
>> +- contrib/plugins/cc.cc
>> +
>> +A pure test plugin to ensure that the plugin API is compatible with C++.
>> +
> 
> IMHO we don't need to be adding a test just to prove the
> existance of the G_BEGIN_DECLS/G_END_DECLS macros in the
> plugin header.

Strictly speaking, if you include this header file from C++, the code 
will be interpreted as C++ instead of C but with C linkage. That worries 
me that the header file may get something not allowed in C++ in the future.

