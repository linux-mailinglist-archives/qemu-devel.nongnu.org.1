Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7123370E205
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:45:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V8a-0000Ny-UF; Tue, 23 May 2023 12:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V8Y-0000JL-LP
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:45:26 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V8X-0003rk-0U
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:45:26 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3093a6311dcso7596885f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684860323; x=1687452323;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vi5G+6PY4GgwjJh4FkhyIBQ3N9QayRpx5s4+uXlSdIU=;
 b=cjEL9LC9Jq0yn50fw5YaEwixrZ3MFY/3CUsxzyCxt6faQ0hoGtHfgByF2+O+/cyQOj
 mHfqkNI682LP7q8ekvTUm6vzVK4fCk97rlCXw/IGQ/xtc+0d34x/AnTwxLMAtGzSHB/i
 i72QA9jwmvM12s0SkE4gJ264b91B2GZ2S5wfXxQYXgK7kXlrfYJgJJkE2qPPSBRDVkaW
 WQcOJE+WyEPHDUGSTLUzFinmnCYUGPZo74DNw7XJrJBLg2VCZO7mBWd2zjJqBjiDLhtX
 fkuM+3BFmnI7KO0ghfB53DLWYnCm7y4lFVXlFrt+DFgDi1+hl2JAGCsnGucps4EbFj/p
 erxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684860323; x=1687452323;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vi5G+6PY4GgwjJh4FkhyIBQ3N9QayRpx5s4+uXlSdIU=;
 b=gpkqHXyFS8vA4hiwY6R+NZZGO/GVuvtm/NGWuUUKKdx5Um6miW8GtwAoh8nI8iXiSm
 jx9eYDn6+ICvN6UAE9tUdUOrLOIyfS460oTyAuAySOWZMYjU49g7wUDupMPHVZ7/OuFH
 v/GDy2SUPLl75rrldUIvDsx4Tt5Wezyxbf352z5n7t32+GMza1RBue1DEyYxCY/woF4h
 tP4NIIvTRl8G//rqPzCmYcVethnzSd+fySnH/pBERCcHqyel1pSnMvu8hLPKrTviHIuV
 eDMTfYl0L3+8qUC4wuWmfnxWT3OyQamnBAEqIypRzsrrLfwTournvLuxC7Xc/OBNxhyq
 6skQ==
X-Gm-Message-State: AC+VfDy8ROgaJmv0rWCBy+N7XbLs/UIin9Td5ipAJQWYwLu0E+NsNXzb
 oWdqlti7v8Nzoq4wcC9TapXqMSZi6fFt75aJte0=
X-Google-Smtp-Source: ACHHUZ70Odvt8+Ke3G7DfLEnRY5U/ID6yGMt+e/ZK/WoWc7QKuPf3uNTx9Nzfs5fO4c+LFAbDsD2Ng==
X-Received: by 2002:adf:cd90:0:b0:309:3d70:e05d with SMTP id
 q16-20020adfcd90000000b003093d70e05dmr10405627wrj.16.1684860323434; 
 Tue, 23 May 2023 09:45:23 -0700 (PDT)
Received: from [192.168.1.102] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 t5-20020adfe445000000b003079986fd71sm11648326wrm.88.2023.05.23.09.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 09:45:22 -0700 (PDT)
Message-ID: <45d83422-6222-22cc-dbc4-238ad0e3e8e2@linaro.org>
Date: Tue, 23 May 2023 18:45:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 45/52] tcg: Define IN_TCG
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
 <20230523135322.678948-46-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523135322.678948-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 23/5/23 15:53, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/region.c      | 2 ++
>   tcg/tcg-common.c  | 2 ++
>   tcg/tcg-op-gvec.c | 2 ++
>   tcg/tcg-op-ldst.c | 2 ++
>   tcg/tcg-op-vec.c  | 2 ++
>   tcg/tcg-op.c      | 2 ++
>   tcg/tcg.c         | 2 ++
>   7 files changed, 14 insertions(+)
> 
> diff --git a/tcg/region.c b/tcg/region.c
> index bef4c4756f..34ac124081 100644
> --- a/tcg/region.c
> +++ b/tcg/region.c
> @@ -22,6 +22,8 @@
>    * THE SOFTWARE.
>    */
>   
> +#define IN_TCG
> +
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
>   #include "qemu/madvise.h"
> diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
> index 35e7616ae9..678ab482f7 100644
> --- a/tcg/tcg-common.c
> +++ b/tcg/tcg-common.c
> @@ -22,6 +22,8 @@
>    * THE SOFTWARE.
>    */
>   
> +#define IN_TCG
> +
>   #include "qemu/osdep.h"
>   #include "tcg/tcg.h"

[...]

Could this be enforced via meson instead? Smth like:

   static_library(tcgcommon.fa,
                  [tcgcommon_ss.sources()],
                  c_args: [-DIN_TCG], ...)


