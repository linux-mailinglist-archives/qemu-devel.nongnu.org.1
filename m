Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C396F7AD751
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 13:58:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkkD5-0000nT-T9; Mon, 25 Sep 2023 07:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkkD3-0000nG-F4
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkkD1-0007Oq-UG
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695643021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwasxZRU9w+5CWpygaO0yzFMZAWGC2+AXa3TX6Vxlt8=;
 b=W+FRMLTBrvCvVZEQ6rRFUUBEI0++f0g4Zkni5Qs6Fx+6Xx8msxJD8rc34MZ5kJIEwwMl/+
 xxZ1CrYHTyEjpnpr6sHFYaGRph2KD8GeUMAO2APMW01XndFISUCvQNLifA3sCE92cGzAKN
 BdCQyqKcGbhKZGsCgX6zrm5qjvdIDNY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-09Ew0nBZOqmg3fWFGKe9IA-1; Mon, 25 Sep 2023 07:57:00 -0400
X-MC-Unique: 09Ew0nBZOqmg3fWFGKe9IA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401b8089339so56782705e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 04:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695643019; x=1696247819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cwasxZRU9w+5CWpygaO0yzFMZAWGC2+AXa3TX6Vxlt8=;
 b=awfVWmoZ2I3uwD/qvzwTgNmZuAaPGA3kJaagzwz70WebZlKQJq3ccPXltQ9sIuHG7L
 f316+4Nhvjewb+G35v6HD5XVCX/lKVYSthig4/8+Vn36eWDI+TkCPNHuMVZB0tMbhM9I
 oaCxmqP7PyjfeKjq5bEFFShfZWRPXW01js+S0FnAXHmgBvmGBSqb5MIx9NwyWvAOPDLF
 ol6r3W1WR5TX8VzIWXVjaRwFoCc/edx8P7+dKln28QB53T70pnsIUTl6MQC5v/SYRmjm
 hIEaK2R4PvmAYRuwq55fdM8Lxe8QOGKyO/WB+LDjFxdtx8Cc3IiCb3oiZMw+cKS6JCDN
 1pzA==
X-Gm-Message-State: AOJu0YzV0nvapjNZP1FsC58sNDgx5+1ZocyaiQBq0xKs3E5Ei6PmpoRw
 YFIOTPRD3VI7PBInQHpgo+AUU6enK8m9XmRGrKTvn5ftexYthyp0RBmbHvm5hNmCz4zrg9+ZLNa
 jZ90QnyUSv0K/3ZI=
X-Received: by 2002:a1c:7904:0:b0:3fe:dc99:56ea with SMTP id
 l4-20020a1c7904000000b003fedc9956eamr5896491wme.19.1695643019046; 
 Mon, 25 Sep 2023 04:56:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfWcW2XO23rmSWxZP6Kp0UrlkVBrKx2TKvXJPz6RmzS8ur8BmZqfpQ9kmN1GjRrphsWq4vdw==
X-Received: by 2002:a1c:7904:0:b0:3fe:dc99:56ea with SMTP id
 l4-20020a1c7904000000b003fedc9956eamr5896473wme.19.1695643018663; 
 Mon, 25 Sep 2023 04:56:58 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-48.web.vodafone.de.
 [109.43.176.48]) by smtp.gmail.com with ESMTPSA id
 i19-20020a05600c2d9300b004054dcbf92asm7186519wmg.20.2023.09.25.04.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Sep 2023 04:56:58 -0700 (PDT)
Message-ID: <89ca9ab0-936c-c08e-ae61-a23297c158ed@redhat.com>
Date: Mon, 25 Sep 2023 13:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] win32: avoid discarding the exception handler
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>
References: <20230925113942.267924-1-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230925113942.267924-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 25/09/2023 13.39, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> In all likelihood, the compiler with lto doesn't see the function being
> used, from assembly macro __try1. Help it by marking the function has
> being used.
> 
> Fixes:

I'd suggest to use "Resolves:" for bug tickets so that they get auto-closed 
when the patch is merged.

> https://gitlab.com/qemu-project/qemu/-/issues/1904
> 
> Fixes: commit d89f30b4df ("win32: wrap socket close() with an exception handler")
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/qemu/compiler.h | 6 ++++++
>   util/oslib-win32.c      | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index a309f90c76..5c7f63f351 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -197,4 +197,10 @@
>   #define BUILTIN_SUBCLL_BROKEN
>   #endif
>   
> +#if __has_attribute(used)
> +# define QEMU_USED __attribute__((used))
> +#else
> +# define QEMU_USED
> +#endif

I first thought we could maybe do it without the detour via the QEMU_USED 
macro, but seems like Clang just learnt this attribute with version 13:

  https://releases.llvm.org/12.0.0/tools/clang/docs/AttributeReference.html
  https://releases.llvm.org/13.0.0/tools/clang/docs/AttributeReference.html

(while GCC already has it in version 7).

So yes, this seems the right way to do this.

Reviewed-by: Thomas Huth <thuth@redhat.com>


