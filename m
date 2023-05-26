Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B3E7121D6
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:08:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2STn-0000uT-FB; Fri, 26 May 2023 04:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2STk-0000u4-Am
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2STh-0003wt-U0
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685088433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rj6mlL93a2054rvUvJhZOabZvE3jhZrKhvFxSZ8eE4=;
 b=EZ2DfN3fmmqwEBsFUhXaDUEGAUe5fcZ6xpep+LePu+97LHNf3+oRxaxqZp5h1cQovjAEFb
 SBWfXsb2TiRx+WyMDKtAfZiw+Wj74t0E8F4MAfOsxjlR+oOr95zv0xjNczJE5Zd4thTnZ2
 ObVdjVH+utJM0dqPd98Fnwz2Fx6nzsY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-QHnXAsGLMRGXsZY7wfD2_w-1; Fri, 26 May 2023 04:07:11 -0400
X-MC-Unique: QHnXAsGLMRGXsZY7wfD2_w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30940b01998so180940f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685088431; x=1687680431;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7rj6mlL93a2054rvUvJhZOabZvE3jhZrKhvFxSZ8eE4=;
 b=T0sTekXII9CcnK9/IkqsQwQp8tb73O1G95ABwRUR2WH4XEK3Zfn149ErcYAFiYY3qr
 2DJxXRJyIsmS/uAc9LCMwKTSJ8Jxr8laQh6LtJGoAVSxG1or7pXUOY/VGWfTdAZr/9J0
 QsVWkxLt5FMQ8/OlIxdbmwYnzWL5uXA8eRmH8jZw6kvCFx35zzJ+Sa1oX07cPaTWLF6u
 vsejVYV2Gjs8nEmR37dbDzeK//oolLMzeaWmbN5G7iksb4psRQ5iETeCIoo9befq3V1F
 J9NoTTti3x8KIlpkk0EgzJuefTvrhFqkqN9Vs9QaWEwVyJhTQsWIxnG8YLkgD8mEq8rS
 VtaQ==
X-Gm-Message-State: AC+VfDyuapn752mqLUatgzICrsSOFk/N0lx8KIR9jDqjduQYSbZpwEXP
 pzq+RCacv3bmKz0ITWM50JR7RHCEaSD9cLHujmPFKZRq3xViBrjVP/Hda25DoWk62/8E+HD9DB9
 bd6Rd+r+q1C3pYNQ=
X-Received: by 2002:a05:6000:1204:b0:30a:c35d:25d5 with SMTP id
 e4-20020a056000120400b0030ac35d25d5mr720157wrx.26.1685088430912; 
 Fri, 26 May 2023 01:07:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6AHWn+n2I2SdU7H00n8/vTzxduiRn+Wr+lra63oNVVZtcLGh1zHYtMVvUuz7Lc2VxN3PLJQA==
X-Received: by 2002:a05:6000:1204:b0:30a:c35d:25d5 with SMTP id
 e4-20020a056000120400b0030ac35d25d5mr720129wrx.26.1685088430621; 
 Fri, 26 May 2023 01:07:10 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-189.web.vodafone.de.
 [109.43.176.189]) by smtp.gmail.com with ESMTPSA id
 k7-20020a5d66c7000000b00307a83ea722sm4203751wrw.58.2023.05.26.01.07.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 01:07:10 -0700 (PDT)
Message-ID: <9b2b8178-5567-a9f3-ade1-a6b2e55ea133@redhat.com>
Date: Fri, 26 May 2023 10:07:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pnv_lpc: disable reentrancy detection for lpc-hc
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 Alexander Bulekov <alxndr@bu.edu>
References: <20230526073850.2772197-1-clg@kaod.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230526073850.2772197-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26/05/2023 09.38, Cédric Le Goater wrote:
> From: Alexander Bulekov <alxndr@bu.edu>
> 
> As lpc-hc is designed for re-entrant calls from xscom, mark it
> re-entrancy safe.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> [clg: mark opb_master_regs as re-entrancy safe also ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/pnv_lpc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 01f44c19ebba..605d3908617a 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -734,10 +734,13 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
>       /* Create MMIO regions for LPC HC and OPB registers */
>       memory_region_init_io(&lpc->opb_master_regs, OBJECT(dev), &opb_master_ops,
>                             lpc, "lpc-opb-master", LPC_OPB_REGS_OPB_SIZE);
> +    lpc->opb_master_regs.disable_reentrancy_guard = true;
>       memory_region_add_subregion(&lpc->opb_mr, LPC_OPB_REGS_OPB_ADDR,
>                                   &lpc->opb_master_regs);
>       memory_region_init_io(&lpc->lpc_hc_regs, OBJECT(dev), &lpc_hc_ops, lpc,
>                             "lpc-hc", LPC_HC_REGS_OPB_SIZE);
> +    /* xscom writes to lpc-hc. As such mark lpc-hc re-entrancy safe */
> +    lpc->lpc_hc_regs.disable_reentrancy_guard = true;
>       memory_region_add_subregion(&lpc->opb_mr, LPC_HC_REGS_OPB_ADDR,
>                                   &lpc->lpc_hc_regs);
>   

Tested-by: Thomas Huth <thuth@redhat.com>


