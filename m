Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB67E34B2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 05:50:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0E1X-0004Tv-1J; Mon, 06 Nov 2023 23:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0E1V-0004TY-Fo
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 23:49:09 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0E1T-0002Nn-Nr
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 23:49:09 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6ce2ea3a944so3201627a34.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 20:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699332546; x=1699937346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SIfr4tIbqy8m9pmMM5ucsH+pdFhHcUkDtfNe9fUDd8c=;
 b=QfYzQctvpu06VhU165eb1X7f3oaLqM/2WNiJ6W4iTdaPfpsjJZREIMrDH5L8CryoqB
 nyjd1IJmysr0Q6BqYPbt3AoW+5fXGTAgFEfitLvuDBbLtEnCS+fSgMYNdvxVAPB7uKhT
 cYoB87s+QH7T2nGqEYuMd46M46I5OKP6tb5MV7sWrA6GDmChQ53nYP0UlpRrAmz3lVPu
 rQWMKHKQAie96Uzeds/FOGB5HVDAf1q8BktGZIyXJTSLw+bBXVZZlCndfbV9Yc/dm6Tz
 Gs9Qc0hHFQTEUcAX0r4uLLE++XjdT3hUmGP0Sl2VCeB2OaPW7IdO13Rx439S31TXgyW5
 MaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699332546; x=1699937346;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SIfr4tIbqy8m9pmMM5ucsH+pdFhHcUkDtfNe9fUDd8c=;
 b=vXA9BZ/YjhGboSvvoqa0qVJbEKFmA0FRKSXjngw0UelbSWsHmxszgH10jYSPZ/1cO0
 80Q3Lxtr3h3q6W7s59sBBuurQ/Jc5bF8F0rqnmUEX3WwN+9MFzhNKIC0R/3WGJQuloSd
 0QSiA+l36L1NEitrTcR+1l9oYH3b8VtQVhFoTn6jvwJo7iStSMBAmysQxoFuUk5Tczzq
 aNDXbUWLszrSZ+j2vMuv/y4fU6LiH3A+yTgZK+ggiVPaM7pGzRYNfy5usQQRIDW9SK53
 ukTF8M04rK69Jf4xMbtfiKQ6HPwABivIpgqAnkUvkBzSDPL0KD2UAli5UH3+fh3dGFak
 vGag==
X-Gm-Message-State: AOJu0YwTtkM5j7M0pym7yWLiQCQ07/lx9ydXs/nY3hClB/EV+PzIPBea
 Kgx5IrniZKcq5YNCkTc5MGjvFg==
X-Google-Smtp-Source: AGHT+IFyUd10QymK9+HUBLqPa0qZNAYqcs+d6WaFxVADmO9XbfbSmrKCMVqtKg8SVCuGAeirdiTu5g==
X-Received: by 2002:a05:6870:5ba4:b0:1d5:91d6:65f3 with SMTP id
 em36-20020a0568705ba400b001d591d665f3mr2112666oab.7.1699332545877; 
 Mon, 06 Nov 2023 20:49:05 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 k125-20020a632483000000b005bd3f34b10dsm548809pgk.24.2023.11.06.20.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 20:49:05 -0800 (PST)
Message-ID: <058ad3c3-7e84-4aab-99b2-6b31d2688ff2@linaro.org>
Date: Mon, 6 Nov 2023 20:49:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 81/94] target/sparc: Move FDMULQ to decodetree
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
 <20231026001542.1141412-111-richard.henderson@linaro.org>
 <8abcfb1b-6fdd-4d74-a75e-419b89a093ca@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8abcfb1b-6fdd-4d74-a75e-419b89a093ca@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/6/23 14:02, Mark Cave-Ayland wrote:
> I was working through my SPARC boot tests for your latest target/sparc series when I 
> spotted a segfault on my FreeBSD SPARC64 image. A git bisect indicated that this was the 
> patch that originally introduced the error, something I must have missed when testing the 
> original decodetree conversion series.
> 
> The reproducer is:
> 
> ./qemu-system-sparc64 -m 256 -cdrom FreeBSD-10.3-RELEASE-sparc64-bootonly.iso \
>      -boot d -nographic
> 
> and the error is a segfault in devd:
> 
> ...
> ...
> Trying to mount root from cd9660:/dev/iso9660/10_3_RELEASE_SPARC64_BO [ro]...
> Entropy harvesting: interrupts ethernet point_to_point swi.
> Starting file system checks:
> Mounting local file systems:.
> Writing entropy file:.
> /etc/rc: WARNING: $hostname is not set -- see rc.conf(5).
> Starting Network: lo0 hme0.
> lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> metric 0 mtu 16384
>          options=600003<RXCSUM,TXCSUM,RXCSUM_IPV6,TXCSUM_IPV6>
>          inet6 ::1 prefixlen 128
>          inet6 fe80::1%lo0 prefixlen 64 scopeid 0x2
>          inet 127.0.0.1 netmask 0xff000000
>          nd6 options=21<PERFORMNUD,AUTO_LINKLOCAL>
> hme0: flags=8802<BROADCAST,SIMPLEX,MULTICAST> metric 0 mtu 1500
>          options=8000b<RXCSUM,TXCSUM,VLAN_MTU,LINKSTATE>
>          ether 52:54:00:12:34:56
>          nd6 options=29<PERFORMNUD,IFDISABLED,AUTO_LINKLOCAL>
>          media: Ethernet autoselect
> Starting devd.
> pid 246 (ps), uid 0: exited on signal 11
> Segmentation fault
> ^^^^^^^^^^^^^^^^^^


I certainly can't imagine that FdMULq is really at fault, because it's not implemented on 
real hardware (and thus I really doubt FreeBSD attempted to use it), and 
CPU_FEATURE_FLOAT128 is not enabled by your command-line.

The only thing that I can imagine is that this is some sort of timing related issue and 
bisect behaved randomly.

All that said, I can't replicate this with master.
Can you, now?


r~

