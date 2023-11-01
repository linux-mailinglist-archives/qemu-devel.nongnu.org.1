Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DBD7DE1DE
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 15:06:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyBpx-0005jW-Uf; Wed, 01 Nov 2023 10:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1qyBpu-0005j3-Sj
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1qyBpr-0004nc-0g
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698847478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KU8sdn3CDmnUGLVhZ2woY8ZKBPjZCE6EPlmsSYG4PRQ=;
 b=IgDcKRvCQiQWSkNvTOd+YX4wlpmBcKu0HSxJuYYGyX2go0GYq6DGsf3hDfFJgFIIxMQyAF
 my+rPogONnOFgqWNIxiaXbopkHSAVd2i3lXTc5T7sAY+NC99bJknActHdsC62jb/8P1qXh
 cPSSKCX56IT/9yvzX3husaAYq0hKmjk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-IdZyG5LXNbqy8KCDGj6z_A-1; Wed, 01 Nov 2023 10:04:36 -0400
X-MC-Unique: IdZyG5LXNbqy8KCDGj6z_A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4090fa518bbso47886945e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 07:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698847473; x=1699452273;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KU8sdn3CDmnUGLVhZ2woY8ZKBPjZCE6EPlmsSYG4PRQ=;
 b=J85sSioAiuiPT4RmOYKHoaMPJr2oS+w+bClZSVE6DEs7i9PwAv2nPxUBw0+SEGebRi
 DmVJ6jXGnJcdlIguazyjV85t61/81sSMZ1IW8GByEcP3B8BkSujW+/CCACReW7zgbm37
 1vCoB+cygfUWVgvbFU1uxlzh59Ugfy/ds7wS7LsN0AR3DNgwmyepPQgUMcr2SKXiy5ot
 GJVfAZp6bzod8On9Cr+/i5l8BuqbjVSRjX9NXwW2+5V8KTn7lerh6yehftU23gmLHBDW
 uWIJI1DOgMz2LPMGxgHRwDX521tBWWCNPMClCJs0RRsH+jfc52bbomogu+vs6bGxfA/c
 fJrg==
X-Gm-Message-State: AOJu0YxLxea47kENFnBBrvn3MvXMXKv+fK7MpCn97HC6ZR4I2WbOkqPY
 XZSpQbZWHRSqRkoQBJ80ei8uuYz2Oymt1yCGkSH2cENNv6+RCKT5M8rlW8MjvdUl5l7WMxGV9Sh
 IkWTUgg95dogs0cSynDUs5MoPMnK3pdESECgxhBu7/mc7BGchXw9r7hm5EoT8Xfk6prpn2tnl3C
 E=
X-Received: by 2002:a5d:64af:0:b0:32f:a3fb:8357 with SMTP id
 m15-20020a5d64af000000b0032fa3fb8357mr936595wrp.6.1698847472821; 
 Wed, 01 Nov 2023 07:04:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV0V8FtHtZfHv9dKvRDGy3JkUIh64RgV7hXzJdY6A1SEodVe+DYhpOWtVd22PSTWKR91uu3A==
X-Received: by 2002:a5d:64af:0:b0:32f:a3fb:8357 with SMTP id
 m15-20020a5d64af000000b0032fa3fb8357mr936564wrp.6.1698847472461; 
 Wed, 01 Nov 2023 07:04:32 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a5d6811000000b0032d2f09d991sm4267660wru.33.2023.11.01.07.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 07:04:31 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eiichi Tsukata <eiichi.tsukata@nutanix.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "mtosatti@redhat.com"
 <mtosatti@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/i386/kvm: call kvm_put_vcpu_events() before
 kvm_put_nested_state()
In-Reply-To: <D3D6327A-CFF0-43F2-BA39-B48EE2A53041@nutanix.com>
References: <20231026054201.87845-1-eiichi.tsukata@nutanix.com>
 <D761458A-9296-492B-85B9-F196C7D11CDA@nutanix.com>
 <78ddc3c3-6cfa-b48c-5d73-903adec6ac4a@linaro.org>
 <87wmv93gv5.fsf@redhat.com>
 <D3D6327A-CFF0-43F2-BA39-B48EE2A53041@nutanix.com>
Date: Wed, 01 Nov 2023 15:04:31 +0100
Message-ID: <87edh9h8nk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

Eiichi Tsukata <eiichi.tsukata@nutanix.com> writes:

> FYI: The EINVAL in vmx_set_nested_state() is caused by the following condition:
> * vcpu->arch.hflags == 0
> * kvm_state->hdr.vmx.smm.flags == KVM_STATE_NESTED_SMM_VMXON

This is a weird state indeed,

'vcpu->arch.hflags == 0' means we're not in SMM and not in guest mode
but kvm_state->hdr.vmx.smm.flags == KVM_STATE_NESTED_SMM_VMXON is a
reflection of vmx->nested.smm.vmxon (see
vmx_get_nested_state()). vmx->nested.smm.vmxon gets set (conditioally)
in vmx_enter_smm() and gets cleared in vmx_leave_smm() which means the
vCPU must be in SMM to have it set.

In case the vCPU is in SMM upon migration, HF_SMM_MASK must be set from
kvm_vcpu_ioctl_x86_set_vcpu_events() -> kvm_smm_changed() but QEMU's
kvm_put_vcpu_events() calls kvm_put_nested_state() _before_
kvm_put_vcpu_events(). This can explain "vcpu->arch.hflags == 0".

Paolo, Max, any idea how this is supposed to work?

-- 
Vitaly


