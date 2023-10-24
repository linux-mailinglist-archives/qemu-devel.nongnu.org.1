Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E557D45FF
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 05:32:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv88A-0002mq-Nx; Mon, 23 Oct 2023 23:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qv87y-0002mY-PJ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 23:30:46 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qv87w-0004Bq-R4
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 23:30:46 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c9b1e3a809so25345315ad.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 20:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698118243; x=1698723043;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7cBJW8KKX1OPAPXI8cwjobaq9ByYayIUvLKFtRg5iOc=;
 b=hCPghgkvywzOyL6F1dEykqxFwphquWUFDS5PhroC17/oKm7ZX9V6RDoTOq+7aDGgki
 xDeY/JyrWyW2xwPn6y4qxLWGU8nyj42xSWuNK3jlsYpMkLcCHfHfoz6yL3UB8bQncRZT
 GIZgWjJwJrMiTzm0SmxseCZPdu3bO3sja89NDzLHzdmnynxMpfUfw2dih+q3Y6/IE9e3
 fDdGpYew9hhsPyk0SXf4v8aTz/KO/WXAoc/bkHqGwCg8Rhj9UfpDFHUBbou9Nk2vTlGs
 xcCVrnfjCrmERCN0S9Odzv/YpIwYvvmk+n6rREss+uxKYq6RTgp6Q8lvX0bItpvM3av9
 oXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698118243; x=1698723043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7cBJW8KKX1OPAPXI8cwjobaq9ByYayIUvLKFtRg5iOc=;
 b=jtdS4uP0Yzz7GqlyQrvxdh5xfWJWnnahFGs5JTcNo1eGl9IwfXVy2mSrG2+tjbm3eL
 6iAQYE8TaUhrq7HsxyOVIldrO7HL0V8tZZiJdJmGjbcDZ32aiLF6a848A+128eKNS5Dh
 zF9KaOhRobmp53NmCcgOoFUwIF5e3vFsgmognyUhPD4TpdoyHRxfS7joWTVblRn7UPX2
 5hTFUXXVVQYlFhklmw5p2yBUZtlnG+Q3hDpomijmsRaF5D9P3qYF34sEprbZV1oi57/3
 Pcai0so4T9/L4jOllLjjrD05oBPURAqfxz3OZag0S/XhyDSlQoGX+aDqpsnAFnecTnNs
 wiQA==
X-Gm-Message-State: AOJu0YyLeQ4657GusJres7Y4VVnWXa2ssKfaqOVScQq6WvKPoZzhAw2b
 k16O/uIG2M7YBOmmKd9uVg2WHA==
X-Google-Smtp-Source: AGHT+IF5yINA2BW+nhUi5KqyU3JW8NK/sPPUYCtn83BtrRHeLY42gwVPLxEf/Cdymk5UTea9zlLNrw==
X-Received: by 2002:a17:902:da83:b0:1ca:2743:bf7c with SMTP id
 j3-20020a170902da8300b001ca2743bf7cmr9840726plx.42.1698118243298; 
 Mon, 23 Oct 2023 20:30:43 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170902d50300b001b8622c1ad2sm6628678plg.130.2023.10.23.20.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 20:30:42 -0700 (PDT)
Message-ID: <7ce1c530-1ba3-4b9c-84ef-2fae5e217cb0@daynix.com>
Date: Tue, 24 Oct 2023 12:30:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] igb: Add FLR support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20231023154507.253641-1-clg@kaod.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231023154507.253641-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

On 2023/10/24 0:45, Cédric Le Goater wrote:
> From: Cédric Le Goater <clg@redhat.com>
> 
> Hello,
> 
> Here is a little series adding FLR to the new IGB models.
> 
> Thanks,
> 
> C.
> 
> Changes in v2:
> 
> - add a "x-pcie-flr-init" compat property for pre 8.2 machines
> 
> Cédric Le Goater (2):
>    igb: Add a VF reset handler
>    igb: Add Function Level Reset to PF and VF
> 
>   hw/net/igb_common.h |  1 +
>   hw/net/igb_core.h   |  3 +++
>   hw/core/machine.c   |  3 ++-
>   hw/net/igb.c        | 15 +++++++++++++++
>   hw/net/igb_core.c   |  6 ++++--
>   hw/net/igbvf.c      | 19 +++++++++++++++++++
>   hw/net/trace-events |  1 +
>   7 files changed, 45 insertions(+), 3 deletions(-)
> 

For the whole series:
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

