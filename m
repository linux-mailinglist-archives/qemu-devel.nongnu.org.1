Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA01766DDC
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:11:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPMZw-0004OE-0v; Fri, 28 Jul 2023 08:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1qPMZt-0004Nx-AX
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1qPMZr-0000RK-4n
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690547293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qeDxsoVMm0MIeYcGnCx9Wi3Ubyezw8i1LZEDcUgNAiQ=;
 b=i5WRCAYjRMhvl8/JItn4vhrwTP8L3RhYxVBy8AwyCZVf8IRxch1/j0Q7Dl3Evj2wtWLGpV
 g5R98ZMPkzy2qF8XC1VI9+r4rwDu0pR9hd0Ur02E8eoq1wnMOu+7KJqTRC9pXJ4TAeR1eJ
 882CYDjXT68cS4IhuGPV7r9vl2uCILg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-aLrrCUOePl-k3YK5rmDZxQ-1; Fri, 28 Jul 2023 08:28:12 -0400
X-MC-Unique: aLrrCUOePl-k3YK5rmDZxQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63cfe46bbb6so22048306d6.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 05:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690547291; x=1691152091;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qeDxsoVMm0MIeYcGnCx9Wi3Ubyezw8i1LZEDcUgNAiQ=;
 b=j8KVerhXrJEz5xDRdP8ONgEiAAvm/AbD/bkIP8V/ULk416HLOdry/DDoCCiflaas1t
 zsULb0S9FrWwyO/mVKXG9QzL2X3BaCZFRMDpET+QvPOui085UxEtD/UPENLE/wO3TQXE
 JlVLl3sHWpbqmOXgyfip7GkamVD49YvrYOqelI3QqbWdzTc3Llk31tdzuyOXBgxVnK9E
 P87jrd59emVud03j65hYxj786x+jTGWjpKmutzSpNinggzQnQdVBTbNX5bmhuEVaCSTK
 R1OFHboR3MOerNKdi6JD3qwDoUm589HKHDx0skmy0Du4uzD8/3c60wHsbeKknAOP1Dub
 U/ow==
X-Gm-Message-State: ABy/qLb/1b3bVnLJ6FU7n8yQrSVnuMw3BrumE/fL8qKaXWY79ojYT9XQ
 DrHe0ByTD/k0HUkLH/hGbx6hfen3ILU/6umaJ0tLg+RuquZCWoyARje9Twl6X8ylLXzdoxTRJq9
 SIRYzT+4iufwZwm8=
X-Received: by 2002:a0c:f3cf:0:b0:62d:f515:9320 with SMTP id
 f15-20020a0cf3cf000000b0062df5159320mr2355948qvm.28.1690547291512; 
 Fri, 28 Jul 2023 05:28:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFm///4uuFv8vOfNipAsnPI2nSUkwMRDz8yQstfp/S3RmdC2oB2S5PEQnLNbY9l9urHe6Bkow==
X-Received: by 2002:a0c:f3cf:0:b0:62d:f515:9320 with SMTP id
 f15-20020a0cf3cf000000b0062df5159320mr2355938qvm.28.1690547291278; 
 Fri, 28 Jul 2023 05:28:11 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a0cf207000000b006238b37fb05sm1181197qvk.119.2023.07.28.05.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 05:28:10 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/2] i386: Fix Hyper-V Gen1 guests stuck on boot with
 'hv-passthrough'
In-Reply-To: <875y79paq6.fsf@redhat.com>
References: <20230612084201.294248-1-vkuznets@redhat.com>
 <875y79paq6.fsf@redhat.com>
Date: Fri, 28 Jul 2023 14:28:08 +0200
Message-ID: <87mszgmd9j.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>
>> Hyper-V Gen1 guests are getting stuck on boot when 'hv-passthrough' is
>> used. While 'hv-passthrough' is a debug only feature, this significantly
>> limit its usefullness. While debugging the problem, I found that there are
>> two loosely connected issues:
>> - 'hv-passthrough' enables 'hv-syndbg' and this is undesired.
>> - 'hv-syndbg's support by KVM is detected incorrectly when !CONFIG_SYNDBG.
>>
>> Fix both issues; exclude 'hv-syndbg' from 'hv-passthrough' and don't allow
>> to turn on 'hv-syndbg' for !CONFIG_SYNDBG builds. 
>>
>> Vitaly Kuznetsov (2):
>>   i386: Fix conditional CONFIG_SYNDBG enablement
>>   i386: Exclude 'hv-syndbg' from 'hv-passthrough'
>>
>>  docs/system/i386/hyperv.rst | 13 +++++++++----
>>  target/i386/cpu.c           |  2 ++
>>  target/i386/kvm/kvm.c       | 18 ++++++++++++------
>>  3 files changed, 23 insertions(+), 10 deletions(-)

Monthly ping)

-- 
Vitaly


