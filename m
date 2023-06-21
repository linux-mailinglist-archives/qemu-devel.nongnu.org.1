Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4EC738BA3
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:39:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0rg-00036T-0I; Wed, 21 Jun 2023 12:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qC0rd-00035N-Tv
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qC0rc-0002Cu-Bk
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687365563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVdFXpPjlqJPMZZKnR2LLT9rdM+KJEhF4WJQ7uIo7nU=;
 b=QUt4h8AiWF2RVdYXIH6cN6AF8ivwSJz3rgkvwt4Nu+3ndMSocVybLD96ynwX78ED7fKdUc
 wWwpED1J0G8Qog5dzNV+iR/2qT75oP3qrPB26mvWVGQvCX81+20+iPXXIz1I2F4pI1yIN0
 D4exGhwaYiOMidbGohMlNFDDUbOdvJU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-sgjv18GEOY6-ph6LJhmcsQ-1; Wed, 21 Jun 2023 12:39:22 -0400
X-MC-Unique: sgjv18GEOY6-ph6LJhmcsQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f9b19cb170so18541105e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 09:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687365561; x=1689957561;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KVdFXpPjlqJPMZZKnR2LLT9rdM+KJEhF4WJQ7uIo7nU=;
 b=mCm9R8OzTR6Mm8XLKiQDng9QBYADw+nyjtPxaFXiM/dlk6AtYub9FMCse54RmpI0as
 le90ku8lGCuhzdKF+V3ODf8tHff/Wy+Z2He1uD0rNyi4LdhtjShfdveMQMhIFhh5HtTV
 at38pqKs7aIGNVyxNG52ccQkcfzBQYqvnYiHPDlW9SJvjtSmy8kYZTuOLRvTJTmfayEK
 vOaKKuXKPDOK481XYWU0zmZbAqzl79wOqrFcR41Gt1sXkHJ7GAdk/1pciLzN1Cyc64nk
 PxUgOOCklnrvrQ8R6mJqIJzkurug6vnVJgnr4pwYJFx77x1VfpF4xoP4goKPs1lj+Y4Z
 /Rgg==
X-Gm-Message-State: AC+VfDx0OlzgaLDaVJ13RuQx2QZKHCStpTkhPpXUzeXRIf2F8x7fsCEP
 cnjmM2qbx6j871ox6cz/lXz+pf7VyRlQACAN9KtDigIyAQIU0Bf8uCLXtvzlJSAesK+NUjsFhfN
 IEQEcjRMVvScq6B4=
X-Received: by 2002:a7b:ca54:0:b0:3f9:b552:411a with SMTP id
 m20-20020a7bca54000000b003f9b552411amr5427633wml.37.1687365560788; 
 Wed, 21 Jun 2023 09:39:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4GSgto16JJNYZ2WJ0ZyfCBtJqHKd0lHiSEosjndJQ2v2PTuWkp4Ke7AdNvEObPczZZk7pGDA==
X-Received: by 2002:a7b:ca54:0:b0:3f9:b552:411a with SMTP id
 m20-20020a7bca54000000b003f9b552411amr5427608wml.37.1687365560432; 
 Wed, 21 Jun 2023 09:39:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:9c00:7978:3030:9d9a:1aef?
 (p200300cbc70b9c00797830309d9a1aef.dip0.t-ipconnect.de.
 [2003:cb:c70b:9c00:7978:3030:9d9a:1aef])
 by smtp.gmail.com with ESMTPSA id
 i15-20020a5d558f000000b0030647d1f34bsm5017228wrv.1.2023.06.21.09.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 09:39:19 -0700 (PDT)
Message-ID: <b13cbcd2-9963-e904-9870-15e911a9fe6e@redhat.com>
Date: Wed, 21 Jun 2023 18:39:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/1] Q35 Support
Content-Language: en-US
To: Joel Upham <jupham125@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Durrant <paul@xen.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 qemu-devel@nongnu.org
References: <cover.1687127946.git.jupham125@gmail.com>
 <272947b9494f00bb4ad3e27c050e99f8b61905b3.1687127946.git.jupham125@gmail.com>
 <02b6a8a8-2da7-2864-0c0e-5ed81a560355@redhat.com>
 <CADPhr0kMXxj1SUQggcNQeXY4wSbLNN1-Amqxo3uGVeBMSJmn-g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CADPhr0kMXxj1SUQggcNQeXY4wSbLNN1-Amqxo3uGVeBMSJmn-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

On 21.06.23 18:35, Joel Upham wrote:
> Sorry, this was sent in error when I did the git send-email for the 
> folder. This was before I broke each patch down (after looking at the 
> Qemu submission guidance). This is my first time sending a patch in this 
> way, so thanks for the understanding. This patch can be ignored, as they 
> are all covered elsewhere.

We've all been there (messing with git send-email), no need to feel bad :)

-- 
Cheers,

David / dhildenb


