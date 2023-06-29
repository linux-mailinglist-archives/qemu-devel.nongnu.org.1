Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 352447424DA
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 13:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpZl-00028M-1l; Thu, 29 Jun 2023 07:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEpZh-00027i-VI
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEpZf-0005Jo-UN
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688037150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5mWGt46wjhq7WLGOkiDn17lIXV9beoQ0E4areOIRRCs=;
 b=LPmeJq3PH+tzZBzI2u6Yim4KWJJu0MCrCzCkPBXCdXa923924I6b8nTHdgL6478eA35H6f
 9Fc9a9bjcJKxcaISvozbrN6ayD8Gs1+RFX/EBE8v6dDbhN6MQkEpOKtnjg+oBImjKn8uws
 ywbx8TzDRmz5e2VphNtRmKKviA9/8W8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-_EtkZ9lUOJmcOoRyXY5G9A-1; Thu, 29 Jun 2023 07:12:29 -0400
X-MC-Unique: _EtkZ9lUOJmcOoRyXY5G9A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3141a98a29aso201287f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 04:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688037148; x=1690629148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5mWGt46wjhq7WLGOkiDn17lIXV9beoQ0E4areOIRRCs=;
 b=fZRVGgx0DJgLvcjKmyTrj26o5GvOWcVtd9MWeHzD99na1Y0t4yBTawvZuSDlr+9YXN
 Rq1ybi/MweOSg8vaZhSKJBZNcqHmU+XpUZL9dEPMhLeCkMTqSKBsM2GHquikwg1UYBoD
 A1mw1aa82FUGyy80NC6BZH3YU2OI4d2OAe20KjziDO3aBpXJ07bDBcurFVEOZ0SgZkOZ
 iGRuD7Ao6uXR6MEjWFU/EiTnDLD+HpOoDgSuv3D5pNJak5yx4sg6JxQIUhj/WZMNGNsN
 x2EPbNU37bcftmqrk4Pm5CcanyUMALFTd1nH49uvU7gFkVSa49NJ3mphTkwI+2F1/yj8
 DHRg==
X-Gm-Message-State: AC+VfDwWSB/xF3yMhrjhJWTguCJp8i/ZiTdDp95oMTkE/Vybh9F+VmBJ
 VGKsasIHm7U0SUeC4MYLHUwCScynj6YbKziYDQeLx+RSt7RClXMgQc+HA91a1fMc/boi54SyYLv
 LxMk56r3/nd6GnWGETj8rOEs=
X-Received: by 2002:a5d:4bc3:0:b0:314:99e:af46 with SMTP id
 l3-20020a5d4bc3000000b00314099eaf46mr4177717wrt.20.1688037148301; 
 Thu, 29 Jun 2023 04:12:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ77kEqP6YRPAXX0OUw3Tqvjof5oaikrp6ziSzuMuHxKpT5P8YS/lxFeokT/gT+gmddQ+k4dKA==
X-Received: by 2002:a5d:4bc3:0:b0:314:99e:af46 with SMTP id
 l3-20020a5d4bc3000000b00314099eaf46mr4177697wrt.20.1688037148026; 
 Thu, 29 Jun 2023 04:12:28 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff845000000b003141b9ddab3sm718815wrq.114.2023.06.29.04.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 04:12:27 -0700 (PDT)
Message-ID: <8bee7886-9b63-c7e9-6bc4-3ad8f6ce037a@redhat.com>
Date: Thu, 29 Jun 2023 13:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 7/7] pc-bios/s390-ccw: Don't use __bss_start with the
 "larl" instruction
Content-Language: en-US
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20230629104821.194859-1-thuth@redhat.com>
 <20230629104821.194859-8-thuth@redhat.com>
 <20230629125818.09ec8ad6@p-imbrenda>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230629125818.09ec8ad6@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29/06/2023 12.58, Claudio Imbrenda wrote:
> On Thu, 29 Jun 2023 12:48:21 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> start.S currently cannot be compiled with Clang 16 and binutils 2.40:
>>
>>   ld: start.o(.text+0x8): misaligned symbol `__bss_start' (0xc1e5) for
>>       relocation R_390_PC32DBL
>>
>> According to the built-in linker script of ld, the symbol __bss_start
>> can actually point *before* the .bss section and does not need to have
>> any alignment, so in certain situations (like when using the internal
>> assembler of Clang), the __bss_start symbol can indeed be unaligned
>> and thus it is not suitable for being used with the "larl" instruction
>> that needs an address that is at least aligned to halfwords.
>> The problem went unnoticed so far since binutils <= 2.39 did not
>> check the alignment, but starting with binutils 2.40, such unaligned
>> addresses are now refused.
>>
>> Fix it by loading the address indirectly instead.
> 
> what are the advantages of this solution compared to your previous one
> (i.e. align .bss) ?

__bss_start is supposed to point to an address that is before all bss-like 
segments. There are also segments like .sbss and .bss.plt on other 
architectures, see https://bugzilla.redhat.com/show_bug.cgi?id=2216662#c11 .
Seems like we don't have them on s390x yet, so currently my previous patch 
is fine, too. But in case there will ever be an extension to the s390x ABI 
that introduces such additional segments, we have to switch back to 
__bss_start again. So it sounds slightly more future-proof to me to keep 
__bss_start here, even if we need a slightly more complex startup code here now.

  Thomas



