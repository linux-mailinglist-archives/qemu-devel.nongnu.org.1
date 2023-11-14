Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3827EB598
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:35:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2xJW-0003LE-CD; Tue, 14 Nov 2023 12:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2xJP-0003KJ-GP
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:34:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2xJO-0003iW-3k
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699983293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1qFu2gHMN06BqPlJo2fr1q/wSEUSz+K+Pjgf8wNvgcg=;
 b=GpeNYAGWBac3Cz/XnID/eQijZryWq+SpGV5J/X27UWtebj/96/LBDXozjb9UzJ6R5j3ek4
 28YytcnXOto46ARbhaQm6AjK16zWTyUi5ULCp/5xkm41bE7gdVgz8mtW/x3bs1J5FESlEe
 lW2AVeXaPjSrOzbAQqAYyqHso8hU+OQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-9NTohd_WPxiMNkeS5jMrDw-1; Tue, 14 Nov 2023 12:34:51 -0500
X-MC-Unique: 9NTohd_WPxiMNkeS5jMrDw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41cc9224395so71720841cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 09:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699983291; x=1700588091;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1qFu2gHMN06BqPlJo2fr1q/wSEUSz+K+Pjgf8wNvgcg=;
 b=Y+qiAYgenjKN+Zf5KaBd8VyZWtXJpbHt/WVPTMEVD6L2TpRHgntXzcrt+ge6MRk8qq
 luuez50oQbPSoZ5CtdNWpolWS2/doMC4FZggfvxdOVOzhKtVctXsj6RDXpi8RzFQg41a
 XCi77UEY01sOe8+c9lFqqvjOmtalScgZX5dtjOyY1LXKpyZJIrVAn7ET4dRefWrZ1IJZ
 5dSL5jqDHxqfWx8zG62oLak/XOCxMrTqLaIpvyHd37gEXfbvqHZhpbmtT08Tiuk+FpYd
 WIn9lF+qx6ch8IrXOSSzmCJ17PFUT3WV0rY8GxseoJyDEAyGu/cTMHRgqFEctyu1K39X
 wiuw==
X-Gm-Message-State: AOJu0Yz0t2bczagfWi/TKhIkbD1HzCJdnevGzoac++FMylXvNOYLE5l1
 A2uNBvtgC3RFxaxpWvSv6yn1S6W9Fphpchcqh83KCY3o/AbMGLyugCiXNJu9TvSKeWDqXy4q8er
 KxsEMB49zURUQE3Q=
X-Received: by 2002:a05:622a:1ca:b0:41c:dbd9:ad3e with SMTP id
 t10-20020a05622a01ca00b0041cdbd9ad3emr3200415qtw.57.1699983291361; 
 Tue, 14 Nov 2023 09:34:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBFycB17RMXPKgivlh3EBme1FR5whWTDSIBy7kEELCdhQlpGkm4+XhJ4OBk0ONhMx4QFNx4w==
X-Received: by 2002:a05:622a:1ca:b0:41c:dbd9:ad3e with SMTP id
 t10-20020a05622a01ca00b0041cdbd9ad3emr3200402qtw.57.1699983291158; 
 Tue, 14 Nov 2023 09:34:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 j7-20020ac85507000000b0041520676966sm2895982qtq.47.2023.11.14.09.34.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 09:34:50 -0800 (PST)
Message-ID: <3da742bf-5cd1-4c28-9280-63cb1ec754ea@redhat.com>
Date: Tue, 14 Nov 2023 18:34:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial 21/21] util/range.c: spelling fix: inbetween
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eric Auger <eric.auger@redhat.com>
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
 <20231114165834.2949011-22-mjt@tls.msk.ru>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114165834.2949011-22-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/14/23 17:58, Michael Tokarev wrote:
> Fixes: b439595a08d7 "range: Introduce range_inverse_array()"
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   util/range.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/range.c b/util/range.c
> index 9605ccfcbe..f3f40098d5 100644
> --- a/util/range.c
> +++ b/util/range.c
> @@ -98,7 +98,7 @@ void range_inverse_array(GList *in, GList **rev,
>           out = append_new_range(out, low, MIN(range_lob(r) - 1, high));
>       }
>   
> -    /* insert a range inbetween each original range until we reach high */
> +    /* insert a range in between each original range until we reach high */
>       for (; l->next; l = l->next) {
>           r = (Range *)l->data;
>           rn = (Range *)l->next->data;


