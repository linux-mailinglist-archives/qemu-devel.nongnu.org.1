Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB074CE7D
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlNa-00074G-9A; Mon, 10 Jul 2023 03:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIlNO-0006zc-KW
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIlNJ-0007BC-DA
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688974320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=06/pO/+pWKetwSH9AlRHMEQzFwZ6mKKx1RhtS9u7Q+k=;
 b=LLOkUcnW9bep7xtH5tissbuXWYjnvMlUmqs69GFO1RcpWe1R6BiyIaKHkgf2N/V8GXvw6Q
 6SJTp60fQoyoF7ErhZMTzZxllyw7orJp46soT2rKH10MXGqLcFt/0AB38kEUeg08r/BXG1
 CncbrISV0SkpO0xI7ZoKtilr4WIklGE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-nu1GJt-CPCa_uhySlcDbsw-1; Mon, 10 Jul 2023 03:31:58 -0400
X-MC-Unique: nu1GJt-CPCa_uhySlcDbsw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7673e4eee45so367533785a.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 00:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688974317; x=1691566317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=06/pO/+pWKetwSH9AlRHMEQzFwZ6mKKx1RhtS9u7Q+k=;
 b=BR5/7z/NWBOow49+qMi9cwfyB/VX+JhxojFseZfUFj03vGo3vW7Ti9j7oiFOeMJw2h
 2gnb3mU6JyqyLXulJfNS65SZUZz8SqLeT0HdzkukIzUSeZ2aBfPMu83ByVEfPvFGiDfl
 mCBTaw2i9codWQfDQDiwHzhQQkvHEiahzBdbFHD6dybGXNZsbghy4RTb3BPyT1e5mdpg
 86MA8FJcULI/F7FjWSUCwvPPzL7lWrdTxU6o+Y/gyaQRvNv96xBBfG9tvbacw3A1Kc7B
 W46spJBobWi7aTxPbjGT2IyH8GWAzYGEmztpvZgOmTWhNEK8P8z7+csrzVexEcQU+pgV
 dhoA==
X-Gm-Message-State: ABy/qLav6EryzASxAnX+zy5Jkyh7BuRI/mwOQ1moDD/cMPVKlmsGTsE9
 UMLyx2FKOQEjwpz2v3b19fg9f7XcIxk71l4lxiPJ+BIuPIyyyQl+3NpJa2l3Ml2nF5nk886+5Ex
 v4NNeym0ri6t5+YQ=
X-Received: by 2002:a37:5a02:0:b0:765:35ec:5ff7 with SMTP id
 o2-20020a375a02000000b0076535ec5ff7mr8117336qkb.20.1688974317588; 
 Mon, 10 Jul 2023 00:31:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkJ2cRq5Le07rJVAwgSjvlSPLrwwxLzPdUfsn9k3dYnvTbpeVwLOw2UQFEvx/bZrtxbdKWsQ==
X-Received: by 2002:a37:5a02:0:b0:765:35ec:5ff7 with SMTP id
 o2-20020a375a02000000b0076535ec5ff7mr8117330qkb.20.1688974317365; 
 Mon, 10 Jul 2023 00:31:57 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 g11-20020a05620a13cb00b007676f3859fasm4604316qkl.30.2023.07.10.00.31.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 00:31:56 -0700 (PDT)
Message-ID: <fbb6b6e0-2aec-5be7-7bf7-83c7b0687533@redhat.com>
Date: Mon, 10 Jul 2023 09:31:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tests/tcg/s390x: Fix test-svc with clang
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20230707154242.457706-1-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230707154242.457706-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 07/07/2023 17.42, Ilya Leoshkevich wrote:
> clang does not support expressions involving symbols in instructions
> like lghi yet, so building hello-s390x-asm.S with it fails.
> 
> Move the expression to the literal pool and load it from there.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Fixes: be4a4cb42961 ("tests/tcg/s390x: Test single-stepping SVC")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/gdbstub/test-svc.py | 2 +-
>   tests/tcg/s390x/hello-s390x-asm.S   | 4 +++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/tcg/s390x/gdbstub/test-svc.py b/tests/tcg/s390x/gdbstub/test-svc.py
> index 7851ca72846..18fad3f163d 100644
> --- a/tests/tcg/s390x/gdbstub/test-svc.py
> +++ b/tests/tcg/s390x/gdbstub/test-svc.py
> @@ -25,7 +25,7 @@ def run_test():
>       gdb.execute("si")
>       report("larl\t" in gdb.execute("x/i $pc", False, True), "insn #2")
>       gdb.execute("si")
> -    report("lghi\t" in gdb.execute("x/i $pc", False, True), "insn #3")
> +    report("lgrl\t" in gdb.execute("x/i $pc", False, True), "insn #3")
>       gdb.execute("si")
>       report("svc\t" in gdb.execute("x/i $pc", False, True), "insn #4")
>       gdb.execute("si")
> diff --git a/tests/tcg/s390x/hello-s390x-asm.S b/tests/tcg/s390x/hello-s390x-asm.S
> index 2e9faa16047..4dbda12d35d 100644
> --- a/tests/tcg/s390x/hello-s390x-asm.S
> +++ b/tests/tcg/s390x/hello-s390x-asm.S
> @@ -8,7 +8,7 @@ _start:
>   /* puts("Hello, World!"); */
>   lghi %r2,1
>   larl %r3,foo
> -lghi %r4,foo_end-foo
> +lgrl %r4,foo_len
>   svc 4
>   
>   /* exit(0); */
> @@ -18,3 +18,5 @@ svc 1
>   .align 2
>   foo: .asciz "Hello, World!\n"
>   foo_end:
> +.align 8
> +foo_len: .quad foo_end-foo

Thanks, that seems to work! Queued now.

Tested-by: Thomas Huth <thuth@redhat.com>


