Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AAF7D4E9F
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 13:12:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvFJk-0006SU-Jo; Tue, 24 Oct 2023 07:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qvFJj-0006S9-9e
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qvFJe-0007Dy-8v
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698145877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RChJWE2y6/tCBvq1YkNyLicJxwV2Yr9RULCgy5swXOs=;
 b=TSIeG3Z1XyzkkwSoQzjwG6Bxzu7qPSRgOTjaa9GUIU/bVjPozm8nY5DVZN8F9juL3CCvpk
 Bs5o790zL6Tqf5ubqCm0VaWoIBjAeiC8hmsWZIsHmMRYA4P2rmFkUnCBSyXuyWLzJPq7fl
 JY+x5L3n9pTwK7IUdlUO5SoXZkk2zqM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-QiMR3eMdN-Sb5Ei2KlztZA-1; Tue, 24 Oct 2023 07:11:15 -0400
X-MC-Unique: QiMR3eMdN-Sb5Ei2KlztZA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4083717431eso26103385e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 04:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698145874; x=1698750674;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RChJWE2y6/tCBvq1YkNyLicJxwV2Yr9RULCgy5swXOs=;
 b=DcMvNaKS+2ku/r+ohsLfw+wjO7umXeTCtY2xjz1jtWPqY9xAXVmiFDwHDpWsoTTpS6
 X8qBOOzXaneuz09DeizI1g8YkSmAD8sCgZk54gFjq6TjkGv3X5DQKyXImBp9RRNAesMC
 l88cvMR4kTKulo9B8mGf6PVb+JCmXwMzVHka4JvuGerWHekmUmTfn5evIurQya9sN+m6
 HUMEUUewHQvurwGZgOpHooVutwQlrfzdu0wGhcCOSkymYkALCAYK3OczzU8nnrsPrYJn
 lbRzFphIxuk/St/ku559L4eJfQaqKOWo1fBDGk6YyKA7E4RrRJEqZWX2niyTnFYyI8au
 MamA==
X-Gm-Message-State: AOJu0YwhsnRwOS2Zw5tXp8v+Hka9jlf/6BzgPHB+5EG8A8NiyGQucb+6
 tEH/pOX954n1YCrPH55VYARycyNNWHkFAD7ZZWPSjSIlcaQPiphnY8G3o25uYQa0bi1a6nqKKOm
 T/Hu5TFTszNtq/bY=
X-Received: by 2002:a05:600c:450d:b0:404:2dbb:8943 with SMTP id
 t13-20020a05600c450d00b004042dbb8943mr10473753wmo.2.1698145874079; 
 Tue, 24 Oct 2023 04:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjyXoZD1+hMnXtdhPwFj1ZG1LmZ5VuV25ZdV9QPytjVmq63bQMvRY1TDIncbhE2PP17dF1lA==
X-Received: by 2002:a05:600c:450d:b0:404:2dbb:8943 with SMTP id
 t13-20020a05600c450d00b004042dbb8943mr10473734wmo.2.1698145873766; 
 Tue, 24 Oct 2023 04:11:13 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c1c1400b004065daba6casm16759103wms.46.2023.10.24.04.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 04:11:13 -0700 (PDT)
Message-ID: <0eb68c96-457f-471f-ad2f-f6282eaf04a2@redhat.com>
Date: Tue, 24 Oct 2023 13:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/5] qemu-iotests: Filter warnings about block
 migration being deprecated
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>, libvir-list@redhat.com
References: <20231018115513.2163-1-quintela@redhat.com>
 <20231018115513.2163-2-quintela@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231018115513.2163-2-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18.10.23 13:55, Juan Quintela wrote:
> Create a new filter that removes the two warnings for test 183.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   tests/qemu-iotests/183           | 2 +-
>   tests/qemu-iotests/common.filter | 7 +++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


