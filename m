Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3298A7CE313
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:41:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9b5-0005wH-50; Wed, 18 Oct 2023 12:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9b1-0005uc-Uh
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9b0-0007tu-5O
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cw6Ww9qVFu18XScQbUYySkVA3mm9ap2DhaKeIlogz3Q=;
 b=bn+8uKhcpLrJEeOGMwHuLM83g1Y7mWC/W7FgepCU1tnHgNfl7h0lwu5O2yRALf2EK/XOVh
 3sGkP3r5okePI3lX0kDCY0NOcsPyMb9TT1XiFy8I1kVGxzSnQnFPUORX3QwuDnhGfRGrit
 NPkbcMDeZr+mt1nW4etQq6gwrK+2bvE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-90rzotlaMPiEglyTN-mLRg-1; Wed, 18 Oct 2023 12:40:31 -0400
X-MC-Unique: 90rzotlaMPiEglyTN-mLRg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a9e12a3093so778710066b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647230; x=1698252030;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cw6Ww9qVFu18XScQbUYySkVA3mm9ap2DhaKeIlogz3Q=;
 b=C6M5uHUFoOBidwbP1dudLchYt0Aajqh/Samo061vljFcCNpHyH7uMQVnZkVw9O4mxF
 0wW3h4CvOPXyqPDPTmgX8kNIluKrCSQ5vlu61MmNPgRPtef4+wy1cesIDa4R3zOLV8z8
 Nd7hX0qvVfdhjjl066NJnkqQoNo/S4gQg2XBigZx6GyzwgAGHd8anyLRx9+T83b2NvQi
 Sdlg49TCjccRqIy+VPaP9ZRMST9bfTN8dBPtFWQ73B2NHXL33OoTZwA6FWsgsrHUaON9
 +JO87+dBNTa6WLNSuGRhrhPu6ilZj71B4hEWePGmT+SaVoPGlqzlRDKUZM2KQA1x4Txw
 3e6Q==
X-Gm-Message-State: AOJu0Yw8dJDi8LBi12zvUAybYVJy96a4pr/ZME4u9hlbYJoVp8H1eI1J
 8Cs1GrVGnj16IU6rC4cQknE/Qn5FqrkHErtphj9QicoRvsSdCuWDI+uQpiRcHI1m9mPzXPKdxk1
 s0SjMPBIfb+rbXp8=
X-Received: by 2002:a17:907:1dd4:b0:9bd:bdfd:e17a with SMTP id
 og20-20020a1709071dd400b009bdbdfde17amr3968799ejc.6.1697647230365; 
 Wed, 18 Oct 2023 09:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOrdoM0I119qtlpEgdjME1uVnAudwnQZ3fq+Iy2xmVBV86sk48T1Dyt5NYTiPn00Y6xukkgw==
X-Received: by 2002:a17:907:1dd4:b0:9bd:bdfd:e17a with SMTP id
 og20-20020a1709071dd400b009bdbdfde17amr3968780ejc.6.1697647230048; 
 Wed, 18 Oct 2023 09:40:30 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 m8-20020a170906160800b009ae54585aebsm2030807ejd.89.2023.10.18.09.40.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 09:40:29 -0700 (PDT)
Message-ID: <244c53a4-e727-44a8-ba30-598a1e43c1a8@redhat.com>
Date: Wed, 18 Oct 2023 18:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH v0 00/12] Gunyah hypervisor support
Content-Language: en-US
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: quic_tsoni@quicinc.com, quic_pheragu@quicinc.com,
 quic_eberman@quicinc.com, quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/11/23 18:52, Srivatsa Vaddagiri wrote:
> Gunyah is an open-source Type-1 hypervisor, that is currently supported on ARM64
> architecture. Source code for it can be obtained from:
> 
> https://github.com/quic/gunyah-hypervisor.
> 
> This patch series adds support for Gunyah hypervisor via a new
> accelerator option, 'gunyah'. This patch series is based on the Linux kernel's
> Gunyah driver, which is being actively developed and not yet merged upstream
> [1].
> 
> This patch series is thus *NOT YET READY* for merge. Early version of this patch
> is being published to solicit comments from Qemu community.
> 
> This patch has been tested with the open-source version of Gunyah hypervisor.
> Instructions to build hypervisor and test this patch are provided in this
> patch series.
> 
> Limitations:
> 
> 1) SMP is not yet supported. This restriction will be removed in the next version
> of this patch series.
> 
> 2) virtio-pci is not yet supported. hw/virtio/virtio-pci.c seems to support only
> KVM and would need changes to support other hypervisors. If there is any ongoing
> work in this regard, would like to build upon it and add support for Gunyah
> hypervisor.

virtio-pci does support other hypervisors; what is not yet supported is 
cross-hypervisor support for IRQFD[1].  This is more of a QEMU issue 
than something specific to virtio-pci.  The way to fix it is to add 
wrappers for kvm_irqchip_add_irqfd_notifier_gsi and 
kvm_irqchip_remove_irqfd_notifier_gsi to AccelOpsClass, and move the 
stub implementations in accel/stubs/kvm-stub.c to the abstract 
superclass.  Then you can switch the users of these KVM functions to the 
AccelOpsClass wrapper.

By the way I've just posted a series to remove support for really really 
old kernels, and this should remove more KVM-specific code from device 
models.

Paolo

[1] a Linux eventfd (or QEMU EventNotifier) that triggers a guest 
interrupt when it becomes readable.  QEMU writes to the eventfd and the 
kernel responds by injecting the interrupt


