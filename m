Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 777927470AB
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:17:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGexR-00086H-Pn; Tue, 04 Jul 2023 08:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGexH-00081D-3k
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGexD-0005lm-Gc
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688472982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIXfzZjsdVt8vvfchF5Qn1Sl+Sb+f/LHZzCge3DWDPE=;
 b=Lo67/PcaOexquWfs0Z3M5QzgFSD5FwCeHqhQWwH+kApHH/Xrd451Uckb/5Dr6/A5rPyEgS
 Y/ZIiKGBxc0gkTvYpWLpevccyRgDQc7jG1bXwbYgIkVMRiYad0V8vG4AN3zVTo8mwSQt4b
 g85X+yCOV1i0vU09ccMyISysI3rKsL0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-YBFNSoowPVuphX-iFjCZMg-1; Tue, 04 Jul 2023 08:16:21 -0400
X-MC-Unique: YBFNSoowPVuphX-iFjCZMg-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-39ec7630322so4781789b6e.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688472980; x=1691064980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YIXfzZjsdVt8vvfchF5Qn1Sl+Sb+f/LHZzCge3DWDPE=;
 b=exjdVjM1yhTU8OyZ3VHTsmd30kAbrilsus/EnuSA4mmMbu5mtiS79XNA3VzTrDZR79
 DSIP04hD5vf5fFDsqopv9je/fB7YVa/h0XcjcjkdPJuRz5P+P3Cgl1DV7oYmeWMTlhbr
 GV9QVtnE0eQv8WKL0E+Cg0F/+5RhvLuH/I64AJZ7whJspXY39iAHXYyE6pofrkLyqNGk
 VkgueGKuSVJxvsSOc0U8ZOfC6YtSMj7bsPzBoBqtAY4w6ebfwaP3JH6jdDU1EpQ1Fp2U
 mz0wH8ovOgkk1o80h9Lh0/5lDj35ifdjgR/9Q2pE9vdAgnZm10xK2kYJd/cWtMpGiBPa
 9oCA==
X-Gm-Message-State: AC+VfDyl0sEqtrsZL05xOvegiOxNTSZB2FIvCSHcokMaS1ih0mPwgI6+
 a28lQpBOtznwiu+Hy6AtK2x8F/Hui2e7HnGtFSjE8rt0Pvmo2bsFDzqNM1dl6ifNjB+B6R7ACgQ
 NjPes7IIbyT6gVLY=
X-Received: by 2002:a05:6808:2a83:b0:3a3:6576:f31b with SMTP id
 fc3-20020a0568082a8300b003a36576f31bmr9794653oib.36.1688472980383; 
 Tue, 04 Jul 2023 05:16:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ62AHFVi349eOottfwQKI1ADJu/ofloNDCL3+OXJkcHbdoOoYm5j7T6tdVHgGJsNtprjihKwQ==
X-Received: by 2002:a05:6808:2a83:b0:3a3:6576:f31b with SMTP id
 fc3-20020a0568082a8300b003a36576f31bmr9794623oib.36.1688472980098; 
 Tue, 04 Jul 2023 05:16:20 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-126.web.vodafone.de.
 [109.43.179.126]) by smtp.gmail.com with ESMTPSA id
 g10-20020ad4510a000000b0063623c266easm6309903qvp.3.2023.07.04.05.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 05:16:19 -0700 (PDT)
Message-ID: <ab53c709-964b-452e-9cb2-c4c8d67d318f@redhat.com>
Date: Tue, 4 Jul 2023 14:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v21 06/20] s390x/cpu topology: interception of PTF
 instruction
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-7-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230630091752.67190-7-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 30/06/2023 11.17, Pierre Morel wrote:
> When the host supports the CPU topology facility, the PTF
> instruction with function code 2 is interpreted by the SIE,
> provided that the userland hypervisor activates the interpretation
> by using the KVM_CAP_S390_CPU_TOPOLOGY KVM extension.
> 
> The PTF instructions with function code 0 and 1 are intercepted
> and must be emulated by the userland hypervisor.
> 
> During RESET all CPU of the configuration are placed in
> horizontal polarity.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   include/hw/s390x/s390-virtio-ccw.h |  6 ++++
>   hw/s390x/cpu-topology.c            | 54 ++++++++++++++++++++++++++++++
>   target/s390x/kvm/kvm.c             | 11 ++++++
>   3 files changed, 71 insertions(+)


Reviewed-by: Thomas Huth <thuth@redhat.com>


