Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A985770DBA
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 06:27:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS8ry-00007h-NT; Sat, 05 Aug 2023 00:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS8rw-00007U-CD
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 00:26:24 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS8ru-0007l5-Se
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 00:26:24 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2680f27b52dso1578157a91.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691209581; x=1691814381;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DHQiMkkF3Ro7JquyXv5V3LxUsoSFyLa7Fy0K5i7krps=;
 b=bDRL9ykyioQEwxjqL0WOjuBzSXe/ErVr3677PIy/f/hB6kAy/iNLpa9AiJQbDE5KHl
 OXla/ikrwicx7FEweYvnQAusHSuvZBVL94nsh22odUHzM8UaC68yIbY4RJ0sguGmMY6O
 7OcJbx+AVocSTIqeehdWB8XzxqkiyoDkZ5S3ggGn1EUV7OTcBfaIn9sZxZ/14pCLupyq
 JdHtVvchrx8Ii6f73U2PrHaLCWhqM9YTbPtZSGS7PbxLvYk02jctYtaR1lJLIuG/ldqL
 AdQaCqML2ZeDB+5WSWIosKS9e5mHTwi4C4U9tQDAgaP7J6Y7Da/hlpU14+U2uD/cEjsB
 nZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691209581; x=1691814381;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DHQiMkkF3Ro7JquyXv5V3LxUsoSFyLa7Fy0K5i7krps=;
 b=ULmlyFepy/pUF6DXreb3b8tO6f4zc7RyXRdyys8PjX2AHCIjzQ/ilOiWw0MqSlZo+U
 sTqLZCYQ20yqgDaGLZKxtrCSxa3yBQ6FOZUQeMuaOtF4v1O8Loct0OpAfW9KW4gTFUE1
 ecy573nkr7qlDFsYYEZ6Dducv5K2nyDDzVdA1QAjg/aJ74Ma+SoAPmPo+tPMF7Gm6dM6
 XI8V2OaJco2JOV3wHFpQE8S+W0EGhE6cwOjU5eiPcw0SvfTVX52O+Z3bBK6d6izF9aa2
 E/fFhkrx6CoQVOC46jwZnOBWMrf73Ad7w6xkyiVM0pj0uiUEf4xOdXw1RA1sPy29Gcp9
 1ytg==
X-Gm-Message-State: AOJu0Yz1sbtAiA+aPLaM6gtF1k19bT9k2v9Dqh9WWsvd8jGsZmn50DRJ
 Fm4TisETnyyfcvIqNyHWBQE7RQ==
X-Google-Smtp-Source: AGHT+IH5DnoNrVJMmZZYwXDk+d200eNVmO5VPGnti2CREvIu59gUAhMTzBQV4/VFF2CiChqM08V7MA==
X-Received: by 2002:a17:90a:738f:b0:267:717f:2f91 with SMTP id
 j15-20020a17090a738f00b00267717f2f91mr3022302pjg.40.1691209581439; 
 Fri, 04 Aug 2023 21:26:21 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:c240:d44e:cb93:acbb?
 ([2602:47:d490:6901:c240:d44e:cb93:acbb])
 by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b002676e961261sm5568824pjt.1.2023.08.04.21.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Aug 2023 21:26:21 -0700 (PDT)
Message-ID: <0c0faac4-952a-1f23-3b43-3b15e6d5f24b@linaro.org>
Date: Fri, 4 Aug 2023 21:26:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 07/24] linux-user: Do not call get_errno() in do_brk()
Content-Language: en-US
To: Nathan Egge <negge@xiph.org>, qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com, deller@gmx.de
References: <d83d4d31-dabd-5f05-e173-cbe255e26aed@xiph.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d83d4d31-dabd-5f05-e173-cbe255e26aed@xiph.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 8/4/23 16:40, Nathan Egge wrote:
> The linux-user/syscall.c has many such places where this style check is failing. Should 
> these be fixed in a separate patch?

Yes, eventually.


r~


