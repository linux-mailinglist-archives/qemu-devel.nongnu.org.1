Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1942E7130CF
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 02:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2hW8-0006mS-7B; Fri, 26 May 2023 20:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q2hW5-0006lt-JR
 for qemu-devel@nongnu.org; Fri, 26 May 2023 20:10:41 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q2hW4-0008Up-2D
 for qemu-devel@nongnu.org; Fri, 26 May 2023 20:10:41 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b00ecabdf2so12919195ad.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 17:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685146238; x=1687738238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qNwhn7tTlfERexFZCJyGlfKeKBkULCRCgD6Fm4bBKjM=;
 b=syXuDElPaNCiZv9TVxaCOmgYqYMBA+c2VgokoUBO2jlkg659RZNXKLbO6NCyAYrOrE
 Go51ohLLYd+IISkmf0EbOkJOEGJBMh0d5OV29fE8JDGZYAQk1r2OnUuD4evE1ENGvqV9
 n/GpBEKWCepj/ZAgsXkgLhMyv5sFwBy5h1K4O9lzocEhkaaP9C6+ug5QlqUAmHNJEHeu
 c6W76iffuu025NQ4Hp2SFUNOnyoJ1Fmzdv/cRHqY9WMm96OsUTdHW68F2Kny424lJfz1
 0LDD8kPoSwuceNRK+DciQ+PSZaBlB4fSyw5YkClTinXT+UyQ95nSkfpQ0oH03hgtGe1z
 Gq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685146238; x=1687738238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qNwhn7tTlfERexFZCJyGlfKeKBkULCRCgD6Fm4bBKjM=;
 b=ayMSntQ5TmtUZFGd4LxJPwX2juUVZp8gp2cg6zCj9JAsMSeCcP1qzrLxXzVOCod1nG
 LBySm+WGSJ2ypSZUQ2hZGbq3EqSefKxyTwQjR7jNAqh611b0zPrdOoAxUOYttpkGwBO1
 9QUflx4dcLakfLkISZ12HFmh8/vrqFVGXhFh6ZQYzRxxdBfjQnBoKPz4BvVWLZuSVDYa
 irO9BZSUnf1xG9q+HxN1Hzh2WoG+pgaB43CxpaQZR++PsDMMuEVn9AO6QU0cp1h8L6Kg
 P2XT93tdvqimbAzLH6cYsgMbxF8PvYDvNIf3WlhZePh5S4mOp9F4uTuVcbhPDkTrXkbZ
 AAjg==
X-Gm-Message-State: AC+VfDyAHMBPhpWWUu1Erb5HjT5wSUMm++692xSC1hHQg44RD8YoGZYZ
 +9V0rN/sr0UmnXp7XKtw7lcGdBAgtkiEdviDpsA=
X-Google-Smtp-Source: ACHHUZ5NilEydZWhtztFpA6SZhwTDwWNqzS02wVeJ4zH+b3KQYj7R3nwfho1bq9jzzrzfwgrEGv4Rw==
X-Received: by 2002:a17:903:230f:b0:1af:bb27:f55f with SMTP id
 d15-20020a170903230f00b001afbb27f55fmr4989318plh.55.1685146238243; 
 Fri, 26 May 2023 17:10:38 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 ik24-20020a170902ab1800b001b0142908f7sm1760069plb.291.2023.05.26.17.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 17:10:37 -0700 (PDT)
Message-ID: <0f5b480e-3e45-0134-faf8-25ba785282c7@daynix.com>
Date: Sat, 27 May 2023 09:10:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 0/7] igb: packet-split descriptors support
Content-Language: en-US
To: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>, qemu-devel@nongnu.org
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
References: <CGME20230525153743eucas1p145858f3572c2d53687377a4e879d1e0b@eucas1p1.samsung.com>
 <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 2023/05/26 0:37, Tomasz Dzieciol wrote:
> Based-on: <20230523024339.50875-1-akihiko.odaki@daynix.com>
> ("[PATCH v5 00/48] igb: Fix for DPDK")
> 
> Purposes of this series of patches:
> * introduce packet-split RX descriptors support. This feature is used by Linux
>    VF driver for MTU values from 2048.
> * refactor RX descriptor handling for introduction of packet-split RX
>    descriptors support
> * fix descriptors flags handling
> 
> In addition to comments from previous review endianess issues in
> igb_write_adv_ps_rx_descr were fixed.
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
>   hw/net/igb_core.c        | 740 ++++++++++++++++++++++++++++-----------
>   hw/net/igb_regs.h        |  20 +-
>   hw/net/trace-events      |   6 +-
>   tests/qtest/libqos/igb.c |   5 +
>   5 files changed, 602 insertions(+), 247 deletions(-)
> 

Please rebase to the current master and remove Based-on: tag. This 
series should cleanly apply.

I left some minor comments that does not involve semantic changes so 
check them out. I think I can give Reviewed-by: and Tested-by: for the 
next version. Thanks for keeping working on this.

Regards,
Akihiko Odaki

