Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 367597054D6
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 19:18:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyyIY-0001N6-Gk; Tue, 16 May 2023 13:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyyIS-0001Mn-Gr
 for qemu-devel@nongnu.org; Tue, 16 May 2023 13:17:12 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyyIQ-00058v-OB
 for qemu-devel@nongnu.org; Tue, 16 May 2023 13:17:12 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ae4e264e03so489915ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684257429; x=1686849429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lx8c71/C3XmqckflJmXp7Zgaa4gNO9RTjqKFnRaPNSA=;
 b=MGWSPZCzYZw9To5wr7TH1AvSvpHKME2LMQbHS1nLdT/MPr4vhUxN97fe7dgw2yPXnP
 TwZor6PsduRz1qaYZSVqCI6PUZQ1UUnd7ojHWHxxZkgm/R+yG6Xh+FeQr2y0OcTDKf+g
 oqOgk2Jy8QbK4tlvHSSRumRhZJbSHSrU6SKSTdb+PchezhxgRQbuzV+b+U1FD9yw5Hza
 bCn7TZat0Xe6EzyVTWGQjesy1PjiRa3o6VwuOTX4ZkHiD2wclCU0flW2UI2Grg13Xs7R
 b99mMy3OGg/Sx2Y7NMpmTD11m84L4GIG2InGX2eFeT/aoB0Z/q51PWPzMheLoJpVtJE3
 zc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684257429; x=1686849429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lx8c71/C3XmqckflJmXp7Zgaa4gNO9RTjqKFnRaPNSA=;
 b=YEUfvB/Kp2teoEYwf4Hkcv/pIyyv3wrjP/80wldLQBVuCJ3XkQTxpyTthA6jxxa4ep
 lnjcCyeYCDXwr76wzIcPHkV33+i7a3G/s+OlVLiuWCbshJGWetjC6bezYkSe4ZaoFrHU
 QRYihyMDZPU/+k51MHj9Gg6/4lTb1xKi9tSZquXVSudsnppdufirfZ1qoxli4aZ95pPU
 HNnMzg1awrmEB8S+MUz3xDhBwHuvvdShpfLdo7d456ksjvawy52kGFOrfAsZYwUP/Tbd
 VlqfCKHcuhn7ZcEhPrwycD0YtkoC8ZkkpwZ59RQTB2SZ+AuWgET1IqM3NwlM4SLNJWkL
 vmBQ==
X-Gm-Message-State: AC+VfDxIyOKKtb+SyzNIaxNXxPKSzEuqNqri6rykl+EiO1jpaNU2YVVO
 /l1884raHXssJquGg4dW0RXUhQ==
X-Google-Smtp-Source: ACHHUZ6quyT9yZq76AVWPKYFAeboQGFZ1Q/DQh4pzMZ0AOD38fr+Z+Ev3p3qko20h0iReHvgQ8FLpA==
X-Received: by 2002:a17:902:e80b:b0:1aa:ffed:652c with SMTP id
 u11-20020a170902e80b00b001aaffed652cmr51278400plg.64.1684257428930; 
 Tue, 16 May 2023 10:17:08 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a170902d2ca00b001aaf13db1acsm15718953plc.276.2023.05.16.10.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 10:17:08 -0700 (PDT)
Message-ID: <03994a55-ead7-4a17-f5d4-78ff6f5bf101@linaro.org>
Date: Tue, 16 May 2023 10:17:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 0/4] 9p queue 2023-05-16
Content-Language: en-US
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>,
 Peter Foley <pefoley@google.com>, Jason Andryuk <jandryuk@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>
References: <cover.1684250463.git.qemu_oss@crudebyte.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1684250463.git.qemu_oss@crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
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

On 5/16/23 08:21, Christian Schoenebeck wrote:
> The following changes since commit ab4c44d657aeca7e1da6d6dcb1741c8e7d357b8b:
> 
>    Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-05-15 13:54:33 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/cschoenebeck/qemu.git tags/pull-9p-20230516
> 
> for you to fetch changes up to 3887702e5f8995638c98f9d9326b4913fb107be7:
> 
>    configure: make clear that VirtFS is 9p (2023-05-16 16:21:54 +0200)
> 
> ----------------------------------------------------------------
> 9pfs: fixes
> 
> * Fixes for Xen, configure and a theoretical leak.

The public key I have for you is expired.
Have you pushed a refresh of it somewhere?


r~

> 
> ----------------------------------------------------------------
> Christian Schoenebeck (2):
>        tests/9p: fix potential leak in v9fs_rreaddir()
>        configure: make clear that VirtFS is 9p
> 
> Jason Andryuk (1):
>        9pfs/xen: Fix segfault on shutdown
> 
> Peter Foley (1):
>        Don't require libcap-ng for virtfs support
> 
>   hw/9pfs/trace-events                  |  6 ++++++
>   hw/9pfs/xen-9p-backend.c              | 35 ++++++++++++++++++++++-------------
>   meson.build                           | 14 ++++++++++----
>   meson_options.txt                     |  2 ++
>   scripts/meson-buildoptions.sh         |  4 ++++
>   tests/qtest/libqos/virtio-9p-client.c |  5 +++++
>   6 files changed, 49 insertions(+), 17 deletions(-)
> 


