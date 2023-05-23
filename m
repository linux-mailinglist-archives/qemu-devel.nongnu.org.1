Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8253170D7AD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 10:38:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1NW6-0003yH-RW; Tue, 23 May 2023 04:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1NW4-0003xe-T1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:37:12 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1NW3-0000y4-0x
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:37:12 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-307a8386946so4626334f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684831029; x=1687423029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AzFYTbCcnw0azLRxoF431Tt+lfeGHY+xCEtszAoLKtY=;
 b=cmWIfm7PKZ5wxurdkLnOdh4iyu6c2eZydAsyCiqABiH2Mw6REvWV5JDk7m2cdkwG6K
 fg7MdPjYfs3ZD/ex1axNEAdm8WoOKY+XzBgY7N+eG3yiAxTp38X4yPIL7GduuNH2+mTR
 ugsvvjNxlVfwU1R7Q2fQZc2nJTvmS3d82mxP3jzLMOR1JjqEQCz7enfWKCl9PSc5svgG
 enTY6WNj4TxRy+Az7Og0+RkjHIdOPy31gkdO8IiXZl+F17lE0aXFWJqKNOSxNhjJgBuO
 zDllPsEaz1eno+bz//PKKQqoatQnFF+K8RxCUlGHgdqNdUfdBfX7TEKP7p+u4HF+WB/M
 4+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684831029; x=1687423029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AzFYTbCcnw0azLRxoF431Tt+lfeGHY+xCEtszAoLKtY=;
 b=Bvj7IheUeW3wX0eIJRnR99arbxB7Wum3+qKa7Z9sQyTnBy7YHu8li377/+PqIJ8Cns
 eiEYu33x+7+SqWukPcO9DaBDQHoIiqb9a9GxZOv+3sUrSnW6bkhGA/j+aaCJB5PtLiZV
 aSEM6wLjulec1my0v0Petzp854s8q1mgp4hNBMr1ibxAUou08r8uXMxY7TMnDODnACGa
 LbDzhtds3MflvoMSoUPG6XVXJu0Q8drtY08mXivIMaXnBSWEQopC/PYQUmhFjFcwpYiI
 ijy2nX+kQmnAjP5wattD5f84TgMv8MC3ufGZlrpRLCA4Bxg6tOkbN97oCuG+eNPCV470
 116w==
X-Gm-Message-State: AC+VfDy/T6nigmvZA/hmS+r/TleLRCnmDa3fYRgggwmGoNgg0QLvzs9F
 RRNOaSMFTcKXOlQEixQMZ1nmMg==
X-Google-Smtp-Source: ACHHUZ67Z9vfVZeD0IsKg2sgYvXZm1dAYvbzRHOHFdw4lasEoy7/NNKS+DfgSAo1FLt+e0VM5QOA9w==
X-Received: by 2002:adf:e58c:0:b0:307:c0c4:109a with SMTP id
 l12-20020adfe58c000000b00307c0c4109amr9119922wrm.6.1684831028888; 
 Tue, 23 May 2023 01:37:08 -0700 (PDT)
Received: from [192.168.69.115] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 n7-20020a7bcbc7000000b003f318be9442sm14148541wmi.40.2023.05.23.01.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 01:37:08 -0700 (PDT)
Message-ID: <8a9c7803-5c1c-3e68-6506-14eae205d11e@linaro.org>
Date: Tue, 23 May 2023 10:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] ui/cursor: incomplete check for integer overflow in
 cursor_alloc
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, jacek.halon@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230508141813.1086562-1-mcascell@redhat.com>
 <CAJ+F1CK2V22PMYP4PQwH+VYKhR32GKxFK5eRODE928iu3LVodA@mail.gmail.com>
 <fcf99624-9a48-6760-a28d-bb88bce6572f@linaro.org>
 <ZGx0ylB10aLWchuf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZGx0ylB10aLWchuf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23/5/23 10:09, Daniel P. Berrangé wrote:
