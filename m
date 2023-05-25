Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB68C71118E
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 19:01:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2EKH-0004ZG-2M; Thu, 25 May 2023 13:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2EJu-0004Y7-RQ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 13:00:12 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2EJs-0007l6-VY
 for qemu-devel@nongnu.org; Thu, 25 May 2023 13:00:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d5b4c3ffeso1830869b3a.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685034006; x=1687626006;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfJ5sDaD5Eigy3wjJQlySka7C8RlP5SjSYtqHDSStgE=;
 b=tO/6PGk3sh44mk9jatSioB/4GkvY/jsBbJVufQ5xu1qoHgAad6F/HPw+GelBQ5RlAp
 j4eZ5+BXP6Ex0YoN9fXdxXQQ88Y1Q9ATTrKHw44pYmq9+Opz0TxFD6UNOU/zhOyDsDrK
 Zwscqr1k9tlSLx7P7xip6pTvbpt1tMWgo9K5k62VSw73AylENSPCRZdezOa1uKNn3xLR
 EvAmpY8d/fhh+oN8Q/vcNzjC9+B52xmSm7yDAZS1JztJM31eQ0pYgw1WjGCe5vMXULFW
 eSvHYGE1jgteXHQVYiVz/XUN/KpKmyttXEIyd71wDx0/lVxBEQBQtZNs/MlS+Iz+HO8D
 CAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685034006; x=1687626006;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zfJ5sDaD5Eigy3wjJQlySka7C8RlP5SjSYtqHDSStgE=;
 b=ZpTkItQZsg+618Tshvr5SMY86D76XLcwfyElG76zNc5tCIrxUffJZ3nUa7qlsNFBPK
 kbNkc+8pzJqj9Dydy69TVQr+qGkIhpritDe7sdoDPYGrYa6ZNalCBUCmmsHGB0xfvqjx
 tR6dLk/rnR7H2jciObDPiZhtbEW20lQUdPgtgHt3cScfNzCs+Ui70lXrqzEcOcyQu8VA
 os8wJSM/w9Ubm+lFq4RMcSqbguS0HaoAHV4rWvESqh5UotIvxCA+s7HHCvybECsXkA43
 EpOMt54Z8mZfOzw1KFcmjbDLgLOSo+zt0zaFN7HHRzEzu+CvqK1OafThtlPpHKwjs7Xv
 JJ6g==
X-Gm-Message-State: AC+VfDwG0xgAyGELHbpJT59QgnYQgp6mUDM1bdsT0uyKyQtIxZoTnMOY
 zpgARRffpoq4w2pr5kM1hYq938ntlUSaPDJND+c=
X-Google-Smtp-Source: ACHHUZ7R+ymdsfnZoHYlBwycnGXoaAL+ChiIEi2uQDXrEdvXQfbNrT50Vvzs1it8hBuVy1UdirP4dQ==
X-Received: by 2002:a05:6a00:1a16:b0:64d:277c:4ab2 with SMTP id
 g22-20020a056a001a1600b0064d277c4ab2mr9765764pfv.24.1685034006163; 
 Thu, 25 May 2023 10:00:06 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7ac5:31cc:3997:3a16?
 ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a62b60f000000b0063b6451cd01sm1398683pff.121.2023.05.25.10.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 10:00:05 -0700 (PDT)
Message-ID: <7b9511f8-eca4-8a27-9d4e-31a6f16a6bb0@linaro.org>
Date: Thu, 25 May 2023 10:00:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: tests/avocado/virtio-gpu.py:VirtioGPUx86.test_vhost_user_vga_virgl:
 ERROR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Hi guys,

https://gitlab.com/qemu-project/qemu/-/jobs/4352476431
https://gitlab.com/qemu-project/qemu/-/jobs/4352476434

This test ERRORs on the azure k8s runners with

qemu-system-x86_64: egl: no drm render node available
qemu-system-x86_64: egl: render node init failed

Can we please SKIP the test if the required resource is not available?


r~

