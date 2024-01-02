Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3682199E
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 11:23:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKbvN-0003OU-0e; Tue, 02 Jan 2024 05:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKbvL-0003OG-9m
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKbvJ-0000g3-Q2
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704190980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tIH2bG8N93rEgertNhssWM6FGlyEVPUPpIZvm/aRBq8=;
 b=O40DidwLihqueFICbHvu0nLdJv9bm0PjL8HvPnR2i1FcU/Zf6Q98uf4tjfx11BwwX5xHDW
 jzezIp6j1d8ydP/am5VLp7hDF+tnYslu03WZp+9AJ0s62R4J9IbxsPOfxmSEq6Jv+hr1CN
 Y6VgMVlXAQy+GbtKtNwXqgn3Gin9PRg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-ENEbdwFHOFWVR7NmJFjBOg-1; Tue, 02 Jan 2024 05:22:54 -0500
X-MC-Unique: ENEbdwFHOFWVR7NmJFjBOg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2cceb983e83so28943651fa.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 02:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704190973; x=1704795773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tIH2bG8N93rEgertNhssWM6FGlyEVPUPpIZvm/aRBq8=;
 b=mTq+QsnDpbwKun8C1Q7aSw0jcnQTMTpXd/KJETFKpuK0ROfXLoevAxVdztSFeqrMZf
 aCdb78/zGrioVIXDt7UaAwB8DTB4YA+et2zHieYfvX6AGS8HoPeTNMtD3D37KYGiFDip
 cViSCLgpEGWVQT1xMjXPfWlBXyXvBWBSPflvKD20xoqJsz1Iuy/5kZp00PtUMLCUsYaW
 OLkPPp3auWIPCXz6qonF+vbo6dDM4FmAsCPa9pc09soCUheROErJzfg7/aahA0DqLeU0
 H8Lr/9zotZPZifUiMRDJI3B1KCQONZamLjcgzj16zfQLbtlO+/mmVJoE+Zsv/sJlsq/R
 VGJA==
X-Gm-Message-State: AOJu0YwtoneHeZdHDJMpnrDE7FBEZoENCDpT2MXvLuHMePQ5pXPc1Ml9
 YHuP1vlVHgSP0EHuBqNH6FXuXriU5fxKZzfbROOkRKX3Cfi0Gl1MUtVjIaObdvWirgs3fdgWLoK
 BgdhBU20ZRwBsi5rPzxrp8kA=
X-Received: by 2002:a2e:be0d:0:b0:2cd:6fa:9b9a with SMTP id
 z13-20020a2ebe0d000000b002cd06fa9b9amr947998ljq.89.1704190972943; 
 Tue, 02 Jan 2024 02:22:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbPBjwvl1BBgmDW2UN/bRue0/Jjn/IeOSUy4VkF1uTSHtRGHqVoi4Alf423WCzVg8xhAH9Zw==
X-Received: by 2002:a2e:be0d:0:b0:2cd:6fa:9b9a with SMTP id
 z13-20020a2ebe0d000000b002cd06fa9b9amr947992ljq.89.1704190972643; 
 Tue, 02 Jan 2024 02:22:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 i2-20020adffc02000000b003364aa5cc13sm28284647wrr.1.2024.01.02.02.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 02:22:52 -0800 (PST)
Message-ID: <e0249e86-2d9f-4f1b-8915-2299fcadbeca@redhat.com>
Date: Tue, 2 Jan 2024 11:22:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/migration: Add helper function to set state or reset
 device
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20231231104818.17666-1-avihaih@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231231104818.17666-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.246,
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

On 12/31/23 11:48, Avihai Horon wrote:
> There are several places where failure in setting the device state leads
> to a device reset, which is done by setting ERROR as the recover state.
> 
> Add a helper function that sets the device state and resets the device
> in case of failure. This will make the code cleaner and remove duplicate
> comments.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>


Applied to vfio-next.

Thanks,

C.




