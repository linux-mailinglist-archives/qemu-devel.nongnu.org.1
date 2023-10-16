Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1F37CABBF
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 16:40:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsOl2-00054R-JE; Mon, 16 Oct 2023 10:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsOkn-0004xn-77
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsOkl-00016w-3W
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697467168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5Zp0O1bQa0QhZxeeIX5P6F8zRLBU3cCZ1Zer18KQjk=;
 b=cDfljPVVZ5q7UDUwfAKYDONN8mrXhJAqhLRVyn1fbcuxlfcMCxTR931t87r9jsx2xjcv4M
 f8oGc4EQ+q9m2SIXUzpcsHSM4vqkK8326nMON0RqxubDpMwBTYtTGUgaO/6xx2AY0UYF0Y
 6L7jsZNfcvrrDgHDLLsDYQGU+YN2p0Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-m6w0BuntPs2QXj4KG0VsKg-1; Mon, 16 Oct 2023 10:39:26 -0400
X-MC-Unique: m6w0BuntPs2QXj4KG0VsKg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae0bf9c0b4so348716266b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 07:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697467165; x=1698071965;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i5Zp0O1bQa0QhZxeeIX5P6F8zRLBU3cCZ1Zer18KQjk=;
 b=uEFPC4/BlGwqd7jiNU33wS/H0I9z7L0xo4CXFNpdxG76fnt7/8THMZHXebL8dN7bWR
 loq9st84d1ZnxEPmIZ4XnYhCeGNEsmrg38XIl8ZUI9rYZ7pkgcRqCP/5IpjvAQ+yKfhZ
 JEEpyKDXkWdHx4eY/KeQEqWW3HMNbkmSvyzXFGzLeEtQK3Z+1MJ4bJTaRaRV7rACBD2N
 jDwwqUYI/iI4sWBcj3w9NjNmDNwk2KwvnyjEIoxZHoZzB9ThRdIlsM9FLtPeLgbvJ/37
 wKbHSF0D7caXeBRlXUedTVcsp3STGCvJ7FZAuQdZndMsM4C/HOZd/TKX2jEBQmKSF1GF
 MYJA==
X-Gm-Message-State: AOJu0Yx5Hx2K0H9L3Jd1I5jH8exYM2XG+MASM20Yw8Lmie65qcENJmjz
 PcWysa3DeO44NKJ8N0Y+QHuYcPkNbclPowp8e3p3zQmSLWIuoE7IwzRjRSPVB4gsc0AaXT2nitF
 HVdmSkpjl+IZ/EdccF7h6IKM=
X-Received: by 2002:a17:907:608d:b0:9bd:d8d6:c1ad with SMTP id
 ht13-20020a170907608d00b009bdd8d6c1admr9253843ejc.61.1697467164732; 
 Mon, 16 Oct 2023 07:39:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1PT1O54YEAgR4U5mjMyMD4xzKEM7iFnXaQRjTOv8+t+X4t2FZvaZ2fkYW8MBhDUbRNcoetQ==
X-Received: by 2002:a17:907:608d:b0:9bd:d8d6:c1ad with SMTP id
 ht13-20020a170907608d00b009bdd8d6c1admr9253823ejc.61.1697467164309; 
 Mon, 16 Oct 2023 07:39:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 my13-20020a1709065a4d00b0099bc8bd9066sm4138356ejc.150.2023.10.16.07.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 07:39:23 -0700 (PDT)
Message-ID: <4319fcd1-981c-4ef0-b6b9-1f7f57c1c4ca@redhat.com>
Date: Mon, 16 Oct 2023 16:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hvf x86 correctness and efficiency improvements
Content-Language: en-US
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu
References: <20230922140914.13906-1-phil@philjordan.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230922140914.13906-1-phil@philjordan.eu>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/22/23 16:09, Phil Dennis-Jordan wrote:
> Patch 1 enables the INVTSC CPUID bit when running with hvf. This can 
> enable some optimisations in the guest OS, and I've not found any reason 
> it shouldn't be allowed for hvf based hosts.

It can be enabled, but it should include a migration blocker.  In fact, 
probably HVF itself should include a migration blocker because QEMU 
doesn't support TSC scaling.

> Patch 2 fixes hvf_kick_vcpu_thread so it actually forces a VM exit instead of
> doing nothing. I guess this previously didn't cause any huge issues because
> hvf's hv_vcpu_run() would exit so extremely frequently on its own accord.

No, it's because signal delivery should already kick the vCPU out of 
guest mode.  I guess it does with hv_vcpu_run(), but not with 
hv_vcpu_run_until()?

hv_vcpu_interrupt() is a problematic API, in that it is not clear how it 
handles races with hv_vcpu_run().  In particular, whether this causes an 
immediate vmexit or not:

            thread 1                         thread 2
            -----------------------          -----------------------
                                             <CPU not in guest mode>
            hv_vcpu_interrupt()
                                             hv_vcpu_run() (or run_until)

Not that the current code is any better; there is no guarantee that the 
signal is delivered before hv_vcpu_run() is called.  However, if as you 
said hv_vcpu_run() will exit often on its own accord but 
hv_vcpu_run_until() does not, then this could cause difficult to 
reproduce bugs by switching to the latter.

> The temp variable is needed because the pointer expected by the hv_vcpu_interrupt()
> call doesn't match the fd field's type in the hvf accel's struct AccelCPUState.
> I'm unsure if it would be better to change that struct field to the relevant
> architecture's handle types, hv_vcpuid_t (x86, unsigned int) and hv_vcpu_t
> (aarch64, uint64_t), perhaps via an intermediate typedef?

I think fd and the HVF type should be placed in an anonymous union.

Thanks,

Paolo


