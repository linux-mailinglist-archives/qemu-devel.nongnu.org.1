Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F0B7FF774
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 17:57:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8kKZ-0005QB-1D; Thu, 30 Nov 2023 11:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1r8kKX-0005Pj-1N
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:56:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1r8kKV-0002mR-Mw
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701363358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KtoN2ZvhcuCaqON5ck8JufGVlPbWB5udZtZepLtMMXU=;
 b=MDOJlR5CbzOdtprQ3/zQumI/lsQUC68Fbt1Xh4KnVENfS59yyHnSSMbXnJ3+4ywpR3ZBu8
 PeHORyhSV6ERTyAoVLQhMD3NZ9Pmk81XgXMnxkOp/mjTfZ7GydfmLQGA6VoSQE68KUedU2
 CdXH34dPVByZpIXMAa/0N8SgHR0q2T4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-9RIqJiVpNnqgwLwgPFMNLw-1; Thu, 30 Nov 2023 11:55:56 -0500
X-MC-Unique: 9RIqJiVpNnqgwLwgPFMNLw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-67a5617dfdaso13011756d6.2
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 08:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701363355; x=1701968155;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KtoN2ZvhcuCaqON5ck8JufGVlPbWB5udZtZepLtMMXU=;
 b=FcA2LzpYGhw6jUkhYZnBNJJ5PA/41Y1YBvn/EqhybTzgSxjKSNXdq1ZdijhVZoVdBr
 DkFEVB5CYQzdS81rvUgJGVpvkUDrQQ8AQ3AESfHNwnNr8knv80tVWvbXMZrTLEehO+0m
 1xRGESF0IphbSuzxcbgm3NJdJrXjkaFDXj88aR3ujjVm0dv6Dz2HKIj5t+61wEiXJtgs
 WZ8ixwc2izHqLifoR0bkJgk9FvBYNPzuHUb1maSArGuF3ps0gos89AzZslqfrODYv9Pw
 NC8eJzSgB8w9q+P7p56XSrBFuXF0brkLx+9a84dy0g3V4Q8WEis6wXtKoQau0K21WXWt
 Ijsg==
X-Gm-Message-State: AOJu0YxehCg33SD7HhJbJFZl3r2PIAQDXuDVA6dKySH+PNt0w5GKAMtJ
 aWa35b6Eb7CeeqwhRWEeivth8cdWPFhpzSkGs1d0LjXl+vsPXPCh+rmWPtW+dCvAqquKbrqpyf7
 TKnaY82mOf3WPtcg=
X-Received: by 2002:ad4:5988:0:b0:67a:8873:5f31 with SMTP id
 ek8-20020ad45988000000b0067a88735f31mr1563750qvb.31.1701363355543; 
 Thu, 30 Nov 2023 08:55:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCWIBeWhqOh5ZvE9cdWqZuBVRYzHXomkD/IZHya+Ja+xoGkrNnZgnDowpjYfCs6kp0jrQKBg==
X-Received: by 2002:ad4:5988:0:b0:67a:8873:5f31 with SMTP id
 ek8-20020ad45988000000b0067a88735f31mr1563741qvb.31.1701363355342; 
 Thu, 30 Nov 2023 08:55:55 -0800 (PST)
Received: from rh (p200300c93f306f0016d68197cd5f6027.dip0.t-ipconnect.de.
 [2003:c9:3f30:6f00:16d6:8197:cd5f:6027])
 by smtp.gmail.com with ESMTPSA id
 d22-20020a0caa16000000b0067a17f65a9csm656796qvb.21.2023.11.30.08.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 08:55:55 -0800 (PST)
Date: Thu, 30 Nov 2023 17:55:50 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>
cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
In-Reply-To: <20231129030827.2657755-1-shahuang@redhat.com>
Message-ID: <58b1095a-839d-0838-24df-f4cd532233be@redhat.com>
References: <20231129030827.2657755-1-shahuang@redhat.com>
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

On Tue, 28 Nov 2023, Shaoqin Huang wrote:
> +static void kvm_arm_pmu_filter_init(CPUState *cs)
> +{
> +    static bool pmu_filter_init = false;
> +    struct kvm_pmu_event_filter filter;
> +    struct kvm_device_attr attr = {
> +        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
> +        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
> +        .addr       = (uint64_t)&filter,
> +    };
> +    KVMState *kvm_state = cs->kvm_state;
> +    char *tmp;
> +    char *str, act;
> +
> +    if (!kvm_state->kvm_pmu_filter)
> +        return;
> +
> +    if (kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr)) {
> +        error_report("The kernel doesn't support the pmu event filter!\n");
> +        abort();
> +    }
> +
> +    /* The filter only needs to be initialized for 1 vcpu. */
> +    if (!pmu_filter_init)
> +        pmu_filter_init = true;

Imho this is missing an else to bail out. Or the shorter version

 	if (pmu_filter_init)
 		return;

 	pmu_filter_init = true;

which could also move above the other tests.

Sebastian


