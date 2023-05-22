Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C05770CE5A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 00:54:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1EOM-0003Q4-Uo; Mon, 22 May 2023 18:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1EOL-0003Pi-6m
 for qemu-devel@nongnu.org; Mon, 22 May 2023 18:52:37 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1EOI-0007Oy-84
 for qemu-devel@nongnu.org; Mon, 22 May 2023 18:52:36 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-51f6461af24so4503476a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684795953; x=1687387953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TZQx8xI8jUehHniFLcxL2MENl+SfW+K8YrSWgJmBSEg=;
 b=TdJfKI4IhJxCosdf5xnMGOk07s5t4nlqhwiGxQYZtSbA2VjILwQ13z91zZJQWN5GDC
 tsx2PJefOKZYbxdFBdb1AAZRq8UQshlyM+SJ5LQFGx5dFR2CRGYYBQgk2JUJshdnAkOE
 HAk7zV4SVBAIR21m/Z+RzGHyd8I0L6zgVxnYlYSLlzTkxNHseNtyRNAzfCV4ornJMiTK
 ljos4F+esySqJf4JRYZqwkl+kbXg9TbrvytDJB6Qw88zIPol+4A6N99HtZcaxTse1KqF
 R+a9Aduc0UIXEHIuoOOdxKSYMZpXqeLHBcMrWt0HvJ+Urlg67McpONH0R7FDZRXbSuH/
 ZWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684795953; x=1687387953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TZQx8xI8jUehHniFLcxL2MENl+SfW+K8YrSWgJmBSEg=;
 b=Ap11dRHNGPFaGh08Nlo6RT3LImxxsfnBrcJxC+08RT6kGKdX9T8K9WINoxWWUpBh7f
 ORbdvyBW5m6QN03CLz0hIWNQZl8vDZePe/BCHbFawDfnQv/UJ4d9NfybfdENBH+SMJOX
 6JX6wOmXJOnTH9AoWaIG+/mUCy7x2iXggYXZEsZXjbAi2pb177ZoZzrE6gH8Ou/agX4j
 4HF6fcujN+QhRq9nXE2am7dKlAYzhcgkrLzl6wAgmbr6c/g462JZ3n/PLP4IrUihhiy7
 BFUEgZkj6TXsJ1Z6f2+v0i9fwu9mDxE8DsN4UmMsZ1MU5stZhFqJwZTvPQRZA2tFe5i3
 jKSQ==
X-Gm-Message-State: AC+VfDyiLd853GxpGrYY4XGi2Qr+HIlYKy8dYA1752L7DDndkNrKfTrZ
 FkMAyOn6gCzbihH1gX6blcGrfg==
X-Google-Smtp-Source: ACHHUZ6q+KaEdkUlR90V6C/hqdcIL6YsEcMJIqwz+hYXAHjBwmUFV2kP16p1L12Qqe4J1YwERK83Sw==
X-Received: by 2002:a17:902:d503:b0:1ac:a661:a4c9 with SMTP id
 b3-20020a170902d50300b001aca661a4c9mr15079077plg.33.1684795952701; 
 Mon, 22 May 2023 15:52:32 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86fe:2b34:5897:c8ef?
 ([2602:ae:1598:4c01:86fe:2b34:5897:c8ef])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a170902db0400b001a65fa33e62sm5327155plx.154.2023.05.22.15.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 15:52:32 -0700 (PDT)
Message-ID: <d08d55dd-f38b-063c-d64e-9a0f79dbebf9@linaro.org>
Date: Mon, 22 May 2023 15:52:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Add CI configuration for Kubernetes
Content-Language: en-US
To: Camilla Conte <cconte@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com
References: <20230522174153.46801-1-cconte@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230522174153.46801-1-cconte@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/22/23 10:41, Camilla Conte wrote:
> Here's a second version (v2) of patches to support the Kubernetes runner for Gitlab CI.
> You can find the v1 thread here: https://lore.kernel.org/qemu-devel/20230407145252.32955-1-cconte@redhat.com/.


This does not work:

https://gitlab.com/qemu-project/qemu/-/pipelines/875254290

In particular, most jobs spent 30 minutes (until I cancelled them), e.g.

https://gitlab.com/qemu-project/qemu/-/jobs/4329346855#L7561

Client:
  Debug Mode: false
Server:
ERROR: Cannot connect to the Docker daemon at unix:///var/run/docker.sock.
Is the docker daemon running?


r~


