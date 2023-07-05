Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE6748836
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:42:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4dj-0001Yq-2o; Wed, 05 Jul 2023 11:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qH4dg-0001Xc-K0; Wed, 05 Jul 2023 11:41:56 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qH4de-0001BV-Vg; Wed, 05 Jul 2023 11:41:56 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b7541d885cso5593193a34.3; 
 Wed, 05 Jul 2023 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688571713; x=1691163713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qu/5ewLjn0n4BgK188DIzbyNItlMS2EWfyKBXti3tpI=;
 b=pClzDZ/9xPBlQJgPNlqeG2Sg/p0PAqP4i4V9h9wBn0CZp1y1Xsqxz3RBYm0s6JrztP
 +7CPeRgIHbf+136UOIWRwHxwtkesugrC8aRCPEhC1vM+Yz9G7UjiybtpdE8qUaWsORqK
 OnLGJIGABq2xpFKNyx/nbzdVPVLvuH9RqNkWMucmaGYcopOSagmHIYohV246AlOXIA2b
 D6fKw6Gvrt2dYaQr923G9uvTT46C96LvqY7j82B9DlG3/OStPCds/H/GMwK/ohr4TRKa
 vrytSmzbtKNDquIAkU4PLXRc5r+V4RUmme6Dr6le2nrvXXgbA5DEe/sFYMEe6Vw+w3Ia
 jmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571713; x=1691163713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qu/5ewLjn0n4BgK188DIzbyNItlMS2EWfyKBXti3tpI=;
 b=DpUCK7L6quIy0mffup1/XylIqy47AqAgei1McMw9rYC4oy5jnbHq3tJ9GYmbTzUQSf
 zAgzGPE5MrSgAB7CZJcoM+NFjamIsi+CrrkGzJOur4PpngetTkyRQMx65D97GwV/pyW5
 bBg2G2VkyfvBdZcC4i2HD/Ua2MXzGzslx9Yk88qG7q1lUEPAe0sEC8+aIFqN8XNdTxzg
 vPv2jhdHhghhkBEdgB32THKL888x1MP0xjYm3dMylqNHu0+vB1Kcdma+sB+LN8GfEBI/
 LQO4ve7kRj6dcRv3RcW7keS5GSRl6ZONnJLhJ+DzeBcq9RESH6D2bodFSDkrFcwce3sm
 mbfQ==
X-Gm-Message-State: AC+VfDzmYVGUfSVl6+6dpsZ/eigyLMm6r+tOnql79ikQN++lEuN3Q12j
 mhFpWUsYGsUK9EtwxAnSBhc=
X-Google-Smtp-Source: ACHHUZ7zAFM6Dq7V8orajMad2ZhQS298/59IqNPaKHTjNhkDy/BmCTcUt0nKaEjD6f5QBgoIYDyTEQ==
X-Received: by 2002:a9d:76d2:0:b0:6b8:7cdf:c2f3 with SMTP id
 p18-20020a9d76d2000000b006b87cdfc2f3mr14788490otl.31.1688571713419; 
 Wed, 05 Jul 2023 08:41:53 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 i2-20020a9d6242000000b006b8b5bc0e6dsm4373519otk.54.2023.07.05.08.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:41:53 -0700 (PDT)
Message-ID: <aa0481b7-c1d2-e301-03ac-01d2cb6b0d78@gmail.com>
Date: Wed, 5 Jul 2023 12:41:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ppc/pnv: Set P10 core xscom region size to match hardware
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230705012736.20020-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230705012736.20020-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.089,
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

This patch breaks make check-qtest:


$ make -j -C build && make -C build check-qtest
(...)
16/44 qemu:qtest+qtest-ppc64 / qtest-ppc64/pnv-xscom-test                 ERROR           0.89s   killed by signal 6 SIGABRT
>>> G_TEST_DBUS_DAEMON=/home/danielhb/powerpc/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-ppc64 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon MALLOC_PERTURB_=231 /home/danielhb/powerpc/qemu/build/tests/qtest/pnv-xscom-test --tap -k
―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ✀  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
stderr:
**
ERROR:../tests/qtest/pnv-xscom-test.c:115:test_xscom_core: assertion failed (dts0 == 0x26f024f023f0000ull): (0x00000000 == 0x26f024f023f0000)

(test program exited with status code -6)
――――――――――――――――――――――――――――――――――――――――――――――――

I believe you'll need to take a look at tests/qtest/pnv-xscom-test.c as well.


Thanks,

Daniel


On 7/4/23 22:27, Nicholas Piggin wrote:
> The P10 core xscom memory regions overlap because the size is wrong.
> The P10 core+L2 xscom region size is allocated as 0x1000 (with some
> unused ranges). "EC" is used as a closer match, as "EX" includes L3
> which has a disjoint xscom range that would require a different
> region if it were implemented.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/pnv_core.c          | 3 +--
>   include/hw/ppc/pnv_xscom.h | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index b7223bb445..ffbc29cbf4 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -299,9 +299,8 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>       }
>   
>       snprintf(name, sizeof(name), "xscom-core.%d", cc->core_id);
> -    /* TODO: check PNV_XSCOM_EX_SIZE for p10 */
>       pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), pcc->xscom_ops,
> -                          pc, name, PNV_XSCOM_EX_SIZE);
> +                          pc, name, PNV10_XSCOM_EC_SIZE);
>   
>       qemu_register_reset(pnv_core_reset, pc);
>       return;
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index f7da9a1dc6..a4c9d95dc5 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -133,7 +133,7 @@ struct PnvXScomInterfaceClass {
>   
>   #define PNV10_XSCOM_EC_BASE(core) \
>       ((uint64_t) PNV10_XSCOM_EQ_BASE(core) | PNV10_XSCOM_EC(core & 0x3))
> -#define PNV10_XSCOM_EC_SIZE        0x100000
> +#define PNV10_XSCOM_EC_SIZE        0x1000
>   
>   #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
>   #define PNV10_XSCOM_PSIHB_SIZE     0x100

