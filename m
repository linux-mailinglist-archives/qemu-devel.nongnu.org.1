Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB4F7DCEC5
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:08:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpOt-0005x3-5t; Tue, 31 Oct 2023 10:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxpOc-0005ha-W4
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:07:09 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxpOb-00035b-Dq
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:07:06 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-507ad511315so8273851e87.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698761223; x=1699366023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IRHPEf47e1nUKxNgIx4Jcx6baFb0037Yq2LfroWRkVo=;
 b=XbBo5tp2j/ySciYdlmcRwWpOFeO/K7YBZerSIXiF79UeopV6dnod7NtvC+g2Rutj8h
 5A2F9IWBfmgeByrHtMURomUcwjA+Y6ZgS/HvSqz9pZXgA7B6WPT0xLbo0x0gYQjyPkBb
 mPuOeY2yuLjp0e3fVaKwAXFc3ZLtFuBHgCT4A/4EY8Slx/FABXnNkHfY67Ld5v45Er+7
 bTaR+IygVJz95XwKIc2t/YMh1oR6M2FJsMfoVjq8/bndoiQzAY593DZlRwBDiU0PVHbk
 opKBrhbB2KQxi7Vv5qC6mwD5ebAWxrTsoPacKwxhq72RMgYjP/T++WvVO89w2X1oKlOT
 AUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698761223; x=1699366023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IRHPEf47e1nUKxNgIx4Jcx6baFb0037Yq2LfroWRkVo=;
 b=nBbMl/5mMCldP+1HT9dPo0wcUacq5JGxPCEf1cAiy+Awfbky2R0Fyo0gg2sCN2AHEO
 v6zqiOw4tbHmIDfYwBWBVoUGtMJTP35zUnJE8z7U0dG/8Bu4R3KmHjLQHg30SUiSVPLN
 LlcxzM7bH9rr5MXDqqYZb+xc/M8YyAcdrj2JKNSvixilJd7w3tWTA8VneTTgCLVYFeah
 YMH/xVWs1KVnyk62tEiLvysMF3CuPnjS/C0l93nCQA5jggt501vK97zq5cEBqiTSPeZJ
 w1vpuvrRKTp03c/qyNfltCfZkv/QCjSugsG0Dlx/vKv+GDD6BnWvYng/BxsAvX3g765m
 ZQuw==
X-Gm-Message-State: AOJu0YwV7HMuhEOd+um/pfPeBjO4YmFF3lFtFCPXMSk9M4+i06ur2OC/
 /ZwHu7tgQ9ysGPE/4cpWtDwHAQ==
X-Google-Smtp-Source: AGHT+IFlhd90p9utMfkP8E5MEraUQWlJmiZ/oL66U7bQzvN5Gw4R+9cZcrSI6Ouv9QWCdP+T5QHJzg==
X-Received: by 2002:ac2:4c83:0:b0:500:b553:c09e with SMTP id
 d3-20020ac24c83000000b00500b553c09emr8586223lfl.32.1698761223619; 
 Tue, 31 Oct 2023 07:07:03 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 l26-20020a05600c1d1a00b003fef5e76f2csm1237435wms.0.2023.10.31.07.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 07:07:03 -0700 (PDT)
Message-ID: <d2c8e554-3bdf-e89d-c579-c9a432e8e08f@linaro.org>
Date: Tue, 31 Oct 2023 15:07:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 7/7] target/i386/cpu: Improve error message for property
 "vendor"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, dave@treblig.org,
 jasowang@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 mst@redhat.com, david@redhat.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
References: <20231031111059.3407803-1-armbru@redhat.com>
 <20231031111059.3407803-8-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231031111059.3407803-8-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.053,
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

On 31/10/23 12:10, Markus Armbruster wrote:
> Improve
> 
>      $ qemu-system-x86_64 -device max-x86_64-cpu,vendor=me
>      qemu-system-x86_64: -device max-x86_64-cpu,vendor=me: Property '.vendor' doesn't take value 'me'
> 
> to
> 
>      qemu-system-x86_64: -device max-x86_64-cpu,vendor=0123456789abc: value of property 'vendor' must consist of excactly 12 characters
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   target/i386/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index fc8484cb5e..e708628c16 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5192,7 +5192,8 @@ static void x86_cpuid_set_vendor(Object *obj, const char *value,
>       int i;
>   
>       if (strlen(value) != CPUID_VENDOR_SZ) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_BAD, "", "vendor", value);
> +        error_setg(errp, "value of property 'vendor' must consist of"
> +                   " excactly " stringify(CPUID_VENDOR_SZ) " characters");

Typo "exactly" (and in example), otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           return;
>       }
>   


