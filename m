Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6E571625A
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:43:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zcD-00019V-CG; Tue, 30 May 2023 09:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3zcB-00015N-0P
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3zc9-0006x2-Bp
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685454136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R17kEjgqNC9yF2Mh/TsFoco8zWxed7P97v3obK20UvY=;
 b=VD/z9mjm7akkD9rC//xc217fctIcVZmgYNHNhmn8fc2xwtSsp7ukBZmtK1FGUeq+iD13Xk
 4p7XellRTZV7QNJcMgKbMBWSKAChBc4PP8rQQUATionCTHv3m5JPPsFL0dbXrTKOmzCJp1
 hjDkOn+v9HS4jeyM36la1fcpsBtmziQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-y6nPR16XMOSwub72ot9xjA-1; Tue, 30 May 2023 09:42:10 -0400
X-MC-Unique: y6nPR16XMOSwub72ot9xjA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f6cc1997fdso16954925e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685454129; x=1688046129;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R17kEjgqNC9yF2Mh/TsFoco8zWxed7P97v3obK20UvY=;
 b=hdsUqp3JGpjM4bnH0UUh6Elm1nKyZD6qUdSog9jHTj+acB4dekQ+ZfbXIpwRDYyLBI
 e4AsAx+PqDowJEFnhCLZGgCGP20rxptn/i5/fBSyQ6q6kAZd758CrrLcpWEeAXi0aq7J
 r2ObhzJGqngZhoesW9Ae3X93LAEDtVHkN8llOe01GRlQ/qiU6BBIrWcLthuD18Opl8vd
 z3gYdX3Ua8qan1/69+MNJhzGP9KgnaEgTi/6tKfCeF0PY8JtgGJxrHCM+r9MXJ04cg9k
 PPw7x5ooiiONtDv81Shz7IoxCnTWlO3Vv27C2E/4nkB6goqSBa5xwCLf0H6cPFUnEjxr
 uhPg==
X-Gm-Message-State: AC+VfDxVU0/iwwVRN/xe8RgnEUQ1E+OrZH1aJ3YVQx4V7WAZQQHqqOc0
 z/565pumnQ6KobVBguCBWaD5DK+nqcTFud4RqY4YyZeNaLJEZ4I4CymZsJ2UsNLYi5ih44p+npH
 NBl/7x4drkMLFK2c=
X-Received: by 2002:a1c:f70b:0:b0:3f6:149:556c with SMTP id
 v11-20020a1cf70b000000b003f60149556cmr1788215wmh.0.1685454129274; 
 Tue, 30 May 2023 06:42:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6n7hRSwCrVoKYl8mm5xcncGy8zeuG/8r8Dc+iTYqr/Lpf0gAVPV3CNSRFqWPr7mDgqYsBSOw==
X-Received: by 2002:a1c:f70b:0:b0:3f6:149:556c with SMTP id
 v11-20020a1cf70b000000b003f60149556cmr1788192wmh.0.1685454128930; 
 Tue, 30 May 2023 06:42:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:d500:78e5:f448:8bef:a30?
 (p200300cbc73cd50078e5f4488bef0a30.dip0.t-ipconnect.de.
 [2003:cb:c73c:d500:78e5:f448:8bef:a30])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a05600c4e1500b003f4283f5c1bsm30202843wmq.2.2023.05.30.06.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 06:42:00 -0700 (PDT)
Message-ID: <f73dfa5c-4efe-a1ad-3ed1-a2c8e783bc27@redhat.com>
Date: Tue, 30 May 2023 15:41:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 08/10] hw/i386/pc: Remove PC_MACHINE_DEVMEM_REGION_SIZE
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230530113838.257755-1-david@redhat.com>
 <20230530113838.257755-9-david@redhat.com>
 <20230530090655-mutt-send-email-mst@kernel.org>
 <9d395d6f-4da9-45c6-bf20-ed33f1c4bca5@redhat.com>
Organization: Red Hat
In-Reply-To: <9d395d6f-4da9-45c6-bf20-ed33f1c4bca5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 30.05.23 15:11, David Hildenbrand wrote:
> On 30.05.23 15:07, Michael S. Tsirkin wrote:
>> On Tue, May 30, 2023 at 01:38:36PM +0200, David Hildenbrand wrote:
>>> There are no remaining users in the tree, so let's remove it.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Richard Henderson <richard.henderson@linaro.org>
>>> Cc: Eduardo Habkost <eduardo@habkost.net>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>>
>> This (with previous patches) means any user changing
>> device-memory-region-size machine property is now broken, right?
> 
> We only had a getter, no setter (for good reason).
> 
>> How do we know there are no users?
> 
> We don't. A quick google search makes "device-memory-region-size" and
> "qom-get" only pop up in BUG fixes for something that appears to be QEMU
> developer driven.
> 
> I don't consider it any useful, but if we want to be careful, sure we
> can leave it around.

Looking further, libvirt doesn't use it (and never used it).

I already renamed it in 2018 without anybody complaining:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg532101.html

So I'm quite confident that nobody will really miss this property.

-- 
Thanks,

David / dhildenb


