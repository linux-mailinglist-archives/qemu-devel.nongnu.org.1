Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E972770C592
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 20:55:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Agd-0001q6-95; Mon, 22 May 2023 14:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1AgW-0001pX-73
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:55:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1AgU-0001aw-HD
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:55:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f427118644so64274895e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684781705; x=1687373705;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cYsueswzgwkhofkIVPjUYS9C979Pv8MhH7BrODe6jLc=;
 b=u6S2q5tza/jV3yR+TPb4pn4uQRoNpkxWhH/8/K7GP+DDXKiAfNKL4xMPhj2E2XsY+B
 QFOhBJ9fbFoir+4CRQoSetm8+Vrv2MIa9bWQVkjoawXJ7+qnTMrR/AsTWTmvn6beJRPc
 s0m5f8YZxvq04r+IQIGhwYLyuVq2CgVK4G1Qqknxe8qk18IofTm/rG8YMTM8G2S8neEr
 mVZY0BLAJVfP2c6US/TagSxl33LesS5lLHYeHfRvh3/XH6Nbh1x7YHJKaOS1XlJ486Jh
 es8z2owvDVD0IOBfiaPADL1a/UHoyh6p6Z1VlM0A0ndSoUhCADRL/vzM2m4LgaLSkHh/
 DGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684781705; x=1687373705;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cYsueswzgwkhofkIVPjUYS9C979Pv8MhH7BrODe6jLc=;
 b=DOQm5weR/zQx18SOG3jF5ZjQ9/sov+NI/1gjmyyBMQwbiGkpNOZ7Id5u7iPsBiokmM
 igg7psHTduyDsYXMPmRF+fvrhHs/BLqj8z7lqpFXqToMdfDsEv6D8u9S6dE8YEzF+J9P
 W3nJ+KsNWsr/DsCFsx0KKSkIO+N6J2jzGgsdnnF/EDbHsi+r/wJpZcHq34kNqoEjQe0z
 +SPuccBAUXFkql3/xgFOdaLS0z9dhZDYGOIwr+HtpakQY7IDa0QDeUQZnhd2c+b34OBA
 JNU9LWIm4ukzdKHhWqxPaTPI4372GPuxsXl6qfKOtE4zfMbmZCYGvkdCX9uzIGN+bPUx
 vcSQ==
X-Gm-Message-State: AC+VfDxdpU/8CZWhAOs9tdbx/m7Wm5FVaz7PdeX2IGkUKsqA5lPmfXu6
 c92xRo2KH6kkrKDrJ/LXv7mr9w==
X-Google-Smtp-Source: ACHHUZ5s882zWmpeNg/5RObTT0E4/cgyDNURP4fcAjdUJESct3E0S4S/JhwvqD7ApyDGrhqbCiKyPw==
X-Received: by 2002:a1c:7504:0:b0:3f6:a44:73bb with SMTP id
 o4-20020a1c7504000000b003f60a4473bbmr26913wmc.8.1684781704916; 
 Mon, 22 May 2023 11:55:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a05600c205300b003f60101074dsm7165962wmg.33.2023.05.22.11.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 11:55:04 -0700 (PDT)
Message-ID: <fcf99624-9a48-6760-a28d-bb88bce6572f@linaro.org>
Date: Mon, 22 May 2023 20:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] ui/cursor: incomplete check for integer overflow in
 cursor_alloc
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, jacek.halon@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230508141813.1086562-1-mcascell@redhat.com>
 <CAJ+F1CK2V22PMYP4PQwH+VYKhR32GKxFK5eRODE928iu3LVodA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAJ+F1CK2V22PMYP4PQwH+VYKhR32GKxFK5eRODE928iu3LVodA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 9/5/23 09:13, Marc-André Lureau wrote:
> Hi
> 
> On Mon, May 8, 2023 at 6:21 PM Mauro Matteo Cascella 
> <mcascell@redhat.com <mailto:mcascell@redhat.com>> wrote:
> 
>     The cursor_alloc function still accepts a signed integer for both
>     the cursor
>     width and height. A specially crafted negative width/height could
>     make datasize
>     wrap around and cause the next allocation to be 0, potentially
>     leading to a
>     heap buffer overflow. Modify QEMUCursor struct and cursor_alloc
>     prototype to
>     accept unsigned ints.
> 
>     Fixes: CVE-2023-1601
>     Fixes: fa892e9a ("ui/cursor: fix integer overflow in cursor_alloc
>     (CVE-2021-4206)")
>     Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com
>     <mailto:mcascell@redhat.com>>
>     Reported-by: Jacek Halon <jacek.halon@gmail.com
>     <mailto:jacek.halon@gmail.com>>
> 
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com 
> <mailto:marcandre.lureau@redhat.com>>
> 
> It looks like this is not exploitable, QXL code uses u16 types, and 

0xffff * 0xffff * 4 still overflows on 32-bit host, right?

> VMWare VGA checks for values > 256. Other paths use fixed size.
> 
>     ---
>       include/ui/console.h | 4 ++--
>       ui/cursor.c          | 2 +-
>       2 files changed, 3 insertions(+), 3 deletions(-)
> 
>     diff --git a/include/ui/console.h b/include/ui/console.h
>     index 2a8fab091f..92a4d90a1b 100644
>     --- a/include/ui/console.h
>     +++ b/include/ui/console.h
>     @@ -144,13 +144,13 @@ typedef struct QemuUIInfo {
> 
>       /* cursor data format is 32bit RGBA */
>       typedef struct QEMUCursor {
>     -    int                 width, height;
>     +    uint32_t            width, height;
>           int                 hot_x, hot_y;
>           int                 refcount;
>           uint32_t            data[];
>       } QEMUCursor;
> 
>     -QEMUCursor *cursor_alloc(int width, int height);
>     +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height);
>       QEMUCursor *cursor_ref(QEMUCursor *c);
>       void cursor_unref(QEMUCursor *c);
>       QEMUCursor *cursor_builtin_hidden(void);
>     diff --git a/ui/cursor.c b/ui/cursor.c
>     index 6fe67990e2..b5fcb64839 100644
>     --- a/ui/cursor.c
>     +++ b/ui/cursor.c
>     @@ -90,7 +90,7 @@ QEMUCursor *cursor_builtin_left_ptr(void)
>           return cursor_parse_xpm(cursor_left_ptr_xpm);
>       }
> 
>     -QEMUCursor *cursor_alloc(int width, int height)
>     +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height)
>       {
>           QEMUCursor *c;

Can't we check width/height > 0 && <= SOME_LIMIT_THAT_MAKES_SENSE?

Maybe a 16K * 16K cursor is future proof and safe enough.

>           size_t datasize = width * height * sizeof(uint32_t);
>     -- 
>     2.40.1
> 
> 
> 
> 
> -- 
> Marc-André Lureau


