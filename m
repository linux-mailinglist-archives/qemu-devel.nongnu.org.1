Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0237223D6
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:51:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67nV-0000A6-ID; Mon, 05 Jun 2023 06:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q67nH-00008B-US
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:50:36 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q67nG-0008KB-2I
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:50:35 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-655fce0f354so695143b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685962230; x=1688554230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UmUHC2X/5xgeg9Gp980CrWFXAoMRAZPv1CuhMek7zw8=;
 b=0dV4P4UTF5Q9yhG8Hcohc/pMx65ZG0pFLoodIBIwdU7YR1KI+oCKxZLQBQzjifRaOt
 CZiEKevZTADYkyKdFk+fKfogs1dWS5XtTTDbkhLbJqijkAfCvnBtzJei68AtyDWvea05
 kXrJhzcWwrhuqS3YhL1OEkUmUoAXm9nUZIB+7zZ7P92Ei0uBYlQRmUyQIXo0MlrZPZtl
 OQ878Y6um7CVdX47wxqKGytWFIh1kB3otMqkKZt20H9d72RLdohJ97dTufOKMsGiDcT7
 dY1zbzUdGXQXlsi/1w8L+Rqq+gXpRE3xxXKCWSE8h3geqyw6TBSrAAr6M9PCXYP6O/rM
 xqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685962230; x=1688554230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UmUHC2X/5xgeg9Gp980CrWFXAoMRAZPv1CuhMek7zw8=;
 b=jYwGpmV1xtDzPdbdKgQnPipBz0sJeEer+nD4+pafLKUI5iAH+UiFCdwzjEzJrASxxy
 NKvuMLvMTlt2fpNnYKl+LLYIdLf8whQIlMeMSQZHQhzxqCe1aYEznJWHYIEw8mAuS6wU
 OLpe89lk9qE6R5YOchvhuuF5ZrwfX9R71tNdWFHXg2DTorYOWprNOVxfodFoGgCnesB8
 NMK56UkDLO+BkvOXOhjHankFY5I/9sYf9G7dD/LFvD0Sw/Oymn3dgfm4CKpvPdXTE6u0
 JPXkcjpgHBabj+xO4FnTxKdRf4IdboiU2K8SdWfxNXOq4TPlwuM0Qvee6NduHoYme/5J
 V8Pw==
X-Gm-Message-State: AC+VfDw4QBfD9uNlbOZvB3V5YydGqlGME+cILW1tQCtVssMnbTYDGBWu
 ik8XimPOr+tNyDHlVlak2HvI1g==
X-Google-Smtp-Source: ACHHUZ4myq9SjYxBNw1DV8NVHWzyARqbiII86IsZDfKi4SnI6xYxVtrB50TdMEoqePj+nqbLx8E0AQ==
X-Received: by 2002:a05:6a20:3d81:b0:10c:4ff5:38b7 with SMTP id
 s1-20020a056a203d8100b0010c4ff538b7mr2290285pzi.6.1685962230533; 
 Mon, 05 Jun 2023 03:50:30 -0700 (PDT)
Received: from [157.82.204.254] ([157.82.204.254])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a170902e54d00b001ae4d4d2676sm6272139plf.269.2023.06.05.03.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 03:50:30 -0700 (PDT)
Message-ID: <231083f0-9813-abfc-8e2a-61deca9ca68d@daynix.com>
Date: Mon, 5 Jun 2023 19:50:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] net: Provide MemReentrancyGuard * to qemu_new_nic()
To: Alexander Bulekov <alxndr@bu.edu>
Cc: Mauro Matteo Cascella <mcascell@redhat.com>, P J P
 <pj.pandit@yahoo.co.in>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>, Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sven Schnelle <svens@stackframe.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Rob Herring <robh@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20230601031859.7115-1-akihiko.odaki@daynix.com>
 <20230601031859.7115-2-akihiko.odaki@daynix.com>
 <20230605080616.ooanu5pk2pvs57yi@mozz.bu.edu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230605080616.ooanu5pk2pvs57yi@mozz.bu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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

