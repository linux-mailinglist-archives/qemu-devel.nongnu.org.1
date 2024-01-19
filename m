Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8CC833068
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 22:43:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQwcx-00027o-Bj; Fri, 19 Jan 2024 16:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQwcv-00027e-76
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:42:13 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQwct-0005Mj-Id
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:42:12 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40ea34df934so1265525e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 13:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705700530; x=1706305330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8QDoutmiDhXwa+QXDbekozFTGuseQkJNNMOuMJ7vhww=;
 b=VtYImeYYea6emgq705FaV1qjJmv/Ukzu7hlUwdkOdMucH3D+21dSdU7aQKlkmnzh34
 t/OkMrH77kY/JXFzaht/BhhkjgiurxlcyUxPlWENZtaDb0tI7Wq3CJM38s67B02f2ZYR
 CUXi1GnjPy1FCjMTUo0l7d2TALoeoa3/uI7Ke7oimIyP1OUwBiB1ZhMvpC5kpQKtXQrl
 YrWQBglVvpT7L/kenzWA+xzTWDtEJJ1tSiAomvPU9enVPLdwen1PzMNbbsodd73GfKBS
 vP13uT4LHvqNyphb+/q7kw8uNZnLPF36qWQzLD7rpJw6p2tzvbFcXfYglMdx+H7fPW3f
 dReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705700530; x=1706305330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8QDoutmiDhXwa+QXDbekozFTGuseQkJNNMOuMJ7vhww=;
 b=r/H0RWcOAZq2yKK1F8Nw6XgXLuNDPKK1f1nk3eIrhPwyKJa0dZUqZbHc6wo6O8wwf9
 4sOOtmIKVEKHmmMbU/iVv99QyWKO/31AkBYUCV66mFD+m/qbohdh4Olt9pR9UK5gH+AO
 XbTt0lJEpzYUwbV3zv+6iEL834lUAvlb+ug8aLQ2KBAtUpnerVqCceL4dNuu/HXteaUf
 srd0wA7DzAmees+Pe73L2ANvCwYFKfi6bZwNjy57JGyVr4sWTzLyJmfA1XR9vDmzuJcJ
 txb3qEhtRIRX9TQcGYA+fdFIHilfY66ekTN762v0aMBwxModSmWYqsmo9hihKoxTApEY
 i2Qg==
X-Gm-Message-State: AOJu0YwHWC39AAwqrKAk1dDAooUlLRzwPPVdcmAFRuX6Or2LQP1fQESP
 EREB9Nw0N73Wo0DobdUV6pjfMneyUQsfiZF+EDZg/kDLIjHOnix4DpCBU61FMLE=
X-Google-Smtp-Source: AGHT+IErSjqNqTZPYVqbGqbRL7jsf90LNXZpAjW/CHr5zqswyMulOJ7NxBCEdDf7dA9DTKQWD/acig==
X-Received: by 2002:a05:600c:4689:b0:40e:714a:dff5 with SMTP id
 p9-20020a05600c468900b0040e714adff5mr199228wmo.27.1705700529429; 
 Fri, 19 Jan 2024 13:42:09 -0800 (PST)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 ay41-20020a05600c1e2900b0040e9e03160bsm3190015wmb.16.2024.01.19.13.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 13:42:08 -0800 (PST)
Message-ID: <fbfadb69-27e5-4d8d-a269-f641cad9cb43@linaro.org>
Date: Fri, 19 Jan 2024 22:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Drop myself as VT-d maintainers
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, eric.auger@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>, zhenzhong.duan@intel.com,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20240118091035.48178-1-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240118091035.48178-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 18/1/24 10:10, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Due to my own limitation on bandwidth, I noticed that unfortunately I won't
> have time to review VT-d patches at least in the near future.  Meanwhile I
> expect a lot of possibilities could actually happen in this area in the
> near future.
> 
> To reflect that reality, I decided to drop myself from the VT-d role.  It
> shouldn't affect much since we still have Jason around like usual, and
> Michael on top.  But I assume it'll always be good if anyone would like to
> fill this role up.
> 
> I'll still work on QEMU.  So I suppose anyone can still copy me if one
> thinks essential.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b406fb20c0..1c85b4bdad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3606,7 +3606,6 @@ F: tests/uefi-test-tools/
>   
>   VT-d Emulation
>   M: Michael S. Tsirkin <mst@redhat.com>
> -M: Peter Xu <peterx@redhat.com>
>   R: Jason Wang <jasowang@redhat.com>

Not my area, but noticing the recent changes in the complex migration
subsystem, and as you mentioned VT-d is well coverage, it is cautious
to unburden you, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

