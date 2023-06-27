Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C1073FBF0
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7km-00040h-EV; Tue, 27 Jun 2023 08:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qE7kW-0003pe-0K
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qE7kR-0004Bz-Km
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687868682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmb9tQf2GENPIo5I6yF2q1ankDrBGnDGOISKz/f5ZMo=;
 b=bm7i78pEjPzuwRIH0Ah/ABoiTq/+nITARTngEZ0vRAkS3e1t2IWUpWXEjolp0PGOjs8kOt
 vv1NNv1HUcyP/CwoGWzyEBC2tPZ1x/D7uTex9oYXqvqisofm8vS5d0oaAeb/mNjNeQetqy
 0D1u6ZAcAjFz4Ec3LiN7+Is3jli12zc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-2fqRYB0TNqaupSFb5b4OKg-1; Tue, 27 Jun 2023 08:24:41 -0400
X-MC-Unique: 2fqRYB0TNqaupSFb5b4OKg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-987e47d2e81so355417866b.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687868680; x=1690460680;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cmb9tQf2GENPIo5I6yF2q1ankDrBGnDGOISKz/f5ZMo=;
 b=QKKYza9OVow6U7f35d+a+kgic/0StkHIXZBocYkueVjKB0Gy+rgRM25CWY4u0FxkPC
 xMrwhNW6kkogTRfFfQ/kHzjGyyoHMcogxJAifPWUL9DQS0Mdt5vbG0zymhkWPOyTZVji
 Ovn4a04KV9bhRePAwHsUbn7kUYujG45UCUxLddgNJl3eX1WDTcIzzO/EkvRzkKC5Qf97
 AgzSN8DaSBIXWiYEV1TAcuyAcEMqDdRlLLinCtoeSQxwwAFOiZUW5KUUkIWL9twWpRGE
 mda+OJGqZezAn4qAurUnu00MnR0MU6SAm0dHgbvIFrYWeiAv7CSSrq3y5z+uUKndfWN2
 jKqg==
X-Gm-Message-State: AC+VfDydQ56PN5ldT0ucj94E11JZPX3Fbl83vkdCEM5i2topparsZYv9
 nUfxjHazQgiOMExRaZdxIV5ntiNTuXN2ARoThUGMKrx45CdZGk2c9JBdhV5kJaxfsNRYD+3+B9E
 xvRJ2sbRMhFMtAmHsYilzcrw6gY/xxx7lLoIHhsjCLUG57P4UTBl015khIPHl72VV1UtZOeQ=
X-Received: by 2002:a17:907:3e27:b0:978:ab4a:2154 with SMTP id
 hp39-20020a1709073e2700b00978ab4a2154mr34061310ejc.1.1687868680026; 
 Tue, 27 Jun 2023 05:24:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ68+3KOTgI/5T1/1IURXg4nD0MmY75NBJ6prO/rD57+jMw9qQpuPwocc5p9WHj8GvtFthDdVA==
X-Received: by 2002:a17:907:3e27:b0:978:ab4a:2154 with SMTP id
 hp39-20020a1709073e2700b00978ab4a2154mr34061273ejc.1.1687868679668; 
 Tue, 27 Jun 2023 05:24:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:4900:68b3:e93b:e07a:558b?
 (p200300cbc737490068b3e93be07a558b.dip0.t-ipconnect.de.
 [2003:cb:c737:4900:68b3:e93b:e07a:558b])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a17090634ce00b0098238141deasm4514931ejb.90.2023.06.27.05.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 05:24:39 -0700 (PDT)
Message-ID: <c0f3d43a-cd56-d4c8-dbae-42b1176fada4@redhat.com>
Date: Tue, 27 Jun 2023 14:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 00/10] memory-device: Some cleanups
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230623124553.400585-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230623124553.400585-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.103, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 23.06.23 14:45, David Hildenbrand wrote:
> Essentially a resend with ACKs/RBs. If I don't get any more comments
> I'll queue this to my mem-next tree next week.

Queued to

https://github.com/davidhildenbrand/qemu.git mem-next

Will probably send a PR later this week.

-- 
Cheers,

David / dhildenb


