Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A15A70B694
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 09:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1014-0001j2-Ii; Mon, 22 May 2023 03:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1012-0001is-9z
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1010-0001FG-W4
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684740694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W8kuLNohnKOx3ExNVEfyvrydeQ45tZ4mo/9wrXAhEKM=;
 b=bTGx3HGfsemROaOTWzr3crajn1l+hxGhaa2uWo5vPy9rT8i7tzCNHFfCyP5cQmXzEseMCg
 lfA7Z+UVOW/oQXmwxv4vZI63f70V09DucUH50htOKg8vG0czpPEE9IPA6iVnM9kXvT/Vgj
 SnC86EbN6emCrCSq5PvZqmvec6yv7DY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-Vq0mj1DqPv2SZIA3EvA7WA-1; Mon, 22 May 2023 03:31:29 -0400
X-MC-Unique: Vq0mj1DqPv2SZIA3EvA7WA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f60162f7fcso3808605e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 00:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684740689; x=1687332689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W8kuLNohnKOx3ExNVEfyvrydeQ45tZ4mo/9wrXAhEKM=;
 b=OtOtpQNvH4jhApdw09gLd6QGrKqOO8c9TFTDZMymJG711FOh9aUTQNERtrRDn1qlCy
 Uohs3QWvoOr1TClhMDBWIQnUtjV/RZnH7Aaefr7JC5PxbmV1EwD21aGlPQewDkdxY+1V
 7tSmCVBNaS4A2D1Kc6zcK4pDHv+nveUfr5AUyyqmmMwUkZnQFijC85wROCZbZ3oRRUN/
 jeoqm/23HmysxklrI/SFuz5zV7XZzo0RNVb+hm80b14UMt4AFlFTJfjmTY8L1F65SSp0
 jHLVm9H48iH93QQG5krE1wd3iEcykaSmX6nad1RQS3YqnnWhFo7+nnjKrTMkfAbFMba0
 XEWA==
X-Gm-Message-State: AC+VfDw7Y5LxAXPMsWMM0Nq7dFfg1+Y2oWEnos8JqoseQTNaDuo3h1VR
 zYDz0/xNAf7ZNjG/dDEbA+p4mK8+jDvKv+4MqLiG8N5SToJLmnVf7TejTJ22rIq2nzItTmMnLjD
 hGyK9pDpPEAq0ZH8=
X-Received: by 2002:a7b:c7d7:0:b0:3f6:514:bddd with SMTP id
 z23-20020a7bc7d7000000b003f60514bdddmr1015877wmk.2.1684740688955; 
 Mon, 22 May 2023 00:31:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7WeJsjV2NHo88dZfXAex4a45EcjXqs+0kuw82a3of3j5IE+559knGclZwSgg2f9NCP5RmgTQ==
X-Received: by 2002:a7b:c7d7:0:b0:3f6:514:bddd with SMTP id
 z23-20020a7bc7d7000000b003f60514bdddmr1015850wmk.2.1684740688627; 
 Mon, 22 May 2023 00:31:28 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-148.web.vodafone.de.
 [109.43.178.148]) by smtp.gmail.com with ESMTPSA id
 o5-20020a1c7505000000b003f0ad8d1c69sm10508880wmc.25.2023.05.22.00.31.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 00:31:27 -0700 (PDT)
Message-ID: <617135d9-8c69-8a1a-0018-93fb52015ea1@redhat.com>
Date: Mon, 22 May 2023 09:31:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 5/8] qtest: use cpu interface in qtest_clock_warp
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20230519170454.2353945-1-alex.bennee@linaro.org>
 <20230519170454.2353945-6-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230519170454.2353945-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.098, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 19/05/2023 19.04, Alex Bennée wrote:
> This generalises the qtest_clock_warp code to use the AccelOps
> handlers for updating its own sense of time. This will make the next
> patch which moves the warp code closer to pure code motion.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/sysemu/qtest.h | 1 +
>   accel/qtest/qtest.c    | 1 +
>   softmmu/qtest.c        | 6 +++---
>   3 files changed, 5 insertions(+), 3 deletions(-)
Acked-by: Thomas Huth <thuth@redhat.com>


