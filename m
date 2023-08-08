Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37058774D1B
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTUJ3-0003Rd-4e; Tue, 08 Aug 2023 17:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUIz-0003LI-51
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:31:54 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUIx-0001m4-8V
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:31:52 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-56ca1eebcd7so3924672eaf.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691530310; x=1692135110;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Rd0fRUKRhT1n/M9BAURN4XpMmak2ZOu1rmOc/VeZwI=;
 b=KzfcMAPgujafg8T17Rrt9tD5Dx+umVNoBfkZA42v5DNtglsAe8U4HPXJpLh/aBTBbN
 XFEa70/DjbTEy+BaQaHanOiGU2GjOKJvG22PlIuklSw2ull46mmCUOICXxdLhZAPIUT4
 ICqAoaYrbZxMkBbFRZldE+c/LBwcnngIZZM1G+LEYwt81cv9DibcTAu7KpVGzpILzqD5
 SyrvVLUjxWS4Zewhocagvm27JUH1Zdxhr0As/A8w/joNcj+DNHdZfXtschf4tHtr3m4F
 qRSNiTm+BQiYOtuUriJbQ33ve/RmedCoHx/7It12ZxsBQGSOmxa/bqTOljNd6Z0zsXFk
 6d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691530310; x=1692135110;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Rd0fRUKRhT1n/M9BAURN4XpMmak2ZOu1rmOc/VeZwI=;
 b=SnNXJefYXzRmH2jeKZd/6++IZyq6O4dpVKAqEk4uKC26vOLnWq1fmZlJbifIOXs/u0
 uncJYLqNBrw5TwBp6yK4euqO9xgpU7SEjg6ee2Xdgxe7Wg+Fxdv3l3I0hrQAlz61fRkd
 ar3wZqGdfk6yUjVdHs0reGPktF2RIdjYyG2Euh+1FrKwaxPgY6rM/DJgRP+WDaoNSkDO
 Ez2DXLGHp2F02XzLnRsMUPjm+omKEKK/VyUOqhIwHvPehqePDq96nhwtY5gm/ZCfgCt+
 0c/ZhuV+Zv2jsLPMzdw0wHoMxLNpIi2KYZoYhSF2SPHCeQhrlVhX+ROxsTkaTX3093PF
 4HQQ==
X-Gm-Message-State: AOJu0YwsDYnVqYHCTBYIZOSqp+2yZvBV/+qxVJLOeGgg8JTYbpiO3+Ws
 0rpnPxj9bFL5vLnQ7MvRJCfwCA==
X-Google-Smtp-Source: AGHT+IGhuKRRWVlUAdCE26yb6C8xN8fq49MilqlM+pmIIwH92wBkqbtawe+4D/KV9Z6fh4Z7lFzClA==
X-Received: by 2002:a05:6808:1482:b0:3a7:1478:50a0 with SMTP id
 e2-20020a056808148200b003a7147850a0mr1075274oiw.46.1691530309983; 
 Tue, 08 Aug 2023 14:31:49 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a170902d48d00b001b801044466sm9480975plg.114.2023.08.08.14.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:31:49 -0700 (PDT)
Message-ID: <c0da41fb-3a15-7fde-4071-e7113034ffad@linaro.org>
Date: Tue, 8 Aug 2023 14:31:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/33] Implement host-target convertion functions
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-14-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-14-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 23:07, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Implement the stat converstion functions:
> h2t_freebsd11_stat
> h2t_freebsd_nstat

"conversion"

And copy the functions into the subject, so that we don't wind up with 4 commits with 
identical subject.


r~

