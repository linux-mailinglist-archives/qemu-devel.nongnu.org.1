Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1CC71540C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 04:50:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3pQS-0003Vh-PF; Mon, 29 May 2023 22:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q3pQQ-0003VV-9d
 for qemu-devel@nongnu.org; Mon, 29 May 2023 22:49:30 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q3pQO-0006Sg-OO
 for qemu-devel@nongnu.org; Mon, 29 May 2023 22:49:30 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-25690e009c8so812140a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 19:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685414967; x=1688006967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6YUyQS0gcguFecxX57szc3ywtCx06jIXTXgj3cUKMj8=;
 b=D8eJY13AsMPuKUGG5Vh9BkM13fqxSQKH75GKRQaY2JxJD7MhTFu8BW3WHyX/9MbsMD
 0eLEbuAvxpyEj34LGnU6LJO7OWkVDjUQUA1mDDKzwceNaD8ofKN/zAzO/tSuF+Jp8jP6
 4qpID6qNe+1EqYfggdsqj+HoQLj0sCxuHyOtikL0LrgKAjRgPh/Wq4VXgmA4Pv9c3b8Z
 6j7ospCCXAOeFiHaebjvHiCXBU/7A09zbt0SBicAElS7gqaJvfbxXkGqU6mJYzLYw0JA
 BvlQN7GSMd/g3TmdlDTNMvbO5w73jNxecA1hVPEqNv+3972OUsQzPWsTZzFSp50rrYyE
 S3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685414967; x=1688006967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6YUyQS0gcguFecxX57szc3ywtCx06jIXTXgj3cUKMj8=;
 b=Gq/J0ywAbW4K1BzUY76aZUlqFjRK3BQvwiaTs+3/z+vJ5LWp2MrogZme0ihqL6wYqc
 EECYbODXB9N2dDZW9UKecpFGCib47sjxO4/kdk8fMEus8Mjz7igKeYuKEYKuVD3lQ5Z7
 yYzOkXm7uS3ZnGzeDh+3KWV4RoILXZ+e+EjNTgngfbXhmG6Dd+idE+LfX/hkWPAE0LpI
 hdPNJbwNsxrnFAsHGkUFb+1EGp6Lo2dbcBzuHqVAvpNZ+qRyQz0/lfHMe7Zp8zKEwjJZ
 KNZG3H9iFv2cGEMvRw0MJhxy6hLrVw3QQs+pjJt/O18fNocbUOJtiHb32q9NiHvscUuy
 I2Rg==
X-Gm-Message-State: AC+VfDz5lI5fKqKgsZLhCMSjSTsmpM2K0Cl5y/fSQ1X8vtNpOkrZfeWk
 9hc7/OVOhLNq7Rd95i6n5XH9Xw==
X-Google-Smtp-Source: ACHHUZ5v8rNg3hycBRQkimiztZ1N9gr3hK52ruC/XcUFqVl4mG8C7+I42jwfbzAMJsxORxuJd95SKw==
X-Received: by 2002:a17:90a:4504:b0:250:1905:ae78 with SMTP id
 u4-20020a17090a450400b002501905ae78mr1111109pjg.15.1685414967027; 
 Mon, 29 May 2023 19:49:27 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a17090b068a00b0024df6bbf5d8sm7851958pjz.30.2023.05.29.19.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 19:49:26 -0700 (PDT)
Message-ID: <7f1ea2a7-aef1-f090-01ab-218747b167c6@daynix.com>
Date: Tue, 30 May 2023 11:49:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v10 0/7] igb: packet-split descriptors support
Content-Language: en-US
To: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>, qemu-devel@nongnu.org
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
References: <CGME20230529140202eucas1p1920add7c8fd0a0c4efdfac6e9bdf5a7f@eucas1p1.samsung.com>
 <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/05/29 23:01, Tomasz Dzieciol wrote:
> Purposes of this series of patches:
> * introduce packet-split RX descriptors support. This feature is used by Linux
>    VF driver for MTU values from 2048.
> * refactor RX descriptor handling for introduction of packet-split RX
>    descriptors support
> * fix descriptors flags handling
> 
> Tomasz Dzieciol (7):
>    igb: remove TCP ACK detection
>    igb: rename E1000E_RingInfo_st
>    igb: RX descriptors guest writting refactoring
>    igb: RX payload guest writting refactoring
>    igb: add IPv6 extended headers traffic detection
>    igb: packet-split descriptors support
>    e1000e: rename e1000e_ba_state and e1000e_write_hdr_to_rx_buffers
> 
>   hw/net/e1000e_core.c     |  78 +++--
>   hw/net/igb_core.c        | 730 ++++++++++++++++++++++++++++-----------
>   hw/net/igb_regs.h        |  20 +-
>   hw/net/trace-events      |   6 +-
>   tests/qtest/libqos/igb.c |   5 +
>   5 files changed, 592 insertions(+), 247 deletions(-)
> 

Thanks for keeping working on this. For the entire series:

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>

