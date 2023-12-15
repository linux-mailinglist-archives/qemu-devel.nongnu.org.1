Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 953438144F0
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 10:57:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE4vL-0006V7-FU; Fri, 15 Dec 2023 04:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1rE4vJ-0006SJ-UB
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 04:56:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1rE4vI-00008b-Cq
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 04:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702634159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XsVx4MsxXeqsM9UmamEQoOhQwuatdwZpdHk8xWe7cXU=;
 b=BhWdUJ/4947x7hKIo0aCfsgf1Dxfl7TXoXvNhNd5NmBgy+BXsBs9qAsu/vfoLcFpmwNc2R
 7QNxbt9VfV9mY+kU+kC/hym3jlM/+nm4BCPX6JruoyI6ZqPvbn+Xn2+QI+XkOrCK/uYAF6
 rQPZG3I/G6MR39u8JFk/i1GRr1CwB6M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-_Mh_05PnMwy5AbOvvOKW-Q-1; Fri, 15 Dec 2023 04:55:57 -0500
X-MC-Unique: _Mh_05PnMwy5AbOvvOKW-Q-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-425f0ab06a2so7668751cf.3
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 01:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702634157; x=1703238957;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XsVx4MsxXeqsM9UmamEQoOhQwuatdwZpdHk8xWe7cXU=;
 b=iVP3imitkGXz0ewrCh0SY9lzUuS43Vp/6gWApwK0CmA+G41ueUfrahwTJfCrrlS6xB
 w+VklXZtUmOtF4RpqeFQCLgST3ky6d16P61FD2Y1Z+1/xp9Zm6FAv0CIooEItrc/vyZc
 7LkJVPWE9EvmC4yZYRVHfHKicgusFsH99UXtWQweLssvRpqgn1uyLZUZiuVlcAI/d2W6
 H5kQmuY9wtRG3fE9+NnzpDBHWmmJvhAHGVKqOvuZow14rTs+OQo7G4UQqO8+cfptbKNs
 RKVrv/WGGYFa9eNBksLy5k911Df/azy7xHdl04+QW4KwUrPmuERmh36YlexMj7lcC9LO
 M/bA==
X-Gm-Message-State: AOJu0YyRxiO74jsx2UQoXt1uih+SgtTw4cPSQL8zWoyWEEr59CN1Q49a
 ylTCt3fmxPVzooHfaNRyGYKGDlTaaQdlOhCn1SeulBR4Kuxh6+B0VECvINpbHs65Zp4G8xJoxNN
 6j8fvR9OjuRxMuA0=
X-Received: by 2002:ac8:5d46:0:b0:425:aa00:cdd7 with SMTP id
 g6-20020ac85d46000000b00425aa00cdd7mr16876849qtx.85.1702634156954; 
 Fri, 15 Dec 2023 01:55:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRNgexYYxGeBYpv2I0o7qP+XF4lN98Nhfdv7ZmdQHRJsJB/kJYReY37LmjQ3BwLt+ONAKnSw==
X-Received: by 2002:ac8:5d46:0:b0:425:aa00:cdd7 with SMTP id
 g6-20020ac85d46000000b00425aa00cdd7mr16876839qtx.85.1702634156712; 
 Fri, 15 Dec 2023 01:55:56 -0800 (PST)
Received: from rh (p200300c93f174f005d25f1299b34cd9e.dip0.t-ipconnect.de.
 [2003:c9:3f17:4f00:5d25:f129:9b34:cd9e])
 by smtp.gmail.com with ESMTPSA id
 cd5-20020a05622a418500b004255fd32eeasm6318380qtb.7.2023.12.15.01.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 01:55:56 -0800 (PST)
Date: Fri, 15 Dec 2023 10:55:51 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eauger@redhat.com>
cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org, 
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
In-Reply-To: <be70b17c-21cf-4f4e-8ec1-62c18ffd4100@redhat.com>
Message-ID: <f1b6dffb-0a23-82d2-7699-67e12691e5c4@redhat.com>
References: <20231207103648.2925112-1-shahuang@redhat.com>
 <be70b17c-21cf-4f4e-8ec1-62c18ffd4100@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 14 Dec 2023, Eric Auger wrote:
> On 12/7/23 11:36, Shaoqin Huang wrote:
>> +    if (kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr)) {
>> +        warn_report("The kernel doesn't support the PMU Event Filter!\n");
>> +        return;
>> +    }
>> +
>> +    /* The filter only needs to be initialized for 1 vcpu. */
> Are you sure? This is a per vcpu device ctrl. Where is it written in the
> doc that this shall not be called for each vcpu

The interface is per vcpu but the filters are actually managed per vm
(kvm->arch.pmu_filter). From (kernel) commit 6ee7fca2a ("KVM: arm64: Add 
KVM_ARM_VCPU_PMU_V3_SET_PMU attribute"):
  To ensure that KVM doesn't expose an asymmetric system to the guest, the
  PMU set for one VCPU will be used by all other VCPUs. Once a VCPU has run,
  the PMU cannot be changed in order to avoid changing the list of available
  events for a VCPU, or to change the semantics of existing events.

Sebastian


