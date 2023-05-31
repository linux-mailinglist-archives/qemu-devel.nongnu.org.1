Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 067EB718525
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Mxi-0003sv-Mg; Wed, 31 May 2023 10:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4Mxf-0003sE-2D
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4MxP-0005ni-N7
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685543866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=brWiXCCbXSq/RX0Y2aPBkPoK0D3XT+XVxIVUSBnGEek=;
 b=EbTgT2xAaItQUOzEa9zkhXVkwADzlHFl4Y080Y3DfB3tTUxugVMMT2B8e7eQRdgau/wd+Q
 dEhYklh+W1EDpVTXuxJppEMPr8AaI2q00mWA23QXJKMtL4/iICorvtkuIV3JDvSiwG24dA
 Mli5Tvl7xFk++KdOpUa0EXomdk0NMpc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-vCKqxOHINrG31yZ4FFlG1w-1; Wed, 31 May 2023 10:37:45 -0400
X-MC-Unique: vCKqxOHINrG31yZ4FFlG1w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f6ffc45209so5347565e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 07:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685543864; x=1688135864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=brWiXCCbXSq/RX0Y2aPBkPoK0D3XT+XVxIVUSBnGEek=;
 b=IPTbTPLLoa3ntRNBHsOrHlI27EXQe0gOQ7IIbDk8TutKszcH2phQPi4u5371H/gyO2
 y8XxScPPS3k+utVDXXs1FpaTWHjvp1Jo0H7f1K5PucFhxMYgDkXSMC0XZrfdXxhyzZTV
 /kEiuyFJr5tOYmyHgOyKCDJRYoMPVbtRyHC9HNQlV4ohdGAA4vOHb5xdb7wohQdt5jsv
 iX8JaFMMe6xiBc7egXkqg6GrpdzZsqpFajvbn3FkBpQ0Zst3BlUBQ7sMgvQJbgzOT57j
 7vzSrr4qYChdK/5/RgPkaWXfyPfS5UtScui5Q7pxrE5/CXWY0Fr1hFJNus0ClnRaizfA
 iAyA==
X-Gm-Message-State: AC+VfDzkZ3TZmdB/Mw5YUN8UPeHTmiKQKEBxMC9VPiKj4akNvHsLzp/0
 AK/V7n6GT92TaMDJxhYzvjasa3lxEAiUCD73dTDPmpa504why2zI039HZ4AaxV4htoTay7Qw+v/
 Aw+nwuPCgMKB5R8ICoJNGozI=
X-Received: by 2002:a05:600c:210e:b0:3f6:1ac:5feb with SMTP id
 u14-20020a05600c210e00b003f601ac5febmr4702824wml.16.1685543863911; 
 Wed, 31 May 2023 07:37:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66iXGKGIekZ9K9j58oHTKV/bwH75q6FT4UTTd6JGz6nz151AuqS9ZCEgdmBjqTF28BGRnMTg==
X-Received: by 2002:a05:600c:210e:b0:3f6:1ac:5feb with SMTP id
 u14-20020a05600c210e00b003f601ac5febmr4702808wml.16.1685543863607; 
 Wed, 31 May 2023 07:37:43 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-4.web.vodafone.de. [109.43.178.4])
 by smtp.gmail.com with ESMTPSA id
 p25-20020a7bcc99000000b003f1751016desm21037708wma.28.2023.05.31.07.37.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 07:37:43 -0700 (PDT)
Message-ID: <d12da5db-da30-b774-1ec7-8e23b9102e62@redhat.com>
Date: Wed, 31 May 2023 16:37:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] linux-user/s390x: Fix single-stepping SVC
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20230510230213.330134-1-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230510230213.330134-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/05/2023 01.02, Ilya Leoshkevich wrote:
> Hi,
> 
> I noticed that single-stepping SVC runs two instructions instead of
> one. The reason is that EXCP_SVC masks EXCP_DEBUG.
> Patch 1 fixes this problem, patch 2 adds a test.
> 
> Btw, there is at least one more problem in that area, namely
> single-stepping instructions that cause e.g. SIGILL. Using the
> existing signals-s390x test as an example:
> 
>      (gdb) x/i $pc
>      => 0x1001740 <illegal_op>:      .long   0x000007fe
> 
>      (gdb) si
>      Program received signal SIGILL, Illegal instruction.
>      (gdb) x/i $pc
>      => 0x1001742 <after_illegal_op>:        br      %r14
>      # So far so good.
> 
>      (gdb) si
>      (gdb) x/i $pc
>      => 0x10017b6 <handle_signal+6>: lay     %r15,-344(%r15)
>      # Missed the first signal handler instruction!
> 
> I'm not sure what to do about it - the trivial fix to add
> gdb_handlesig(cpu, 0) to the end of handle_pending_signal() caused GDB
> to hang, and I haven't looked further yet.
> 
> Best regards,
> Ilya
> 
> Ilya Leoshkevich (2):
>    linux-user/s390x: Fix single-stepping SVC
>    tests/tcg/s390x: Test single-stepping SVC

If there are no disagreements, I can take this through my s390x tree. Queued 
it for my next pull request now.

  Thomas



