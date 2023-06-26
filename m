Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8FC73E55B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:40:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDpFQ-0004fk-Ua; Mon, 26 Jun 2023 12:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qDpFP-0004ey-6m
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qDpFN-0008Fi-CF
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687797564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=garBrlVDJrKl7+FDKkQjFB93wXXuczjXyNFP2TUkEow=;
 b=CQjpE0dl5GGhXRwQlS+YAF02t1JZupICsqFvozaUGdAQoo58EhveBbYx3yc8hg2berN+3o
 NKjGyfazkcHOw+3OSbg+14/Q8RHeXethwiEuiKKppsFTetDcUPHUlNGbAr+BIk2lxvGvJ4
 1enu18g1wV+enCVmdG0bBvzD880yd+s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-XIwDZ7b1PVitxcsw2lBbfA-1; Mon, 26 Jun 2023 12:39:20 -0400
X-MC-Unique: XIwDZ7b1PVitxcsw2lBbfA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3fde20eded9so37334811cf.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687797559; x=1690389559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=garBrlVDJrKl7+FDKkQjFB93wXXuczjXyNFP2TUkEow=;
 b=YJjdLHeq17raS069NeegMODgqLDb1lJ5cHZhaM1K6Q0dVIdoExwZs35l1UHSth0F9y
 +Xr5gir0wux8js7YyqRGpQ7ItmD5aqLxG6plJFDJaj4vUEFRxRATYsKY8HqhThe6yZaR
 8/fLserjgY+fiAWxxJ7Y8Gl+xaGY1nYQMsYZg1htuEmoQKVJzqzGAJBw7vZIfE8Wkuxe
 Rs7z9BaTKc1BhfVhQjiCFhsPAnqvPf1m74GoBexrIyNwHtaC8lsGmcUbtKyLPiLPFHvy
 GG885V728CpPU1FgSGovqKa6TOY91tDZQODYSAO/hqvrKoyF57NuEUdq56y6D82/1ls6
 /UrA==
X-Gm-Message-State: AC+VfDx/M6M/EEl0OhsYGxOK43KdJJMb0AntomywfUulTIAU9BmbphSc
 roJ6ZLTp6A00wVSXFFsQs2zvDQLQsupxdC6yTPHLYzyGEB/9IF4DjAqvWcufcwj9/YMaQrQ7wcy
 GO3SVI34x58PQq3M=
X-Received: by 2002:a05:622a:19a7:b0:400:a5b2:92d7 with SMTP id
 u39-20020a05622a19a700b00400a5b292d7mr4161376qtc.14.1687797559582; 
 Mon, 26 Jun 2023 09:39:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FKWyq/MudOOvgV0w9EaVnOq+o32+ON1RnJ27GgJ1dapbx6lsc7ewItcG3U3CDevhQ4r8gSA==
X-Received: by 2002:a05:622a:19a7:b0:400:a5b2:92d7 with SMTP id
 u39-20020a05622a19a700b00400a5b292d7mr4161352qtc.14.1687797559278; 
 Mon, 26 Jun 2023 09:39:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 y19-20020ac85253000000b00401eafa8f1fsm48938qtn.24.2023.06.26.09.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 09:39:18 -0700 (PDT)
Message-ID: <22784bf5-b4bf-2fb7-985c-dfd69899ed1d@redhat.com>
Date: Mon, 26 Jun 2023 18:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, qemu-devel@nongnu.org
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-4-avihaih@nvidia.com>
 <cd94caa3-cb16-f44e-6ffc-2e8fc37e9441@redhat.com>
 <62b1ce2a-8191-fc6b-c7b7-e4c787deacf5@oracle.com>
 <78ef9a6d-25ac-e0ac-ca52-5a0673df661e@redhat.com>
 <ZJm6mqJeYS7qMAWR@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZJm6mqJeYS7qMAWR@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 6/26/23 18:19, Jason Gunthorpe wrote:
> On Mon, Jun 26, 2023 at 05:26:42PM +0200, Cédric Le Goater wrote:
> 
>> Since dirty tracking is a must-have to implement migration support
>> for any existing and future VFIO PCI variant driver, anything else
>> would be experimental code and we are trying to remove the flag !
>> Please correct me if I am wrong.
> 
> I don't think we should call it experimental - it is like other qemu
> options where we can choose to run qemu in a suboptimal way.

In that case, whether the driver implements dirty tracking or not
is not a condition to enable migration, only the host kernel driver
support is.

C.


