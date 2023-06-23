Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E69473C3F9
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 00:20:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCp7M-0007EQ-7O; Fri, 23 Jun 2023 18:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCp7J-0007EC-En
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 18:18:57 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCp7D-0007dI-UM
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 18:18:57 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b46bfa66d2so18206111fa.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 15:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687558728; x=1690150728;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3F8kMmQTAsCXckruz6kzbxlTvdH81Rh/OG2im+oNzZE=;
 b=g1egHYIA3doR/6aOPGqeX/VfJV4gVQnqudWUrkd5OuQ/IsW6VNQZwvJGVxd6pKIgak
 blFEs8NKc+JGQ5Rs5+aB0/qtnETp5pXZQmxYCSNo/2ZIy07+/cl51mU+Ee2dYcjXXLJk
 Uj6eyt9V371jbPlcpb1/S72xEe3ydmgWAhseosw4zEdJfw9IG9/ngbv7kiwh8owb32hF
 MMYrr8Cx7uj2nr4mnm+8Kgv9WoT6aunvlSVa4Da9h2MZfjMYtH9eq5XNTcGGK6agzDD2
 GdCZGGO4qwRwlZR8Qpq1CBEd9fUybDtjdovChoYdlRJ9I8skrjbVF7aJ+tx2jhF1L8+v
 AMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687558728; x=1690150728;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3F8kMmQTAsCXckruz6kzbxlTvdH81Rh/OG2im+oNzZE=;
 b=apYzALMci+Jq4x/J8mvt+V0YvJbZXTiyme3uCdoTzbFckZZjDa1ntCesLtY7dPmrod
 fvad5xbxy4v3dTjbjZJXcj7O4j1IqchSaory1fI0lIBtRTWaNQlrYyuxiPCEXRjTcwcM
 4BnDAMKp9SbvM4HqYeY5SfJPETWThhSR6/DOQVIoqaYusjv32g82LhOQgGywAZrc00Wt
 9/zJuAGNt3F25I83y2bblRZt6SkaLpZQpW5PgoUfMOEK8XegSuv7ONFkPgrVufCDRu1W
 bVl1m7mCkaXxU3RtEWGjwlflQaAI8Tf6CJSWgcuWKzVi2wnXc2HOv7jL1BsTWR7mOKZx
 X8+A==
X-Gm-Message-State: AC+VfDzIJmkBAZHXNK1d7VHOVw7DToACP7juwkY+mZDv3+p673mNdLG8
 VxT+lt3LvXkI/yl+lM4jDTUHAw==
X-Google-Smtp-Source: ACHHUZ4GsaP7ZWVNoosjHbaymehqz3p59yoOctyVpdzkKUtAweLGXnq2zrpn5TNRamcH58fLMPRRqA==
X-Received: by 2002:a2e:9d10:0:b0:2b5:7f93:b3b0 with SMTP id
 t16-20020a2e9d10000000b002b57f93b3b0mr8404153lji.17.1687558728338; 
 Fri, 23 Jun 2023 15:18:48 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.168.147])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a170906065300b009882e53a42csm139206ejb.81.2023.06.23.15.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 15:18:47 -0700 (PDT)
Message-ID: <1d3b8f13-3e65-f0ff-d4fc-ce1f676c2e87@linaro.org>
Date: Sat, 24 Jun 2023 00:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] target/nios2 : Explicitly ask for target-endian loads and
 stores
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20230623172556.1951974-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230623172556.1951974-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 23/6/23 19:25, Peter Maydell wrote:
> When we generate code for guest loads and stores, at the moment they
> end up being requests for a host-endian access. So for target-system-nios2
> (little endian) a load like
>     ldw        r3,0(r4)
> results on an x86 host in the TCG IR
>     qemu_ld_a32_i32 r3,loc2,al+leul,0
> but on s390 it is
>     qemu_ld_a32_i32 r3,loc2,al+beul,0
> 
> The result is that guests don't work on big-endian hosts.
> 
> Use the MO_TE* memops rather than the plain ones.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1693
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Presumably this got lost in a recent conversion somewhere,
> but I can't figure out where, so maybe it's been broken much
> longer...
> ---
>   target/nios2/translate.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


