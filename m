Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C77F77CABBD
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 16:39:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsOjk-0004CI-Ls; Mon, 16 Oct 2023 10:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsOjg-0004Bs-LJ
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:38:24 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsOjb-0000qv-0k
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:38:24 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so248695566b.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697467097; x=1698071897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NSLqr6SjIOcO45ea+pK9oSCGiEaOT8FVHOYHorSTAZQ=;
 b=nbEVMZESpsd7HGPXSMOOG7giU03EDtW4wBIz9JbNOuXS+MfsMU+UOwnQZdb8g4Olun
 BRpFA4bBQfjn+9qaLCVqeLgf2u4iMMFIv/cJWm8IfMJ92lVCL43EHoEMYT7Q5M+v7aql
 FoBFm77SehiaTRUEvxtE+3pK+EJ8VafS/nPGmVWbWsccfCmH2TBtBiVdG/7AMjrlHELX
 eHmSlzqiQd2v5nh662whgeTBa0LtccIJaMbiLLi9rWfRDTjwK/0IxdZpYVx4AS5k4k33
 xVKbCBSx85IUY6rkb5y6XM4uimsNqXqjdiSE//gzRb3SNDZ87/6TpVL1xWusQdp62MkU
 5H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697467097; x=1698071897;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NSLqr6SjIOcO45ea+pK9oSCGiEaOT8FVHOYHorSTAZQ=;
 b=TDFKCrr8jk8jxL3F5v91qr1Jo6Eo6zUs0vW1Ov0YH9Km3TQblTNjc8GR2wUUsCXlHo
 687YV3i9HgTL66jI8VLmwG6EQ6irUqvbdXJKm9RIPEiEE+E7lcVdl0KbI2uXgG2gmOP7
 gN0Q9ZORT+nQba7Q45bbmrpz5+IVwTnkgbrgDAJ4fIk3aXAmxipAvoX+cNYyN2TmHYy4
 D/ry54kc1yc07K7WOBFqeHyEqJbMVMgEP5AR8H06QI8vFlKcXjHbZ4S9ruGpd2mUfTOz
 9APTbVqFKu+OTrULx0Z+jBUo8IA0puky+afz/lFXrcEIk30YqUDS7tpr23GWi1iz0uBQ
 yOLg==
X-Gm-Message-State: AOJu0YxmElfUvFwEobBMry8BXNJpo1N8mbBXuOJs11yBdgqoRUHMUSBT
 mtE1Pw/knzagiVUve+srLX6NXA==
X-Google-Smtp-Source: AGHT+IETNUccMjtbY0LEe9sKYEyDv1xFBybk1MkXCA/BvDg0vjbrBILjGaWBd2eKONyyhKYQfWP/NA==
X-Received: by 2002:a17:906:4b12:b0:9c5:7f5d:42dc with SMTP id
 y18-20020a1709064b1200b009c57f5d42dcmr290430eju.33.1697467096760; 
 Mon, 16 Oct 2023 07:38:16 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-186.dsl.sta.abo.bbox.fr. [176.171.211.186])
 by smtp.gmail.com with ESMTPSA id
 gw11-20020a170906f14b00b0098669cc16b2sm4112909ejb.83.2023.10.16.07.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 07:38:14 -0700 (PDT)
Message-ID: <637d33e5-9165-6213-6d53-8a6fa07a2e38@linaro.org>
Date: Mon, 16 Oct 2023 16:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/5] hw/intc/apic: Pass CPU using QOM link property
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20231003082728.83496-1-philmd@linaro.org>
 <20231003082728.83496-6-philmd@linaro.org>
 <3a901d18-a07c-cc6c-f9ce-b500d07556cb@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <3a901d18-a07c-cc6c-f9ce-b500d07556cb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

Hi Paolo,

On 6/10/23 01:04, Paolo Bonzini wrote:
> On 10/3/23 10:27, Philippe Mathieu-Daudé wrote:
>> -    /* TODO: convert to link<> */
>> -    apic = APIC_COMMON(cpu->apic_state);
>> -    apic->cpu = cpu;
>> -    apic->apicbase = APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE;
>> +    qdev_prop_set_uint32(cpu->apic_state, "base-addr",
>> +                         APIC_DEFAULT_ADDRESS | MSR_IA32_APIC
> 
> For this to use a link, it's missing the corresponding 
> object_unref(apic->cpu) + apic->cpu = NULL assignment somewhere.  For 
> example you can add it in apic_common_unrealize (called by 
> device_unparent - which is called in turn by x86_cpu_unrealizefn).

I am a bit confused.

DEFINE_PROP_LINK() sets OBJ_PROP_LINK_STRONG:

  * If the link property was created with
  * %OBJ_PROP_LINK_STRONG bit, the old target object is
  * unreferenced, and a reference is added to the new target object.

Is this what you are pointing at? If so, I agree this should be
unref in apic_common_unrealize().

