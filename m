Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F5581454D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 11:18:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE5GZ-0000kb-R6; Fri, 15 Dec 2023 05:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1rE5GX-0000k0-Ag
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 05:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1rE5GV-00068a-KT
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 05:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702635474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=42FJiFvltYp2rdiqySuaRIVVGIjwc6Ht5anz+ABGSo8=;
 b=HCknJ1SYDuZgbw04xsPJb9DR+08q8GMa4E0MP5EvNoGkkPL5CwRH5ZRvcOGRlZQbHkSyIc
 qIRZQI/uxnKDSgGlrmSF2QD9w1oAOCf59KOlvZy+hlOV1EjtS2EY7a2SRiFLCQmWjKmE5e
 xPxD7SJafc8n40U0Ob6oC9bhTPp7VxY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-AwyRqMcJNIGB2hLtJj0bzw-1; Fri, 15 Dec 2023 05:17:53 -0500
X-MC-Unique: AwyRqMcJNIGB2hLtJj0bzw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77dca859cdeso79015585a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 02:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702635472; x=1703240272;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=42FJiFvltYp2rdiqySuaRIVVGIjwc6Ht5anz+ABGSo8=;
 b=fbZaOtE71Qh4qx0mVsdXvXWMAsczxMvox/j+uJL7/BfBJ/NZbrCL5MOzeGaqDihBqP
 05f4dGpPbxZj5MmOHRGd/2EOz3xvyBois+IxOB/V4pMuqvvFphigAX2aVRIo/x8ovA3I
 /laazk3UULOBEkfAxxSW23Di47oAxYeMdGqnAu9TMUTH7Fd6YIcufWRWwS/lKYd5EzFh
 AbGC4YJVku96kU8h5BxYCKgVHV5GwqK5QzcZtwzHDf4dmwcU7Kv9WcL+Jmm+VV3f3Yay
 FJ5/VRdknq9Omb9dgLi+Z3JcLl+QObpEA2q+bFPLAQwKQXlum4ULpVSxud8cYZIbrrQV
 V41g==
X-Gm-Message-State: AOJu0YyyllTu/DwtVxlsntUs47NQ2+0dwYARgBMg42MeV2mYfi6WrUi3
 pYSf10BfVPu5WMngPLQ6DJjFpd9OEa1SNVbIEdjitcLxq4e1yk/zCecz8l5fz8YHHCkFxTi25eH
 B5aGNaMuIAPcM428=
X-Received: by 2002:a05:620a:27cc:b0:77f:1382:e6ee with SMTP id
 i12-20020a05620a27cc00b0077f1382e6eemr13807782qkp.146.1702635472508; 
 Fri, 15 Dec 2023 02:17:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtlgZ6Vf8A9Q7i4kEqb7UmwkpjoJSFeIhKzIWQgD4mRCU4qzjQHbQ3PMKqqff5KX8/dbxwgg==
X-Received: by 2002:a05:620a:27cc:b0:77f:1382:e6ee with SMTP id
 i12-20020a05620a27cc00b0077f1382e6eemr13807769qkp.146.1702635472240; 
 Fri, 15 Dec 2023 02:17:52 -0800 (PST)
Received: from rh (p200300c93f174f005d25f1299b34cd9e.dip0.t-ipconnect.de.
 [2003:c9:3f17:4f00:5d25:f129:9b34:cd9e])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a05620a148500b0077d65ef6ca9sm5910268qkj.136.2023.12.15.02.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 02:17:52 -0800 (PST)
Date: Fri, 15 Dec 2023 11:17:47 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eauger@redhat.com>
cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org, 
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
In-Reply-To: <f1b6dffb-0a23-82d2-7699-67e12691e5c4@redhat.com>
Message-ID: <80bd3241-f3e2-f5ee-27b9-af5ad76144d4@redhat.com>
References: <20231207103648.2925112-1-shahuang@redhat.com>
 <be70b17c-21cf-4f4e-8ec1-62c18ffd4100@redhat.com>
 <f1b6dffb-0a23-82d2-7699-67e12691e5c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, 15 Dec 2023, Sebastian Ott wrote:
> On Thu, 14 Dec 2023, Eric Auger wrote:
>>  On 12/7/23 11:36, Shaoqin Huang wrote:
>>>  +    if (kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr)) {
>>>  +        warn_report("The kernel doesn't support the PMU Event
>>>  Filter!\n");
>>>  +        return;
>>>  +    }
>>>  +
>>>  +    /* The filter only needs to be initialized for 1 vcpu. */
>>  Are you sure? This is a per vcpu device ctrl. Where is it written in the
>>  doc that this shall not be called for each vcpu
>
> The interface is per vcpu but the filters are actually managed per vm
> (kvm->arch.pmu_filter). From (kernel) commit 6ee7fca2a ("KVM: arm64: Add 
> KVM_ARM_VCPU_PMU_V3_SET_PMU attribute"):
>  To ensure that KVM doesn't expose an asymmetric system to the guest, the
>  PMU set for one VCPU will be used by all other VCPUs. Once a VCPU has run,
>  the PMU cannot be changed in order to avoid changing the list of available
>  events for a VCPU, or to change the semantics of existing events.

I've managed to quote the wrong commit. It's that one:
d7eec2360e3 ("KVM: arm64: Add PMU event filtering infrastructure")
  Note that although the ioctl is per-vcpu, the map of allowed events is
  global to the VM (it can be setup from any vcpu until the vcpu PMU is
  initialized).

Sebastian


