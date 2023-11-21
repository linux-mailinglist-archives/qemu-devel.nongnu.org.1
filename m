Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE307F3A45
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 00:29:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5aA7-0003lT-FV; Tue, 21 Nov 2023 18:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r5aA5-0003k8-Sj
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 18:28:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r5aA4-0007iT-F9
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 18:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700609287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oY0DQVF7MZjWjEq2OlZLq7FU1SY1X79y6xy2fdoZNSk=;
 b=ZHaSQ58YbCN6GNrNRXgdDYrC2fGlbskJVAMXhHB3Zu8M6umQxGxbBeVzYxS37pi8ZaONqz
 rA7vrqtksOtbu+kzxQFFnXarjj4b/oj/lOVLkg4gBFSv7KFIlRFS+Yehdxn+rdtkrXk1LI
 35lVhHUaqgMxahYqzK/eYVEFJkHUVbc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-8mzCI0A8NgmJNjksO2Gh_A-1; Tue, 21 Nov 2023 18:28:04 -0500
X-MC-Unique: 8mzCI0A8NgmJNjksO2Gh_A-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-282dcfbcc0aso7159535a91.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 15:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700609283; x=1701214083;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oY0DQVF7MZjWjEq2OlZLq7FU1SY1X79y6xy2fdoZNSk=;
 b=gnB0KQLaaWGAB2S0wP0b2yXyiTQpEXIoNyh1GUSRG55r70NCPQXTpHpTp2q70lRSAW
 7fFXmQ0/Ot1LaTHJjDS1BpO9j9O6atnme1B3qn8Z0ualiKDbbS1Ec0+ImUJhQ33l7vzZ
 vvxoyEMFOaVmV6Y2G04/nOz+02TZOkRENpm72x+ev2JIwQbPscxXYaXvatAG+Yx+k30/
 x4g/C2YW7pKVeQvXH1GI8WnZIij2oRQhiYUsqWYF1QevPsJ2Ntlbhw2/yqWFE6Q75jvP
 o9qPQKVqJ/zaqUOCs5ODI3TmFgTYmuh7NICe6G90Cjb4c/VtzyOkw8S+L8g1VviCT6GV
 sSUQ==
X-Gm-Message-State: AOJu0Yz8IwYf5p+GDgpE8dk5FNL0DUHY8bCN2uDHQbjDq8ym1e3hetJs
 5eQs3pbFLNKNNFu3ZR3pxHxBFPvfwtxBuQIHW7hB2gyoIb3tO+O2jEarC+/yVrtbxSrG/vj8/Gt
 ERTrFceTcUemHkqA=
X-Received: by 2002:a17:90b:1e0e:b0:280:a5b8:daf1 with SMTP id
 pg14-20020a17090b1e0e00b00280a5b8daf1mr790799pjb.47.1700609283022; 
 Tue, 21 Nov 2023 15:28:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDjsUAipHxp/5Fgi3aKJ1sBwBl1xNEy2Xk2leFZX/c1aISoGpZ17EPhqvUxq8Emjt92Qjmuw==
X-Received: by 2002:a17:90b:1e0e:b0:280:a5b8:daf1 with SMTP id
 pg14-20020a17090b1e0e00b00280a5b8daf1mr790778pjb.47.1700609282719; 
 Tue, 21 Nov 2023 15:28:02 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15?
 ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a17090a788700b00283a0c3df63sm67210pjk.54.2023.11.21.15.27.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 15:28:02 -0800 (PST)
Message-ID: <948cc368-241e-41f4-b3c9-683e220dcfc2@redhat.com>
Date: Wed, 22 Nov 2023 09:27:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] hw: Add compat machines for 9.0
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <20231120094259.1191804-1-cohuck@redhat.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120094259.1191804-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/20/23 19:42, Cornelia Huck wrote:
> Add 9.0 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/arm/virt.c              |  9 ++++++++-
>   hw/core/machine.c          |  3 +++
>   hw/i386/pc.c               |  3 +++
>   hw/i386/pc_piix.c          | 17 ++++++++++++++---
>   hw/i386/pc_q35.c           | 13 ++++++++++++-
>   hw/m68k/virt.c             |  9 ++++++++-
>   hw/ppc/spapr.c             | 15 +++++++++++++--
>   hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>   include/hw/boards.h        |  3 +++
>   include/hw/i386/pc.h       |  3 +++
>   10 files changed, 80 insertions(+), 9 deletions(-)
> 

For hw/arm/virt.c

Reviewed-by: Gavin Shan <gshan@redhat.com>


