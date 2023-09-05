Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5E5792223
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 13:32:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdUGr-0000Sh-1s; Tue, 05 Sep 2023 07:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdUGp-0000SZ-JJ
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:30:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdUGn-0006vn-99
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:30:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3ff1c397405so24161175e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693913456; x=1694518256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UcAwxlzo4K5nT9F+dWcxnhKJ2kqSzuz/Ts8Ii3nK0TE=;
 b=e3k0ShkZj+z4kbUYElDzk1z0iQ95RuEaT+U8SLHvuvY5/LYSJgRbXbVkQxK4kjRWj/
 vdr8hUcbDKBjZvkVolHhrSRjxHtgsl0VqciiOeW62E4Ygo1Il3YtZArCy2KujozULrNK
 4SVtM+lyRsMyKL8Rfzg1qkuvD7e3SKqDqxN1ur7AIo7jbVG4jRpBVXSbG8alf/dlU2zG
 23QqA2SdcBggy1AwJ4uDkhm4QWw3+pu1Nvs2CI37kuq3uQyzMgyT2czJgLQ55Ub+0Ewz
 IVTTJBVtBcHcyA9JgtQLzeTuaJlC7ULzksJk3ZUD7fdyvvQduUPFqemWCuwiSuZN7yhq
 5AkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693913456; x=1694518256;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UcAwxlzo4K5nT9F+dWcxnhKJ2kqSzuz/Ts8Ii3nK0TE=;
 b=QR2iWbOAA+I4ETm8Cr++2kXc29xvwdVfCOl6nN3xbJIV1VXJi+sWJDClN3voumJLuA
 Si+2B/obdIpT67Pjf5ixmMOMxrlQno7ZSBpL1TXduiiv7rGM411mYBgsosNdIc5+v16S
 iKmiB5CKKx1RI44QDIJgl/S18WD1aY2+lAQB53wjUk/Vc2v4vpaQZHio2vcduZhj4Pgr
 IjIZRGBSPAns1fVtixLBrfy1ef30kNdsG4FapDBmVy+YeLIcEkjjRaWV0FrIeMwwsxTL
 INHYNPW9e6Af2ptohQ4blRbTOeOQOGz2U/iav2jn/VpEIpBIPGFIoOtsYBxORv1XoPfQ
 MSdg==
X-Gm-Message-State: AOJu0YzVL32wEXNyQepzOv9AEX5+dqD1w1TOrh99lsJqawXh4KidL9kS
 niCCeCrgoewHtckQInCNjD+oIg==
X-Google-Smtp-Source: AGHT+IHQT7ymNgt//aEEmV27ZP7Nyts+j5T4iNryhX45veJCS22OJhJ944PAv28yUcbdlVrQelQS+w==
X-Received: by 2002:a7b:c7d9:0:b0:401:bedd:7d42 with SMTP id
 z25-20020a7bc7d9000000b00401bedd7d42mr9957333wmk.13.1693913455723; 
 Tue, 05 Sep 2023 04:30:55 -0700 (PDT)
Received: from [192.168.1.34] ([37.69.27.38]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05600c294800b003fd2e898aa3sm8816939wmd.0.2023.09.05.04.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 04:30:55 -0700 (PDT)
Message-ID: <585c03fc-761a-be52-1477-af1044c122b1@linaro.org>
Date: Tue, 5 Sep 2023 13:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 05/14] simpletrace: update code for Python 3.11
Content-Language: en-US
To: Mads Ynddal <mads@ynddal.dk>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-6-mads@ynddal.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823085429.20519-6-mads@ynddal.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 23/8/23 10:54, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
> 
> The call to `getargspec` was deprecated and in Python 3.11 it has been
> removed in favor of `getfullargspec`. `getfullargspec` is compatible
> with QEMU's requirement of at least Python version 3.6.
> 
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   scripts/simpletrace.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


