Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18752716135
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:12:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3z8u-0003iZ-JD; Tue, 30 May 2023 09:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3z8q-0003i7-8r
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3z8o-00049e-O5
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685452318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=on7RpFhJz1BSF98u2+EhG3SopGxsq+FLnRLwSYTszMg=;
 b=HN1CpU2OKxV+olpvRatmaSMGW6qh0XAglDEOYuTweQF5S60HfIltCJLq7Vo5Kn7klyT7CY
 9k8kkDyzDg8XlK443tmykNckZgX/SrdKtwmKYHyTVBsG37990nNTTHAk1hmjsqTwxCI+nm
 74rqy+o7jqn3ak/wuy3Ru16bTSarW9o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-BHyO_U3pNwaCk-oIUeDXRA-1; Tue, 30 May 2023 09:11:54 -0400
X-MC-Unique: BHyO_U3pNwaCk-oIUeDXRA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f6ffc456e7so10013315e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452313; x=1688044313;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=on7RpFhJz1BSF98u2+EhG3SopGxsq+FLnRLwSYTszMg=;
 b=f036oipgAHR6suWhsNSot5zqBjjW3cvJwaCTtjoEnbCdqtguCfnGQmYcj1CdePMCYm
 WrEwITG8twgwi2e+4BBrfwQ0vgwFzB5XQu0Joir53o3g3l7onln/I7N/8258uzKVXWkx
 S7W1b5t428b02p/vQyAJ5jGaCIpLjNS2DV3eTAfAy3Z6nTuWNz9mpGiNqtj77mdbZKlN
 sjLE+crYI9ha5t27t9+q1b5Wwu2nhLWQFOmQm/BUtxa9am4rjU2jHfRtQSDiJiAFAcqz
 bqED9DWenn02sn0lmP6oPKXJKQsyAAFbLBNYbnv5AFaNV6vev2NgZTT0XeJa1eA5W74T
 0gug==
X-Gm-Message-State: AC+VfDz7E3xYKOfoL+XT9oRv4gH9uU+ha9AvaCgjJmHkIie2jtVEWjhg
 NzMjcWqHfHwyayn/8Ube7ATkmRD4qsUXuOFkH99y7pzUueChW/pUe+WbtTu8nLMjWOFGn6I1Ver
 iJx9QYIUlclCpgBo=
X-Received: by 2002:a7b:c044:0:b0:3f6:42ce:a384 with SMTP id
 u4-20020a7bc044000000b003f642cea384mr1420742wmc.11.1685452313724; 
 Tue, 30 May 2023 06:11:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5o2kE1rLA1DrTpVeBVRuts/i2O6s/XIrOa9r20OdggtvGudkJIwj0Mv+zKbXx+zUWgs7uwXQ==
X-Received: by 2002:a7b:c044:0:b0:3f6:42ce:a384 with SMTP id
 u4-20020a7bc044000000b003f642cea384mr1420724wmc.11.1685452313422; 
 Tue, 30 May 2023 06:11:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:d500:78e5:f448:8bef:a30?
 (p200300cbc73cd50078e5f4488bef0a30.dip0.t-ipconnect.de.
 [2003:cb:c73c:d500:78e5:f448:8bef:a30])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bc8ca000000b003f42ceb3bf4sm17229324wml.32.2023.05.30.06.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 06:11:53 -0700 (PDT)
Message-ID: <9d395d6f-4da9-45c6-bf20-ed33f1c4bca5@redhat.com>
Date: Tue, 30 May 2023 15:11:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 08/10] hw/i386/pc: Remove PC_MACHINE_DEVMEM_REGION_SIZE
Content-Language: en-US
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
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230530090655-mutt-send-email-mst@kernel.org>
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

On 30.05.23 15:07, Michael S. Tsirkin wrote:
> On Tue, May 30, 2023 at 01:38:36PM +0200, David Hildenbrand wrote:
>> There are no remaining users in the tree, so let's remove it.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Eduardo Habkost <eduardo@habkost.net>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> 
> This (with previous patches) means any user changing
> device-memory-region-size machine property is now broken, right?

We only had a getter, no setter (for good reason).

> How do we know there are no users?

We don't. A quick google search makes "device-memory-region-size" and 
"qom-get" only pop up in BUG fixes for something that appears to be QEMU 
developer driven.

I don't consider it any useful, but if we want to be careful, sure we 
can leave it around.

-- 
Thanks,

David / dhildenb


