Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F217EBA91
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:28:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r33jZ-00079V-Ql; Tue, 14 Nov 2023 19:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33jY-000797-1z
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:26:20 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33jV-0004nI-UG
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:26:19 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5c184b3bbc4so2387832a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 16:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700007976; x=1700612776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vh0f+DLVSskNc/Ix2R5WGG/tkbWUsXl0JR36nuVWWBQ=;
 b=O1tJzsLJvqL4DCFR5RGSOtZBh/wrOVZnTBknzqI7bAyMrukN20SHUCM5JbI3zVk5Fu
 hYGRLsXY6pWM6XJuX044P6bklAAACgQ1h30hM5sAG17LR3IWYK/EVtfmeuQb/nyPVwPR
 3asN15nzVkfLVB4RjFowhPl1snQ3t8XNvW4aRTuw9vhxHg2V8CXNXP6W2YmJnPdP6+xW
 aady1DSSswEOoJMSi8/ZibUKBskQDzh1T/K0YkPEophpOS4IOXycoJEmwNi2kfM19VxB
 kSIzY1EvNTwzzkpNcUrbIXr7DYEkW9hLemRliNu2AfE5LNJ4Qwh5gDmKu8iBGQMRDLaG
 j48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700007976; x=1700612776;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vh0f+DLVSskNc/Ix2R5WGG/tkbWUsXl0JR36nuVWWBQ=;
 b=foR0Tf+w1iXf89WRbEaVf5Ic69llET6OZfpT1Kn82oGCPHEIDhH3uba9ixtcEw4K73
 yJ4uFI/eDc42uh3CKpyDNcrd37tj/4TmDxx5sVdfxwQsC/uTL6oCNgbrZH4/0TSDa/jx
 hw+Gql67R/Eg7alOf8ds7mhsz6hqsWB5SYXGvzxiE1ci/Co0QaMC0Oo4vGHmHAjYkPLn
 U+Fr+v69WbIOg4Un82w9ciHOmJUEEbZbzjpQBIyG+3Pq1PesdFnnLL/qVNuy7QdXE2SY
 xTq3UJSOxvZYq7XjedUcF+V6iLsTyRnx8mTUuG4rLhiLikCvXSJAVPQQ6x1LU6MgyF/6
 972g==
X-Gm-Message-State: AOJu0Yy4d/ccySQuN2tyWSmUoMHGzWk/i7QO6Gs3Fgm2saZ0Rg8CoOkM
 A6TtNimzCQxNJVcYCVw5Cwz8tUSyYEzBVO+mQ+g=
X-Google-Smtp-Source: AGHT+IE6bI8yR4rpNExj5oaYra6990mZ0hcEy3uS43iWnCoCG/sDRVI8kmzuciTsQhfAH50vxYNA2A==
X-Received: by 2002:a17:902:db0d:b0:1cc:4467:a563 with SMTP id
 m13-20020a170902db0d00b001cc4467a563mr3737133plx.3.1700007976010; 
 Tue, 14 Nov 2023 16:26:16 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a170903245200b001b9be3b94d3sm6273870pls.140.2023.11.14.16.26.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 16:26:15 -0800 (PST)
Message-ID: <b81fb193-d5f4-4b08-bfd8-b28e3253ecf0@linaro.org>
Date: Tue, 14 Nov 2023 16:26:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/31] target/hppa: Remove object_class_is_abstract()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-3-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-3-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 11/14/23 15:55, Gavin Shan wrote:
> No need to check if @oc is abstract because it has been covered
> by cpu_class_by_name().
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/hppa/cpu.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 04de1689d7..fc4d2abad7 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -163,7 +163,6 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
>       ObjectClass *oc = object_class_by_name(typename);
>   
>       if (oc &&
> -        !object_class_is_abstract(oc) &&
>           object_class_dynamic_cast(oc, TYPE_HPPA_CPU)) {
>           return oc;
>       }


