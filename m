Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1C476B9B5
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 18:35:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQsJU-0007vc-R6; Tue, 01 Aug 2023 12:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qQsJN-0007Tg-40
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:33:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qQsJK-0003Yc-T9
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690907604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2LFFHMZCPpFrHj9GHUN3Fmk401Wjxwu92uWmwSv+p1U=;
 b=fEkmPkYDrOuMQZMjxGnKFYAvjs+LWG6T0Xi7I5oD72f42bOwcpK9kJajfBAMb5VooxpfrI
 c+pK4cpFnlmFxQb+RzTzJvR2CvLG2fQ85Rc3OUT7KRJgKe+uI0QGnW3dGxD9oXT6PdXkct
 +zm+KgSbaVQV6NS3QrQmTmY86u4Ms7o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-zD2m4YLeOs6aNcMYonJGSg-1; Tue, 01 Aug 2023 12:33:21 -0400
X-MC-Unique: zD2m4YLeOs6aNcMYonJGSg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbb34f7224so40172975e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 09:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690907600; x=1691512400;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2LFFHMZCPpFrHj9GHUN3Fmk401Wjxwu92uWmwSv+p1U=;
 b=b0IThrdtn0TKk5/M7G73w7d27v+vgzti4uRGnOub67z7vJ+S9vRMZbKqN1b0BUER/M
 pMWzVI/2XUvhX825j6yLx+c/mc05ukajnZ0aWXQw7LnJValQPT8AML1sB7vUGAlU8/hm
 hy4QQBw4h5Uf94jl6oTwmcMqDSJ5EHQlAX0OnaKaHrAejAWb/IRwI8jordymo8jTusSQ
 VJXUY6u0BlpUrkXyVhVbBOL1J3gpZ6Lg15j23PwC1+soLMbVyir7M8WcwIf0Jo3CyH5k
 qYbrReLyyObF/uZeV31rHk1H1u74+BDH9T3ww0rokZewhoxBgqPsqTC8CaZaHnvWrbfr
 vLpA==
X-Gm-Message-State: ABy/qLbWy1aIZnis+3SodNc5nGkq1srptskyDRor65cZEBat0vGPK3bz
 W6lm9Qcw8prmOZwk9mSzFCjXtO0RicXMJWdSlB9XLmO35nmv9T9HsgL0TzhCzgFWtK2fxqpHSd/
 57c9LW3V+0qb8zFI=
X-Received: by 2002:a7b:ce07:0:b0:3fb:d1db:545b with SMTP id
 m7-20020a7bce07000000b003fbd1db545bmr2900130wmc.20.1690907600552; 
 Tue, 01 Aug 2023 09:33:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHSbUqrv1Zne7pCMT8HI7XTC9rr5ni1gbnrW3jfHSN9SjJ2jRf6Ff96/2UP1i0YrsVgDMUo4g==
X-Received: by 2002:a7b:ce07:0:b0:3fb:d1db:545b with SMTP id
 m7-20020a7bce07000000b003fbd1db545bmr2900100wmc.20.1690907600047; 
 Tue, 01 Aug 2023 09:33:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:d100:871b:ec55:67d:5247?
 (p200300cbc705d100871bec55067d5247.dip0.t-ipconnect.de.
 [2003:cb:c705:d100:871b:ec55:67d:5247])
 by smtp.gmail.com with ESMTPSA id
 cs5-20020a056000088500b0031435731dfasm16773081wrb.35.2023.08.01.09.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 09:33:19 -0700 (PDT)
Message-ID: <65e55994-620d-f3c7-2f1f-dd69dd915ff5@redhat.com>
Date: Tue, 1 Aug 2023 18:33:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Igor Mammedov
 <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-4-xiaoyao.li@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 03/19] RAMBlock: Support KVM gmemory
In-Reply-To: <20230731162201.271114-4-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 31.07.23 18:21, Xiaoyao Li wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Add KVM gmem support to RAMBlock so we can have both normal
> hva based memory and gmem fd based memory in one RAMBlock.
> 
> The gmem part is represented by the gmem_fd.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

So, *someone* creates a RAMBlock in QEMU.

Who'll squeeze a gmem_fd in there? When? How?

Shouldn't we create the RAM memory region / RAMBlock already with the 
gmem_fd, and set that when initializing these things?

-- 
Cheers,

David / dhildenb


