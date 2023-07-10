Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE7374D0BD
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:59:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qImj3-0003dC-45; Mon, 10 Jul 2023 04:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qImj1-0003cr-E4
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qImiz-00058J-Jt
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688979508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KIIKXsEzRV8CMQ3doCs9SyA3svfIFaY5+Er5PXe+wY=;
 b=HHPfLleydstvEDAjmpoePkGhZn76UlKUdsq8TpxKxZRhswlnisXdeLgaxz3wtDiqvyfsrx
 SlZpuQOQBcbbcD1Gq8UvwxWmHYHqt+dcNh6Yf6v6d4avRBVmM5DMVPdBqBl/xoTUlb9EIZ
 BUb5JTwb00az/Se6FtejbQ1V6s2QF8Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-jI_yWaSZNo6CaTToPI6B9Q-1; Mon, 10 Jul 2023 04:58:26 -0400
X-MC-Unique: jI_yWaSZNo6CaTToPI6B9Q-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-767b778582eso243025785a.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 01:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688979506; x=1691571506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8KIIKXsEzRV8CMQ3doCs9SyA3svfIFaY5+Er5PXe+wY=;
 b=RcjTFk46u6WEOyNa30o9ZueVXff8V29eZam1BJySerhQ/NhPAEJIBHJ7qnNfuyjZgM
 +fXUDb/5VQEuhwsEFzBsRFkhJs8KH+0Jk1bLs4Ub/DE7I7snQQO2aPzF80MQ+bOqK5Qq
 hwf37Fbv6IR1i5zzPwDqhHeU89Ebt+8zRYOhxGadmWJqLCQh5SAFo7LY1PN7Ps5T2FXO
 lBpQ2rRKrhWl7FHenilATesQleuMQYeb1XCWz1yP2e3C0UUe3Ft9QYn25DY6BSoDfJtx
 UC4+xR2meNnlhrGUw2mY38lk4P/rDJ1e6MpJX/kizzEROFmoZqLfGQ6OndAyEGEkUd9g
 cLLg==
X-Gm-Message-State: ABy/qLZaIa3KvtARk1ZZPZ3IsnDDdZHR+mAi4iActFBJ6bjqNN96vFaf
 fH+gT0SMJHF8O/WGL6cPHNbjjmkTOS6xqkzArAJKpat2kyTjVrRo2qa5BpT9S7xMBCJuD+ZnAiW
 CyK0MYZIcdHLPDhHKC0oulxo=
X-Received: by 2002:a05:620a:468e:b0:767:405b:650f with SMTP id
 bq14-20020a05620a468e00b00767405b650fmr12602032qkb.45.1688979505987; 
 Mon, 10 Jul 2023 01:58:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHMV4DefDqF8Zf86bgRZFNOmx/T6u23TX0errF1r7QtFsjo3xqwIx/tbwT6MDG9SSKQjJTR7A==
X-Received: by 2002:a05:620a:468e:b0:767:405b:650f with SMTP id
 bq14-20020a05620a468e00b00767405b650fmr12602026qkb.45.1688979505708; 
 Mon, 10 Jul 2023 01:58:25 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 m16-20020ae9e010000000b00765aa3ffa07sm4647440qkk.98.2023.07.10.01.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 01:58:25 -0700 (PDT)
Message-ID: <f783a557-9d30-bdf4-e13f-b3edd405a012@redhat.com>
Date: Mon, 10 Jul 2023 10:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: TCG broken on s390x hosts (was: [PULL 11/27] tcg/s390x: Support
 128-bit load/store)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-s390x <qemu-s390x@nongnu.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
 <20230530185949.410208-12-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230530185949.410208-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 30/05/2023 20.59, Richard Henderson wrote:
> Use LPQ/STPQ when 16-byte atomicity is required.
> Note that these instructions require 16-byte alignment.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target-con-set.h |   2 +
>   tcg/s390x/tcg-target.h         |   2 +-
>   tcg/s390x/tcg-target.c.inc     | 107 ++++++++++++++++++++++++++++++++-
>   3 files changed, 107 insertions(+), 4 deletions(-)

  Hi Richard!

I think this patch broke something on s390x hosts. I currently
cannot run the BootLinuxS390X.test_s390_ccw_virtio_tcg avocado
test on a s390x host - it times out:

  make check-venv
  ./tests/venv/bin/avocado run -t arch:s390x \
   tests/avocado/boot_linux.py:BootLinuxS390X.test_s390_ccw_virtio_tcg

... gets INTERRUPTED after the timeout expired.

It used to work fine in the past, so I bisected the problem
and it seems like 4caad79f8d60a5df20ceed1c396724af745c9512
is the first bad commit. If I revert it on top of the master
branch, the test works fine again. Could you please have
a look?

  Thanks,
   Thomas


