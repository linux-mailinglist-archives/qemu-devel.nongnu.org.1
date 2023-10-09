Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 608257BD46B
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:36:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpknt-000359-Ku; Mon, 09 Oct 2023 03:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpknl-000337-M1
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpkne-0006dS-Pa
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696836932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9GZQbn4wiCqBlo4fHt4z40bLhUg9xnSJ4Arfaca7WM=;
 b=V6Phf3nARKkid6AVdPE0qKXnB8/rGjc2F/E+2Tq97GxbqG1JaIb9QoA/EU2eXnj3id2TGE
 G9OmkRlO+W/7wYckoOig5XLo70TAFaRlvwfeOBRNYHSDfe6brKOJ/ckkhka/XKYP1cVddT
 Yq7n3fNV1zuD220MNroorfyARVuQhiU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-i_Ew935FOnagpjwAPqockg-1; Mon, 09 Oct 2023 03:35:30 -0400
X-MC-Unique: i_Ew935FOnagpjwAPqockg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-59bdb9fe821so76712367b3.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 00:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696836929; x=1697441729;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w9GZQbn4wiCqBlo4fHt4z40bLhUg9xnSJ4Arfaca7WM=;
 b=grpHrrjQYrfRyiuOHqjGHFmgsEYuR9s9G/yweZGhcTaGpPh5sSOAluZyt7sQ6diCvL
 VYinv7Ilp/2VpSBQML/wBJoxEzwne7+1WVopqxYCezS1/vkysPwNJ0TWFm2BPiHQJRA0
 SyL5JMufqxWTZK1akhy3cBYafeZdsfAC3PMq0uptX55C1O6fG48B0Y1rmFiyT7KEcTlW
 DDQEzfF8299hfomBrYwufFRbAs3G1lLE9LkmUfz9hkyI0LknBMe1qTcXWMdXUTjmbbEm
 dH9m1eszaYGD4vkervxayQ1WDf3Y+L/aeyPce+mLna542VvnBaEzmb626AS+fCqlkdJV
 DbiQ==
X-Gm-Message-State: AOJu0Yxoul4OyiqXaVgNVZ97czPMhLusqHKSXvyus9pzOklO/+NHr+cp
 SphzD2Dntil7cBCOocDh6X6LOCbp0hDrHSC1I6BZKaVpmfLo6BFoa4zHOUfvLhnefT/PGX0y7zG
 VqjMvRNY1Qg8tjJM=
X-Received: by 2002:a25:cad7:0:b0:d5d:4df9:b6e2 with SMTP id
 a206-20020a25cad7000000b00d5d4df9b6e2mr12685818ybg.46.1696836929734; 
 Mon, 09 Oct 2023 00:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoJ7kLDoAIAcKTOIYBWOTVaqsM9lwUUzdxiLAqy64GXvs6b+iQdBVFsvDhmltAgoZYaJEt+A==
X-Received: by 2002:a25:cad7:0:b0:d5d:4df9:b6e2 with SMTP id
 a206-20020a25cad7000000b00d5d4df9b6e2mr12685808ybg.46.1696836929374; 
 Mon, 09 Oct 2023 00:35:29 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 a13-20020a0ce34d000000b006516780a0a5sm3594362qvm.117.2023.10.09.00.35.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 00:35:29 -0700 (PDT)
Message-ID: <a14b0213-5908-a788-125f-8d360bed20a3@redhat.com>
Date: Mon, 9 Oct 2023 09:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] meson: mitigate against ROP exploits with
 -fzero-call-used-regs
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20231005173812.966264-1-berrange@redhat.com>
 <20231005173812.966264-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231005173812.966264-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 05/10/2023 19.38, Daniel P. Berrangé wrote:
