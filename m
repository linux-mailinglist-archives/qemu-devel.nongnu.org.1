Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D1774D05
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:26:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTUD9-00074V-Bg; Tue, 08 Aug 2023 17:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUD5-00071o-Qk
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:25:48 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUCu-0000pu-Ey
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:25:47 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bc8b15c3c3so7230005ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691529926; x=1692134726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GPhdLsOA/pOUeHlpCljg0ekI3uxRJuN04nnKRfR8jVU=;
 b=ot3G1E4EEYvbz/IDqZMT5hlWdOZv50eKfOUYgRKe+QrXxClT157a2nteWPcPnFG8Wi
 kNn0oE0L7l3beWhv3dB5lDnHNINOGOtMXUGwvvA0dZIaxTmFgiN2aE5q39FicwLtNMlT
 bcZerIMZQEasoXlNWB+mt0ipVHXKh73l8iRmqjFcZRniS9WS1mYTmaeSVRDFbD7mGzQh
 Afxgd0fX5+G+qwj4poFuE4cYW1uaLPmy5XeOQu6eoElr3KvoHYZJNUaOo79kYwKoJsk+
 qCg7jXTkyzr40yJvXyLBd++KMLnrVtUjhwoEoUodZ6wQk3p+j/JPIXcdxAWEYr2Az2WY
 B3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691529926; x=1692134726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GPhdLsOA/pOUeHlpCljg0ekI3uxRJuN04nnKRfR8jVU=;
 b=kQT4jgp5dsX1YnYS6BnxrAmQGSBGopZaIIWMoG7rU4YsBU/aPhhlsMEc6x8fX6Jpfb
 5VVgKr+L9P2A2kFEVcl7KmaaK2+qJEEFpLGh1/eLUdAChImSnr5Bxq9eQjsslgNVX+dc
 pR95nihwcFjgtfzvex+0qLWfczdKwSN8awm39LuVRT5eKGxpSwPq5ftBMCDBgO3faW9f
 rXWx7mngy67QSbvd2yVDSJrhTAEnvEmrhRkEw4qL5kLrSHqZfGNoLtxssv/GrhqV/oZ1
 sGILiZmZov6PlPtKQsEPnGepSnSPIcaDTp2YqGRNKECPT7tU8rrQ6FcNu41nHzVZJ2sZ
 eS9g==
X-Gm-Message-State: AOJu0YzCfUadaxzBKTAEobG9GCLFeeRZlyd2mKYHzNRgtqnkCs007V04
 KEsjZPtqF8ufDaAV5C+I+mj3+g==
X-Google-Smtp-Source: AGHT+IHi41GttcT1mw5wnsg1cKnxI0p1qtaXBh3YU0bhTGqjm5BdsDsReTGHhOG0ZhA+LcRp9A4gLw==
X-Received: by 2002:a17:903:2283:b0:1b9:cb8b:3bd3 with SMTP id
 b3-20020a170903228300b001b9cb8b3bd3mr1052299plh.31.1691529925969; 
 Tue, 08 Aug 2023 14:25:25 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a170902eb0400b001a183ade911sm9457394plb.56.2023.08.08.14.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:25:25 -0700 (PDT)
Message-ID: <35fdd7ca-39f0-b150-6d0b-283f0f13dfd1@linaro.org>
Date: Tue, 8 Aug 2023 14:25:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/33] Add struct target_statfs to bsd-user/syscall_defs.h
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-10-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-10-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
> +struct target_statfs {
> +        uint32_t f_version;             /* structure version number */

Indentation.  Otherwise,

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

