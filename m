Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4777DD0C5
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:42:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqsq-0006Op-GF; Tue, 31 Oct 2023 11:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxqsm-0006OW-JA
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:42:20 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxqsk-00043q-Eo
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:42:20 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c5720a321aso75603761fa.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698766936; x=1699371736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R/qIlIFXg7NDwrYty7iNq9lKUhXA7raYHCI5rlRpP54=;
 b=LQbqv7gOcnH1Sptl4L6aCmhgyYtSsqbrt1j+DqpXLMo6EOhEu/zIINqe0WLcPH1Ma+
 yAO3Y3r1eVlzT3P4Xlwbh/wtIqU5F5U5OQQbGVESk5URHqemWuUorUavjuZeckuuRCz1
 g34lO2x/j5niup8UKjNx1+vXgCep1HRngIF49rx3Yh68/FExpLpu6B9F5xgncIKDq3Xt
 aAPiuNIkMPMKfAH9cRCLLfxkpBApuvjgszpNbZMKoxJ63XoZGsM/0R6Aef/MyaG4b+cd
 WU+bwRl2tXMFVHKY3Hof4OJrZbQDWpYjPICvF2nLYK7ZC69xh0E5VFJnbcnR8WyugGCG
 p2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766936; x=1699371736;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R/qIlIFXg7NDwrYty7iNq9lKUhXA7raYHCI5rlRpP54=;
 b=DjjalflOZ3OoQIpTSVN9bWZ6I6CSHkzT/A5M1E2uiAKEeHCoVp+UfUqY8Dm+TIZxkE
 iM6k/f1ulg8wQ5Ke+rW407cbpUH5lf7BobRsynSMdurGfLdIjodEhp5ItTiGJmp0fcqB
 XqAgz0/ubvTABRfxjs2NV9LzZyo6KSltfYu48YTi8ExsWpafkUOtIHMT0Wyv1iMQTdyT
 rIaa6L63jMMD9ld6qNMQ0Okq8A7fbna8ay0dQQ3TtqLpTP30T7nmHAb8SRDgTWCLMMNb
 0J7HxNw/ZW7izOQKWO2KvaowlGmSXvu44R/DDBpFrloPc85ZTagY3f1tAtpu22/MiziD
 TfIg==
X-Gm-Message-State: AOJu0YxqurQa06X6ay1DXumXX9FUBFIYPXkEstl5dbaFnCbtxtAVyVLK
 5Jyhnfl1sFYNl0rolXXltfekYA==
X-Google-Smtp-Source: AGHT+IFkzRAiOMJsVp82unJIA9KNS/NNUjLBxE2juPZFz6BKuREx/BtZyqsihgm1yQUIt4z8QgBv7w==
X-Received: by 2002:a2e:a988:0:b0:2bb:b01a:9226 with SMTP id
 x8-20020a2ea988000000b002bbb01a9226mr12730566ljq.7.1698766936395; 
 Tue, 31 Oct 2023 08:42:16 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 t10-20020a1c770a000000b0040641a9d49bsm2027174wmi.17.2023.10.31.08.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 08:42:16 -0700 (PDT)
Message-ID: <66663c7e-3ab8-ae62-cd55-52c89bcd7733@linaro.org>
Date: Tue, 31 Oct 2023 16:42:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 7/8] docs/specs/vmcoreinfo: Convert to rST
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230927151205.70930-1-peter.maydell@linaro.org>
 <20230927151205.70930-8-peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230927151205.70930-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

On 27/9/23 17:12, Peter Maydell wrote:
> Convert docs/specs/vmcoreinfo.txt to rST format.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                                   |  1 +
>   docs/specs/index.rst                          |  1 +
>   docs/specs/{vmcoreinfo.txt => vmcoreinfo.rst} | 33 ++++++++++---------
>   3 files changed, 19 insertions(+), 16 deletions(-)
>   rename docs/specs/{vmcoreinfo.txt => vmcoreinfo.rst} (50%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9e27cad11c3..23ee617acaf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2805,6 +2805,7 @@ F: include/sysemu/dump.h
>   F: qapi/dump.json
>   F: scripts/dump-guest-memory.py
>   F: stubs/dump.c
> +F: docs/specs/vmcoreinfo.rst

Good :)

