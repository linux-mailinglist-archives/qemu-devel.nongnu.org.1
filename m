Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F574811E
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 11:38:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGyxJ-0005ka-Ts; Wed, 05 Jul 2023 05:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGyxH-0005k6-QY
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 05:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGyxC-00089V-Pp
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 05:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688549861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iyV1NbVItgPr80q1ZiNZekhKp10UooKWDyn6BXtlauQ=;
 b=B6NnJojVpHNmx0arb+6+2Z0qE8vNnVx1oEag6NqlrPTNlUNukER0fdbk6FBwu3xxkjS6Vu
 aqYvICLTzb/RTZ+7ySPJ0/73vck3Nx/FhLYSrcxEV37MjlMXvDryErsZ7uOHhvVtrT3NTO
 84zLAIm9BZkm49XgprqLCnMv+meJCW0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-GboxM7EDNyi9ZTHRV7032Q-1; Wed, 05 Jul 2023 05:37:40 -0400
X-MC-Unique: GboxM7EDNyi9ZTHRV7032Q-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6372702c566so13688176d6.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 02:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688549860; x=1691141860;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iyV1NbVItgPr80q1ZiNZekhKp10UooKWDyn6BXtlauQ=;
 b=Q4cWZRzaO/XYPXr8uA3QgeuldIwf9JUVonvUTcutjAMKrUDAWDzPE3HXklzMIHC/et
 kXSBS5yO6W5x0midNpHuSpJm3zww0a4/mBYjnNGV+5tqyLSBl3ViWfPl0M1PwQKG6YvW
 67yI3x4hwfsmuHTLfNi8J28aTKyDG/ErJ1rYDEINyq5zKLtRTQ/FIbgT9rWo5rHm22JV
 H8wpZVLr/XSj+loHmy3kSK1Gh83vKN5VsSrrBr8/lXUOm9fPOS6WXcLubB7q2rnkGTvI
 bXY+1aHWv+YXZjO2Ax6Kd25D8c4jDHikQEKZs9wmO9Y6GKkGbhu+4dUYHBrevT7bYIxO
 ensA==
X-Gm-Message-State: ABy/qLbSi/vps5XvBpq75BnP1y3Ys3BqGmU17IUSWESkQHT9A8xyeArH
 fQd2oVCAB9WbhYmdTByNZJ0Cm9Jm9bPzwARbcYItXpoepJif1rNGQPdxje2brH/tNuLn2ynXkWF
 ypHqZ0Ej8vkZnTJE=
X-Received: by 2002:a05:6214:1c47:b0:62f:f13e:bd73 with SMTP id
 if7-20020a0562141c4700b0062ff13ebd73mr13487581qvb.20.1688549860245; 
 Wed, 05 Jul 2023 02:37:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFHL4BEoPQCfsxDvmlF7SuoQLflGcmu7RK9w2yyR30FBEjDJ2bWBef6qAkZlLYSonjwFw4STw==
X-Received: by 2002:a05:6214:1c47:b0:62f:f13e:bd73 with SMTP id
 if7-20020a0562141c4700b0062ff13ebd73mr13487571qvb.20.1688549860047; 
 Wed, 05 Jul 2023 02:37:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 lw18-20020a05621457d200b006262de12a8csm5525857qvb.65.2023.07.05.02.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 02:37:39 -0700 (PDT)
Message-ID: <c30fb7f5-8aa4-f710-1c3e-d5c7801b1229@redhat.com>
Date: Wed, 5 Jul 2023 11:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ppc/pegasos2: Add support for -initrd command line option
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230704181920.27B58746335@zero.eik.bme.hu>
 <a789088f-c3ca-9f61-66d3-3bddfc0510fa@redhat.com>
In-Reply-To: <a789088f-c3ca-9f61-66d3-3bddfc0510fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 7/5/23 11:35, Cédric Le Goater wrote:
> Hello,
> 
> On 7/4/23 20:19, BALATON Zoltan wrote:
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> The patch is not a oneliner, it deserves a minimal commit log.

It was fixed later on. Forget my comment.

Thanks,

C.



