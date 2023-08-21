Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D35D782894
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:08:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY3h2-0001Tx-PT; Mon, 21 Aug 2023 08:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY3gs-0001JD-7T
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:07:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY3gp-0006OA-Uf
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:07:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e587eso31068625e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692619642; x=1693224442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=re0HGh/VVeBdDKxNmmul9IBGiBmPOCyIA62KqflmZg0=;
 b=dWulUhuyAK4SLjAVNJnPrbAt00KqIn1ANwUNNvZuYrDmRZkq0q7CfFliwtFbHDoTmD
 PJaOKIAZgvWlQ4opuUxUpREhmHAVhbZHY1ONPX85l3ZhAwNhv3sYW7I0QC5o95/N9tHy
 aLaVdmxKB+fPvv7i5qImwkLP1Dt6dBEU/u7pXUCe42XmH/SntruirMTwQ+TpBn0j7T6o
 q4c4EpY5gOHhUuafm3atX348UFWpZsk7FrJrlxlhWIKgKqNYg81Gz06bzDhxbc0P65O1
 E+4G67BPDbG8275eDTi+Dr6bDYD3xC0IwEumtJcHDJFL3UdZY+wUrG0m6jrs7Rr6ZqYs
 NDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692619642; x=1693224442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=re0HGh/VVeBdDKxNmmul9IBGiBmPOCyIA62KqflmZg0=;
 b=PqPbMQHFDkqT1I4iVNuWCdQ7CGUIYPOFAtbMu9JdIfsMtlTpLltIhXa6TnH/EctzcD
 WHdCuBWn3jQI6nQtbBqc9v8W/co0JM+uulOkNueJwhwlL/LXagiBO9ABSuSTYdJXAgAX
 di9DKuxr8nPlFomSdN67ZKCoTk+s3vnlIzZMeRN+lDrpq9RuMc1uOb7CCWhxgeLclVP5
 zwYbXLtHDaNWgqK9yUz914krfgzCyCD9dTpCN19zbZbu9YRUKqAUGZXzXaS9xuVHUhtR
 yxaxZ1teAXsRSQB7oXa3bPMWRNKYggQqvk2Aj8yha3TJvct71n+omvzwdP56zrm0CKIZ
 2MrA==
X-Gm-Message-State: AOJu0YwuifVNwXhF8XFNf4aI8n9IVvT0woVnbDODc4ErwYeWApek9E5d
 /dJQiDoB0WI1OjEMAI0Yk2hFStnNCbPyfIM3Wv8=
X-Google-Smtp-Source: AGHT+IGi5v45Q4u+cB8Cmms5B4tBFN0Z+6shb5Ig+MB7mdswi2jaILQsiIst2MkIVYxLgGQ4+aeOvg==
X-Received: by 2002:a05:600c:3781:b0:3fb:9ef1:34ef with SMTP id
 o1-20020a05600c378100b003fb9ef134efmr5447037wmr.37.1692619641682; 
 Mon, 21 Aug 2023 05:07:21 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 n16-20020a5d4850000000b003179b3fd837sm12311414wrs.33.2023.08.21.05.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 05:07:21 -0700 (PDT)
Message-ID: <3dbc44b8-8fdb-1476-c5b4-7e2699f224c9@linaro.org>
Date: Mon, 21 Aug 2023 14:07:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 4/6] linux-user: Show heap address in /proc/pid/maps
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, deller@gmx.de
References: <20230816181437.572997-1-richard.henderson@linaro.org>
 <20230816181437.572997-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816181437.572997-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 16/8/23 20:14, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



