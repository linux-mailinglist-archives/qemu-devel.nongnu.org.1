Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 139C37F95EE
	for <lists+qemu-devel@lfdr.de>; Sun, 26 Nov 2023 23:52:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7NzK-0006CK-53; Sun, 26 Nov 2023 17:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r7NzC-00068j-VJ
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 17:52:25 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r7NzB-0002ri-DY
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 17:52:22 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40b472f98b1so1049045e9.3
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 14:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701039138; x=1701643938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jPNTT6Oy5GZ3Bdh+yH5tUPI/xHbaz9jn+4YGerUhI2c=;
 b=RbMPuUFkk9FJeQIesdHqs0E7W8rFL5z+fMtyTXN6wTvH0dQs3kamHjj+iAZFo0W1Yi
 YFq9qTdmhooMQ/9SjR1RKbfSn82QhRGS7S38Hhz6p3Vk2P0rzK/m1XVfDfDjsuauhsdX
 iTBnmlGGhuw8YicSQxaf1uTrZHRitNjQQo+mUM1rL3dGdzRJ5onKXPGM1BUzvkGHvNJc
 piQYTwDtOb3pPOH/y9sCZg/LEJbiszSgSv3CixbIyKHUhu1vam27BnvrIDvSdLOHQikB
 O4V7ScYY0jBV49XBy5LjE5O1SXZoiq6paZhFAsoJDWrkBrM/hp2xyA52pB3pHVMbSEbO
 39uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701039138; x=1701643938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jPNTT6Oy5GZ3Bdh+yH5tUPI/xHbaz9jn+4YGerUhI2c=;
 b=LtB0DzBLoED/dKbYzn3Aj+7FPiAW/otMP74ntAM0HaTp6/9SAKasRsVQglsibHK7Ih
 8XaQVvzCEgTyjbn97v5D4cxlC03jI6g1e7iGWSctKOwpWBZs0YMUy76nbMKdy8LK7HfX
 No7bVIj5eTVT+ulgY4L7affdvHz5/oNkzD8nNx+/FA7P+2qHX1hzFdNCaK4RezF0ymet
 NAPQJ5OIb8C90y5kRsSgFPey18GGw3D0wWrc0L6re/bELroilGD6LpiNBYQthujDOTAX
 df7EjQhRnKIx6MvvO2q0a7YNTBCXnmaxoDrk28AE5RWdNBtWpyrLMjHqpOR+1uVmuppG
 h9BA==
X-Gm-Message-State: AOJu0Yywax5x0rEglbtJESiZ83LGxEj4ugbsLQMaA01CCoNlB04OwJH/
 DsG8I7+8NKlTYOqI/Tp5khrGz3NBGXk=
X-Google-Smtp-Source: AGHT+IH1zoottKL2tsILoUuQUw6q3xcr9/DScytw+hI4ilPVsWtOhPCGnWFlAJbMBswHZJA39wdOeg==
X-Received: by 2002:a05:600c:524c:b0:40b:3df2:c5e5 with SMTP id
 fc12-20020a05600c524c00b0040b3df2c5e5mr4590101wmb.40.1701039137608; 
 Sun, 26 Nov 2023 14:52:17 -0800 (PST)
Received: from ?IPV6:2001:1ae9:1e8:b200:ae52:b385:81fe:eeab?
 (2001-1ae9-1e8-b200-ae52-b385-81fe-eeab.ip6.tmcz.cz.
 [2001:1ae9:1e8:b200:ae52:b385:81fe:eeab])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c471500b0040a4751efaasm11599922wmo.17.2023.11.26.14.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 14:52:17 -0800 (PST)
Message-ID: <ce5c9d80-28b9-43ff-8315-996929faaa60@gmail.com>
Date: Sun, 26 Nov 2023 23:52:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu/timer: Don't use RDTSC on i486
Content-Language: en-US, cs
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "S. Tsirkin, Michael" <mst@redhat.com>
References: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
 <CABgObfabW_WKdfGFgao0BJ0wHYHRx6KzMsLzvqUvzu3ZMx5Bdw@mail.gmail.com>
From: Petr Cvek <petrcvekcz@gmail.com>
In-Reply-To: <CABgObfabW_WKdfGFgao0BJ0wHYHRx6KzMsLzvqUvzu3ZMx5Bdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=petrcvekcz@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Dne 26. 11. 23 v 16:56 Paolo Bonzini napsal(a):
> 
> 
> Il sab 25 nov 2023, 13:23 Petr Cvek <petrcvekcz@gmail.com <mailto:petrcvekcz@gmail.com>> ha scritto:
> 
>     GCC defines __i386__ for i386 and i486, which both lack RDTSC instruction.
>     The i386 seems to be impossible to distinguish, but i486 can be identified
>     by checking for undefined __i486__.
> 
> 
> As far as I know QEMU cannot be run on i486 anyway since TCG assumes the presence of CPUID. Have you actually tried?
> 

Yes I tried running x86_64 mesa3d glxgears on amd 5x86. It worked with about 5 fps :). Latest 486 CPUs supports CPUID btw.

> Paolo
> 
> 
>     Signed-off-by: Petr Cvek <petrcvekcz@gmail.com <mailto:petrcvekcz@gmail.com>>
>     ---
>      include/qemu/timer.h | 2 +-
>      1 file changed, 1 insertion(+), 1 deletion(-)
> 
>     diff --git a/include/qemu/timer.h b/include/qemu/timer.h
>     index 9a366e551f..7baa5d1d41 100644
>     --- a/include/qemu/timer.h
>     +++ b/include/qemu/timer.h
>     @@ -872,7 +872,7 @@ static inline int64_t cpu_get_host_ticks(void)
>          return retval;
>      }
> 
>     -#elif defined(__i386__)
>     +#elif defined(__i386__) && !defined(__i486__)
> 
>      static inline int64_t cpu_get_host_ticks(void)
>      {
>     -- 
>     2.43.0
> 