On 2023/06/05 17:06, Alexander Bulekov wrote:
> On 230601 1218, Akihiko Odaki wrote:
>> Recently MemReentrancyGuard was added to DeviceState to record that the
>> device is engaging in I/O. The network device backend needs to update it
>> when delivering a packet to a device.
>>
>> In preparation for such a change, add MemReentrancyGuard * as a
>> parameter of qemu_new_nic().
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> 
> Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
> 
> One minor comment below.
> 
>> ---
>>   include/net/net.h             | 1 +
>>   hw/net/allwinner-sun8i-emac.c | 3 ++-
>>   hw/net/allwinner_emac.c       | 3 ++-
>>   hw/net/cadence_gem.c          | 3 ++-
>>   hw/net/dp8393x.c              | 3 ++-
>>   hw/net/e1000.c                | 3 ++-
>>   hw/net/e1000e.c               | 2 +-
>>   hw/net/eepro100.c             | 4 +++-
>>   hw/net/etraxfs_eth.c          | 3 ++-
>>   hw/net/fsl_etsec/etsec.c      | 3 ++-
>>   hw/net/ftgmac100.c            | 3 ++-
>>   hw/net/i82596.c               | 2 +-
>>   hw/net/igb.c                  | 2 +-
>>   hw/net/imx_fec.c              | 2 +-
>>   hw/net/lan9118.c              | 3 ++-
>>   hw/net/mcf_fec.c              | 3 ++-
>>   hw/net/mipsnet.c              | 3 ++-
>>   hw/net/msf2-emac.c            | 3 ++-
>>   hw/net/mv88w8618_eth.c        | 3 ++-
>>   hw/net/ne2000-isa.c           | 3 ++-
>>   hw/net/ne2000-pci.c           | 3 ++-
>>   hw/net/npcm7xx_emc.c          | 3 ++-
>>   hw/net/opencores_eth.c        | 3 ++-
>>   hw/net/pcnet.c                | 3 ++-
>>   hw/net/rocker/rocker_fp.c     | 4 ++--
>>   hw/net/rtl8139.c              | 3 ++-
>>   hw/net/smc91c111.c            | 3 ++-
>>   hw/net/spapr_llan.c           | 3 ++-
>>   hw/net/stellaris_enet.c       | 3 ++-
>>   hw/net/sungem.c               | 2 +-
>>   hw/net/sunhme.c               | 3 ++-
>>   hw/net/tulip.c                | 3 ++-
>>   hw/net/virtio-net.c           | 6 ++++--
>>   hw/net/vmxnet3.c              | 2 +-
>>   hw/net/xen_nic.c              | 4 ++--
>>   hw/net/xgmac.c                | 3 ++-
>>   hw/net/xilinx_axienet.c       | 3 ++-
>>   hw/net/xilinx_ethlite.c       | 3 ++-
>>   hw/usb/dev-network.c          | 3 ++-
>>   net/net.c                     | 1 +
>>   40 files changed, 75 insertions(+), 41 deletions(-)
>>
>> diff --git a/include/net/net.h b/include/net/net.h
>> index 1448d00afb..a7d8deaccb 100644
>> --- a/include/net/net.h
>> +++ b/include/net/net.h
>> @@ -157,6 +157,7 @@ NICState *qemu_new_nic(NetClientInfo *info,
>>                          NICConf *conf,
>>                          const char *model,
>>                          const char *name,
>> +                       MemReentrancyGuard *reentrancy_guard,
>>                          void *opaque);
> 
> Does it make sense to roll *reentrancy_guard into NICConf here?

Probably no. All members of NICConf are device properties the user 
configure, but reentrancy_guard is an internal state. Similarly, the 
opaque parameter is an internal state and not included in NICConf.

