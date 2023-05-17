Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DB6706F2D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:17:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKla-0000a4-8B; Wed, 17 May 2023 13:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzKlY-0000Vw-4j
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:16:44 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzKlW-0006Xq-GS
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:16:43 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-52c690f7fa4so714534a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684343801; x=1686935801;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XM2+Z5alXxXIaNFRegKP34Ryf3gK2wiUytFRwIQ0uks=;
 b=UXs1n0aQITKFTXid5w3+3yVqCwUKS/+ENY4tzuvOfi+waRzJQa/jGyXwA7HdhNEeHh
 2wr/f62vkFFX1kZkyG2JKGpZR8YP/6tzyAqsipLj1AGHZs6IoNwZ9wyK4+YTZAw4RMPZ
 gdlAHqlgNI8/ez7DsWcCTLA8dA6j6teBdOUBgC+3wFvpt4kW78zESUebSaRuG/6j9bJH
 PyHbGD5I+hmaLfTfEDra/0WEWyk5AhmeqNtom4A8byC+4LT1FuRMLOAQHheVxSJCkVYf
 hSH+yLTnSm3djIF+mtW96KOrjtvSUfxHDBvplynnRvpg3jgE0S8MFga6KtLvcbRz+dGk
 M51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684343801; x=1686935801;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XM2+Z5alXxXIaNFRegKP34Ryf3gK2wiUytFRwIQ0uks=;
 b=kYNOwoW9+qyTe0WHbHXVkWzS1ds0MzvsW/z3uYRPUz3sU1XEoynTmIluw/SMWYB8XF
 0tYpy+xdi92JOhTv0vQ4W4OVImki2G94UDBqWRqHhRaQetgCldzupeh8cAFcTRabhVzU
 qtMe9veKIESiONJdC/NxEwcl0cFFosjK+hTSNfsMsHhZ80EuibBvYEQfje7sxrE+/Xg0
 Hf7doDhzWpbBo0QUYXxThN5CynvedCc8DMLDAQmEF89FPJ0fYWJ+LNJmwHlBoP9y5e4H
 VVYrc/NrXKYvGrSMqW2fU2klEw4aXdvC0oEJYE9bbHOi0VwpEB5ZybtZMhGlMpIZFjjG
 iXRw==
X-Gm-Message-State: AC+VfDzJrxzZ6GP5iUBJ/7BlKsxpxgSlpEdREtRDTtqjnByJ74KE+yLL
 UOG5hczE19XeYfY7m6ZuFzKeRg==
X-Google-Smtp-Source: ACHHUZ5R6fYzngY+a/uQJTPPtqlKJGJPnJ2w755y/5ZnzFQM/HiJXcgE3Hr9x55QMkSKWRPZb9+mPA==
X-Received: by 2002:a05:6a20:6a0c:b0:106:70af:a5ca with SMTP id
 p12-20020a056a206a0c00b0010670afa5camr12676670pzk.38.1684343800969; 
 Wed, 17 May 2023 10:16:40 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7?
 ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 3-20020a630a03000000b0051b930b2b49sm15634576pgk.72.2023.05.17.10.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 10:16:40 -0700 (PDT)
Message-ID: <4d3356c0-2e9e-bc3c-5200-88a3b5edd3e4@linaro.org>
Date: Wed, 17 May 2023 10:16:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 0/5] QAPI patches patches for 2023-05-17
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20230517152516.1884640-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230517152516.1884640-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.412,
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

On 5/17/23 08:25, Markus Armbruster wrote:
> The following changes since commit f9d58e0ca53b3f470b84725a7b5e47fcf446a2ea:
> 
>    Merge tag 'pull-9p-20230516' of https://github.com/cschoenebeck/qemu into staging (2023-05-16 10:21:44 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2023-05-17
> 
> for you to fetch changes up to 28d2a4f620db2bc327dbd3443b777890d39a0bf6:
> 
>    qapi/parser: Drop two bad type hints for now (2023-05-17 15:49:22 +0200)
> 
> ----------------------------------------------------------------
> QAPI patches patches for 2023-05-17

Multiple failures:

https://gitlab.com/qemu-project/qemu/-/jobs/4303506112#L4674

▶  2/61 /x86_64/migration/multifd/tcp/tls/x509/default-host - 
ERROR:../tests/qtest/migration-helpers.c:180:check_migration_status: assertion failed 
(current_status != "failed"): ("failed" != "failed") FAIL


https://gitlab.com/qemu-project/qemu/-/jobs/4303506102#L3766
https://gitlab.com/qemu-project/qemu/-/jobs/4303506050#L5856
https://gitlab.com/qemu-project/qemu/-/jobs/4303506047#L3654

/home/gitlab-runner/builds/Jpwtyaz7/0/qemu-project/qemu/docs/interop/qmp-spec.rst:71:Error 
in "code-block" directive:
1 argument(s) required, 0 supplied.
.. code-block::
   { "QMP": { "version": json-object, "capabilities": json-array } }


r~

