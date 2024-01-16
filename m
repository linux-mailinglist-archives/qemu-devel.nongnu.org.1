Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDA482EB9D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 10:34:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPfot-00054s-4G; Tue, 16 Jan 2024 04:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1rPfoq-00054O-EO
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 04:33:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1rPfoo-0001EW-PF
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 04:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705397592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RXJRf67FGygBSwTq+ImaBbYLkmHg7FGC5oYkqjq+YeA=;
 b=KaXgE5sIlpoG0AUI/fnp5dRFu9bNyPb37TsL/OMMeMAataAlN59gBu1EkjLhC/HyxKMvUm
 tqD3F0PW98dI/uZPiT4+xuFLW0xpJzRHwrS5JN7b7nTNQYR4KnVf1JlTjJodlMnJPpzXyI
 XdvWE3gszm1pgkWTVvYFF/RrPV5g+Uo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-P0HFveR3O-SrR5OpEF2ktw-1; Tue, 16 Jan 2024 04:31:54 -0500
X-MC-Unique: P0HFveR3O-SrR5OpEF2ktw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e6e3c46bfso23520775e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 01:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705397513; x=1706002313;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RXJRf67FGygBSwTq+ImaBbYLkmHg7FGC5oYkqjq+YeA=;
 b=FVGhHCnv9rSpRwXrzSeeQOO7pofkc2FE9+UTXjlURcypchEwBNXGkSf9aLx9IQicET
 NS1f/zwPrhI8AGPNZALLmGgMDfmK01qlxnKTC7ZrldSMCGlFU0j23SOFWoiudFA6RBQg
 zmOkEo/zrZk3FqNuPrDt0cMWHNtGvcm4blNuCil188Ibd9H0W01nDs8R0s6sD1Rhnl1T
 fKNPYc42p51zzMAvbAp3djj4f+1QvQVTpQxt1PTF0Ukh9JE8WTxPSBvdN2eIiTiUNSbc
 6DL7Ck8HaaCOGrQQepAsIsoksUCF0tXU3f0L4QvpwbpyyPvemmp1X19imJfCbzQVMIGr
 FPlA==
X-Gm-Message-State: AOJu0YzBYbRsnHFwGzd8XGOqunYkbh8hmyRnuJ+69cNHEOEHAZgvNaw6
 nVmn07/hY2QwOF27u+Z53yXxzSOVP3/AEJBdsbPZUzPWm6aRqG6CLyewKbqCL2MnjewIb4Q2FJK
 2GQshKptUOe95HB6YMEaB4YUQOrE5dc/xw9Z6gFcod/fBHfz2f9dxBvLIgPZNi/ofPbVSua1/Xn
 qvflNshIg=
X-Received: by 2002:a05:600c:1c14:b0:40e:5316:2173 with SMTP id
 j20-20020a05600c1c1400b0040e53162173mr3713018wms.174.1705397513359; 
 Tue, 16 Jan 2024 01:31:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeKe7WhuCPRV24M7POZhFc8IZa9D4Q02mLGeGRvGGuELJEdSNVupJg26yEu5bUuF1xeM3eEQ==
X-Received: by 2002:a05:600c:1c14:b0:40e:5316:2173 with SMTP id
 j20-20020a05600c1c1400b0040e53162173mr3713001wms.174.1705397512998; 
 Tue, 16 Jan 2024 01:31:52 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
 by smtp.gmail.com with ESMTPSA id
 l39-20020a05600c1d2700b0040e50d82af5sm18762137wms.32.2024.01.16.01.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 01:31:52 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eiichi Tsukata <eiichi.tsukata@nutanix.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "mtosatti@redhat.com"
 <mtosatti@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/i386/kvm: call kvm_put_vcpu_events() before
 kvm_put_nested_state()
In-Reply-To: <585D19C7-80BD-4599-ABBD-A0FE25F0ACB9@nutanix.com>
References: <20231026054201.87845-1-eiichi.tsukata@nutanix.com>
 <D761458A-9296-492B-85B9-F196C7D11CDA@nutanix.com>
 <78ddc3c3-6cfa-b48c-5d73-903adec6ac4a@linaro.org>
 <87wmv93gv5.fsf@redhat.com>
 <D3D6327A-CFF0-43F2-BA39-B48EE2A53041@nutanix.com>
 <87edh9h8nk.fsf@redhat.com>
 <7A7A55C5-6151-453A-852C-96CD10098EE6@nutanix.com>
 <585D19C7-80BD-4599-ABBD-A0FE25F0ACB9@nutanix.com>
Date: Tue, 16 Jan 2024 10:31:51 +0100
Message-ID: <87cyu1bp4o.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

As I'm the addressee of the ping for some reason ... :-)

the fix looks good to me but I'm not sure about all the consequences of
moving kvm_put_vcpu_events() to an earlier stage. Max, Paolo, please
take a look!

Eiichi Tsukata <eiichi.tsukata@nutanix.com> writes:

> Ping.
>
>> On Nov 8, 2023, at 10:12, Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
>> 
>> Hi all, appreciate any comments or feedbacks on the patch.
>> 
>> Thanks,
>> Eiichi
>> 
>>> On Nov 1, 2023, at 23:04, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>> 
>>> Eiichi Tsukata <eiichi.tsukata@nutanix.com> writes:
>>> 
>>>> FYI: The EINVAL in vmx_set_nested_state() is caused by the following condition:
>>>> * vcpu->arch.hflags == 0
>>>> * kvm_state->hdr.vmx.smm.flags == KVM_STATE_NESTED_SMM_VMXON
>>> 
>>> This is a weird state indeed,
>>> 
>>> 'vcpu->arch.hflags == 0' means we're not in SMM and not in guest mode
>>> but kvm_state->hdr.vmx.smm.flags == KVM_STATE_NESTED_SMM_VMXON is a
>>> reflection of vmx->nested.smm.vmxon (see
>>> vmx_get_nested_state()). vmx->nested.smm.vmxon gets set (conditioally)
>>> in vmx_enter_smm() and gets cleared in vmx_leave_smm() which means the
>>> vCPU must be in SMM to have it set.
>>> 
>>> In case the vCPU is in SMM upon migration, HF_SMM_MASK must be set from
>>> kvm_vcpu_ioctl_x86_set_vcpu_events() -> kvm_smm_changed() but QEMU's
>>> kvm_put_vcpu_events() calls kvm_put_nested_state() _before_
>>> kvm_put_vcpu_events(). This can explain "vcpu->arch.hflags == 0".
>>> 
>>> Paolo, Max, any idea how this is supposed to work?
>>> 
>>> -- 
>>> Vitaly
>>> 
>> 
>

-- 
Vitaly


