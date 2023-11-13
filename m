Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C377E7E970D
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 08:28:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2RMR-00020y-G6; Mon, 13 Nov 2023 02:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2RMP-00020i-F9
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 02:27:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2RMM-0002zb-AE
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 02:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699860469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C/I/zpSh5MTkZyYBxCbTP8bPJWX1YDUZLPNOQfrjaeI=;
 b=B37l5TmaBWA+8QQ1jMIHkjPmmrXJ65JHR4M2TOSMyFbeGhRDgwLxmRCK37m344fhJuSwqU
 REtmIWuUlYmBYmip7KRASJbb5Kk3Q05KQ/WuiGLAo2hfUjg5njBhKukbw86jtikDK4Artl
 ToeRHH7rh6vvjSbVywNlKnossvScQiU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-njbjy74eMyuFSMuLXOM6tg-1; Mon, 13 Nov 2023 02:27:47 -0500
X-MC-Unique: njbjy74eMyuFSMuLXOM6tg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d03dcdc6bso52340206d6.1
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 23:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699860467; x=1700465267;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C/I/zpSh5MTkZyYBxCbTP8bPJWX1YDUZLPNOQfrjaeI=;
 b=iTmjCQHY4sl8knLPRFjut7CDfNmZZazicJl6pNA5m3coYhd7WeTj405kLeYXHYeTuU
 7UGNP9uJq2O8HAUEJ1SCWRcvGb7DReWonNCP92eUjHHI3XUmnKnifL8d79Sd6nCitWSi
 bOfhNE2eG/CqmxEZ7moJN5nsjCqEsXeGTvmI9PcNgy3WaTEi9yt646UZ1Uxkws8P635q
 mybO2kZ00NrDyfbTWDnz+jSpXqC3aVZaHfLu0rFFyAshgk2BVDbQk8+GCFLgB2fYZ/y+
 M2eB7VI75Kn7ICLF/ttJHz2YDELjGUZmBmKI/n5Ra+88HiW7anATcNs/grl0kAfmUuBx
 1s0w==
X-Gm-Message-State: AOJu0YzAmiOr2yBSvnQP+UI2g6JIfqx0XN81nWynzXpkzMzOm1T+wTGD
 kungOEbRIbm5bFnPCz1mI9Afd7Z86nkBL8QHtjOkiah5RFG936mkJt1hzb24HL8TrXWm1OFkzFl
 BH7xixzcczoFG5TQ=
X-Received: by 2002:a0c:ea4b:0:b0:656:3612:7954 with SMTP id
 u11-20020a0cea4b000000b0065636127954mr7283725qvp.1.1699860467093; 
 Sun, 12 Nov 2023 23:27:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfNm7lPW/MnWUxXYNa70I5a5/Nd1VTFXbDdgDraF8sC4920NZUnqTX4ICM/iqiG6zce5TFXg==
X-Received: by 2002:a0c:ea4b:0:b0:656:3612:7954 with SMTP id
 u11-20020a0cea4b000000b0065636127954mr7283718qvp.1.1699860466906; 
 Sun, 12 Nov 2023 23:27:46 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-177-79.web.vodafone.de.
 [109.43.177.79]) by smtp.gmail.com with ESMTPSA id
 lw4-20020a05621457c400b0066d1540f9ecsm1857001qvb.77.2023.11.12.23.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 23:27:46 -0800 (PST)
Message-ID: <3a95656b-5c01-4ac0-9586-abc7069bf2fe@redhat.com>
Date: Mon, 13 Nov 2023 08:27:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add a general architecture section for x86
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20230929134551.395438-1-thuth@redhat.com>
 <c3f7cb29-2aab-4767-a6af-58c4e043c002@redhat.com>
 <0c4ff767-7461-4ecd-9968-b216a98f0e95@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <0c4ff767-7461-4ecd-9968-b216a98f0e95@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 07/11/2023 10.50, Thomas Huth wrote:
> On 16/10/2023 11.05, Thomas Huth wrote:
>> On 29/09/2023 15.45, Thomas Huth wrote:
>>> It's a little bit weird that the files in target/i386/ which
>>> are not in a subfolder there do not have any associated
>>> maintainer (and thus nobody might be CC:-ed on changes to
>>> these files). We should have a general x86 section for these
>>> files, similar to what we already have for s390x and mips.
>>> Since Paolo is already listed as maintainer for both, the
>>> x86 KVM and TCG CPUs, I'd like to suggest him as maintainer
>>> for the general files, too.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   Richard, being listed as x86 TCG CPU maintainer, do you
>>>   want to be listed here, too?
>>>
>>>   MAINTAINERS | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 3914bbd85b..5b4ab7d142 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -131,6 +131,17 @@ K: ^Subject:.*(?i)mips
>>>   F: docs/system/target-mips.rst
>>>   F: configs/targets/mips*
>>> +X86 general architecture support
>>> +M: Paolo Bonzini <pbonzini@redhat.com>
>>> +S: Maintained
>>> +F: configs/devices/i386-softmmu/default.mak
>>> +F: configs/targets/i386-softmmu.mak
>>> +F: configs/targets/x86_64-softmmu.mak
>>> +F: docs/system/target-i386*
>>> +F: target/i386/*.[ch]
>>> +F: target/i386/Kconfig
>>> +F: target/i386/meson.build
>>> +
>>>   Guest CPU cores (TCG)
>>>   ---------------------
>>>   Overall TCG CPUs
>>
>> Friendly Ping!
>>
>> Paolo, Richard, what do you think about this?
> 
> Ping^2

Since there were no objections, I'm going to take this patch through my next 
pull request (where I have some other MAINTAINERS patches, too). We still 
can refine the entry later if necessary.

  Thomas


