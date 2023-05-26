Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8796713042
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 01:13:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2gcX-0002uc-KG; Fri, 26 May 2023 19:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2gcS-0002uI-RD
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:13:12 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2gcR-0007JB-As
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:13:12 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b01d7b3ee8so5601245ad.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685142790; x=1687734790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C6Ciku7TJc2O+Rg1JsLUcxGliHrIc5Ui3TqRUtjLcyI=;
 b=ReND5amc+GXw1cUoQfvRsAcUt7cMddlbLQAnbeTc+XXoFo6/0hB8zQETSD9bMsXbkp
 FIiuZj8XbNcNNm4bBWyxlc+6yqanT7lk20HtAP2cdUlcxyUT+woLdzMuPfZCw7bLAsrm
 WYfmPXe2AXxjn9tBJ6KWp09s5wBpNgg9oyOBSFk/nUDHlso2tdNSOv0UdQtjXg59Llbu
 DtwFaaULRLNPKb8wfAXytHqyq6DWPuo82OixqK4FO/ofvvv8Ju9qEF7rwZaZSivaU9Pb
 mJoMMU6yk5dGp1It3jka8XeFOn3bvIy/O6j7TWtnckBxMa/DXySdYDfrPG/k5v1++TfL
 M9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685142790; x=1687734790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C6Ciku7TJc2O+Rg1JsLUcxGliHrIc5Ui3TqRUtjLcyI=;
 b=BIyHf9jmjxUCBJ6SMnzqu4mS0h3fKVxuuiTm9TBfRIIIak+JliGbjjge5tT/X4TTvo
 mDh9vdRDG0KXCnCXVHpCy3xFhoDBIOB6w+bqwzQgYMBMmwXhU647P8hgHFUIMFQUzpEM
 3vEPIgzD8q/XK4tcrMtkgTx7v76ElWYJY/pYyqobSVezWqsYLisJWj0Qd4Yi2zooSiXF
 4Sm/BDaX4mJwobbfPk8sWPfFWcMr+1Po06zFvj88B+Qu9zaOjkwDu94lQ2C9RmQbpWLh
 rIK/RcC5gYujNwJscKZ32lk//Tp+X+36IsFar7+/EQN48iEAI67u+OjCWuWpUJaQjku5
 6EPA==
X-Gm-Message-State: AC+VfDzoL/qtNY8yq1/7irgl+hVHHMI2f+znG6drlZB5uchh4Z5vveEq
 atfEVC6ZgmwwYqj0OTW3xX/pbw==
X-Google-Smtp-Source: ACHHUZ4yUI1LbpExVIEvctkzlnZBafB98LYJJo+1bjFWI1L5SnjnP1Hy/NPkXM/3AAkMq7iyaoXymw==
X-Received: by 2002:a17:903:5cc:b0:1ac:8148:8c40 with SMTP id
 kf12-20020a17090305cc00b001ac81488c40mr3977360plb.53.1685142789768; 
 Fri, 26 May 2023 16:13:09 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a170902ea9300b001a212a93295sm1508525plb.189.2023.05.26.16.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 16:13:09 -0700 (PDT)
Message-ID: <b79f3fb8-5a65-d822-271c-753c814a6dde@linaro.org>
Date: Fri, 26 May 2023 16:13:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] tests/tcg/s390x: Test LCBB
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230526181240.1425579-1-iii@linux.ibm.com>
 <20230526181240.1425579-3-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230526181240.1425579-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/26/23 11:12, Ilya Leoshkevich wrote:
> Add a test to prevent regressions.
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  1 +
>   tests/tcg/s390x/lcbb.c          | 51 +++++++++++++++++++++++++++++++++
>   2 files changed, 52 insertions(+)
>   create mode 100644 tests/tcg/s390x/lcbb.c
Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

