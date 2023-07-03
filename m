Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E7745416
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 05:18:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGA44-0002Ai-At; Sun, 02 Jul 2023 23:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGA42-0002AO-QA
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 23:17:22 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGA41-0002lP-6Z
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 23:17:22 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a04e5baffcso3067821b6e.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 20:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688354240; x=1690946240;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2XZ0RqBcTEPEDEu/Cbyg9EfJb6udItHDAI0I7EzuA7g=;
 b=ilnnAOeU/2ka00mhxeZl6EKJ0ZjUJK4ZRh0lCNgfEgJWJxXJGurzA7e8xLdoPVjKk9
 38mCL2P1iJoXvZI6hSHXUAC7oQCH0FFTusBAuUxNM6V6MPh+5SlayZqDsTIs34hykj1G
 hIadBGFaBzXjobaZWEaQgveeNPOoA635c8AvKLwdt2SJs8u6zTNo3vORyYSgE4XGp73C
 XH7f3HrC9F9XukI82PDPd7KWDeKtDxEwrjPN58AlSUvdHR2cfr/f2Y3r3Lrm5q8B4snQ
 eTGrSm6EhkKveRMPm/aflKQoKIp02M9eouE+GGPA65n4klePMhwkawyTf34BJrlKOhuy
 xTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688354240; x=1690946240;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2XZ0RqBcTEPEDEu/Cbyg9EfJb6udItHDAI0I7EzuA7g=;
 b=J4HQANjIO2It2W2dDqUTR4el6ScbY8VSTBPgWLmjM62vY1+Ma2pyHmBpYSEL7Kh16R
 6YTgiF/VcGUS+XSoJJnKZaSzPQa0flSrPBdJgDaZPtLKe7xN0nCGPkI4b6PxGUumC8aI
 dRBOw6Q6QpdV227Kw5xcbxIWphCpLtREa2FABmfkvvz1JISm+K1xXBmFcKQncUrevE/V
 abKbkFIZMEOhktqmus8hXPTBsMZ0xnZX7LGGZl+1ieRzkNEH2txpLQvyFeSjHTEAQFHZ
 nJ+/4w9gg9zbW7Asxyz9KPtTmJd/7cpNkiHCl3vlcpe838MrYYU3nGpCKWbEasaANzls
 rYWw==
X-Gm-Message-State: AC+VfDzN9z5UC9+vmgiHj5qnpqqAWRVW/d11gMOr4m+tDBjz98Na3GiR
 bJYJDWEQufiUQ7MZG5zEkRArjA==
X-Google-Smtp-Source: ACHHUZ5zyK4AWUj11m/y5sMysL9djJVVETmS+mtU8eZpF1P87ODbPbk5NwmGV2BS3VC85m2D/RpdUg==
X-Received: by 2002:a05:6808:18aa:b0:3a1:d8cb:17d4 with SMTP id
 bi42-20020a05680818aa00b003a1d8cb17d4mr8918496oib.35.1688354239989; 
 Sun, 02 Jul 2023 20:17:19 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f4-20020aa78b04000000b0064fd4a6b306sm13047264pfd.76.2023.07.02.20.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jul 2023 20:17:19 -0700 (PDT)
Message-ID: <0a6bd04c-8364-2735-0ee6-060550bea77b@daynix.com>
Date: Mon, 3 Jul 2023 12:17:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/2] pcie: Fix ARI next function numbers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
References: <20230702120229.66978-1-akihiko.odaki@daynix.com>
 <20230702084251-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230702084251-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/07/02 21:43, Michael S. Tsirkin wrote:
> On Sun, Jul 02, 2023 at 09:02:25PM +0900, Akihiko Odaki wrote:
>> The ARI next function number field is undefined for VF. The PF should
>> end the linked list formed with the field by specifying 0.
>>
>> Supersedes: <20230701070133.24877-1-akihiko.odaki@daynix.com>
>> ("[PATCH 0/4] pci: Compare function number and ARI next function number")
> 
> Thanks! How was this patch tested?

I brought VFs up with igb and performed link up for a fresh VM and a VM 
migrated from 8.0.2.

> 
> 
>> V2 -> V3:
>>    Moved the logic to PCI common infrastucture (Michael S. Tsirkin)
>>
>> V1 -> V2:
>>    Fixed migration. (Michael S. Tsirkin)
>>    Added a caveat comment. (Michael S. Tsirkin)
>>
>> Akihiko Odaki (2):
>>    pcie: Use common ARI next function number
>>    pcie: Specify 0 for ARI next function numbers
>>
>>   docs/pcie_sriov.txt   | 4 ++--
>>   include/hw/pci/pci.h  | 2 ++
>>   include/hw/pci/pcie.h | 2 +-
>>   hw/core/machine.c     | 1 +
>>   hw/net/igb.c          | 2 +-
>>   hw/net/igbvf.c        | 2 +-
>>   hw/nvme/ctrl.c        | 2 +-
>>   hw/pci/pci.c          | 2 ++
>>   hw/pci/pcie.c         | 4 +++-
>>   9 files changed, 14 insertions(+), 7 deletions(-)
>>
>> -- 
>> 2.41.0
> 