> To quote wikipedia:
> 
>    "Return-oriented programming (ROP) is a computer security exploit
>     technique that allows an attacker to execute code in the presence
>     of security defenses such as executable space protection and code
>     signing.
> 
>     In this technique, an attacker gains control of the call stack to
>     hijack program control flow and then executes carefully chosen
>     machine instruction sequences that are already present in the
>     machine's memory, called "gadgets". Each gadget typically ends in
>     a return instruction and is located in a subroutine within the
>     existing program and/or shared library code. Chained together,
>     these gadgets allow an attacker to perform arbitrary operations
>     on a machine employing defenses that thwart simpler attacks."
> 
> QEMU is by no means perfect with an ever growing set of CVEs from
> flawed hardware device emulation, which could potentially be
> exploited using ROP techniques.
> 
> Since GCC 11 there has been a compiler option that can mitigate
> against this exploit technique:
> 
>      -fzero-call-user-regs
> 
> To understand it refer to these two resources:
> 
>     https://www.jerkeby.se/newsletter/posts/rop-reduction-zero-call-user-regs/
>     https://gcc.gnu.org/pipermail/gcc-patches/2020-August/552262.html
> 
> I used two programs to scan qemu-system-x86_64 for ROP gadgets:
> 
>    https://github.com/0vercl0k/rp
>    https://github.com/JonathanSalwan/ROPgadget
> 
> When asked to find 8 byte gadgets, the 'rp' tool reports:
> 
>    A total of 440278 gadgets found.
>    You decided to keep only the unique ones, 156143 unique gadgets found.
> 
> While the ROPgadget tool reports:
> 
>    Unique gadgets found: 353122
> 
> With the --ropchain argument, the latter attempts to use the found
> gadgets to product a chain that can execute arbitrary syscalls. With
> current QEMU it succeeds in this task, which is an undesirable
> situation.
> 
> With QEMU modified to use -fzero-call-user-regs=used-gpr the 'rp' tool
> reports
> 
>    A total of 528991 gadgets found.
>    You decided to keep only the unique ones, 121128 unique gadgets found.
> 
> This is 22% fewer unique gadgets
> 
> While the ROPgadget tool reports:
> 
>    Unique gadgets found: 328605
> 
> This is 7% fewer unique gadgets. Crucially though, despite this more
> modest reduction, the ROPgadget tool is no longer able to identify a
> chain of gadgets for executing arbitrary syscalls. It fails at the
> very first step, unable to find gadgets for populating registers for
> a future syscall. Having said that, more advanced tools do still
> manage to put together a viable ROP chain.
> 
> Also this only takes into account QEMU code. QEMU links to many 3rd
> party shared libraries and ideally all of them would be compiled with
> this same hardening. That becomes a distro policy question though.
> 
> In terms of performance impact, TCG was used as an evaluation test
> case. We're not interested in protecting TCG since it isn't designed
> to provide a security barrier, but it is performance sensitive code,
> so useful as a guide to how other areas of QEMU might be impacted.
> With the -fzero-call-user-regs=used-gpr argument present, using the
> real world test of booting a linux kernel and having init immediately
> poweroff, there is a ~1% slow down in performance under TCG. The QEMU
> binary size also grows by approximately 1%.
> 
> By comparison, using the more aggressive -fzero-call-user-regs=all,
> results in a slowdown of over 25% in TCG, which is clearly not an
> acceptable impact, and a binary size increase of 5%.
> 
> Considering that 'used-gpr' succesfully stopped ROPgadget assembling
> a chain, this more targetted protection is a justifiable hardening
> / performance tradeoff.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   meson.build | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 20ceeb8158..2003ca1ba4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -435,6 +435,17 @@ if get_option('fuzzing')
>     endif
>   endif
>   
> +# Check further flags that make QEMU more robust against malicious parties
> +
> +hardening_flags = [
> +    # Zero out registers used during a function call
> +    # upon its return. This makes it harder to assemble
> +    # ROP gadgets into something usable
> +    '-fzero-call-used-regs=used-gpr',
> +]
> +
> +qemu_common_flags += cc.get_supported_arguments(hardening_flags)

Linux kernel uses the same flag and talks about similar performance costs:

  https://github.com/torvalds/linux/commit/a82adfd5c7cb4b

So I think this should be fine fine to be used in QEMU, too.

Reviewed-by: Thomas Huth <thuth@redhat.com>


