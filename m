Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD02A7B4B97
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnCfM-0002Qf-1j; Mon, 02 Oct 2023 02:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCfJ-0002QN-Ck
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:44:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCfH-0002HP-Gp
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:44:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40535597f01so162764045e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696229058; x=1696833858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ccpleAyicjSReTd2DQFQjo7T/MhV1w3hiWWfwNeFQvQ=;
 b=OK08UXEaUY5P6ie2TJlx/hT+6Lu/eGlLBkyUxiTIp5dKx+WQXa6wF8sczTLaNhD1zU
 0PU7OZObOh+uJuxMLdPWiLER9i4JXLpXRh3xgTllras0FBquAZNMVZ40a7PmQBdcQ9EC
 2OVZBfixk2peChb6VRcYJ/cO3LT+I8+nxeYHaEOimE+bN245RwnV7Y3TkmeDI7IhzSt7
 wEBhsvLrDlSt4TdK9hRIHCxcMfSxnzcuRsQugxukW2ySdwoKlMgnlb/6xAiRsfGbW6w4
 //4D0fJUFQKvUDhFK9c/qcFOjVoDI3UWIAw10mDMZoJYRHDZdZzZXxDlbGSzopAOPqxK
 S/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696229058; x=1696833858;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ccpleAyicjSReTd2DQFQjo7T/MhV1w3hiWWfwNeFQvQ=;
 b=EtMYRf6PfFZAx8vrPCIUOk6U0ue3z7Wx1gJ8RQEsrFEp1pYisnyivKrY8bWxetaDXD
 JZvrQ5IRuiQkJZ7nazl/1lt4ZiXbmPJW/CSBz74/o7WK7OQM+zoVHrhKx20CL/+GAKIt
 RjglHf80Q4fEs/f3oD4Mp7l26WkV40ZnTMeWyz2J2bLmyvsgdVRMfMg22bxed8qLHFJy
 u1YaTtu4hgKui6epCW5tVmeb/BuoAjKUOl8epTojaKAvGbROazWxlPhkBmit8yN7WbDh
 ZsGjolJxPwUEXwpTzwbuuaIdGVjhmFfKiLHWScTp/UFcM9jrPN4a6vvnMdyEn4iV8idE
 wuPw==
X-Gm-Message-State: AOJu0YwV5Xoh3KDW7l1Fu17NcD+WxZIho8STms+WOoM/v3F+w9VDLtWB
 n9Qh042NcbKlHcPrAZiszvmXCrExb90mOYjTC0Y=
X-Google-Smtp-Source: AGHT+IF3JRzabvcHMReum63HbsTMAeIyuoRQ+J0cBn8rcpjkzM9RYPutW/rRd8kMSnJTnFn7NZi2Fw==
X-Received: by 2002:a05:600c:2981:b0:401:daf2:2735 with SMTP id
 r1-20020a05600c298100b00401daf22735mr9070382wmd.31.1696229058172; 
 Sun, 01 Oct 2023 23:44:18 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 n9-20020a7bcbc9000000b004060f0a0fdbsm6540197wmi.41.2023.10.01.23.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 23:44:17 -0700 (PDT)
Message-ID: <fd1e7ed5-bfa1-180d-cf3f-611d3d784230@linaro.org>
Date: Mon, 2 Oct 2023 08:44:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] crypto: only include tls-cipher-suites in emulators
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230928074918.874468-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230928074918.874468-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
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

On 28/9/23 09:49, Paolo Bonzini wrote:
> tls-cipher-suites is an object that is used to inject TLS configuration
> into the guest (via fw_cfg).  It is never used for host-side TLS
> operation, and therefore it need not be available in the tools.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   crypto/meson.build   | 3 ++-
>   hw/nvram/meson.build | 6 +-----
>   2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/crypto/meson.build b/crypto/meson.build
> index 9ac1a898027..c46f9c22a7f 100644
> --- a/crypto/meson.build
> +++ b/crypto/meson.build
> @@ -46,7 +46,8 @@ endif
>   if have_afalg
>     crypto_ss.add(if_true: files('afalg.c', 'cipher-afalg.c', 'hash-afalg.c'))
>   endif
> -crypto_ss.add(when: gnutls, if_true: files('tls-cipher-suites.c'))
> +
> +system_ss.add(when: gnutls, if_true: files('tls-cipher-suites.c'))
>   
>   util_ss.add(files(
>     'aes.c',
> diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
> index 988dff6f8e5..75e415b1a01 100644
> --- a/hw/nvram/meson.build
> +++ b/hw/nvram/meson.build
> @@ -1,8 +1,4 @@
> -if have_system or have_tools
> -  # QOM interfaces must be available anytime QOM is used.
> -  qom_ss.add(files('fw_cfg-interface.c'))
> -endif
> -
> +system_ss.add(files('fw_cfg-interface.c'))

Thanks, Richard mentioned it and I had it tagged as TODO,
but forgot about it...
https://lore.kernel.org/qemu-devel/8c26026f-26b4-08c0-0e77-ca9970dca279@linaro.org/

FTR the original issue was:
https://lore.kernel.org/qemu-devel/20200929154651.GC4398@linux.fritz.box/

$ qemu-storage-daemon --object help
List of user creatable objects:
qemu-storage-daemon: missing interface 'fw_cfg-data-generator' for 
object 'tls-creds'
Aborted (core dumped)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


