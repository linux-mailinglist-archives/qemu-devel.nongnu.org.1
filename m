Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9A8783A4D
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:06:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLSU-0000QS-Vw; Tue, 22 Aug 2023 03:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLSP-0000QI-B5
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:05:41 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLSN-0000fl-4L
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:05:41 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31c479ede21so1662371f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692687937; x=1693292737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BFz0f2dectxZc+G7ixhxv5mVyg+EiNhSDUpmAiQejlc=;
 b=qYTsKDSDppo/5wIn/tRmD7aWW9gdfHKfDXWgZC+srj4MObVuEaVUld+0T7m/cm4rom
 8npAO2YPPVqetmoxmmGtr+rkDgxwbSZh8Lo0wn7vbBtNycrLqcR6O/xOxUXhQCiUnz2n
 GxNSABrPaI1gnUp/JwngvftyzI3QOH85hDaRI5FZglLyRyy5HDu/8A6G3vlzGg9ZqcK0
 Y7odoQ9Yt8GnbNjLEREr0OBjWDx9xK3T2NEmhXIZOnBerFjFZMJWTbmTY+2hUb5Jnfjl
 iEMlC15DKb6ILlecr/lCyxAo8rfUmA3gEaC969+xbUrVmg6IPRFOPaT6oOWep8jNPjAM
 geHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692687937; x=1693292737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BFz0f2dectxZc+G7ixhxv5mVyg+EiNhSDUpmAiQejlc=;
 b=ggfAviEj5a5cMErd1y0UGx1Hi2uF89tF5wrCkCVjN/Q49e8qvwlgl+tCfO2TOJAxLC
 0nd6E8edYDZS7mnn0lyH/QbYZzyn5syoOSo30LWLDHurdSW9c2VyKJICpfAlzaAms78a
 RqEBifNqRfzXfvaxlZnbJKqi5uYHvKz5V+W3DurtdwakEOfMuBU2sEbEwIL3nVNLD1op
 Wmg6o/QV8/HpdmJDLXQz62YxfM+ytIuiWyGJh6zXNO+Ce9ZnpC1snnYln+tr65KRIOqx
 O8uWh5711MHlubc9XSIcLW1pYbCOevltVeCSJ1umLgTfZ1ZARchTZ0ZljlEb7+JHmuza
 BQLw==
X-Gm-Message-State: AOJu0Yxy7HA+ayOetIv2HtK5814oQ3uQwQ0JcofZBgqgV2jl0+2SvOeY
 ZMmSTA6JrQjD9Tz5ENd7YYoLVQ==
X-Google-Smtp-Source: AGHT+IHxNzDPWmiGTchekqbxLmsZR13oJoCael/WXNnXeG7rPwiZfjcroPeFb+h2IAuoVm00N8+7RQ==
X-Received: by 2002:adf:e802:0:b0:317:e68d:f862 with SMTP id
 o2-20020adfe802000000b00317e68df862mr7019869wrm.37.1692687937365; 
 Tue, 22 Aug 2023 00:05:37 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 m7-20020a5d6247000000b003195504c754sm14845517wrv.31.2023.08.22.00.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 00:05:36 -0700 (PDT)
Message-ID: <8068a901-2897-9518-6ccf-4bbcd82bcbd3@linaro.org>
Date: Tue, 22 Aug 2023 09:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 05/15] target/loongarch: Truncate high 32 bits of
 address in VA32 mode
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230822032724.1353391-1-gaosong@loongson.cn>
 <20230822032724.1353391-6-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822032724.1353391-6-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

On 22/8/23 05:27, Song Gao wrote:
> From: Jiajie Chen <c@jia.je>
> 
> When running in VA32 mode(!LA64 or VA32L[1-3] matching PLV), virtual
> address is truncated to 32 bits before address mapping.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.h                        |  9 +++++
>   target/loongarch/cpu.c                        | 16 ++++----
>   target/loongarch/gdbstub.c                    |  2 +-
>   target/loongarch/op_helper.c                  |  4 +-
>   target/loongarch/translate.c                  | 32 ++++++++++++++++
>   .../loongarch/insn_trans/trans_atomic.c.inc   |  5 ++-
>   .../loongarch/insn_trans/trans_branch.c.inc   |  3 +-
>   .../loongarch/insn_trans/trans_fmemory.c.inc  | 30 ++++-----------
>   target/loongarch/insn_trans/trans_lsx.c.inc   | 38 +++++--------------
>   .../loongarch/insn_trans/trans_memory.c.inc   | 34 +++++------------
>   10 files changed, 85 insertions(+), 88 deletions(-)

(I had to split this patch to ease my review)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


