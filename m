Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA7F7CDD15
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:20:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6TM-0004NY-2H; Wed, 18 Oct 2023 09:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6TB-0004LV-BM
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:20:17 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6T9-0002Hl-Em
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:20:17 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so80061851fa.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697635213; x=1698240013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PBfHY+i4wONx0Vv1enpd8PbgLKhbdsvN1Nv1qC7ToJE=;
 b=i8cShwimAJvYLu7yaM8vdTUsaS2VYAOmQOz9C3hh9qYERVT3TtyqbsDP9VTLtCBl9P
 EUS8KQHIk7VWRR29s5SQY7BxMg8XT2Q7bZBx8tpo51H8rGI2Vpm178e6viUa9AXyurgo
 S7F7jmowIsdw+/iv+L3BR1L4477tMr51n3rH9YaMoh1uY5wATL+mgOTjdrbTyJN1o7Zq
 /suiQsBhoeaPo2P95YfxHrRpBo5JW2CXSxJ2d91NJqWuZ+wq7S/c0NK/kcQZOf/kfz6C
 0IuNTBHDfjOwCtUsEzkcKMAvpUQk1qH1X0UczBEVthKflHeovypbnoYn1BSqQUMcZFW2
 E6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635213; x=1698240013;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PBfHY+i4wONx0Vv1enpd8PbgLKhbdsvN1Nv1qC7ToJE=;
 b=WsDVgxqYkRbICtvu/TtuuImMV2yJ+41P/VQFkCLQSetEMYq9+CSP1DK6aT28KUh12y
 IKHY/AlqFf19GlH1Hj7gCMWdxgkHa3OgErSE4Fyox6mgUmd/w6UDkvT50f73pV3PWCce
 kgTfZDH5lUVNGD6Ll3+tFuH8X3dFYrtjNIYEkjxtDIMVzWWwgRcTbAG1JhSIGO1/tKrE
 AdiOsh+V3MMXYjCAhZkxetC80AYRqvsPrjKcNbRH+rWxlGi3r3bOAKeTx6+JhHVb6TEG
 jKHrrObwy4HC7VroGLmqBXQwRa8aNtiQM8sY60gZOxIwvmlo5U5Fs1OH9elYvvHFxrmF
 CO6Q==
X-Gm-Message-State: AOJu0YzaEAB+Lo9uRWGPTgisucTVi2w3fXwJNCy4/aVHs566ChZ2vL1a
 ATXeV8mHqnVo+xknLOe4cOKM1Q==
X-Google-Smtp-Source: AGHT+IEDN1DNvVW/bylS5bS+5zz806wbV2yINrtEbnRdDjKaSpPko7MyWoaNEXQMF91xDTyZ9wbCSQ==
X-Received: by 2002:a2e:9b86:0:b0:2c0:14e2:1f5c with SMTP id
 z6-20020a2e9b86000000b002c014e21f5cmr3476863lji.5.1697635213262; 
 Wed, 18 Oct 2023 06:20:13 -0700 (PDT)
Received: from [192.168.69.115]
 (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr. [176.171.218.149])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c1c1400b003fefb94ccc9sm1536231wms.11.2023.10.18.06.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 06:20:12 -0700 (PDT)
Message-ID: <f12e8129-a77d-e8ee-2a25-b31b5729a0f5@linaro.org>
Date: Wed, 18 Oct 2023 15:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3] qapi: provide a friendly string representation of QAPI
 classes
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
References: <20231018120500.2028642-1-berrange@redhat.com>
 <87y1g0nm1y.fsf@pond.sub.org> <ZS/XgggmI0aoYJR0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZS/XgggmI0aoYJR0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 18/10/23 15:02, Daniel P. Berrangé wrote:
> On Wed, Oct 18, 2023 at 02:37:45PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>
>>> If printing a QAPI schema object for debugging we get the classname and
>>> a hex value for the instance:
>>>
>>>    <qapi.schema.QAPISchemaEnumType object at 0x7f0ab4c2dad0>
>>>    <qapi.schema.QAPISchemaObjectType object at 0x7f0ab4c2dd90>
>>>    <qapi.schema.QAPISchemaArrayType object at 0x7f0ab4c2df90>
>>>
>>> With this change we instead get the classname and the human friendly
>>> name of the QAPI type instance:
>>>
>>>    <QAPISchemaEnumType:CpuS390State at 0x7f0ab4c2dad0>
>>>    <QAPISchemaObjectType:CpuInfoS390 at 0x7f0ab4c2dd90>
>>>    <QAPISchemaArrayType:CpuInfoFastList at 0x7f0ab4c2df90>
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---


>> Mind if I swap things?  Like so:
>>
>>      def __repr__(self):
>>          if self.name is None:
>>              return "<%s at 0x%x>" % (type(self).__name__, id(self))
>>          else:
>>              return "<%s:%s at 0x%x>" % (type(self).__name__,
>>                                          self.name, id(self))

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Sure, fine with me.
> 
> With regards,
> Daniel

