Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 342FF712A26
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:03:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zt6-0007Ob-Rz; Fri, 26 May 2023 12:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ZsF-00072g-VJ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:01:15 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ZsB-000199-Lk
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:01:03 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2532d6c7ef2so1755473a91.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685116858; x=1687708858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eiJ/02BSMJp7u+0lI90IOySOT5jiZ9eQ5KzDzvOawsA=;
 b=CCzQg7Zd2cy1cfLAK+7b2oc2LHl2nlxCPYVqUcZudwYeCqkwpl1OfMQdZWl41IO4K3
 qtW8fASqe5gLtR7GTis6T/jct1Co/7r9yIRaXtW56pqE3iB1HQWN1RZN/SUSQmrIJSIP
 W0xLGUDXBssD1XCPTXHmJC3ZCLV9fdQy6irX7VkXqfNUU+zNjvZh+IwZy4IuV/5NkOXc
 KsJWqiBWU/hDP+Uwch+E3Wve0pIPNiyIVTeafdJcl1igs3cBUwQSy16gqg9nj5D9Xbwy
 P4QFGZ0ge/oXEqZOZbuNO6vFA9W+4nnyzHkjLTU5EJG2yaPYRr9dci0irLCWW/GRbMt4
 nwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685116858; x=1687708858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eiJ/02BSMJp7u+0lI90IOySOT5jiZ9eQ5KzDzvOawsA=;
 b=aATKYRiytjlwFQIun6VhjijSNp2vsHRU3WnYFYbfOwFtObPouvkdB49Up3tYAUHQ7E
 SVKmxDfH9FwVcDFZvCefaXVS2YMdliorUBHc2pTH29+QkzdcUQ/zEhw9QoZ0Kkee0TbE
 75a9kPBitAQVyT4r2QMSaWNmkfwXdG9AfkZi4giQQeE0QdiLr7Uk6sUiHExoBsjwXjgF
 L5q5VwYq4OMByv+b/Fq7SGTMElreaxFwCGxPm3d5F7tpcPXmjs4leljFADbx11p5UqMT
 FCYAYlsRR6bWjdMJEIrxHz4LJ0p6ddaeKWHOimcrCd5q/9fknOrGxU7fnv7HfpGnY08r
 R6HA==
X-Gm-Message-State: AC+VfDzf1fak4vuGYyOMVBoUMGHJI38dHvaUoXFQ4ByW591ny2Ycyo8e
 J2RXAOv9F7HmqEqTQwdJs/rp2g==
X-Google-Smtp-Source: ACHHUZ5NZwMAwhUZqiOzarBr7Ox9zNMxrFUmOrrjTV60w0hle3T81Tj7zn/0uUYRipvTZ03elGRF1A==
X-Received: by 2002:a17:90a:5802:b0:253:25c3:7a95 with SMTP id
 h2-20020a17090a580200b0025325c37a95mr6609477pji.14.1685116857731; 
 Fri, 26 May 2023 09:00:57 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a17090abb9500b00253230bce61sm4690881pjr.43.2023.05.26.09.00.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 09:00:57 -0700 (PDT)
Message-ID: <45ad9d3d-f796-5af7-97b3-08260d82b73c@linaro.org>
Date: Fri, 26 May 2023 09:00:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/5] gitlab: avoid extra pipelines for tags and stable
 branches
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230526101934.935969-1-berrange@redhat.com>
 <20230526101934.935969-5-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230526101934.935969-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/26/23 03:19, Daniel P. Berrangé wrote:
> In upstream context we only run pipelines on staging branches, and
> limited publishing jobs on the default branch.
> 
> We don't want to run pipelines on stable branches, or tags, because
> the content will have already been tested on a staging branch before
> getting pushed.
> 
> Reviewed-by: Michael Tokarev<mjt@tls.msk.ru>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   .gitlab-ci.d/base.yml | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

