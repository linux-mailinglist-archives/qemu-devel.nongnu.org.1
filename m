Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DFA79FD61
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:42:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qggzQ-0007Gt-TN; Thu, 14 Sep 2023 03:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qggzN-00079Z-O3
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:42:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qggzL-0007IW-Go
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:42:13 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68fb2e9ebcdso484588b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694677330; x=1695282130;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6EU5+9YYyaVWi9hzEkNcZDNpLIKBvSPYj/acx/fpp38=;
 b=u06DnSJSBAHAO2qvIOEoM+F3uGuca2ydsAOyv3nW3U1fMd0UrEQOZUMn/uhNqlMvGq
 VsVHPIX1Iar+EgcfPuc1tajKNFMyEvYMLFF1p21U0YM164eBqN2mVDtbefgqAn3T+iBa
 YuVGrNjjLiOpt7tGLePrjnZ3pCQnAmr1Q825NxVr1GJLt4RTMEVNMLQB5jq5Hec9SXt8
 tepI4Yl5aOFfUsLxADzlkT0H4Duyn/uQR/9U1k7JO9qMj/ibGJhX8GYUNPQCBuUja0sj
 farYagntz8IpV2FEDGexMhEfmEm+F8jNR1Jv99VFlfFeCNtJ5zkV9MYe+90c0JSpv+uT
 6HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694677330; x=1695282130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6EU5+9YYyaVWi9hzEkNcZDNpLIKBvSPYj/acx/fpp38=;
 b=FiDkPV98/r2ZRZk0KsUaFFdY9A4p4jsESXGQaHuafFeq/BSyg0+gYRBBuaykSL9wpF
 t1anylBFnSXecx3tyD4aYCGa1bLBKFrZalKKG/CMKQgYKcLAShCoRdeel8CPS3+YqefH
 9/22uxt93fUVrjcDT4ELcRk+od5/3LZBhh2KnxB/azc0jSsI+MTO1JNcksBQl4sjS62x
 Q4HRl1sDFDiKeM0dmnZSyzQgDaI1fwQ0i5SgCAtl+64/9At9Qmc4YpDk2Z+OwuY0el8R
 j7exUr02JlcpkCGqgroB9QxY7wVfRcCb6diJL8QaHPLo3c70mT6w2p9riYRvuZMdqPM6
 +gaw==
X-Gm-Message-State: AOJu0YyQw7pcnyjG6mcPzRFxu/SYkOfR6ZfA9KgQIE/tfplwJQCdoHbJ
 vXma7/JsdjoHGhK0M7tMhXhweQ==
X-Google-Smtp-Source: AGHT+IEQr/OUkQvHm0Lxp0OdxZZ9R5eKjAJGFZ1pp89qTpIWNU8wuBcPrHdyqpM5NxemAsGRBD7svw==
X-Received: by 2002:a05:6a21:1f03:b0:14c:def0:db07 with SMTP id
 ry3-20020a056a211f0300b0014cdef0db07mr3500128pzb.34.1694677330015; 
 Thu, 14 Sep 2023 00:42:10 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 ix6-20020a170902f80600b001b86e17ecacsm872975plb.131.2023.09.14.00.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 00:42:09 -0700 (PDT)
Message-ID: <ed707975-71bc-4690-a463-2e461dedcba1@daynix.com>
Date: Thu, 14 Sep 2023 16:42:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] elf2dmp: use Linux mmap with MAP_NORESERVE when
 possible
Content-Language: en-US
To: Viktor Prutyanov <viktor@daynix.com>, annie.li@oracle.com,
 kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 viktor.prutyanov@phystech.edu
References: <20230913224657.11606-1-viktor@daynix.com>
 <20230913224657.11606-5-viktor@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230913224657.11606-5-viktor@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/09/14 7:46, Viktor Prutyanov wrote:
> Glib's g_mapped_file_new maps file with PROT_READ|PROT_WRITE and
> MAP_PRIVATE. This leads to premature physical memory allocation of dump
> file size on Linux hosts and may fail. On Linux, mapping the file with
> MAP_NORESERVE limits the allocation by available memory.
> 
> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> ---
>   contrib/elf2dmp/qemu_elf.c | 66 +++++++++++++++++++++++++++++++-------
>   contrib/elf2dmp/qemu_elf.h |  4 +++
>   2 files changed, 58 insertions(+), 12 deletions(-)
> 
> diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
> index ebda60dcb8..94a8c3ad15 100644
> --- a/contrib/elf2dmp/qemu_elf.c
> +++ b/contrib/elf2dmp/qemu_elf.c
> @@ -165,10 +165,37 @@ static bool check_ehdr(QEMU_Elf *qe)
>       return true;
>   }
>   
> -int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
> +static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
>   {
> +#ifdef CONFIG_LINUX

Here CONFIG_LINUX is used while qemu_elf.h uses CONFIG_POSIX.
I also wonder if GLib implementation is really necessary.

> +    struct stat st;
> +
> +    printf("Using Linux's mmap\n");
> +
> +    qe->fd = open(filename, O_RDONLY, 0);
> +    if (qe->fd == -1) {
> +        eprintf("Failed to open ELF dump file \'%s\'\n", filename);
> +        return 1;
> +    }
> +
> +    if (fstat(qe->fd, &st)) {
> +        eprintf("Failed to get size of ELF dump file\n");
> +        close(qe->fd);
> +        return 1;
> +    }
> +    qe->size = st.st_size;
> +
> +    qe->map = mmap(NULL, qe->size, PROT_READ | PROT_WRITE,
> +            MAP_PRIVATE | MAP_NORESERVE, qe->fd, 0);

It should be possible to close the file immediately after mmap().

