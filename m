Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCD4762D22
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 09:22:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOYqa-0001g8-5N; Wed, 26 Jul 2023 03:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qOYqS-0001cE-Ny
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qOYqO-0001Gc-G3
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690356119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txnapvyzQ9FCrGv8S8lOCuZTYC4MLFrECRp8QHnD0sU=;
 b=aXW/08Ps7nfO1m0CpBSMAsTwAUSRxE84C6aRM06SGJCtWTpPSkYDn9uic/JRfDOVF+Ujqt
 Py8JBPz2hE/taKlMddnyRatk6CtWY7rvGflwNGyR61gS+6jR0m4KJEqDFQ52rOVPR2RMOD
 p21bg/jfzWDyXhdQxKxV3o75oVzBBhg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-9BBeXQdaPE-YbPZxo_KNuA-1; Wed, 26 Jul 2023 03:21:57 -0400
X-MC-Unique: 9BBeXQdaPE-YbPZxo_KNuA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fd2778f5e4so3724685e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 00:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690356116; x=1690960916;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=txnapvyzQ9FCrGv8S8lOCuZTYC4MLFrECRp8QHnD0sU=;
 b=LFwNG3GvxNfAqJAKrjV6XO3iDEEMJ2vhfwvqVVUeP26ENp1iaFXCrgj4HzS9nlEK93
 LiX4AaUvIQBaJw3Ag4Nv7FcmPivob33QdlPTvcvdfNiZpd/8+OKZTuqpN+OiMP3obWml
 l5HWKu24Kb+0R/B2pnhU46JWJE9cRLSYeFja7wz6911QQZ+CwHminxOMPxWBJLlM49X/
 aJDHGYVDx8B/evVsqHNXxDdz4UUJxfFwW+JMcz0DfRapWlpO2jNiQONufaT1eLcqMiDY
 KZaiw5wfhOEiXwvKgEfqC/uxgfy2Y2XFPA9NOJKD1dSjwkEu6b+2fX4ie7FrcKuS2oo0
 hVaQ==
X-Gm-Message-State: ABy/qLZ6qbBwkiViGON6sG0xpKogXE93Fz0p3Yji6N7Jz0IF73L93Zj/
 eG25h+4O6dqXmtakrRd0yyprN/5dmRZUSL3Ry0kbCIihXHlJmXMT4Ate0ctMZ8Gv0CVThS4pA4u
 zUUSgxRupH4wuXGU=
X-Received: by 2002:a1c:4b10:0:b0:3fa:8c8b:716 with SMTP id
 y16-20020a1c4b10000000b003fa8c8b0716mr3876814wma.1.1690356116065; 
 Wed, 26 Jul 2023 00:21:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEqRshJW4XLQtIKOZkdYdEEOUvIN/jBWZrJygYjoAzIYa0pAlxxvWK5pN9zvRaIxxfcliC8Xw==
X-Received: by 2002:a1c:4b10:0:b0:3fa:8c8b:716 with SMTP id
 y16-20020a1c4b10000000b003fa8c8b0716mr3876800wma.1.1690356115804; 
 Wed, 26 Jul 2023 00:21:55 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-0.web.vodafone.de. [109.43.176.0])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a05600c290c00b003fc16ee2864sm1137053wmd.48.2023.07.26.00.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 00:21:55 -0700 (PDT)
Message-ID: <e4484ab4-30bb-71ae-147e-8e2f9f9bbb12@redhat.com>
Date: Wed, 26 Jul 2023 09:21:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, hreitz@redhat.com, k.jensen@samsung.com,
 kwolf@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 stefanha@redhat.com, berrange@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, philmd@linaro.org,
 lvivier@redhat.com, jeuk20.kim@samsung.com
References: <cover.1690348453.git.jeuk20.kim@samsung.com>
 <ebc4e4c699a43724319fda275a71db3ab6b6c0f7.1690348453.git.jeuk20.kim@samsung.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v7 4/4] tests/qtest: Introduce tests for UFS
In-Reply-To: <ebc4e4c699a43724319fda275a71db3ab6b6c0f7.1690348453.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

  Hi!

On 26/07/2023 07.30, Jeuk Kim wrote:
> This patch includes the following tests
>    Test mmio read
>    Test ufs device initialization and ufs-lu recognition
>    Test I/O (Performs a write followed by a read to verify)
> 
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
...
> diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
> new file mode 100644
> index 0000000000..5104a0a56a
> --- /dev/null
> +++ b/tests/qtest/ufs-test.c
> @@ -0,0 +1,575 @@
> +/*
> + * QTest testcase for UFS
> + *
> + * Copyright (c) 2023 Samsung Electronics Co., Ltd. All rights reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "qemu/units.h"
> +#include "libqtest.h"
> +#include "libqos/qgraph.h"
> +#include "libqos/pci.h"
> +#include "scsi/constants.h"
> +#include "include/block/ufs.h"
> +
> +/* Test images sizes in Bytes */
> +#define TEST_IMAGE_SIZE (64 * 1024 * 1024)
> +/* Timeout for various operations, in seconds. */
> +#define TIMEOUT_SECONDS 5

 From what I've seen in the past, it's possible that a process gets paused 
for 3 - 4 seconds on a very loaded CI machine, so 5 seconds is already close 
... I'd suggest to use 8 - 10 seconds for a timeout instead, just to be on 
the safe side.

> +static char *drive_create(void)
> +{
> +    int fd, ret;
> +    char *t_path;
> +
> +    /* Create a temporary raw image */
> +    fd = g_file_open_tmp("qtest.XXXXXX", &t_path, NULL);

Could you maybe use "qtest-ufs.XXXXXX" or something more prominent instead? 
... in case the files don't get deleted correctly, it's easier to know at 
which test to look at later.

With that change:
Acked-by: Thomas Huth <thuth@redhat.com>


