Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CFD7B11EE
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 07:09:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qljFN-0002Wg-FJ; Thu, 28 Sep 2023 01:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qljFK-0002WH-KR
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 01:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qljFI-0003tQ-Lo
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 01:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695877647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JbkUHUdCEH81m9FYXiQ/Hpgpz0vkct/uHAxVhIg1zN0=;
 b=VP26NNuIyL+G+673Et3CyUaaXSQ1LfcCxlIuh3O3MoVqV+bs/8N0LQ/EHh6HvWXQhx8VVG
 qdLT7ZgQ09hk2uLnUEXxYiOnNjOUxwRQQrr+U6Ib1zRu0khFVArvteEy1rp0lH3XmDNCU9
 aJXzk9IkouENwCGGps3qTGSRsmwC3+0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-cthwoBHaOlidnLxGncw5Mg-1; Thu, 28 Sep 2023 01:07:24 -0400
X-MC-Unique: cthwoBHaOlidnLxGncw5Mg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a681c3470fso1033697166b.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 22:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695877644; x=1696482444;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JbkUHUdCEH81m9FYXiQ/Hpgpz0vkct/uHAxVhIg1zN0=;
 b=CZDKFmnKxKNjo1OZ4KDZWJYoWQ/EjyXX3BcWih63Ad2fvVikr5l0S8NZ3gYLqwwlj+
 biQJS2TWit1rnbsRJlUUHvQtnarNizhDW1anLYO0zrz4HSihpFY927NsgTyKtL7YDwQu
 nd8MUg3zYrd2gy9UCycMKNSxJ+DUJSxtEsVjW9XclUEByiCMkiwV7pNKn9FJ+GJTcaDR
 2p2rAyCqEXMbJiKHzIBOveEG+SKAwqNGlLYusYBsiRmIfrw/bHQHzy7sr+sWAe0kskSE
 5oaF/9TUGvzMyR+1ljkapCeEomoO6TQSl4LcfihhELgr+uWR516NhDKU8ZzbnfufOOBQ
 PwZQ==
X-Gm-Message-State: AOJu0YzR0LY/T2j5czgfK5rIcWtw2nprgAqcU1fuYeqFBXy8Ye7Wj71B
 3bN5TMel6ZmIqpEWPbAdqrZEJKCGA4Ng06E8ycbSbvWUYIOl0T2h3xToSWWwHunjUcZ1cOpl7Qi
 o7TWW61m647Y915A=
X-Received: by 2002:a17:906:76d8:b0:9ad:fb23:21d4 with SMTP id
 q24-20020a17090676d800b009adfb2321d4mr169680ejn.12.1695877643900; 
 Wed, 27 Sep 2023 22:07:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTM9X/yXtxkJdrJ4KfmJL2VOfN/mP6KSkgxTiriQ/c8SasX/kftvyNbbGTWEDhknpxATk+HQ==
X-Received: by 2002:a17:906:76d8:b0:9ad:fb23:21d4 with SMTP id
 q24-20020a17090676d800b009adfb2321d4mr169670ejn.12.1695877643475; 
 Wed, 27 Sep 2023 22:07:23 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 d19-20020a17090692d300b009ae69c303aasm9750801ejx.137.2023.09.27.22.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 22:07:22 -0700 (PDT)
Message-ID: <62c405c9-27f2-a77a-1f94-8d03cf65fff6@redhat.com>
Date: Thu, 28 Sep 2023 07:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230927214756.14117-1-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] qtest/migration: Add a test for the analyze-migration
 script
In-Reply-To: <20230927214756.14117-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 27/09/2023 23.47, Fabiano Rosas wrote:
> Add a smoke test that migrates to a file and gives it to the
> script. It should catch the most annoying errors such as changes in
> the ram flags.
> 
> After code has been merged it becomes way harder to figure out what is
> causing the script to fail, the person making the change is the most
> likely to know right away what the problem is.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> I know this adds a python dependency to qtests and I'm not sure how
> much we care about this script, but on the other hand it would be nice
> to catch these errors early on.
> 
> This would also help with future work that touches the migration
> stream (moving multifd out of ram.c and fixed-ram).
> 
> Let me know what you think.

Without looking at this too closely, my first thought was: This sounds 
rather like a good candidate for an avocado test instead. It's using Python, 
so tests/avocado/ sounds like a better fit. Have you considered adding it as 
an avocado test already?

 >+#define ANALYZE_SCRIPT "tests/qtest/analyze-migration.py"

Why can't you use scripts/analyze-migration.py directly?

 >+    file = g_strdup_printf("%s/migfile", tmpfs);

Please, no static file names for temporary files - tests might be running in 
parallel, and then you get race conditions! Use something like 
g_file_open_tmp() instead to create a file with a random name.

  Thomas


