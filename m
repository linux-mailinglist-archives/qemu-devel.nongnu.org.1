Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F297263A2
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:03:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ugF-0007sq-PQ; Wed, 07 Jun 2023 11:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6ugC-0007rx-Qn
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6ugB-0002kv-4W
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686150082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ibCGDwHTPAmn0Z6J6KG+5ecbU18hd2RO1NZWX7nHoSI=;
 b=LeW6eMGFYXaifB2xuii/WEJwy857v3B0fefIA7sSZutsr8qKfPPoHlXi1PwlnfFzku2yYz
 jQhdaFDKxTEN41+qaAZyNkxtoMG5Bvii0tA2/FqIPKY0yNZVQ0PlsefAHNSaj6TI8QZ4Y1
 qvguylFYzi3oiCwuNkQVQyXP1UYBxYU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-G6jacI32OeuteaAnyKGTIA-1; Wed, 07 Jun 2023 11:01:20 -0400
X-MC-Unique: G6jacI32OeuteaAnyKGTIA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a348facbbso671893866b.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686150079; x=1688742079;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ibCGDwHTPAmn0Z6J6KG+5ecbU18hd2RO1NZWX7nHoSI=;
 b=JDp4jtA9SLgkCA31jVlGPF3pCj39Buq3C3l4sQzEWHyWna34JygzUt6ECzAPR+rhTq
 CTkzYdCDiB/Ta4NMZuvNBRicheSi3hyCq2kXdSrNiZ0NYdEv6EATaX70VRrdBjzCQRdN
 941S3i6qyU7GX4alHlN19hMcWqWd+x26+tpfZx3fxU0unEtLYUeMIt2D9EC93L19ngw3
 Bw+LvnLcyhjPO4/a5nZR7ccuBZMslg88fwzfklxEIVPoBGWimRmC9roPbU95PFQa2Lfx
 Rim8QKv+MDFrf4Do86ya4Vq0JP/wTbmq6tFI93zKF0u3+zQwZgz/gc4Lx8+xcTmkeU5Y
 bHHg==
X-Gm-Message-State: AC+VfDxcUyttIGMWQiAdyHzvmMtpOJqIsiRa7IgHlDrIWYgYR/VINPfE
 2ygDIqBNz7hYqEy/7aHPLOF9/zZjV7xmMGkI+MeEn/c04Qg/9X/UMp0/NDQNCaS2SxgvKlNJhL6
 3TlYOvPT3FCE56es=
X-Received: by 2002:a17:907:7baa:b0:96a:30b5:cfb0 with SMTP id
 ne42-20020a1709077baa00b0096a30b5cfb0mr6504162ejc.22.1686150079428; 
 Wed, 07 Jun 2023 08:01:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5NtV42BHMWb7a4hx7+jyslS4+TxOheUV4yYxts/q8xWC0xHrnhezWKLEIajqgv0aeGBW6rYQ==
X-Received: by 2002:a17:907:7baa:b0:96a:30b5:cfb0 with SMTP id
 ne42-20020a1709077baa00b0096a30b5cfb0mr6504144ejc.22.1686150079111; 
 Wed, 07 Jun 2023 08:01:19 -0700 (PDT)
Received: from ?IPV6:2003:cf:d740:9017:191d:265b:b68c:4fa4?
 (p200300cfd7409017191d265bb68c4fa4.dip0.t-ipconnect.de.
 [2003:cf:d740:9017:191d:265b:b68c:4fa4])
 by smtp.gmail.com with ESMTPSA id
 q19-20020a170906b29300b0094f23480619sm7065798ejz.172.2023.06.07.08.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 08:01:18 -0700 (PDT)
Message-ID: <24269db5-2464-0eb6-2f39-ed8a6d1aca58@redhat.com>
Date: Wed, 7 Jun 2023 17:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
Subject: Release of RSD (Rust QSD) 0.1
To: Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi everyone!

I’ve just released the first version (0.1) of RSD, which is a 
proof-of-concept to rewrite the qemu-storage-daemon (QSD) and thus the 
qemu block layer in Rust:

https://gitlab.com/hreitz/rsd
https://gitlab.com/hreitz/rsd/-/releases/v0.1

We’ve been talking for quite a long time about adding Rust into qemu and 
the qemu block layer, and usually ended it with “Could be nice, we just 
need someone to start.”  After we’ve had discussion last year about 
maybe adding C++ for language-supported coroutines, I thought if the 
time isn’t now, it’s never.

In the process, I’ve gathered some insights into obstacles and benefits 
that Rust could bring us, which I’ve summed up in two blog posts:

Part 1 (Overview): https://czenczek.de/blog/rsd-overview.html
Part 2 (Performance): https://czenczek.de/blog/rsd-performance.html

The bottom line so far is that Rust could bring us valuable benefits, 
but likely only if we rewrote everything.  A middle ground is possible, 
by keeping RSD focused on a specific subset of functionality, the one 
that is most valuable for it.  In any case, this (v0.1) is as far as is 
reasonable to go with RSD as an experiment – any further work we’d need 
to do in earnest and define what exactly we actually want.  And that’s 
an important part of what this announcement is for, to see whether 
anyone has this interest!


Hanna


