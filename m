Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF210708855
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 21:27:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjGq-0004vw-IA; Thu, 18 May 2023 15:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzjGo-0004vT-PT
 for qemu-devel@nongnu.org; Thu, 18 May 2023 15:26:38 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzjGn-0006hf-AI
 for qemu-devel@nongnu.org; Thu, 18 May 2023 15:26:38 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2536b4b3398so702945a91.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684437995; x=1687029995;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOkqgPXJCT+a3A1t6S3MvG9Vo/ycj4H3b0YinTyGems=;
 b=Rkg7HtMe3tTcM5mUK/KoMyfoQFWc+00gWk0/7DLycd9qLx6FOncpVJ4JWYpD0CHBzW
 Myg7gWY+jCE5nbMYj9ip1SlxV2Qy3RhO2xooqQerT+JiAi5Ezf0B6wUSQ0mJ5fLLWuwT
 Qm9kQ9OFno2/ZvX/IK+9jfhU/9HaqAPBvYuIZwlrT/Caq3DV+Y7YTlwHu31WHceF1DNN
 xqy2mkGpEz1x+Uy95YETcM9rEwz6B47NdXx+5wNYUvgug5QdLHj7Ugx2aJv+fSn2OT57
 ctyhHmvxJRFjHFflHZcrY6PmgalBvlFb9GfJCFwY7y+qt386JcFnM98VjWYG4KXAex5b
 MsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684437995; x=1687029995;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gOkqgPXJCT+a3A1t6S3MvG9Vo/ycj4H3b0YinTyGems=;
 b=BCaXvThv0M7qwZtCRZoG16wnfrlEjZL4FEY3Qc5J5Ixus9STQuNZ9dG3wEX8VJhcTD
 Ja7Zgfm43UFxt4bHoz/jvYaVCc5eh4IptLc9wLESzOU7KIzjDba3QDAPPIH7vtDxT4FW
 E8Y4jvRmbuMK+Zu9y6WoOgArsWKer0q95W0WESEQKM4otDzihEiXB2LD4vgOwnOobxd7
 c8Uh0YoIRGR54Q8tSisg/ir5DtOIJGXCA61Lif8+hiRVCrgLyb7Gw4auK+Cd5XkqQV+q
 Vnplfgy89mEEloV+uZOLrBoIpj7a+XGvf1zLoT8cWG1dCeRfqMZ7AN900wcg6OXq/Tk0
 6ffA==
X-Gm-Message-State: AC+VfDz3lNFij3lT0A644P9ytdRFkvYu3r+w0GUZOLQxglkRFt6789WC
 tVCVLrnEZwZUpSthJAiJvn6D/WBN0gTImxN98+8=
X-Google-Smtp-Source: ACHHUZ4oiAdLWJA5rvqqd6rUhzTmZh0kerllan7doVOT4eZfVPq4Tj4P0S0jmF0/U+7iLSlRYo3Z8Q==
X-Received: by 2002:a17:90a:4003:b0:247:4f32:d108 with SMTP id
 u3-20020a17090a400300b002474f32d108mr3411789pjc.13.1684437995337; 
 Thu, 18 May 2023 12:26:35 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a17090a128f00b002477dda66d2sm36550pja.37.2023.05.18.12.26.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 12:26:34 -0700 (PDT)
Message-ID: <58b8067d-3136-94ed-f53e-2ccd0feb8c75@linaro.org>
Date: Thu, 18 May 2023 12:26:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: gitlab shared runner time expired
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

So, here we are again, out of runner time with 13 days left in the month.

Did we come to any resolution since last time?  Holding development for that long just 
isn't right, so I'll continue processing the hard way -- testing on private runners and 
local build machines.


r~

