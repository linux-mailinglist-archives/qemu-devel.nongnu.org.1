Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A859D9B5F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Nov 2024 17:26:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyO4-00045c-3h; Tue, 26 Nov 2024 11:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tFyNZ-0003vT-7H
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:25:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tFyNW-0003Ow-70
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732638324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eaXSUrSzDyqyBCYMtv59u+5Y36ny2i2aqn9R89gpmvE=;
 b=PbPLKjpoPSwnheuE10rBpOSKS3LLpnEBLKmLBBKk+VRlPZfRvrioHjbSWTo7YbogpYSspp
 CjSzONGQTMbpasiESGT5XxZ75yiNvtX4uIGM4zgszPO+o4i/DCCwdZA8ZIVWkboVACtM9G
 FJdV0l4OKZEtKe87Fr/tzWz/n119fp0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-1o4Gcct9M9Kxr36zhYSrOg-1; Tue, 26 Nov 2024 11:25:23 -0500
X-MC-Unique: 1o4Gcct9M9Kxr36zhYSrOg-1
X-Mimecast-MFC-AGG-ID: 1o4Gcct9M9Kxr36zhYSrOg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-434a37a57dfso11845615e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732638322; x=1733243122;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eaXSUrSzDyqyBCYMtv59u+5Y36ny2i2aqn9R89gpmvE=;
 b=tjhAxMrVz5PgqSlVwllMkLwjO1sgfbIV7aBni+rPaieoPe/dRMh9ZfYqfTIxYRaov9
 ZmgQQA9hVKRCKxDI0ZLKvbQz3m13Pf5wRI2nTthmKzKjarx+Rm6IcW9RTHWssV9Km7ps
 0fRHuB2X8dFecRuV5fHGx6wBLEDoaNBW8aYucIZ2rcHRvGbWlkcmD1L4quyvZV5hryaW
 fTQEOefS4QKT5qXxly1x/DaBfbqaTCWlwDxVvGGNRxKsr0RhC6QC+FhsNcWk9MnnQVnF
 hkuv7nPADdt84rqipywc7fy9y58aLFHNMI5JwTbgKKFfU4f1b1GsATca2ZLFGu5a+uhB
 sdAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNsk/wPKEoih7LhVFfLsTem/zBJ1z5d5tezUyOZPUzzcTyoobWVpXYe5THyHIjJtMCGWBcTCqCoJ8R@nongnu.org
X-Gm-Message-State: AOJu0YzSNIM89CW6suPtx2eqkDCMsPIQH5B7SgxnJEma73U/5Bz+zPD4
 bH3zkG0/sL0KT+GZL8MHZ/Dl752SH7npPcMN3x9zOEsfIw4IeVOuObXFMQmx2P4PQv30YezqhhH
 dSfTwSlEbNOf+FO231f7MHe4mvdPsUfDs4b69E+TaSSgD8qP5rseA
X-Gm-Gg: ASbGncvCu1QaC9myaFlcEQMqe/gjyMHmuzjs4yp+vzNvjIsLcJo6DXf/dRX8qF/nFPe
 xSSUPSFEcwElDE4qr/S8sFpigh1Gm6roVvYDetQ3iIggd34B0zTrJArw7fG8hVz0AiElFBABZub
 O0kF2VllE/lEaeNZ0NZ8gs+io7IvxQ61JQRSsi2eKwD0ekecoQjQwUW0RwCc5R2gPSMMLtflG56
 E7sdtzy19mhawZpIN+8rzKGm49OOfQx/ZBMnI4Cr6mla+ycUYqrHXh2dDhuSpS9rpqy/39zDAwX
 Ze2AKck3EuHx
X-Received: by 2002:a05:600c:1c25:b0:434:a504:7a51 with SMTP id
 5b1f17b1804b1-434a50489demr29734155e9.21.1732638321870; 
 Tue, 26 Nov 2024 08:25:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqcELqZJgvT2XXxcJjawvyQcHbclrdqXALbnF+wv+Bk0y2yDRZ4msBDMCXETY3MOIj/Ky+Tg==
X-Received: by 2002:a05:600c:1c25:b0:434:a504:7a51 with SMTP id
 5b1f17b1804b1-434a50489demr29733925e9.21.1732638321513; 
 Tue, 26 Nov 2024 08:25:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a15d86a4sm57725305e9.36.2024.11.26.08.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 08:25:20 -0800 (PST)
Message-ID: <955b56c1-d749-4266-adff-54dc78ceda6e@redhat.com>
Date: Tue, 26 Nov 2024 17:25:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/24] migration: Clarify that {load,save}_cleanup
 handlers can run without setup
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <b082ad4d76ab10e4078acdf25b2bad4278a98331.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <b082ad4d76ab10e4078acdf25b2bad4278a98331.1731773021.git.maciej.szmigiero@oracle.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/17/24 20:19, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> It's possible for {load,save}_cleanup SaveVMHandlers to get called without
> the corresponding {load,save}_setup handler being called first.
> 
> One such example is if {load,save}_setup handler of a proceeding device
> returns error.
> In this case the migration core cleanup code will call all corresponding
> cleanup handlers, even for these devices which haven't had its setup
> handler called.
> 
> Since this behavior can generate some surprises let's clearly document it
> in these SaveVMHandlers description.

I think we should spend some time analyzing the issues too. I would prefer
to avoid the changes in patch 18 ("vfio/migration: Don't run load cleanup
if load setup didn't run") if possible.

> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/migration/register.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index f60e797894e5..0b0292738320 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -69,7 +69,9 @@ typedef struct SaveVMHandlers {
>       /**
>        * @save_cleanup
>        *
> -     * Uninitializes the data structures on the source
> +     * Uninitializes the data structures on the source.
> +     * Note that this handler can be called even if save_setup
> +     * wasn't called earlier.
>        *
>        * @opaque: data pointer passed to register_savevm_live()
>        */
> @@ -244,6 +246,8 @@ typedef struct SaveVMHandlers {
>        * @load_cleanup
>        *
>        * Uninitializes the data structures on the destination.
> +     * Note that this handler can be called even if load_setup
> +     * wasn't called earlier.
>        *
>        * @opaque: data pointer passed to register_savevm_live()
>        *
> 


