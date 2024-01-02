Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8EF821DD4
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 15:39:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKftv-0002le-Qu; Tue, 02 Jan 2024 09:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rKftq-0002lV-SN
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 09:37:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rKfto-0003Ue-Is
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 09:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704206261;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jbq+XaVKn2FWk/Ya3/4WcyL27Rug8ZsEKgRfXq+eH6M=;
 b=ZYRdu4fcb3nNt28vNTQBlh/nTYWP/i/X9uYISBTC1eLpQl+sR7MtR4gpoYJCzDFfx6Yh2k
 7Xpa6w7xOkcCsbGk2u/YFxHQAO1YVWn9+bG6Mi5bwgixBrpx0VXzvXMdaAohMaZZgkJNID
 sODbvGgq7CEl5FiEGfOP5ZpymIet0fY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-EBtEPv-fOoefr8ov7RVm0w-1; Tue, 02 Jan 2024 09:37:40 -0500
X-MC-Unique: EBtEPv-fOoefr8ov7RVm0w-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-680971002e3so57119676d6.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 06:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704206260; x=1704811060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jbq+XaVKn2FWk/Ya3/4WcyL27Rug8ZsEKgRfXq+eH6M=;
 b=T1f/D8nR//RbFq5bknmwO5QWOfRPN2rbo6mFxAH1tUwSvMT1PoJSgIzxbZL8u89rrD
 9YqBXr6iD12HYHkE9WOyN9T8SQZ+T7buXuiVznSPlShrX2pTncCYC9gjrcpYyHQktM+n
 pUGNi3NG7h6hSTT+Fd0qLxJZDPt5GXpsyvewrgTy+Tr1orSt1B6B58MQyhG4KPDRBjee
 PluQBsdHBDoxB1dVxYKC9GKhLe15TI/fuFZLoFd9C63zoyZin4M9fDveXt3RXRqjn7S1
 HSw8UBBVZarAmcuyS5ZhBdTJw6jtjG2HODdkDd2G9gPSuh6peiFTdzqh2fuADEWjQMOF
 0J/A==
X-Gm-Message-State: AOJu0YxJmApf5OjteHt2EeqfoNLjKGkR+3VDig42Ga4RteF/SNtcW5fL
 FVqdOqgxpNfymAWslsyRYO2K+rJq2v4kOXAHdCEA84CoUTe464n93zfRr2EJTbskBvc3CuQ3ImN
 hXf1yEjZX0wKLszsV35B8QEI=
X-Received: by 2002:ad4:5ce3:0:b0:67f:2201:81df with SMTP id
 iv3-20020ad45ce3000000b0067f220181dfmr32408054qvb.28.1704206260101; 
 Tue, 02 Jan 2024 06:37:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFee0bphBILMM7DyPOInrWpf9fdcEvyLW4elwBStC27478IsAEPHLMZLXVx8AZX7YCZswndIw==
X-Received: by 2002:ad4:5ce3:0:b0:67f:2201:81df with SMTP id
 iv3-20020ad45ce3000000b0067f220181dfmr32408041qvb.28.1704206259923; 
 Tue, 02 Jan 2024 06:37:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a0cdc82000000b0067f49eef3b1sm10109443qvk.114.2024.01.02.06.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 06:37:39 -0800 (PST)
Message-ID: <f7ef0a77-3745-4cd8-95df-35c496fa678f@redhat.com>
Date: Tue, 2 Jan 2024 15:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] backends/iommufd: Remove mutex
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20240102123210.1184293-1-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240102123210.1184293-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Cédric,

On 1/2/24 13:32, Cédric Le Goater wrote:
> Hello !
>
> Coverity has some reports regarding the IOMMUFDBackend mutex. Since
> the IOMMUFDBackend routines are called from the QEMU main thread, this
> series simply suggests removing the mutex and rely on the BQL to
> handle concurrent access.
>
> Thanks,
>
> C.
>
> Cédric Le Goater (2):
>   backends/iommufd: Remove check on number of backend users
>   backends/iommufd: Remove mutex

for the series:
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thank you for the fix!

Eric
>
>  include/sysemu/iommufd.h |  2 --
>  backends/iommufd.c       | 12 ------------
>  2 files changed, 14 deletions(-)
>