Cc'ing Marc-André.

>   Error reporting
>   M: Markus Armbruster <armbru@redhat.com>
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 8d30968650b..7a56ccb2155 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -30,3 +30,4 @@ guest hardware that is specific to QEMU.
>      pvpanic
>      standard-vga
>      virt-ctlr
> +   vmcoreinfo
> diff --git a/docs/specs/vmcoreinfo.txt b/docs/specs/vmcoreinfo.rst
> similarity index 50%
> rename from docs/specs/vmcoreinfo.txt
> rename to docs/specs/vmcoreinfo.rst
> index bcbca6fe47c..462b04474d3 100644
> --- a/docs/specs/vmcoreinfo.txt
> +++ b/docs/specs/vmcoreinfo.rst
> @@ -2,19 +2,19 @@
>   VMCoreInfo device
>   =================
>   
> -The `-device vmcoreinfo` will create a fw_cfg entry for a guest to
> +The ``-device vmcoreinfo`` will create a ``fw_cfg`` entry for a guest to
>   store dump details.
>   
> -etc/vmcoreinfo
> -**************
> +``etc/vmcoreinfo``
> +==================
>   
> -A guest may use this fw_cfg entry to add information details to qemu
> +A guest may use this ``fw_cfg`` entry to add information details to qemu
>   dumps.
>   
>   The entry of 16 bytes has the following layout, in little-endian::
>   
> -#define VMCOREINFO_FORMAT_NONE 0x0
> -#define VMCOREINFO_FORMAT_ELF 0x1
> +    #define VMCOREINFO_FORMAT_NONE 0x0
> +    #define VMCOREINFO_FORMAT_ELF 0x1
>   
>       struct FWCfgVMCoreInfo {
>           uint16_t host_format;  /* formats host supports */
> @@ -26,17 +26,17 @@ The entry of 16 bytes has the following layout, in little-endian::
>   Only full write (of 16 bytes) are considered valid for further
>   processing of entry values.
>   
> -A write of 0 in guest_format will disable further processing of
> +A write of 0 in ``guest_format`` will disable further processing of
>   vmcoreinfo entry values & content.
>   
> -You may write a guest_format that is not supported by the host, in
> +You may write a ``guest_format`` that is not supported by the host, in
>   which case the entry data can be ignored by qemu (but you may still
> -access it through a debugger, via vmcoreinfo_realize::vmcoreinfo_state).
> +access it through a debugger, via ``vmcoreinfo_realize::vmcoreinfo_state``).
>   
>   Format & content
> -****************
> +================
>   
> -As of qemu 2.11, only VMCOREINFO_FORMAT_ELF is supported.
> +As of qemu 2.11, only ``VMCOREINFO_FORMAT_ELF`` is supported.

Maybe s/qemu/QEMU/, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   The entry gives location and size of an ELF note that is appended in
>   qemu dumps.
> @@ -44,10 +44,11 @@ qemu dumps.
>   The note format/class must be of the target bitness and the size must
>   be less than 1Mb.
>   
> -If the ELF note name is "VMCOREINFO", it is expected to be the Linux
> -vmcoreinfo note (see Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
> -in Linux source). In this case, qemu dump code will read the content
> -as a key=value text file, looking for "NUMBER(phys_base)" key
> +If the ELF note name is ``VMCOREINFO``, it is expected to be the Linux
> +vmcoreinfo note (see `the kernel documentation for its format
> +<https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-kernel-vmcoreinfo>`_).
> +In this case, qemu dump code will read the content
> +as a key=value text file, looking for ``NUMBER(phys_base)`` key
>   value. The value is expected to be more accurate than architecture
>   guess of the value. This is useful for KASLR-enabled guest with
> -ancient tools not handling the VMCOREINFO note.
> +ancient tools not handling the ``VMCOREINFO`` note.


