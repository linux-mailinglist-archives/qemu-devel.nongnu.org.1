Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 401A5762F75
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 10:17:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOZgs-0002Wo-Ii; Wed, 26 Jul 2023 04:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qOZgf-0002TT-Dx; Wed, 26 Jul 2023 04:16:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qOZgd-0001RI-4S; Wed, 26 Jul 2023 04:16:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b9ecf0cb4cso37183555ad.2; 
 Wed, 26 Jul 2023 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690359357; x=1690964157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RHHGJom7gS+tjxigZW2+nYbpZqNyHXRDhE3erYl0rUw=;
 b=C8wlP+gKpXTs5ubZuYxBgtjDb6GvztaU4T/T+83YNn2QxeBuZ7Uo8bagmnmn5dNr5c
 h11FucDpdiEFTagOvwhZmV+cJtt3IvWS4Fp4JN3I8iPY1KJ7Eliy6yHNhduSlEOBtlcL
 TvHg47QEIlOPDhCg5BNIKQohcP9q5O8/LZ198PgYSuX32Ea4rF4UBHGnRpqMqnl6jdsJ
 9rTDZ+eT1r2SM7McdcJx3RGbhdX+rFQugYxwyVYohcjxi4o6YdFA2oExEfSV2PciCYPK
 lpfVg/OxTHmr4/OnGPHr1JTgaijSupsePW6WE4TRwvIejpKz/y8m0YNwxCo9HTcDJFWo
 T5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690359357; x=1690964157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RHHGJom7gS+tjxigZW2+nYbpZqNyHXRDhE3erYl0rUw=;
 b=G4s23rjt4q7yXeVaPgagmfCEUhNLYnhD5CrpvMIqIaFieHAuEfVqCdhU0rdTZmqLcN
 FWU82clGrL1f+k38yig17BFiojs5p+O4DlGuNdXjvwRMVFNqD6oIdy3zFFa0TqFf3QF1
 ROvFij94aO30MgtegHdZYL7NIX7hFpKTHrnorcT8SjbZsQFNCu3MLpZxGD9JfIOU/Su8
 FUMM7M8CdjAY9A73ySXB395SWXNpzk4HJ1FFiwJFN0YFxV0gTMeeWz38k2eR2giH4OEK
 fZvuljwUkGGEhn2ghqI6nIxy8W4H2n0W8+qAd1OC9i5dVGhhibk03aOejQFGDUQbSd3W
 cSlA==
X-Gm-Message-State: ABy/qLaU5bmlLdstuYYiMjEhrjERmLDPp4Z++bJnt0UNgbJk35npF/Z2
 jD1Bc/9mqoQDo1wx7846N2Q=
X-Google-Smtp-Source: APBJJlEh8YSBmqLH16b63sRVy4w1UTiYxX32xZ3DuOSAqgDOAFnlHQ/jz+JMiyqO4hSGPqik0Fn/CA==
X-Received: by 2002:a17:902:bf02:b0:1b3:c7c1:8ded with SMTP id
 bi2-20020a170902bf0200b001b3c7c18dedmr1062296plb.27.1690359357130; 
 Wed, 26 Jul 2023 01:15:57 -0700 (PDT)
Received: from [192.168.0.62] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 jb20-20020a170903259400b001b66e3a77easm6109639plb.50.2023.07.26.01.15.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 01:15:56 -0700 (PDT)
Message-ID: <756b6d6a-9e51-500f-8458-9ddb393ff802@gmail.com>
Date: Wed, 26 Jul 2023 17:15:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 4/4] tests/qtest: Introduce tests for UFS
To: Thomas Huth <thuth@redhat.com>
Cc: fam@euphon.net, hreitz@redhat.com, k.jensen@samsung.com,
 kwolf@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 stefanha@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 philmd@linaro.org, lvivier@redhat.com, jeuk20.kim@samsung.com
References: <cover.1690348453.git.jeuk20.kim@samsung.com>
 <ebc4e4c699a43724319fda275a71db3ab6b6c0f7.1690348453.git.jeuk20.kim@samsung.com>
 <e4484ab4-30bb-71ae-147e-8e2f9f9bbb12@redhat.com>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <e4484ab4-30bb-71ae-147e-8e2f9f9bbb12@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/26/2023 4:21 PM, Thomas Huth wrote:
>   Hi!
> 
> On 26/07/2023 07.30, Jeuk Kim wrote:
>> This patch includes the following tests
>>    Test mmio read
>>    Test ufs device initialization and ufs-lu recognition
>>    Test I/O (Performs a write followed by a read to verify)
>>
>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> ---
> ...
>> diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
>> new file mode 100644
>> index 0000000000..5104a0a56a
>> --- /dev/null
>> +++ b/tests/qtest/ufs-test.c
>> @@ -0,0 +1,575 @@
>> +/*
>> + * QTest testcase for UFS
>> + *
>> + * Copyright (c) 2023 Samsung Electronics Co., Ltd. All rights reserved.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/module.h"
>> +#include "qemu/units.h"
>> +#include "libqtest.h"
>> +#include "libqos/qgraph.h"
>> +#include "libqos/pci.h"
>> +#include "scsi/constants.h"
>> +#include "include/block/ufs.h"
>> +
>> +/* Test images sizes in Bytes */
>> +#define TEST_IMAGE_SIZE (64 * 1024 * 1024)
>> +/* Timeout for various operations, in seconds. */
>> +#define TIMEOUT_SECONDS 5
> 
>  From what I've seen in the past, it's possible that a process gets 
> paused for 3 - 4 seconds on a very loaded CI machine, so 5 seconds is 
> already close ... I'd suggest to use 8 - 10 seconds for a timeout 
> instead, just to be on the safe side.
> 
>> +static char *drive_create(void)
>> +{
>> +    int fd, ret;
>> +    char *t_path;
>> +
>> +    /* Create a temporary raw image */
>> +    fd = g_file_open_tmp("qtest.XXXXXX", &t_path, NULL);
> 
> Could you maybe use "qtest-ufs.XXXXXX" or something more prominent 
> instead? ... in case the files don't get deleted correctly, it's easier 
> to know at which test to look at later.
> 
> With that change:
> Acked-by: Thomas Huth <thuth@redhat.com>
> 

Okay, I'm going to change the timeout to 10 and rename the file to 
"qtest-ufs.XXXXXX".
Thank you for your comment!!

