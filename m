Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AB7802B30
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 06:04:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA16x-0001yB-0g; Mon, 04 Dec 2023 00:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA15h-0001rs-Hm
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA15e-0001VM-GK
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701666109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bi0k+Gt2DbcretUI8IY1MGTcXkh80nxSh8qKjblyyME=;
 b=LMO19ux3SWbUcxoWO5+D5B8sZtTymNdtgSFREWJxkL6QdRyb8BXDxl286JujpaKyaTsXoh
 50uKBXntVZNA8uG2TqaEKIUEL2WstMi2dIeu515QDeX4Bj1FZ39z1gADVJEqxSrSQ2SutU
 seg5lsVsDUhFVNuOE3UmttM+rM/toeM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-9hNNtTysOXC-1Sz97ORWxg-1; Mon, 04 Dec 2023 00:01:47 -0500
X-MC-Unique: 9hNNtTysOXC-1Sz97ORWxg-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d04dbb4811so35015695ad.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 21:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701666106; x=1702270906;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bi0k+Gt2DbcretUI8IY1MGTcXkh80nxSh8qKjblyyME=;
 b=okvC3fiTSetQb7E3kIPInTM37tSJFkVvTpV2jTD6swbhUCgMDSzQASDlGHr65CHa2N
 IKzcaLLFzMdkb+u5XJ63egRQ/ERKl3M79XrH6vgvaZDbqvJFBnhKvG0+id00T4ncWf4n
 MRmZrMuJIkwEWHsTdPyzHnQZesqNlnChyXZdWUZPdNqmai5vRKSbqShi3gH5EygYSZpr
 +XASeXADUZmLJytyIt79rYbWCNnLJZeCH9QS23iuiHsZ69QEIxoH6ILnuCqZHYOYLcbO
 Z4nBO1pGjNvEZOEjxz7F3YDq5ZI204m24sB/IQ9NgQI0VwYtAXqHdi781/wfiJx7PkcX
 iNxg==
X-Gm-Message-State: AOJu0Yz5/ZWDzR359/otMLAvZvcZUkTuyrstiSRKhNpOhUBErOabnjFd
 JQ4hmVODOIPdfzsMnqz0eXMsVKQfvJWXM9QH1M/nIycJ1Xdk2Z22p1D12LJPwKX4XAHnQvcCeQ8
 8hdeRnaYlZmfwHtB2g/otazo=
X-Received: by 2002:a17:902:c404:b0:1d0:6ffe:9fb with SMTP id
 k4-20020a170902c40400b001d06ffe09fbmr4607837plk.89.1701666106397; 
 Sun, 03 Dec 2023 21:01:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB8FX+XnfkVKF3OWpEo2ps6wrWjY7UIKfRtCdJnEohWc0FYvzDTZlnQvZWMrDm5xoizm5Q7g==
X-Received: by 2002:a17:902:c404:b0:1d0:6ffe:9fb with SMTP id
 k4-20020a170902c40400b001d06ffe09fbmr4607818plk.89.1701666106153; 
 Sun, 03 Dec 2023 21:01:46 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.21.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 21:01:45 -0800 (PST)
Message-ID: <24295035-aafe-4c92-958e-31968a2ec3fd@redhat.com>
Date: Mon, 4 Dec 2023 15:01:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 21/25] hw/arm: Simplify memory_region_init_rom()
 calls
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-22-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> Mechanical change using the following coccinelle script:
> 
> @@
> expression mr, owner, arg3, arg4, errp;
> @@
> -   memory_region_init_rom(mr, owner, arg3, arg4, &errp);
>      if (
> -       errp
> +       !memory_region_init_rom(mr, owner, arg3, arg4, &errp)
>      ) {
>          ...
>          return;
>      }
> 
> and removing the local Error variable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/fsl-imx25.c | 13 ++++---------
>   hw/arm/fsl-imx31.c | 13 ++++---------
>   hw/arm/fsl-imx6.c  | 13 ++++---------
>   3 files changed, 12 insertions(+), 27 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


