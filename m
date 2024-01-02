Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B68218DA
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 10:21:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKawh-0001Es-7s; Tue, 02 Jan 2024 04:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKawe-0001EV-JR
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 04:20:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKawW-0006TI-6R
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 04:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704187211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1EdfEBT9MX8EOHvut0wpuIr7iUSuWYmnYxtyNsXqW2c=;
 b=DValNd+w73J4VZGbQA9JZ1Lq8JdESeJA21ACYD+wd4CRTYEEOpmtnw5oYJJfWXIn+ZVE4+
 QBugqMe8zpmTsLUGkaEXdZ5ViivqyDVUff4W7bitrBmHRJ9IaAgkXxwFXb+jXPk6Rqdcv0
 +BGozkGSSWSUdphqOzeMw4H99paxrV4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-QvHmy7_HP42QtDoz-rIARg-1; Tue, 02 Jan 2024 04:20:09 -0500
X-MC-Unique: QvHmy7_HP42QtDoz-rIARg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d38c09797so87557675e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 01:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704187208; x=1704792008;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1EdfEBT9MX8EOHvut0wpuIr7iUSuWYmnYxtyNsXqW2c=;
 b=vK2JpdviHP0G6HyMms9gVbacuXZFMc/pc5ib+/7jONwwchiAhWzny8h0Ves7lEO0YO
 mnXKd3iSZGMCEtye9EMXyhnIF6ROZlTuTBiADLVTAdox1icQDtsrMIC/Wquu3no7m+Va
 bf1aPDKkSTA4OHUeDOjvoslDecZyGNor2hzKsm677SWTlkypwkXLaSHbnlXUzw93J28z
 M2vvRjrQuGWDmE5kJOZunCBK1VXRJjprJ4UUOHy3ZIlTuXQwAf8uA5TqS8diGNVf1hKo
 MQ1XnmlZmQZTvDpq12F+25Rkfbeg2lcGZYmpIIYk5x5PsEq7fb3YwhgTbXUGl075zeRh
 uz/g==
X-Gm-Message-State: AOJu0YybWI0XaakvPqqGYgft1w69qH572tc51lvSCVJh59WqBSVBPOrO
 akEkxrRi+Yk52omX5DKO2FN+iQB2J1t7mW4IMDU3QF2ZCDA6R1UE55Mg4htbBeOUow7QmOXagvR
 FBlbgcH7NQY42R/OqEs5KPBU=
X-Received: by 2002:a05:600c:4496:b0:40d:41d4:d29e with SMTP id
 e22-20020a05600c449600b0040d41d4d29emr9115828wmo.187.1704187208274; 
 Tue, 02 Jan 2024 01:20:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo+WuDPylMXdoKBRvNN26pOsqGxMqMpsKByF5HUyfM6nWzP+WrEg3XxYahWVJwECnL8VgHfw==
X-Received: by 2002:a05:600c:4496:b0:40d:41d4:d29e with SMTP id
 e22-20020a05600c449600b0040d41d4d29emr9115825wmo.187.1704187208020; 
 Tue, 02 Jan 2024 01:20:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 hn34-20020a05600ca3a200b0040d1bd0e716sm43130312wmb.9.2024.01.02.01.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 01:20:07 -0800 (PST)
Message-ID: <a376d845-065a-4630-9e3b-f3a1bfea78a1@redhat.com>
Date: Tue, 2 Jan 2024 10:20:06 +0100
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
Content-Transfer-Encoding: 8bit
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


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


