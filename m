Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E51722A98
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:13:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6BtA-00085x-Oi; Mon, 05 Jun 2023 11:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Bt8-00083j-FV
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:12:54 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Bt3-00023L-SC
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:12:54 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-654f8b56807so2184163b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685977967; x=1688569967;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a++GAF0MDAeTSIgN9SCoLRw68S+4x4zAoAJVrfMuAhE=;
 b=aCS/EGWqEccw0FTSL4ZIrsJe2i4wxGnI1fTMR84uJFtkhbqiTLs+q4mTX5mAzqbYX7
 BHaXJlyyLmllFoOnFafbueke+Qb+34scsJYx6bUfJMaq4VPCfZpXynyRN+tCg7TUTjQU
 T4a2qVzFURoDJpMJT5EY2K5rSZim75XuBU0DU0mQjiRBHwJ77uytM5EGN77NBKQoMDIa
 m7mlzZzNcJMRawDN6K7+Jdj+2AcoXLAQClNObZ7Iha6CMjs56ulpGSrgoYHgpCUGLiCV
 vRD42lFurDtxDl9T/wyOcjlwtJN+z4rky9kN6OzB3xo0X6Cu03v8oqcTjHH+XV38tj5A
 ZPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685977967; x=1688569967;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a++GAF0MDAeTSIgN9SCoLRw68S+4x4zAoAJVrfMuAhE=;
 b=NO8ECUaW4dx11mI9VHux6yaK9LU38sXfHyeErkp6Wqodgols08cOLp3A3p6TxNERDZ
 mKaqJxbRbp28YYBpRkMEgtzN/wAqQD0rgpazSr6412OLmfWDXOJirw1hptvJsA1ZBlfS
 oMyCOaLOx2k9PM6GFdCdSqyDdDCaP5JNM3DYwQ6hxygEwYfmpUgDHt4Yu6qoSZos4UhX
 O/Sqe+OIvepoYuo3NUMqdzzILeWf5pEXvQ0osGTWyVAnzmwXySz7+qLtbDUbT5FVnTxL
 GZWJF3ecbcC7Ea7J4Cyt/jMFccZ1pVjtUafaCDz7HAYGiYlAbgOvzc8T64tz5Wqfrjip
 oRyQ==
X-Gm-Message-State: AC+VfDwYlPZi8emwXZD/LhrnlgLUlYB5yAvaefIr/qw22JzknY1k1l9t
 /vReX+gmDQoDu6JJwdxq+6W5GQ==
X-Google-Smtp-Source: ACHHUZ7yKdBGRuSnMfSZPDyuS2nCd4H0oJ6Ws0Qo+tlrl0nTN3Z73rPwr8Zpqh3uI0lLh3Fgo88HIA==
X-Received: by 2002:a05:6a00:b50:b0:64c:a554:f577 with SMTP id
 p16-20020a056a000b5000b0064ca554f577mr26309559pfo.11.1685977967270; 
 Mon, 05 Jun 2023 08:12:47 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3f85:a600:6a3e:e465?
 ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a655a47000000b0050fa6546a45sm1405085pgs.6.2023.06.05.08.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 08:12:46 -0700 (PDT)
Message-ID: <c807209d-4d2a-f7e3-ca46-eb08804c151b@linaro.org>
Date: Mon, 5 Jun 2023 08:12:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/riscv: Smepmp: Return error when access permission
 not allowed in PMP
Content-Language: en-US
To: Himanshu Chauhan <hchauhan@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20230605075150.367555-1-hchauhan@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605075150.367555-1-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/5/23 00:51, Himanshu Chauhan wrote:
> +            ret = ((privs & *allowed_privs) == privs ? true : false);

Never convert bool to bool in this way.


r~

