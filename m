Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F6D7CF437
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:43:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPXO-0001kF-8T; Thu, 19 Oct 2023 05:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtPXM-0001k1-BS
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:41:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtPXK-0008EN-Oa
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:41:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32dc9ff4a8fso1610981f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697708509; x=1698313309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M9Vime+N6LUS62nsgOe3v3jxJz/ZXJdMvcNTZxmw8AU=;
 b=XwExUHzv57U/GbluPDGeglB9jxxGnPPIIqHMASAhDb22070VwGmi9fWawE1NjlwoR6
 hS8SAWmeZ25e1YuGxt885QybaoNhdQuagNZyZY5XnkiY+MjgF0Gdf0lkXYMNUHnotuz0
 pxeeBVOmz8fR8Mri1wzEfIy7GDRzcdXXzOgCy6fKWo4Tm0JNO7ltM9rEQ8DDLnl67YSX
 obsN0U42gnWcjBikuOCtCAYP6EjaXDHlJvpnlIKbBUakjpDCy0TrMZimD1S54bVdpgac
 0aPdyHNIn/eVckHWqpxEsAzevi8na8t8h1MezVrb0JvVU8xjsFF7vufwiWoGFbDGHXfR
 1R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697708509; x=1698313309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M9Vime+N6LUS62nsgOe3v3jxJz/ZXJdMvcNTZxmw8AU=;
 b=iyD0HEEH35xHswO9NYTq9VnGao//Q9RSHAD4+a5fnUtLXeAWSBIzMa/Q0qJolJibl0
 MsqGRqYNpnLdByxAwxO3zagjxYsLDZO4Q1wnWifFM4IWib2UvpfrZbvgd1vyOsoRzo+I
 wdz2hw3E3L7Z9APVTz3xjGYVCSPTaBWWN0OVnvmGXJLAtNVD2rQw2b0cOjPG4FYa0l4l
 JKXDtlcKTLq+HfvMcs1GQD8GULkaUjCHfb6OtLsv+xi8vn0oOThtB7MnjbEAzii4p8hG
 jbPx8vSshaOdchfofen1jdEpAl2oa76gNFYOeJxIJvMjiHp09DpPJctkVuW+4LTeplXO
 9+DA==
X-Gm-Message-State: AOJu0Yxd2g+h5QbVNU3tKLC4s+2mCN4H24h2MwCgg4pFulpdoIdWOGtz
 O9A9aYZ/7tjPqWgM781mmdTKpBJJ9/EjlHdbWEvllg==
X-Google-Smtp-Source: AGHT+IEZjLfy+ym/HAoVO6inlT4VjeeyXQEk9/YiEd3cEG0jJA63tV4WuxqU24z7VNNEMbmwM6B1EA==
X-Received: by 2002:a5d:494c:0:b0:32d:8c57:b4f2 with SMTP id
 r12-20020a5d494c000000b0032d8c57b4f2mr939376wrs.37.1697708509017; 
 Thu, 19 Oct 2023 02:41:49 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 k1-20020a5d66c1000000b0032326908972sm4068666wrw.17.2023.10.19.02.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 02:41:48 -0700 (PDT)
Message-ID: <9bb5de70-9e47-5404-be9e-5e2db029dc12@linaro.org>
Date: Thu, 19 Oct 2023 11:41:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 02/61] target/hppa: Remove get_temp
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
 <20231018215135.1561375-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231018215135.1561375-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 18/10/23 23:50, Richard Henderson wrote:
> Replace with tcg_temp_new without recording into ctx.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 76 +++++++++++++++++------------------------
>   1 file changed, 31 insertions(+), 45 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


