Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F77974890
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Sep 2024 05:20:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDtg-0007dX-Dl; Tue, 10 Sep 2024 23:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDte-0007cU-Rp
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:19:58 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDtd-0000Ht-Do
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:19:58 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-718d704704aso1354307b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726024796; x=1726629596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TpnVDxKqmP/X0f2pLAY6WkuZ4jhKUGZt7DlyutRJ1uU=;
 b=XXhOzqDZ3yo58Xroi9KDjwQEWNYpMUP0IG5RqX8nrRQDEVRBgvYWO4Ez/zloTC/uxM
 +xxnnkhUTbmwZgMCMw7lmDV81Dw5Wm3GpdjZatunNxI0lpDqUVnxK8qWxwJkBY6fyiTC
 izprpv/qYOPYPWww2aDA9wZ4AxBZ1X19VrPV+mCrCvC82XSgDzRFS/+spoTEsqxNUtjE
 edFGHXTNyGUU/EIdGONv5mM8jSCXYjvQS4yphj/EMJSh652pzE9nH7UCTrzPDYXBfnYr
 hPa0uTuiTD/xvVpAPzbWa6/GOTer+MIRtLzfRcoB5qZl9shvkeaoF740FAb1ZnKxDWC9
 lUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726024796; x=1726629596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TpnVDxKqmP/X0f2pLAY6WkuZ4jhKUGZt7DlyutRJ1uU=;
 b=OLcgfWekQgKHvb6ZssICxOl4kKTfCdntuO/1pOmPu9SDY9sV/gdsNAn1ufD+1Wa+kf
 g6GGKofpKCOESxAh/JOqG2Wi2aBHb1rx4MZ/AEozo+HcwEHa/eBDR9zfjn4Bwy8evCYh
 8KHg5WkNSjd7AnWT8jEZG7P2cNyLb3+/03w8VYTWgRFw6o39+wRSVIYmCw3gQ4VUB34R
 DCoUnHaqhtqxbljbgovPw4RM3L/A91QKceZNT6W24D/9XkdfFU2xOH0eBG7k5V+p7DOg
 2GTG9uuoXNfRBRLC+1WA4s889sTGVsnDuzOHlfx5B3xAKKumy17vyQ2jieEYLlMUSnND
 zv+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzaJWVAUPWw6fsOiV5py5gF3S8tvsNKekhDj+5pTPXsISoxYqSWSmxRoaLOMF+2L9/dkZR7ZiJ5CCV@nongnu.org
X-Gm-Message-State: AOJu0YxSY3OyLr9E3pzAr50vJlB365fDTtYsuDl1L2dO4tLSa80nzJJR
 KYM2RkVLozd1Ngt0t8ipqMlNRvTUGBoQo/PR4P1XyYdeXxwlgrFsT6TtUmYq32nSWaNgGGMV0hh
 F
X-Google-Smtp-Source: AGHT+IGZtUegG+P3n97bjztebNJ6clJ4MYpF21+8P96Nk7xJ0l0WAeknxQPazfl6r17LRkiBRu3u6w==
X-Received: by 2002:a05:6a00:66c8:b0:70a:f576:beeb with SMTP id
 d2e1a72fcca58-71916df6fdfmr1987773b3a.15.1726024795785; 
 Tue, 10 Sep 2024 20:19:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7190909256csm2046443b3a.125.2024.09.10.20.19.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:19:55 -0700 (PDT)
Message-ID: <39eb2141-fc11-4e9d-914a-854f8ef814e3@linaro.org>
Date: Tue, 10 Sep 2024 20:19:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/39] include/hw/s390x: replace assert(false) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-15-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-15-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/s390x/cpu-topology.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
> index c064f427e94..dcb25956a64 100644
> --- a/include/hw/s390x/cpu-topology.h
> +++ b/include/hw/s390x/cpu-topology.h
> @@ -57,7 +57,7 @@ static inline void s390_topology_setup_cpu(MachineState *ms,
>   static inline void s390_topology_reset(void)
>   {
>       /* Unreachable, CPU topology not implemented for TCG */
> -    assert(false);
> +    g_assert_not_reached();
>   }
>   #endif
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

