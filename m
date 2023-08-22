Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF69D78439F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 16:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYS6l-0002Jp-I6; Tue, 22 Aug 2023 10:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYS6j-0002Jh-DA
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYS6h-0005Pr-5H
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692713501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1S/FYsmo/ifS4X/1nfHCx4+ubTKvD4Ceh8NSntQm0KQ=;
 b=eN0ftwbD6v/qw2/noJIKk1xmO0R7DHbCCaqn6K6FfD4RgX2AbK49E23D5Mk4T3CMjOTJTJ
 nJvmydr8wxHJsO7IsF97yK2KD6pkF/FBTdotH/XSkFHZMbdwcaHRdX15es+ZFdwkOsjQ3O
 Yq/52DYPDdo0jebEnpXpqNzjNA+Iq6U=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-TQjFIzpMOZ2NtU7T9ieANw-1; Tue, 22 Aug 2023 10:11:40 -0400
X-MC-Unique: TQjFIzpMOZ2NtU7T9ieANw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50091545239so393052e87.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 07:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692713498; x=1693318298;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1S/FYsmo/ifS4X/1nfHCx4+ubTKvD4Ceh8NSntQm0KQ=;
 b=dfQkJ0+2TSTLCBqXHMzoMScW3pqkW7V2pel0/suEZjgz1rJTnBYpcgjNurrFx0Y86r
 qAWEVOGSNBkxDOmESG1L67GUn/Z51FcTbrXRZB22/nkhrs4pZTJGIWjRzlnoHw7FP+3H
 XZodFwribioQCrJ0rOhfSSXe/pTduszoJIcd9p4FRhURPU8qQkcAnfogeji76rPWVV6B
 hob/vvG1GEwroBcNhzozSbi8lnty4L6DzC9MWe7zMKhmx5wz0obR0BPQhXx1qha9OMqU
 vK0BCICq8vVBTIH4mknQIZfqJBwIY5BbJO9RQ/VNnKYXzAAZXs0EDpVYqA1QQJNk5P/U
 RTZQ==
X-Gm-Message-State: AOJu0YyOmU0TcZF2P1eWTef3lyhvDwGCQcf34dY0k5x6kc4bQLKtIUHk
 Wli5LU85edyggUeaatjCpXqwYR9w+6wSQr+PvlidDRSkd2tkOfeOoSecKdgJwT3Hb5Wq2IqXCfI
 OB5q+9r99hkIfWQepInLz6hs=
X-Received: by 2002:ac2:4a6e:0:b0:4fb:9e1a:e592 with SMTP id
 q14-20020ac24a6e000000b004fb9e1ae592mr5956531lfp.4.1692713498368; 
 Tue, 22 Aug 2023 07:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqwiebL3z/z0nmZMn/kqlUxwkQNOwQRA6rx1FNUYw0KID2zcxLSNeDbIFYWqcbWh//HlpPfg==
X-Received: by 2002:a5d:45c4:0:b0:31a:d90d:8d9f with SMTP id
 b4-20020a5d45c4000000b0031ad90d8d9fmr5864788wrs.25.1692713099011; 
 Tue, 22 Aug 2023 07:04:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:7400:83da:ebad:ba7f:c97c?
 (p200300cbc706740083daebadba7fc97c.dip0.t-ipconnect.de.
 [2003:cb:c706:7400:83da:ebad:ba7f:c97c])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a5d5748000000b003196e992567sm15844861wrw.115.2023.08.22.07.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 07:04:58 -0700 (PDT)
Message-ID: <9a9e66ef-11a8-6e61-581f-d06be7b86237@redhat.com>
Date: Tue, 22 Aug 2023 16:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 9/9] docs: Start documenting VM templating
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230822114504.239505-1-david@redhat.com>
 <20230822114504.239505-10-david@redhat.com> <ZOS8ZNaRrcrNNNOe@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZOS8ZNaRrcrNNNOe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22.08.23 15:47, Daniel P. Berrangé wrote:
> On Tue, Aug 22, 2023 at 01:44:57PM +0200, David Hildenbrand wrote:
>> Let's add some details about VM templating, focusing on the VM memory
>> configuration only.
>>
>> There is much more to VM templating (VM state? block devices?), but I leave
>> that as future work.
> 
> Then there's the supposedly "unique" hardware identifiers, most notably
> VM UUID & NIC MAC addr that don't change if you create many VMs from
> a "template". Or from the guest OS there are "unique" things like
> /etc/machine-id, SSH host keys, web server certificates, etc.
> 
> The vmgenid device at least provides a way for guest OS to get notified
> to update its unique resources/identifiers, but doesn't solve the overall
> VM UUID. NIC MAC addr could be solved by hotunplug+plug either side of
> creating the template & instantiating the template.
> 
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   docs/vm-templating.txt | 109 +++++++++++++++++++++++++++++++++++++++++
> 
> Can you make this doument RST from the start and link to it from
> somewhere appropriate in our documentation. Perhaps it should live
> under the docs/system/ directory ?

I blindly did what memory-hotplug.txt and nvdimm.txt do. I can make it a 
RST and move under docs/system [+ link it in the index]

> 
>>   1 file changed, 109 insertions(+)
>>   create mode 100644 docs/vm-templating.txt
>>
>> diff --git a/docs/vm-templating.txt b/docs/vm-templating.txt
>> new file mode 100644
>> index 0000000000..419362c1ea
>> --- /dev/null
>> +++ b/docs/vm-templating.txt
>> @@ -0,0 +1,109 @@
>> +QEMU VM templating
>> +==================
>> +
>> +This document explains how to use VM templating in QEMU.
>> +
>> +For now, the focus is on VM memory aspects, and not about how to save and
>> +restore other VM state (i.e., migrate-to-file with 'x-ignore-shared').
>> +
>> +Overview
>> +--------
>> +
>> +With VM templating, a single template VM serves as the starting point for
>> +new VMs. This allows for fast and efficient replication of VMs, resulting
>> +in fast startup times and reduced memory consumption.
>> +
>> +Conceptually, the VM state is frozen, to then be used as a basis for new
>> +VMs. The Copy-On-Write mechanism in the operating systems makes
>> +sure that new VMs are able to read template VM memory; however, any
>> +modifications stay private and don't modify the original template VM or any
>> +other created VM.
> 
> I feel like we should have a paragraph at the top here explicitly calling
> out the dangers of templating, wrt to unique data in the hardware and guest
> OS. Don't have to provide solutions, just more of a scarcy "here be dragons"
> warning to users who might be tempted to try this.

Agreed, I'll use some of your information above, thanks!

-- 
Cheers,

David / dhildenb


