Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AD27454AF
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 06:55:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGBaN-0002d8-Uu; Mon, 03 Jul 2023 00:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGBaI-0002cs-Lp
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 00:54:46 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGBaH-0002ZO-3K
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 00:54:46 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-53482b44007so1958000a12.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 21:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688360083; x=1690952083;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KOh8GylA0diSZ0K36kpgyPJyvz4a4+u/VXYYT2BNNJc=;
 b=RDY7fFCUtfPABAEenx/1Z1B785SfA1/hoCD/wagSvJaujKMS7ZzNT7lmgVLs8Vf8qh
 p9g6MekRWPoTQMBNq+sz28jOoFIf/wiQPa3Ec54YlEk6gU7keOI6a9A4l4YQVw6MPRRG
 xHFc60iDNQuA74gxTU1gFGVMdV7zhQDah/WpZtOMsLuqTrbZGoBbSEh66WOcPQ8f/vcp
 Lv4DZaJiJSh77/aBxaKMpdtC+8JMMFktyrZFZ3fXDIY/uvUQP+cMW46U1018RvWJUC1e
 WT8cL/rpZmG6vpYX5Z5eY3XpjS8hU0XONb0dvKmLpUsP+ZBL1M3C2a2p8Ftn5o8ANcAn
 p9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688360083; x=1690952083;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KOh8GylA0diSZ0K36kpgyPJyvz4a4+u/VXYYT2BNNJc=;
 b=eWtsx/XSyddMkl1WD0i30yx+2beNYmuRGnCl/Gyw/rnL4pniTF8PmOm5pReK64FlRs
 zu4rcMDIa5BmQBMb8haE18+1hqLNdO9rJcpQViSUoLoXLiOzpUMvnHZdBqmUwfAedJKc
 3FOdyHzwivnvdvGzJrDg3q0JJxR0utUSeopoEC13s6QBoz5nkcjJBOMPabC97+lNaHWS
 Qlija4DI5undj+d9v5CBZ40EdWYtcac1Pjcco0a4F4rCkl808xz6bxl3gGL1W4a881Fs
 iSaogFAzeGGZEesVtPVlDuiH+IKwzYZnQnh49uO2QbYCZkRv31aaFhD1uLhAkakMhqcF
 UriA==
X-Gm-Message-State: ABy/qLaiaXHbjkwisrheSE5P9T+Q81FaQn3jp06DX/enFRRtDrUyJ+KI
 ZinR+nkUaHUmg12UDsAqabMbdg==
X-Google-Smtp-Source: APBJJlEWGAlSuxnVmFNMob06M62+yR6IWeK9/jQ365Vb5StJxgJUAoeeSlmrO+f5wvgv9GcXDXU9Kg==
X-Received: by 2002:a17:902:e5c5:b0:1b6:b445:36d4 with SMTP id
 u5-20020a170902e5c500b001b6b44536d4mr9382051plf.43.1688360083349; 
 Sun, 02 Jul 2023 21:54:43 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a170902ab8700b001b03f208323sm14270378plr.64.2023.07.02.21.54.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jul 2023 21:54:43 -0700 (PDT)
Message-ID: <004a4a2d-842d-b748-5ee5-d6eb0544b50d@daynix.com>
Date: Mon, 3 Jul 2023 13:54:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/2] pcie: Fix ARI next function numbers
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
References: <20230702120229.66978-1-akihiko.odaki@daynix.com>
 <20230702084251-mutt-send-email-mst@kernel.org>
 <0a6bd04c-8364-2735-0ee6-060550bea77b@daynix.com>
 <20230703005201-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230703005201-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
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

On 2023/07/03 13:52, Michael S. Tsirkin wrote:
> On Mon, Jul 03, 2023 at 12:17:16PM +0900, Akihiko Odaki wrote:
>> On 2023/07/02 21:43, Michael S. Tsirkin wrote:
>>> On Sun, Jul 02, 2023 at 09:02:25PM +0900, Akihiko Odaki wrote:
>>>> The ARI next function number field is undefined for VF. The PF should
>>>> end the linked list formed with the field by specifying 0.
>>>>
>>>> Supersedes: <20230701070133.24877-1-akihiko.odaki@daynix.com>
>>>> ("[PATCH 0/4] pci: Compare function number and ARI next function number")
>>>
>>> Thanks! How was this patch tested?
>>
>> I brought VFs up with igb and performed link up for a fresh VM and a VM
>> migrated from 8.0.2.
> 
> Which guest?

I use Fedora 38.

> 
>>>
>>>
>>>> V2 -> V3:
>>>>     Moved the logic to PCI common infrastucture (Michael S. Tsirkin)
>>>>
>>>> V1 -> V2:
>>>>     Fixed migration. (Michael S. Tsirkin)
>>>>     Added a caveat comment. (Michael S. Tsirkin)
>>>>
>>>> Akihiko Odaki (2):
>>>>     pcie: Use common ARI next function number
>>>>     pcie: Specify 0 for ARI next function numbers
>>>>
>>>>    docs/pcie_sriov.txt   | 4 ++--
>>>>    include/hw/pci/pci.h  | 2 ++
>>>>    include/hw/pci/pcie.h | 2 +-
>>>>    hw/core/machine.c     | 1 +
>>>>    hw/net/igb.c          | 2 +-
>>>>    hw/net/igbvf.c        | 2 +-
>>>>    hw/nvme/ctrl.c        | 2 +-
>>>>    hw/pci/pci.c          | 2 ++
>>>>    hw/pci/pcie.c         | 4 +++-
>>>>    9 files changed, 14 insertions(+), 7 deletions(-)
>>>>
>>>> -- 
>>>> 2.41.0
>>>
> 

