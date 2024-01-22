Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 919108364F4
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 15:03:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRusD-0003ZC-1B; Mon, 22 Jan 2024 09:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRus9-0003Yt-Hb
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:01:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRus7-00063R-HC
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705932113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=byDAG06xxyn2HzqTNWebayGFRrQQuxt/kQVXB92vpeg=;
 b=cwh3g9DQFaaGzHNMEXF6SGbw86xW1TY/YYbYwu47mFp9JJfMWLhmOo/6s/J9VngH9kxZ2O
 mlKWiU8uDPxRDBAXQAV0jXefIl442nk42npYOGDl54lCPX772+M04J5+N/GVDZ0srbqz/j
 1gmmSbZsEuP1qUAEoWTCtvGMRAfDNDI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-sPabpgwBN5GUvxyqlqIMbA-1; Mon, 22 Jan 2024 09:01:52 -0500
X-MC-Unique: sPabpgwBN5GUvxyqlqIMbA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-783350c4584so631089885a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 06:01:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705932111; x=1706536911;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=byDAG06xxyn2HzqTNWebayGFRrQQuxt/kQVXB92vpeg=;
 b=Ee10vx8JRNV2rVXQ52rugTiCqqaTdkKcNELDuHLLj86TOHPBKi5LvA/SzCx//3x4j6
 pNYKwuF0A2+GwcP6GSvewKXl2/gmGph3tT86zIAGxeek9iA8N3QwmCglQsv1bWdjP4W8
 yYRrduPtKYpYp6Pn3r8gX5dyrHNk2JKExMl0doml/cg37XHFlEfRe5mjubMrgWiRBIOP
 UC68qYi++30JHgBoTAONwIErvWvhsglFaojr8LilsJVoEXKbGbFsNx/jgDjTdsTQhLap
 jYT3YCdw4zqhg+Ql9YYy5zejkjy5joU6nYg+jKveAgsZ5BB3qnasvw6ony8KECakIPTP
 7z+A==
X-Gm-Message-State: AOJu0YxrOPV7/B1f31dgjZq6PvxzU2DA7/wCw49V3w943RTn4zIkE2xj
 qYXhI6p1u5kbqImR8kjp5AmXiN27K0RNMfYnWBFwJTdhJnblFkwjHvfhz2HlnThSu2Bio0wDsW7
 06h9czO0QPyV+1ROXOTrhcPnPHGjRH/NE+YYtPtneqeYX/AHYwXvdoScyMWNf
X-Received: by 2002:a05:620a:24c1:b0:783:25d4:621b with SMTP id
 m1-20020a05620a24c100b0078325d4621bmr6923543qkn.80.1705932111434; 
 Mon, 22 Jan 2024 06:01:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcHxAivX0v5Ve7MDdgwg4eF4l76CMekCB8aCoBlSxmcr0u2jlyx/aqwmiaz5CFsRE+mtpj0w==
X-Received: by 2002:a05:620a:24c1:b0:783:25d4:621b with SMTP id
 m1-20020a05620a24c100b0078325d4621bmr6923529qkn.80.1705932111140; 
 Mon, 22 Jan 2024 06:01:51 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-227.web.vodafone.de.
 [109.43.179.227]) by smtp.gmail.com with ESMTPSA id
 vy24-20020a05620a491800b0078358c123f8sm2135347qkn.109.2024.01.22.06.01.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 06:01:50 -0800 (PST)
Message-ID: <e16dbe80-a574-41e1-977f-a7763828e779@redhat.com>
Date: Mon, 22 Jan 2024 15:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xtensa: require libfdt
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240122094230.283653-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240122094230.283653-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22/01/2024 10.42, Paolo Bonzini wrote:
> Always allow -dtb in qemu-system-xtensa.  Basically all other targets require
> it if it can be used (including for example i386/x86_64).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/targets/xtensa-softmmu.mak   | 1 +
>   configs/targets/xtensaeb-softmmu.mak | 1 +
>   hw/xtensa/xtfpga.c                   | 9 ---------
>   3 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/configs/targets/xtensa-softmmu.mak b/configs/targets/xtensa-softmmu.mak
> index f075557bfa9..c394df73034 100644
> --- a/configs/targets/xtensa-softmmu.mak
> +++ b/configs/targets/xtensa-softmmu.mak
> @@ -1,2 +1,3 @@
>   TARGET_ARCH=xtensa
>   TARGET_SUPPORTS_MTTCG=y
> +TARGET_NEED_FDT=y
> diff --git a/configs/targets/xtensaeb-softmmu.mak b/configs/targets/xtensaeb-softmmu.mak
> index b02e11b8200..517b4c3e12d 100644
> --- a/configs/targets/xtensaeb-softmmu.mak
> +++ b/configs/targets/xtensaeb-softmmu.mak
> @@ -1,3 +1,4 @@
>   TARGET_ARCH=xtensa
>   TARGET_BIG_ENDIAN=y
>   TARGET_SUPPORTS_MTTCG=y
> +TARGET_NEED_FDT=y
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index fbad1c83a3f..3c93cfffbaa 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -357,7 +357,6 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
>               cur_tagptr = put_tag(cur_tagptr, BP_TAG_COMMAND_LINE,
>                                    strlen(kernel_cmdline) + 1, kernel_cmdline);
>           }
> -#ifdef CONFIG_FDT
>           if (dtb_filename) {
>               int fdt_size;
>               void *fdt = load_device_tree(dtb_filename, &fdt_size);
> @@ -374,14 +373,6 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
>               cur_lowmem = QEMU_ALIGN_UP(cur_lowmem + fdt_size, 4 * KiB);
>               g_free(fdt);
>           }
> -#else
> -        if (dtb_filename) {
> -            error_report("could not load DTB '%s': "
> -                         "FDT support is not configured in QEMU",
> -                         dtb_filename);
> -            exit(EXIT_FAILURE);
> -        }
> -#endif

Agreed, we should do this the same way on all architectures.

Reviewed-by: Thomas Huth <thuth@redhat.com>