> On Mon, May 22, 2023 at 08:55:02PM +0200, Philippe Mathieu-Daudé wrote:
>> On 9/5/23 09:13, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Mon, May 8, 2023 at 6:21 PM Mauro Matteo Cascella
>>> <mcascell@redhat.com <mailto:mcascell@redhat.com>> wrote:
>>>
>>>      The cursor_alloc function still accepts a signed integer for both
>>>      the cursor
>>>      width and height. A specially crafted negative width/height could
>>>      make datasize
>>>      wrap around and cause the next allocation to be 0, potentially
>>>      leading to a
>>>      heap buffer overflow. Modify QEMUCursor struct and cursor_alloc
>>>      prototype to
>>>      accept unsigned ints.
>>>
>>>      Fixes: CVE-2023-1601
>>>      Fixes: fa892e9a ("ui/cursor: fix integer overflow in cursor_alloc
>>>      (CVE-2021-4206)")
>>>      Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com
>>>      <mailto:mcascell@redhat.com>>
>>>      Reported-by: Jacek Halon <jacek.halon@gmail.com
>>>      <mailto:jacek.halon@gmail.com>>
>>>
>>>
>>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com
>>> <mailto:marcandre.lureau@redhat.com>>
>>>
>>> It looks like this is not exploitable, QXL code uses u16 types, and
>>
>> 0xffff * 0xffff * 4 still overflows on 32-bit host, right?
> 
> cursor_alloc() will reject 0xffff:
> 
>      if (width > 512 || height > 512) {
>          return NULL;
>      }

I hadn't looked at the source file (the 'datasize' assignation
made me incorrectly think it'd be use before sanitized).

Still I wonder why can't we use a simple 'unsigned' type instead
of a uint32_t, but I won't insist.

>>
>>> VMWare VGA checks for values > 256. Other paths use fixed size.
>>>
>>>      ---
>>>        include/ui/console.h | 4 ++--
>>>        ui/cursor.c          | 2 +-
>>>        2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>>      diff --git a/include/ui/console.h b/include/ui/console.h
>>>      index 2a8fab091f..92a4d90a1b 100644
>>>      --- a/include/ui/console.h
>>>      +++ b/include/ui/console.h
>>>      @@ -144,13 +144,13 @@ typedef struct QemuUIInfo {
>>>
>>>        /* cursor data format is 32bit RGBA */
>>>        typedef struct QEMUCursor {
>>>      -    int                 width, height;
>>>      +    uint32_t            width, height;
>>>            int                 hot_x, hot_y;
>>>            int                 refcount;
>>>            uint32_t            data[];
>>>        } QEMUCursor;
>>>
>>>      -QEMUCursor *cursor_alloc(int width, int height);
>>>      +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height);
>>>        QEMUCursor *cursor_ref(QEMUCursor *c);
>>>        void cursor_unref(QEMUCursor *c);
>>>        QEMUCursor *cursor_builtin_hidden(void);
>>>      diff --git a/ui/cursor.c b/ui/cursor.c
>>>      index 6fe67990e2..b5fcb64839 100644
>>>      --- a/ui/cursor.c
>>>      +++ b/ui/cursor.c
>>>      @@ -90,7 +90,7 @@ QEMUCursor *cursor_builtin_left_ptr(void)
>>>            return cursor_parse_xpm(cursor_left_ptr_xpm);
>>>        }
>>>
>>>      -QEMUCursor *cursor_alloc(int width, int height)
>>>      +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height)
>>>        {
>>>            QEMUCursor *c;
>>
>> Can't we check width/height > 0 && <= SOME_LIMIT_THAT_MAKES_SENSE?
>>
>> Maybe a 16K * 16K cursor is future proof and safe enough.
>>
>>>            size_t datasize = width * height * sizeof(uint32_t);

-------------------------------^

>>>      --     2.40.1
>>>
>>>
>>>
>>>
>>> -- 
>>> Marc-André Lureau
>>
>>
> 
> With regards,
> Daniel


