Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5387A92C9
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:46:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFKP-00083g-E7; Thu, 21 Sep 2023 04:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFKC-00083K-Pl
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFK8-0003VJ-OV
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695285971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qT83k5KL55IHPMxMrxHeCEwMFmX72whvKRfXhwzkqs4=;
 b=FsT306/mGukOtiTgnmRYobk/yZAAac6DzLgGXC/XnJsh5UMvTNeof/bIImgXO+H39bw+d7
 pNvFK179IMbDiIAQtSpX6bZDENdnCelxN/PLKYMZP0/gN4nZJ4C+vzlNImxlMf4oj9ifhz
 upXQfTTyz+LI9Gi1euKB2k1Vf8luuRI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-79iHuX6nOemr37DEQKYINg-1; Thu, 21 Sep 2023 04:46:10 -0400
X-MC-Unique: 79iHuX6nOemr37DEQKYINg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4052d1b19f8so4795945e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 01:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695285969; x=1695890769;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qT83k5KL55IHPMxMrxHeCEwMFmX72whvKRfXhwzkqs4=;
 b=Cg0sKFdi1OSbQ/YlcEXssrlJUF9MWnOpEdSH95/QBQisU489TacgcQOF0/a7Skt5/n
 zCgyZ23OzlUFNbNDS7J01uIMz5+CcyrR9jpIdab39lRqZ1Wpt03QAdbnO/vL1mC4bh1f
 CDbR2vOA6AQUZhJ+SxZzZcYcxV3mBj5eBvdXeQp8qNR5JMR+kbkMWRB5CuKXsOATh4gF
 g217HU8f/PXw0Ky2h4jQoYxSxYCF/dW/7yv9i7VZsezJnQBl6UHsuS0mtpC3DHkcpW4A
 TEWY8Lo5RjM15ZUzdeNaNSqRtZCKsz0c1qTz7brxxHXs9oL9BULaXQd2zgNTeP2pGxLj
 zAlA==
X-Gm-Message-State: AOJu0YzW+33Sw/MzwfpekEPh64wIN1LdG6BEsuG9pteFNE2ehwepSAZU
 LiC5+oan/vAE/EbjEQJwHn1pUdhuTUl/9byZhjZQiZZtzOGt2vd7P0sYmRE6EnETshDreVqzZQl
 DaYLhcYaRAakbrpM=
X-Received: by 2002:a05:600c:290:b0:3fd:3006:410b with SMTP id
 16-20020a05600c029000b003fd3006410bmr4635434wmk.34.1695285969269; 
 Thu, 21 Sep 2023 01:46:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEKqCuAIJwnQJsQZZ8qqBZ0geuqmHsPXvhx9v7opOsIwmZxaAVauR+DFVx/KCsQqfrlHMEpA==
X-Received: by 2002:a05:600c:290:b0:3fd:3006:410b with SMTP id
 16-20020a05600c029000b003fd3006410bmr4635410wmk.34.1695285968901; 
 Thu, 21 Sep 2023 01:46:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:3c00:9eab:fce5:e6f3:e626?
 (p200300cbc70d3c009eabfce5e6f3e626.dip0.t-ipconnect.de.
 [2003:cb:c70d:3c00:9eab:fce5:e6f3:e626])
 by smtp.gmail.com with ESMTPSA id
 k1-20020adfe3c1000000b0031ff1ef7dc0sm1123795wrm.66.2023.09.21.01.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 01:46:08 -0700 (PDT)
Message-ID: <f525d4da-0878-b4bc-f9cf-7b824abfef0a@redhat.com>
Date: Thu, 21 Sep 2023 10:46:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 04/21] memory: Introduce memory_region_has_gmem_fd()
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-5-xiaoyao.li@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230914035117.3285885-5-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 14.09.23 05:51, Xiaoyao Li wrote:
> Introduce memory_region_has_gmem_fd() to query if the MemoryRegion has
> KVM gmem fd allocated.

*probably* best to just squash that into patch #2.

-- 
Cheers,

David / dhildenb


