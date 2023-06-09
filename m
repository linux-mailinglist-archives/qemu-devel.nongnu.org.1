Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B65728F66
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 07:46:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Uw3-0000ns-Pu; Fri, 09 Jun 2023 01:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1q7Uvq-0000nO-3h
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 01:45:06 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1q7Uvo-0004mS-7E
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 01:45:05 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-30e3caa6aa7so1437986f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 22:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686289502; x=1688881502;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wiBH8ro7s+2HOTjhDW5MENMs54pJ8nJqoJOG6oDQlzk=;
 b=xvdsOwAcsbCvIWCwftP1XNN1QUX/YNTBCDXnpyWIbl48DPNbAgQ71ege1mkLB5oFMr
 I4JNEJg/LSrfpFfTRrCdyluzDshHoiO+UiwDT2B7uSU10clQ+ouLriVz1/WWUPK4zLsF
 EagN/6loVUDtZ9TPaMHzmxwbrFE3khEzdTJ+LKiosr9b9n8iGZ5PMSEKv39OCWdI7sbK
 k/awRk2XFtGT7tRPbTrIaGvO6Ktw4zftD1nlFjnbYln6G6vq9UazclBo8kCfP54jzFHA
 CMxftFv0X86WCFe9zrdY9g5kpuIKz/pKGLIG9uHSuDdqk9gFoUZQeBy7wA6p43id4Qox
 MRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686289502; x=1688881502;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wiBH8ro7s+2HOTjhDW5MENMs54pJ8nJqoJOG6oDQlzk=;
 b=QfqOMJ5/0csI+kVa6Kq6E4pKTdPu/XmXys2h3a1ivMqXo8ysPIrXdSNKS+43qYnBdc
 RBIAWcTO4KPX+B1MtPnBZsgxqqkYl3IV6wyhk2pqaTqAsT8XhPcxg59C/KoeZXD4bwVv
 Tj6BbbleFqHs3YinD4F3OU3JfORILm9xOElbqtg+3ByGZN1DovQwWwxy4SN/wdBK17FJ
 7i/zLaEaYAJdijFIvZxFRknhhqbzvbuIVdEYSCKrA5TLcwJ9c33Hq1JrYsp6uG9liUwx
 ttVpZ3/dHH1YIodQZ9o5zXaeajNuY9X6RxTtvVznSjK89kry1tb3+MU4B6Vv/8ZoWTOC
 ytPg==
X-Gm-Message-State: AC+VfDwzsKoavJ4+HQI4wGS0PQe66G9VWJnm/DaOETFpVAhjTs5ZiJAT
 YvungQ7NbW9rAo1RorvfChL0uA==
X-Google-Smtp-Source: ACHHUZ4XlaTCNTaIHAO7Nk5PCkDhhZDqXkGUkgyymQnfKn0pjv5orWIvWnSOv9bP6kyefF3hpeqQrw==
X-Received: by 2002:a5d:4709:0:b0:30e:3e99:3021 with SMTP id
 y9-20020a5d4709000000b0030e3e993021mr198458wrq.45.1686289502284; 
 Thu, 08 Jun 2023 22:45:02 -0700 (PDT)
Received: from meli.delivery (adsl-68.37.6.160.tellas.gr. [37.6.160.68])
 by smtp.gmail.com with ESMTPSA id
 e8-20020adff348000000b00304adbeeabbsm3414752wrp.99.2023.06.08.22.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 22:45:01 -0700 (PDT)
Date: Fri, 09 Jun 2023 08:24:42 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, alex.bennee@linaro.org
Subject: Re: [RFC v2 6/6] linux-user: Add '-native-bypass' option
User-Agent: meli 0.7.2
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
 <20230607164750.829586-7-fufuyqqqqqq@gmail.com>
In-Reply-To: <20230607164750.829586-7-fufuyqqqqqq@gmail.com>
Message-ID: <vz1az.urjahnph4c90@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
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

On Wed, 07 Jun 2023 19:47, Yeqi Fu <fufuyqqqqqq@gmail.com> wrote:
>--- a/linux-user/main.c
>+++ b/linux-user/main.c
>+    /* Set the library for native bypass  */
>+    if (native_lib != NULL) {
>+        char *token = malloc(strlen(native_lib) + 12);

malloc() can fail (in rare circumstances). Check for the return value 
here. Or use g_malloc() which terminates on alloc failure.

>+        strcpy(token, "LD_PRELOAD=");
>+        strcat(token, native_lib);

(You could alternatively use snprintf() here)

> 
>diff --git a/util/envlist.c b/util/envlist.c
>index db937c0427..713d52497e 100644
>+int
>+envlist_appendenv(envlist_t *envlist, const char *env, const char *separator)
>+{
>+    struct envlist_entry *entry = NULL;
>+    const char *eq_sign;
>+    size_t envname_len;
>+
>+    if ((envlist == NULL) || (env == NULL)) {

separator must not be NULL as well.

>+        return (EINVAL);

Unnecessary parentheses here and in later returns.

>+    }
>+
>+    /* find out first equals sign in given env */
>+    eq_sign = strchr(env, '=');
>+    if (eq_sign == NULL) {

Perhaps you can return an error message to the user here also, and 
explain why it failed. You can do that by passing an error message 
pointer with the function arguments.

By the way, if strchr(strchr(env, '='), '=') != NULL, shouldn't this 
fail also?

