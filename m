Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDA3745F3E
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 16:59:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGL0v-0000qR-2A; Mon, 03 Jul 2023 10:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGL0n-0000kQ-GA
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGL0l-00028Y-W6
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688396323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AxutL7BimSO96g+1PY4TTLtzSATGi8i63Fcrfm9aWc8=;
 b=dXElOdEJWWSb4YiICpB28U/2OMxHk7ODP6RFPxHy9EUtYiDE9j4zX+Td0YQH8gj5jMkxhE
 MBr3+ov/m9pibVuOTDSFl4dBpufShyavxxDReDMJyTpQwSbfwh0svFdnOU2Gb3t0bHLqq1
 YM1MR9v6cUxKNkmNBrcO34BskqWwLp4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-j44oPt1dNBSw7EjOXWj5Sw-1; Mon, 03 Jul 2023 10:58:41 -0400
X-MC-Unique: j44oPt1dNBSw7EjOXWj5Sw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-765a651a3bfso550179985a.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 07:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688396321; x=1690988321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AxutL7BimSO96g+1PY4TTLtzSATGi8i63Fcrfm9aWc8=;
 b=TZqY5hAah23l/C4e13zy1nOEDN5BMA3C5yB3ihdIciqUIAoQk4lbfAJvTbsb6M6Efk
 Q2nhR71eP/lG+LZ33oemutJNR1Nsk896hsN+t5yTQxpAMRewtAzKn/pMNZkAuIqzv6qB
 QpsBTNS9xrUpZW5e2z9xirc6c5WLlW9bgCeOg/UngRzbHOreqFfcwxRUcuJs2JvRU4Vc
 oGlrffujCI0vqGlnbr53hdI6W93Rlzbp6wSdS3Y8dPfY/tr4KPWLEc4uOOskOR2/kT2H
 5DJoZpw1Nw4XT2wA2eyriSQ8IWLtD+CE9m9OHK1vHveW2xI6SgTkW576GOCwOFpA0v/B
 OG5w==
X-Gm-Message-State: ABy/qLZwFOFBAp0CR7lNN5ynOGI0jy3EU5+FA9yzxqc7MOjg3rcCEudu
 IElVCLV1zvtYP5udoKdgEROhe4LanSJNdIFl6RduHrsSEcYzu2Q/SU1exgbm//27umb8Iv0AF6b
 hhM3yHkJBYDhTBhQ=
X-Received: by 2002:a05:620a:b53:b0:767:58ed:592f with SMTP id
 x19-20020a05620a0b5300b0076758ed592fmr6863737qkg.72.1688396321215; 
 Mon, 03 Jul 2023 07:58:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGj+pPeYdMTC9jIQvFrOumafoVIue09CJJwcKPip6tu2+8+xofwyzXLSrJV0elJxXTmOE6DQ==
X-Received: by 2002:a05:620a:b53:b0:767:58ed:592f with SMTP id
 x19-20020a05620a0b5300b0076758ed592fmr6863727qkg.72.1688396320993; 
 Mon, 03 Jul 2023 07:58:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 cx13-20020a05620a51cd00b007339c5114a9sm7327426qkb.103.2023.07.03.07.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 07:58:40 -0700 (PDT)
Message-ID: <f03d0cc8-647e-14fe-cc4e-f57941eee63f@redhat.com>
Date: Mon, 3 Jul 2023 16:58:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 6/7] vfio/migration: Remove print of "Migration
 disabled"
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
References: <20230703071510.160712-1-zhenzhong.duan@intel.com>
 <20230703071510.160712-5-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230703071510.160712-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/3/23 09:15, Zhenzhong Duan wrote:
> Property enable_migration supports [on/off/auto].
> In ON mode, error pointer is passed to errp and logged.
> In OFF mode, we doesn't need to log "Migration disabled" as it's intentional.
> In AUTO mode, we should only ever see errors or warnings if the device
> supports migration and an error or incompatibility occurs while further
> probing or configuring it. Lack of support for migration shoundn't
> generate an error or warning.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9154dd929d07..eefd4ec330d9 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3209,7 +3209,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       if (!pdev->failover_pair_id) {
>           ret = vfio_migration_realize(vbasedev, errp);
>           if (ret) {
> -            error_report("%s: Migration disabled", vbasedev->name);
>               goto out_deregister;
>           }
>       }


