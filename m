Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A30FC76C1A7
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 02:53:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR06k-0004cu-T4; Tue, 01 Aug 2023 20:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qR06i-0004cQ-Sk
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 20:52:56 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qR06h-0008Qc-Fa
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 20:52:56 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686fa3fc860so4143663b3a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 17:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690937573; x=1691542373;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tA2F+3ttj0sCh86+wn2oqY7WZr5Dg5nGQ8JV3knhWW4=;
 b=P5ebNS0jjb/w2EoPcsAoUZlCYkPnox/Fyw7WCz7Y7ZFC4xIkOGGVM1HuMlqHJtz3Py
 gi9CD1u2N6zC9+V2SYWBX5eqljH1Gxp303ahzIFnUBvD62wRxyowlTx4OZQbzQrqvnbA
 sulgZ899kX0LaHup2b0W5RapN5DCnrn14RAOZG10SCfrm5lVjR6tTm3wE7HGCtwh02zf
 sPRqxq5rNxaQPc+79PiwckyBaGpIc3mpHEk61gkCpivZ/F/z1+uPxw+vCGq7djQ7WSKg
 7vj1WEoo97Ijlc+iH89rEGKdKSkvdKdMHTI7exUK4rHL9kvG7t1jqBnHZ0uSxt9yIL8a
 sQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690937573; x=1691542373;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tA2F+3ttj0sCh86+wn2oqY7WZr5Dg5nGQ8JV3knhWW4=;
 b=Sz+h/2CGcDCsWTxBBj8WWvGvoIcC9ov3zCc9iwCsxJx3VUKLHIsiyyQf0Q2kIFB1Sp
 lKDAL1cj0G+4YQ9uiDGioIdxs2vmxGbjLv6zv3/WgYVEUh5hD5pQx9+tyD84Y8we0NdA
 5QxXv52umPIcq1nvMnuJZjOuQYMKkRyHwX4GdP4xMdKs6cykCZeZzMsgkfk71BZg8dzn
 ivMDFGB3TT6GkFvspRFsD7cER4nvZ3zNyWuWOa7nT2gdZ/4OdPOW28zvyXbX6yrX1frC
 rHXPZGbS9v42QcNGyPEjRePj7JJW7zOctHUSqmZS2VQHsk7iBs4Qt0KuwuJKno7odjKO
 urVA==
X-Gm-Message-State: ABy/qLZCq24bQksKvOU5Y50bVq2uYrK3ZkJZ+4kSPGM09QnWOa+1qwNG
 9hhBy6+ryGZ6eeXLLOayfxI=
X-Google-Smtp-Source: APBJJlEJeOLO9TLpOpCR1UGagK5BBgzHXMV5BQGaqxefHwZ6ifkslnJLL3/kdmkT2lChLd4d3oL6Lw==
X-Received: by 2002:a05:6a20:a10e:b0:13e:1945:8857 with SMTP id
 q14-20020a056a20a10e00b0013e19458857mr6537350pzk.37.1690937572392; 
 Tue, 01 Aug 2023 17:52:52 -0700 (PDT)
Received: from [192.168.0.62] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a170902f7ce00b001ae0152d280sm11018857plw.193.2023.08.01.17.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 17:52:52 -0700 (PDT)
Message-ID: <1dea4954-900b-d2be-b9bf-c2c10198b7f2@gmail.com>
Date: Wed, 2 Aug 2023 09:52:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] hw/ufs: fix compilation warnings
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Mike Maslenkin <mike.maslenkin@gmail.com>
Cc: qemu-devel@nongnu.org, jeuk20.kim@samsung.com, stefanha@redhat.com
References: <20230727233405.35937-1-mike.maslenkin@gmail.com>
 <892a9975-1901-862d-4766-bd76fbb5d7cc@linaro.org>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <892a9975-1901-862d-4766-bd76fbb5d7cc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/2/2023 6:03 AM, Philippe Mathieu-Daudé wrote:
> Hi Mike,
> 
> On 28/7/23 01:34, Mike Maslenkin wrote:
>> This patchset contains a trivial compilation fixes for UFS support
>> applied to block-next tree.
> 
> Since the series isn't merged, it would be clearer to send
> a v9 of "hw/ufs: Add Universal Flash Storage (UFS) support"
> with the fixes squashed in (there is still time).
> 
> Regards,
> 
> Phil.
> 

Hi Phil,
Thanks for your comment.
If Mike is okay, I'll send v9 of "hw/ufs: Add Universal Flash Storage 
UFS) support" with the fixes.

To Mike,
Is it okay with you if I make a patch v9, incorporating your fixes?

