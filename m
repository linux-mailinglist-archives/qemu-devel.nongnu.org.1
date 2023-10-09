Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8C67BD30F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:10:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjTD-00067Y-NW; Mon, 09 Oct 2023 02:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjTC-000661-3k
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:10:22 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjTA-00009X-Bu
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:10:21 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so682110066b.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 23:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696831818; x=1697436618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XWdPdOs7mx57SjWq3066JLzCN01TLQELOyLYiY/Ghzg=;
 b=OcJqZX8T6F9P0HSvXRm3yOcgmf6cgGx4dWlpUfwmg18v5m5igYZ6iz70WabWqnNPoG
 nyXtylwM0cwzSjtAbq4LPOvP0+p7j+mYvhEbANcESNKaBTNR7dOCKFRm2xgyLXB8ZNos
 77xDao5Ljp2ygNG3YFXLmE1jQPUwOenwn51ArgG/0ySzZeLBT/U0bqgNmySeOxQSsePp
 SlFUa3bbhcBHA8/TxkrkJSwLQUz8wRoJ5rtM/Jnj94WMfyI5baPkMc+O6fJDaLh9C//1
 P6Lo+N1HKEa6caO/00fzToH35EE7oPJ5EDg/jwqj1Qv6NGI1uiDNYrV0J7vxRUEraLdW
 jw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696831818; x=1697436618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XWdPdOs7mx57SjWq3066JLzCN01TLQELOyLYiY/Ghzg=;
 b=e8qTivF5+Hf+UrzhDyFt175Ic1awdsJNvsFF7Uq4WB1FAEkoGkI0CTAQBOceIQRqD+
 0NETOOJ8PVSnzMES8oY8IYxxpczaKX7cgyKJBckrNMoQQ/Wgcm5Fmjsz5yqFy/yBiA1Z
 pmnKKLox4lpMrPmoShydDTK0dDCpW/6To1a2YKW5Ywo84LLrz4LVmlUx+lvxFZeT96d9
 Sx0cdlLOuseN7ZVZuysoBt3ZzTDm327FJzKHrA5TMO36Oj6QrqlkZNKuOjUd/V95aq2r
 QSRUgV0sYXhed9Sn0zc5lKtE762CHE9me7Y/bXKSbiVewr1+Dw62e7/T6kKHDBCYguOE
 dXNA==
X-Gm-Message-State: AOJu0YxYY3wQK7xo50PjF414FSXT/7xVFBiB+9hJ8q45d1LeQKNj1p8H
 DWueCu2MR0PHPLbD1eheEasDRA==
X-Google-Smtp-Source: AGHT+IHumSgXDgDq5Mkpr0qzW1Xcjl84nK3WP83lycjdfKpwzPzzvK8UkZ3ABd4bf2q9DCztbu7NPg==
X-Received: by 2002:a17:906:5198:b0:9aa:25f5:8d93 with SMTP id
 y24-20020a170906519800b009aa25f58d93mr11896837ejk.49.1696831817930; 
 Sun, 08 Oct 2023 23:10:17 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 v24-20020a1709067d9800b009b2c5363ebasm6277441ejo.26.2023.10.08.23.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Oct 2023 23:10:17 -0700 (PDT)
Message-ID: <c4536580-6757-7cc0-170f-f20fb0ad6e6f@linaro.org>
Date: Mon, 9 Oct 2023 08:10:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/3] target/hexagon: move GETPC() calls to top level
 helpers
Content-Language: en-US
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, quic_mathbern@quicinc.com, stefanha@redhat.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
References: <20231008220945.983643-1-bcain@quicinc.com>
 <20231008220945.983643-2-bcain@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231008220945.983643-2-bcain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
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

On 9/10/23 00:09, Brian Cain wrote:
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> 
> As docs/devel/loads-stores.rst states:
> 
>    ``GETPC()`` should be used with great care: calling
>    it in other functions that are *not* the top level
>    ``HELPER(foo)`` will cause unexpected behavior. Instead, the
>    value of ``GETPC()`` should be read from the helper and passed
>    if needed to the functions that the helper calls.
> 
> Let's fix the GETPC() usage in Hexagon, making sure it's always called
> from top level helpers and passed down to the places where it's
> needed. There are a few snippets where that is not currently the case:
> 
> - probe_store(), which is only called from two helpers, so it's easy to
>    move GETPC() up.
> 
> - mem_load*() functions, which are also called directly from helpers,
>    but through the MEM_LOAD*() set of macros. Note that this are only
>    used when compiling with --disable-hexagon-idef-parser.
> 
>    In this case, we also take this opportunity to simplify the code,
>    unifying the mem_load*() functions.
> 
> - HELPER(probe_hvx_stores), when called from another helper, ends up
>    using its own GETPC() expansion instead of the top level caller.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Message-Id: <2c74c3696946edba7cc5b2942cf296a5af532052.1689070412.git.quic_mathbern@quicinc.com>-ne

Again suspicious '-ne' trailing.

> Reviewed-by: Brian Cain <bcain@quicinc.com>
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>   target/hexagon/macros.h    | 19 +++++-----
>   target/hexagon/op_helper.c | 75 +++++++++++++++-----------------------
>   target/hexagon/op_helper.h |  9 -----
>   3 files changed, 38 insertions(+), 65 deletions(-)


