Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 957E879711D
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 11:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAz8-0006Cp-6Q; Thu, 07 Sep 2023 05:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qeAz2-0006CI-AG
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qeAyq-0002av-OP
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694077635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ca5SvaGFhydrtHFnQTGuyLgLeuxIWWbec59ogaRMFHI=;
 b=VbQ/hDlD+qykphJHyZQnaQZAyY9eUmTpu1gx0C/Q43AyY+9ojwdwYiHimIfgfLKouIDvWS
 rWoEpDyLksBfIV+WgVP2GNEerQHbCZFKjWg+T4/YGhl2Bh3tI3HZXb1MzwXcLjDNSOF33v
 ITJ/8KuaJVT0A8p5lFm8WPYXjDhlZi8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-mt9_AOxZOHOJGZAG5WHCcQ-1; Thu, 07 Sep 2023 05:07:14 -0400
X-MC-Unique: mt9_AOxZOHOJGZAG5WHCcQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4135f2b4d3fso8792201cf.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 02:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694077634; x=1694682434;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ca5SvaGFhydrtHFnQTGuyLgLeuxIWWbec59ogaRMFHI=;
 b=TABKksbdOEjFxitFP4Uf8jKaXFtUbDbK1CQz+mObObuqOTln3XSm8YlGtEhT5MrJDr
 xmdrlsSLmBuSniN+oXNk50m1uY6Pd4LzIrUOUvZr9iyoGmlOScfsba+tIOsF90v3OOjZ
 K64qBq0jl67uVtOtL+1tRabdKldvxl+JwNFqBn7EwL4a6pzoOwtEhWwKDgolAkrsuNfH
 vOAiRLWFbR0GxDchc7DvAsD4wzDd7GTLXA1ja/qo6Lg8k8vufJ4jqsXoj+zbs8pa96lF
 FgQ4UAp5ZZCdZwaNmb+sBZEVWeDspKm53KtcekIf8LFP6RU1QOgsz5Zw3KWaWlFajPdI
 f4hg==
X-Gm-Message-State: AOJu0YwAmrnxUgX3XGjQh7tp/oae4tCImYMnnuOx8GNMW49hx7imfW0e
 gfHQts6Or1BLBl9em6SzcyFpqOkJo8uj76K76HOTYaq7MHCvY7trbMtkcG7CwYcjC+D0F3b5RZv
 W/VaV1App5/9FIpY=
X-Received: by 2002:ac8:7e94:0:b0:412:2911:7e16 with SMTP id
 w20-20020ac87e94000000b0041229117e16mr22419464qtj.24.1694077633980; 
 Thu, 07 Sep 2023 02:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBg3P5zYPFq/Dt8mSh4MdgwfWK2Fy5HcI4l6fZ5yG5J3Qes/sEAS/YRrh4AD/WoIgg6mXwAA==
X-Received: by 2002:ac8:7e94:0:b0:412:2911:7e16 with SMTP id
 w20-20020ac87e94000000b0041229117e16mr22419456qtj.24.1694077633755; 
 Thu, 07 Sep 2023 02:07:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h16-20020ac846d0000000b0040ff387de83sm6025787qto.45.2023.09.07.02.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 02:07:13 -0700 (PDT)
Message-ID: <a79d5831-4ec7-89d4-2b5c-270b80229dc4@redhat.com>
Date: Thu, 7 Sep 2023 11:07:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/6] vfio/migration: Block VFIO migration with postcopy
 and background snapshot
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>
References: <20230906150853.22176-1-avihaih@nvidia.com>
 <9a962af2-1748-017b-9ab3-fdf7d9f84b4b@redhat.com>
In-Reply-To: <9a962af2-1748-017b-9ab3-fdf7d9f84b4b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[ ... ]

> Applied to vfio-next.

On that topic I am preparing a PR.

Juan, Peter, Leonardo, is it ok for you if these migration changes
go through the VFIO tree ?

Thanks,

C.


