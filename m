Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C001E7EDF7A
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 12:19:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3aNM-0005rU-Nl; Thu, 16 Nov 2023 06:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3aNB-0005rG-Vo
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 06:17:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3aNA-0008Ds-9q
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 06:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700133442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xUL23OdJUNWIkD1pw+4V2KCssVfdvESVaYD7IDVY57A=;
 b=O7I6zQtjdZizrWQ9FK7ku8AcZpz4hUbH2nJP4Ty1NOF1jhiURrnkNl8of3FaA67kH06Zf4
 0XjWo68M+0GFZYHuX7cdapCtj3/oQS9xinsEnPqvGB4huZakl2ci+Vy726Dh6o/xwfKbRg
 vRHt4n9pPMmTibBzb9p2/n3L229KLjA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-pO423qU4MPeiQ-5m2BMKrQ-1; Thu, 16 Nov 2023 06:17:21 -0500
X-MC-Unique: pO423qU4MPeiQ-5m2BMKrQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66fe14725aeso8863246d6.2
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 03:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700133440; x=1700738240;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xUL23OdJUNWIkD1pw+4V2KCssVfdvESVaYD7IDVY57A=;
 b=XLjM/djf3ZFQVYXfhSdQ6Z3ZU9RL+c/bAFdOlepoxfPlxszAkOk7VTyFt4HVamfR4p
 nEsVGVpyo7L23ePMuNz2WJH1hvz6X/EE4zu7dtZMP8sgC7TVfarpyHOhquOnWEwqjw94
 P8XtI6xD9roM385wzOrk3b8tAEmCIzOWvJ6UNYSyyd+lvpIrJ3UfCXhY70LEdg7ZJ4by
 SyTzU7/GddRilsAiik6B6+4zT12vwbm9WjY7BQ/k1wijXZU6rp4GcmzFJFKm/5zEqLm3
 HwDoclMg9isvAa0f9AkhrSH3gxQ0l96YSHogWLOvuoY0GppMnXuvW/92bdMEi54Zcddq
 YFaQ==
X-Gm-Message-State: AOJu0Yw++v29Tbfx3YL0LtHIS1gTJW0AtrSQ1Pj7BOl0nLjVoentPjSh
 8uG3NOZy44e31INTfPBmL871ebHagEC9evDdgG0sczDqM2yQr3DcBEkQ9tOjua/x/vAZmB/z+40
 eoChB3BiswsU9jKE=
X-Received: by 2002:a0c:f706:0:b0:66d:1e25:9777 with SMTP id
 w6-20020a0cf706000000b0066d1e259777mr7938907qvn.64.1700133440799; 
 Thu, 16 Nov 2023 03:17:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV8Y9LhhLbfG/q3R8icq1U9GL/vRbfZlpAebCJ1lD70w7iVUzmEFSLk8anVAE9hOVAh03M9g==
X-Received: by 2002:a0c:f706:0:b0:66d:1e25:9777 with SMTP id
 w6-20020a0cf706000000b0066d1e259777mr7938895qvn.64.1700133440525; 
 Thu, 16 Nov 2023 03:17:20 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-122.web.vodafone.de.
 [109.43.176.122]) by smtp.gmail.com with ESMTPSA id
 v14-20020a0cdd8e000000b0065b29403540sm1284111qvk.127.2023.11.16.03.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 03:17:20 -0800 (PST)
Message-ID: <e04933cf-1c74-4475-8007-888d9d0591f2@redhat.com>
Date: Thu, 16 Nov 2023 12:17:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qom/object: Limit type names to alphanumerical and some
 few special characters
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>
References: <20231114130415.283228-1-thuth@redhat.com>
 <CAFEAcA_LcmowH28KG9LXRQRPFkAbmDCoPz5RDDK0TG+Am-p73w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_LcmowH28KG9LXRQRPFkAbmDCoPz5RDDK0TG+Am-p73w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 14/11/2023 14.21, Peter Maydell wrote:
> On Tue, 14 Nov 2023 at 13:05, Thomas Huth <thuth@redhat.com> wrote:
>>
>> QOM names currently don't have any enforced naming rules. This
>> can be problematic, e.g. when they are used on the command line
>> for the "-device" option (where the comma is used to separate
>> properties). To avoid that such problematic type names come in
>> again, let's restrict the set of acceptable characters during the
>> type registration.
>>
>> Ideally, we'd apply here the same rules as for QAPI, i.e. all type
>> names should begin with a letter, and contain only ASCII letters,
>> digits, hyphen, and underscore. However, we already have so many
>> pre-existing types like:
>>
>>      486-x86_64-cpu
>>      cfi.pflash01
>>      power5+_v2.1-spapr-cpu-core
>>      virt-2.6-machine::hotplug-handler
>>      aspeed.i2c.slave::vmstate-if
>>      pc-i440fx-3.0-machine::nmi
> 
> I think all these '::' are specifically interface types --
> see type_initialize_interface(), which constructs the
> interface type name by gluing together the class name and
> the interface name with a '::'. The rule we ought to be
> requiring for ':' I think is "no : in the type name, unless
> it is the one generated by type_initialize_interface()".
> 
> I think we could do that by having the type_name_is_valid()
> checks done in:
>   * type_initialize_interface(), on ti->name and interface_type->name
>   * type_register_internal(), on info->name
> 
> If we do that, can we take ':' out of the list of characters
> we permit in type_name_is_valid() ?

Thanks, that's a very good idea! Actually, after looking at the code for a 
while, I think it should even be enough to add a check to 
type_register_internal(), since type_initialize_interface() is rather used 
with base types and interface types that should have been registered already 
via type_register...() before.

There just seem to be two stragglers left:

1) #define TYPE_DUMMY "qemu:dummy" in tests/unit/test-io-task.c ...
    easy to fix, it's just a unit test anyway

2) #define TYPE_RAM_DISCARD_MANAGER "qemu:ram-discard-manager"
    in include/exec/memory.h ... I believe it should be OK to
    simply rename it, since it's about an interface type...
    Or do we use these interface names in migration streams, too?

I'll try to come up with some patches to rename them ... let's see how it 
goes...

  Thomas


