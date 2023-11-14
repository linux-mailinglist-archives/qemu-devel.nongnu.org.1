Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DF17EB568
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:15:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wyw-0002LM-H6; Tue, 14 Nov 2023 12:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r2wyu-0002KY-A0
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:13:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r2wys-00088O-QM
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699982021;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ChLaxQpTaN/ipJnuh8jYkBNezYnnWFz964ifrrqwoZM=;
 b=i+7Inb3jc3HOeX5njM+tGrZ8XAdbDPsXvZQdbQ02POzO6sXqNFBaWsLvILcfZZdTiHHhcF
 XWppKmWCQ9mV2h/+Nnpu2RuWIL6ih0jJp+VPTz0YOETwlMmkfHnlBVmY0BgiqfV4JyhKhY
 AxLL7Oyadm+7X9IgqMvkfTgTIWaRRwU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-xlAC3xpQPXyYwcEILx47wQ-1; Tue, 14 Nov 2023 12:13:40 -0500
X-MC-Unique: xlAC3xpQPXyYwcEILx47wQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-670aa377deeso76155696d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 09:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699982019; x=1700586819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ChLaxQpTaN/ipJnuh8jYkBNezYnnWFz964ifrrqwoZM=;
 b=MK6mcL6pjYEYBQjrf2Ok068EpRg3s/qV11wiPD0xcCsg/dCiNdd8J11NqHVHa3DTXE
 +ETdk2Q0rgpW5dn/rrnI2zUZ6YQ7OFNnVDPSzekeM/tI+bnCSBRUbjAXBYVUarJBeaAC
 cH1g5QgdSzaA9yECdTT+rpPk1rwS6DKL/nxXLgYpiseh48++bENblIV3TSExCJKgJJa8
 JFrtOSsOV7U3qFG+CKh06WmyOKhwmwwXb6tV3THPfArTo3xHRPmx2CbER6ITzU9IjdXM
 IXluYkPGHKZtoYMh9KARVskhgmsRp/dHEERfnSYy8BbkdrqOrnba819aLvhCisdy5oCx
 o/Nw==
X-Gm-Message-State: AOJu0YzExBJCn+1zqdQ7jboyqP8nboAF8md4MmtHnwaERtfGfhzGZ62H
 mOomGSQUJSQ2XGUN+3PXUkhANlz0N5QJvgLUvn5QUlfCXCZ4sSaE3l3mXiyJZLk5tiGRfGsAt/K
 cYep8X1+5o2eCdgU=
X-Received: by 2002:ad4:5846:0:b0:66d:4191:91ee with SMTP id
 de6-20020ad45846000000b0066d419191eemr2931322qvb.51.1699982019593; 
 Tue, 14 Nov 2023 09:13:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEl4jqGKzbUznpN0ZoFavBM8erB55HSL9TOcXRDxKOhpoPYGf3er4dLiDxEFlJ2E6Vb1OtGPA==
X-Received: by 2002:ad4:5846:0:b0:66d:4191:91ee with SMTP id
 de6-20020ad45846000000b0066d419191eemr2931308qvb.51.1699982019357; 
 Tue, 14 Nov 2023 09:13:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 o13-20020a0ceccd000000b006624e9d51d9sm3036318qvq.76.2023.11.14.09.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 09:13:38 -0800 (PST)
Message-ID: <24f9d094-f6a4-4510-9a2b-75949e96bf1d@redhat.com>
Date: Tue, 14 Nov 2023 18:13:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial 21/21] util/range.c: spelling fix: inbetween
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
 <20231114165834.2949011-22-mjt@tls.msk.ru>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231114165834.2949011-22-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 11/14/23 17:58, Michael Tokarev wrote:
> Fixes: b439595a08d7 "range: Introduce range_inverse_array()"
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  util/range.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/range.c b/util/range.c
> index 9605ccfcbe..f3f40098d5 100644
> --- a/util/range.c
> +++ b/util/range.c
> @@ -98,7 +98,7 @@ void range_inverse_array(GList *in, GList **rev,
>          out = append_new_range(out, low, MIN(range_lob(r) - 1, high));
>      }
>  
> -    /* insert a range inbetween each original range until we reach high */
> +    /* insert a range in between each original range until we reach high */
>      for (; l->next; l = l->next) {
>          r = (Range *)l->data;
>          rn = (Range *)l->next->data;


