Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE72473B10C
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 09:06:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCaqs-0000ND-Ki; Fri, 23 Jun 2023 03:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCaqk-0000Jg-Qa
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 03:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCaqh-0004xC-Fj
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 03:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687503890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cT4MyoMDtwoUaZudbQdRXjpQgVGQFbmpGqTjbUxnO+k=;
 b=OpA+JPgvJTNM0nvhWBT8Z3i41Y2KKg/hnKFXslkBcKfVQXLLqlsU38UZbS+Xrmb74tp7m8
 BzUakFlQ5qmKxCzNsBaWezDSQs6RuBzLbLisLvywFgps5ScDA52MHUu1UUpFg3t4oS5B9o
 a8nH5bffe5PNnmZOfDBfHLEqsppy2VU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-RkbKqFzINpi-8xzc3CcB4g-1; Fri, 23 Jun 2023 03:04:41 -0400
X-MC-Unique: RkbKqFzINpi-8xzc3CcB4g-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4ec817fb123so177903e87.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 00:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687503879; x=1690095879;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cT4MyoMDtwoUaZudbQdRXjpQgVGQFbmpGqTjbUxnO+k=;
 b=l4qb11nG0piUvaapr5WBTrBW7ASgID7dLxG9JnRDKbp95ODi8jMzH8e3yRFpOBAFnT
 1EZ8e3xera6ZTm8CuaeJHM/RwlBYuW4n9z7JyXvXySo1GDg9IVQoqsegwqjeFSSpkFeX
 +p5tUDmRTO2bym9fmIOOIy7VY3iRSJSL92t/uNAFRCcHbaJQehX+G0GTd8kJKrzHk+Ph
 khVRUijZT3uNets37an04Wyu0qVkNyGe5Yf3yeN6FcJxMqcWTO9WuRgD02NzkCQTmRNB
 zo9/D94I2bcR1Vd5Ja/7wgWEdij8JHNr2KcgFIpwjGcEiq6oI+P2K8eHhi16xicukOmS
 xEyg==
X-Gm-Message-State: AC+VfDxN+xTYJ4+5L1McHFoF3gJZd8L7OFTcb0pBldbTlbd8Wc3gPKfX
 lUTNdBA+zBihgJiBRQ6d7F7vrfrHX9YA4SneLf4s4b4x7uKIeTdl2N9p5xfHUdfauzRe8OidL4S
 tylVPhDJ/MYaPNpc=
X-Received: by 2002:a19:ca4e:0:b0:4f8:8be4:8a82 with SMTP id
 h14-20020a19ca4e000000b004f88be48a82mr6531516lfj.22.1687503879580; 
 Fri, 23 Jun 2023 00:04:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4kAFZGSA4pN3OUo37z//n4EV45/dZys8nTilCwi7QzEfrMgNqPqnSQEPiRyK+Z/yVD8krGgg==
X-Received: by 2002:a19:ca4e:0:b0:4f8:8be4:8a82 with SMTP id
 h14-20020a19ca4e000000b004f88be48a82mr6531502lfj.22.1687503879201; 
 Fri, 23 Jun 2023 00:04:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c729:1700:9783:58ba:9db:1221?
 (p200300cbc7291700978358ba09db1221.dip0.t-ipconnect.de.
 [2003:cb:c729:1700:9783:58ba:9db:1221])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a05600c221400b003f8f8fc3c32sm1426036wml.31.2023.06.23.00.04.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 00:04:38 -0700 (PDT)
Message-ID: <81e0644d-96fa-8d1e-17b5-03f548729c93@redhat.com>
Date: Fri, 23 Jun 2023 09:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/5] virtio-mem: Device unplug support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>
References: <20230613150210.449406-1-david@redhat.com>
 <20230623015740-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230623015740-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23.06.23 07:58, Michael S. Tsirkin wrote:
> On Tue, Jun 13, 2023 at 05:02:05PM +0200, David Hildenbrand wrote:
>> One limitation of virtio-mem is that we cannot currently unplug virtio-mem
>> devices that have all memory unplugged from the VM.
>>
>> Let's properly handle forced unplug (as can be triggered by the VM) and
>> add support for ordinary unplug (requests) of virtio-mem devices that are
>> in a compatible state (no legacy mode, no plugged memory, no plug request).
>>
>> Briefly tested on both, x86_64 and aarch64.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Eduardo Habkost <eduardo@habkost.net>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: qemu-arm@nongnu.org
>> Cc: Gavin Shan <gshan@redhat.com>
> 
> Lots of duplication pc/arm. Which is not new but do we have to keep
> growing this?  Can't we put at least the new common code somewhere?

There are some minor differences in the code, but I guess we could 
factor the (un)plug handlers out.

hw/virtio/virtio-md.c
include/hw/virtio/virtio-md.c

?

-- 
Cheers,

David / dhildenb


