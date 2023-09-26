Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7092B7AEFCF
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:38:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlA7f-00021O-9t; Tue, 26 Sep 2023 11:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlA7d-00021D-Ra
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlA7Z-0002WM-0Z
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695742628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lo9KXR61pKjsEjnho4ZEkIzeJ3p3t6d0hL05s36O2Ac=;
 b=AFKosN1oS7UHG/77GL2yMm/7H6yQfUpVVu7ef7sl20APk7OtrmpK9qjEYayvKad0zCPc3B
 teFV3aceljM1UA96q570DXRcmUG67HhGP8L9WctQvARapTbJ5Y9/co5GCJ6+f7OxkCswjs
 BSQ83oikU9YdzY12X/T839nvleTmiso=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-lsKRjcJjMnmzeTQ_fW-HrA-1; Tue, 26 Sep 2023 11:37:06 -0400
X-MC-Unique: lsKRjcJjMnmzeTQ_fW-HrA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4063dd6729bso10643905e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695742624; x=1696347424;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lo9KXR61pKjsEjnho4ZEkIzeJ3p3t6d0hL05s36O2Ac=;
 b=UOpMwa8uzr4oxtkhnpzbdRrP4DwRWSW7rAkDFjKa73UAHHvO6diOc4Bfc6rrHlqqFM
 SmfmmrMgv5E87buI8ww+B5zQcIaNdAwISB0hmhNDgW3kWxQzJlAHMCqo4V2mn50WBAmt
 nBeSIZDK15ElQUDzt1h18oRuTSeMzBiCKJvXRb55LINbmuIzP6FRPQAeoCauT1RdqwUy
 fK1c9LKjaJSgc8/c1NcI3gbZoOSAN1XTSaub3zfiuQfeUaQMkL0md4XDBHHUhYdSC20t
 +SAOIUrQMnDZt8TAbWN0+hQG9b2HAIqh3iX3E3NnEktzNvTmEjiQKNsNYvj3RI8frMgy
 co+A==
X-Gm-Message-State: AOJu0YxAHiHYOmrjVG5fVCFDV3LheEjqt2LSBpBaodx0zTq0WJaqRIYL
 2kO9YAsMIpILnGg4IDSYPo+gJzngZhsMk8dThwfGwO2OXeysAN1xcvj4Q5ZZi1revEb/Tyc2dSm
 sJBqdGn0iSdi9zms=
X-Received: by 2002:a7b:c3cb:0:b0:402:bbe3:827c with SMTP id
 t11-20020a7bc3cb000000b00402bbe3827cmr8343431wmj.31.1695742623981; 
 Tue, 26 Sep 2023 08:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgZbfbn1HshEjjUhkYs+QYTkB7XaKqqvp8tpxKDoNmSm/avWomYIcizb7kscqD4prT8Aa2RQ==
X-Received: by 2002:a7b:c3cb:0:b0:402:bbe3:827c with SMTP id
 t11-20020a7bc3cb000000b00402bbe3827cmr8343417wmj.31.1695742623606; 
 Tue, 26 Sep 2023 08:37:03 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 l7-20020a1c7907000000b003fef60005b5sm7838322wme.9.2023.09.26.08.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 08:37:02 -0700 (PDT)
Message-ID: <09ed554b-ceff-4ab5-68b4-f0aa0234b4b7@redhat.com>
Date: Tue, 26 Sep 2023 17:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] target/i386: enumerate VMX nested-exception support
To: Xin Li <xin3.li@intel.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, seanjc@google.com, chao.gao@intel.com,
 hpa@zytor.com, xiaoyao.li@intel.com, weijiang.yang@intel.com
References: <20230901053022.18672-1-xin3.li@intel.com>
 <20230901053022.18672-4-xin3.li@intel.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230901053022.18672-4-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/1/23 07:30, Xin Li wrote:
> Allow VMX nested-exception support to be exposed in KVM guests, thus
> nested KVM guests can enumerate it.
> 
> Tested-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---
>   target/i386/cpu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3dba6b46d9..ba579e1fb7 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1340,6 +1340,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>           .feat_names = {
>               [54] = "vmx-ins-outs",
>               [55] = "vmx-true-ctls",
> +            [58] = "vmx-nested-exception",
>           },
>           .msr = {
>               .index = MSR_IA32_VMX_BASIC,

Please also add it to scripts/kvm/vmxcap, and rebase on top of the 
recent introduction of MSR_VMX_BASIC_ANY_ERRCODE.

Paolo



