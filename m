Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B57A92D6
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:52:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFPU-0002A0-R0; Thu, 21 Sep 2023 04:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFPT-00029q-0k
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFPQ-0004UQ-Gi
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695286299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zqxjd7vzkCUrJrBDjFOpFx4UYTiSrfDdK9nV5ZYkB0s=;
 b=TVXh8tgSzlfmxUeFppjzs509Qj4EWGI59rEfkBKEqLT1GRQqAiOZ0Vufb7cEMmw7yzPiYg
 a2NNfTOFbILbfjjn43VRLSJI0ooMDoWs7E1KZI8L8csvYAoxEt+0Gyzq5fmIlVJ/zf0EAp
 BDqebl1ofQsYAi1/CnMZkKOpkWlUUTA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-pbweV82vNIGPx8mTdvCJ7Q-1; Thu, 21 Sep 2023 04:51:38 -0400
X-MC-Unique: pbweV82vNIGPx8mTdvCJ7Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-503343a850aso933147e87.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 01:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695286297; x=1695891097;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zqxjd7vzkCUrJrBDjFOpFx4UYTiSrfDdK9nV5ZYkB0s=;
 b=TC9EEGS+Pam5oXQG27NOMosNk2QKEkcmxBDTum6/oD11gRj7s1iBuh0ayCLVHb//u8
 NhJvNMtm3+GEMzJY2dgg4UYjqTj5Mrbu+fDYo/UMmfc8iX1US+PP3MgnqKatZgH3N3JK
 irp70p94TWY4vg2bgN5g1XHmRn4cQ/02668DfDQDZxAM0vgQnWGmIzbwR86vGomqUdDC
 x6oNQcIJTJVatEkw5Jwwvc3/GFjXxEIt/NkvGdq0pnJ3lAq2fKTONqK49eOYrtyxaOtL
 Vzce3FnFOZxKXCah9LN+CUIDnfutqf8x+NPYVz0EPE2GHzzqRA3t3jmv6a803BjG2Ntd
 Ap/w==
X-Gm-Message-State: AOJu0YwYx9TbmRxfitkwwESFSOlIexGj/YSFI3HVKQlFtf72a1KeQIig
 fTowun/kCY/yHo1xzrH1ytqKfvUW+c+QFpQ+17XILeZxpkVaWdhZZ1u1oX0QPQCgCBPzGOH8Hye
 G6wzO15rvCf2tReY=
X-Received: by 2002:a05:6512:3d1f:b0:501:c406:c296 with SMTP id
 d31-20020a0565123d1f00b00501c406c296mr5503267lfv.31.1695286297150; 
 Thu, 21 Sep 2023 01:51:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+MmV39liaYeAhAK9D4LYF6Qc1Bqlbt7hlk2i4KRE4cT4ptZEZznYU2JOQtWzt30+nwS40dg==
X-Received: by 2002:a05:6512:3d1f:b0:501:c406:c296 with SMTP id
 d31-20020a0565123d1f00b00501c406c296mr5503251lfv.31.1695286296699; 
 Thu, 21 Sep 2023 01:51:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:3c00:9eab:fce5:e6f3:e626?
 (p200300cbc70d3c009eabfce5e6f3e626.dip0.t-ipconnect.de.
 [2003:cb:c70d:3c00:9eab:fce5:e6f3:e626])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a5d6189000000b003142ea7a661sm1145419wru.21.2023.09.21.01.51.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 01:51:36 -0700 (PDT)
Message-ID: <b5ebeeac-9f0f-eb57-b5e2-4c03698e5ee4@redhat.com>
Date: Thu, 21 Sep 2023 10:51:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 07/21] i386/pc: Drop pc_machine_kvm_type()
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
 <20230914035117.3285885-8-xiaoyao.li@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230914035117.3285885-8-xiaoyao.li@intel.com>
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
> pc_machine_kvm_type() was introduced by commit e21be724eaf5 ("i386/xen:
> add pc_machine_kvm_type to initialize XEN_EMULATE mode") to do Xen
> specific initialization by utilizing kvm_type method.
> 
> commit eeedfe6c6316 ("hw/xen: Simplify emulated Xen platform init")
> moves the Xen specific initialization to pc_basic_device_init().
> 
> There is no need to keep the PC specific kvm_type() implementation
> anymore.

So we'll fallback to kvm_arch_get_default_type(), which simply returns 0.

> On the other hand, later patch will implement kvm_type()
> method for all x86/i386 machines to support KVM_X86_SW_PROTECTED_VM.
> 

^ I suggest dropping that and merging that patch ahead-of-time as a 
simple cleanup.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


