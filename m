Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0DB7DBDA5
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:21:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxUzV-0007AX-S4; Mon, 30 Oct 2023 12:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qxUzU-0007AP-3o
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qxUzS-0008R7-Er
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698682784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HB5TWAzdJuXPi1kYX6X5/vOasWHLsL60Obvb/RE/qVc=;
 b=g5ObAkk+EyI+buEzqOHJ/+ja9226VFocQzfI9pDAVw7AaKf37VByhikfE3/VWHYBxvQyK/
 lQF7cv6XRKz9kzrvpJu12yNCgIdOiCgl1WfBsCwqYewFZwchizh3gFfd5D+QtRjcAsFDym
 M6XjVm2i4SRwjaUpw+ltbVw/TK2QdUQ=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-T7cFpQm0MUenIZ2EXQ6ZMw-1; Mon, 30 Oct 2023 12:19:42 -0400
X-MC-Unique: T7cFpQm0MUenIZ2EXQ6ZMw-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3b2e7a8fbbdso6106366b6e.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 09:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698682781; x=1699287581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HB5TWAzdJuXPi1kYX6X5/vOasWHLsL60Obvb/RE/qVc=;
 b=T1zj7D07O+ZpFSrXHKdEcpXxzGnMrUM7ZARrpB4aZT7kZ3lh09WsbmSuATA9uw5Cwr
 2znH1AZga/v6gZO2FRoIZMfFpMTFWwe4rYpgOQ3t3HhbehnEGHTIVdUkLrHtAiTVv+g6
 XrNmpw51NLSkFhaLccK3ubSwVdmZ4h02Df8CpNIgV+cTSNUgYhX556wbTb8TD1b9sWlk
 qlEp7uPBhxdYrBSGpv4m51ExYQtInEqI6mzEWIgA9bqDFn7/zk8FGZDaG19o5rHbvqQn
 teywkAjfZYUs5X1ZWDIvSh8ebRtb7eQr2uQ/X+g0lBJ1R0MV2mOOi3TIsBauW2s4ahFv
 tmXA==
X-Gm-Message-State: AOJu0Yxtj6dVz0Ymemv4GwXxDbl1q1/M/umosc21JZwKrtZTiOYNElJP
 daAprm/aeQTvea8BKBvKovPqnQ1HgUfiId9719gL77AIKmVPqr+IuxvUGor6BE2G1T7Q4MejRH+
 E0z76Dg4wY2NcDDg=
X-Received: by 2002:a54:4012:0:b0:3ab:9afd:8efd with SMTP id
 x18-20020a544012000000b003ab9afd8efdmr8297220oie.40.1698682781677; 
 Mon, 30 Oct 2023 09:19:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeAh50UpaxPclvAkUiclgsVsJdMRjfGBlDT0HZLgNQHUcGDjJqcl+Pjply+3v+BSgmA+7Wtg==
X-Received: by 2002:a54:4012:0:b0:3ab:9afd:8efd with SMTP id
 x18-20020a544012000000b003ab9afd8efdmr8297204oie.40.1698682781377; 
 Mon, 30 Oct 2023 09:19:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 az33-20020a05620a172100b00767d572d651sm3425869qkb.87.2023.10.30.09.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 09:19:40 -0700 (PDT)
Message-ID: <76165393-f7ef-40fb-883f-ba8654856467@redhat.com>
Date: Mon, 30 Oct 2023 17:19:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: intermittent qtest-aarch64/xlnx-canfd-test test failure
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <fd2b7868-2ac5-64a1-d66f-3025c1da6bd1@tls.msk.ru>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <fd2b7868-2ac5-64a1-d66f-3025c1da6bd1@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/21/23 09:51, Michael Tokarev wrote:
> Hi!
> 
> While doing stable-8.1.1 preparation, I've a CI failure of ubuntu-20.04-s390x-all here:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/5132720046
> 
> ▶ ERROR:../tests/qtest/xlnx-canfd-test.c:265:match_rx_tx_data: \
>    assertion failed ((buf_rx[size] & DLC_FD_BIT_MASK) == (buf_tx[size] & DLC_FD_BIT_MASK)): (2281701376 == 2147483648)
> 
>   qemu:qtest+qtest-aarch64 / qtest-aarch64/xlnx-canfd-test  \
>             ERROR           0.77s   killed by signal 6 SIGABRT
> 
> Re-run of this test went successfully.  However, the assert looks
> a bit scary, and the fact that it does not fail in a reliable way
> is a bit troubling too.  Is it a flaky test or there's something
> else in qemu with concurrent threads?
> 
> I don't see this assert in previous test runs.  But ubuntu-20.04-s390x-all
> test fails quite often due to other reasons, so it isn't conclusive.
> 
> Should something be done with this?
> 
> The testing is done for commit f2fc49c302036315db6e8c9f74592decc3be0476,
> which is in staging-8.1 branch only temporarily.
> 
> Thanks,
> 
> /mjt
> 

I had the same CI error in job https://gitlab.com/legoater/qemu/-/jobs/5416150239
  
▶ 170/258 ERROR:../tests/qtest/xlnx-canfd-test.c:265:match_rx_tx_data: assertion failed ((buf_rx[size] & DLC_FD_BIT_MASK) == (buf_tx[size] & DLC_FD_BIT_MASK)): (2281701376 == 2147483648) ERROR
170/258 qemu:qtest+qtest-aarch64 / qtest-aarch64/xlnx-canfd-test           ERROR           0.49s   killed by signal 6 SIGABRT
>>> QTEST_QEMU_BINARY=./qemu-system-aarch64 PYTHON=/builds/legoater/qemu/build/pyvenv/bin/python3 MALLOC_PERTURB_=60 G_TEST_DBUS_DAEMON=/builds/legoater/qemu/tests/dbus-vmstate-daemon.sh /builds/legoater/qemu/build/tests/qtest/xlnx-canfd-test --tap -k
――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
stderr:
**
ERROR:../tests/qtest/xlnx-canfd-test.c:265:match_rx_tx_data: assertion failed ((buf_rx[size] & DLC_FD_BIT_MASK) == (buf_tx[size] & DLC_FD_BIT_MASK)): (2281701376 == 2147483648)
(test program exited with status code -6)

I could reproduce on PPC64 and s390x systems.

C.


