Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E2471F257
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 20:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nKv-0000tC-Ua; Thu, 01 Jun 2023 14:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4nKu-0000sF-42
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 14:47:48 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4nKs-0005lt-Hc
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 14:47:47 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-256531ad335so901195a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685645265; x=1688237265;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DJ/bRm7ihLLng19cWGK3MQwR5rUFmuWOEgcl1k6Ad24=;
 b=E+xLV3AbP4dvuXowNeizC29lFuYQJ86bdOQ3SnxewLuak/LfV4Kb7uV31/CRczlY30
 v5xGQC6pQBxWwD9xnMiW+4Z0muTUrDerk7nqT7bXoicGjs5wFilehvIdZzV1BIKSrNRO
 YwZJ9ncJuBEOwmN0wB0zUy4xQnFM+sb+KOGypyFm3XLx4igmTX65HNXd0Nom/jsgfNB/
 AG6JYBn+Btu4+WKpjLgNcvXNqeezTM+oGoZzk1o4maTCSURlGXrASJfXy4Jx1uMMjv1Z
 tq4JXOS4wc+f6o5E6tQZ0JBiBqGHQbWGdll+g6jx7yFZsB0KJhqFHTL5I4S9ELFjKeck
 vS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685645265; x=1688237265;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DJ/bRm7ihLLng19cWGK3MQwR5rUFmuWOEgcl1k6Ad24=;
 b=GBx+lBzCH9B5mQjNAStzi1AKsRydmPwS7/5v1Cr3G/HvEcJN4HtFDIwSdzNrItBxwk
 NxYTPWhx2B+aQjlH25Og/dNdanRy5sUvQjYxZvsSTPSLxYraQ4Kp0I9MwMLyr8ib8VKH
 V+Nzq/GcOLIMJ7z0WsecJ8onG4CVtaveVzIrXwZgJZ7qwHIS2wn/l4nwJleBLmSBl/Pp
 j7mp/P0cOgbgAYBiUtBa326uFl7RArISjy+rR9Ht7R1Tkb9+ZP8aUL5kCzjQcPeKpqx0
 kddWaLb0TqUKSZpMqLNA6pI2edyO2oe28fTukwtO2v/osrXX3gFD6v2Fdg849SNFaxkZ
 vGog==
X-Gm-Message-State: AC+VfDx7p/IDD4QeqagS5PHODZ19W359Pnj0E3cqc4VgPt7g59xB9dB+
 4O7hF6PgEVNaTaaBsxJnnc1QiHrw8gifarfMk6U=
X-Google-Smtp-Source: ACHHUZ62zsMCaKhC4sl1Qc0+cU/JJiTuHF1Gr4dSdOiKv+n6x9AelLaN+6gcjnDtnUe42tuRRAlwyQ==
X-Received: by 2002:a17:90a:fc94:b0:256:845f:333a with SMTP id
 ci20-20020a17090afc9400b00256845f333amr239147pjb.19.1685645265250; 
 Thu, 01 Jun 2023 11:47:45 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c935:f07f:4b59:7091?
 ([2602:ae:1598:4c01:c935:f07f:4b59:7091])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a17090b018300b002535a337d45sm1712107pjs.3.2023.06.01.11.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 11:47:44 -0700 (PDT)
Message-ID: <4afee714-2d42-7ce5-e27f-5f5826253dd1@linaro.org>
Date: Thu, 1 Jun 2023 11:47:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v2 00/11] Tracing patches
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20230601150649.1591095-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230601150649.1591095-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 6/1/23 08:06, Stefan Hajnoczi wrote:
> The following changes since commit c6a5fc2ac76c5ab709896ee1b0edd33685a67ed1:
> 
>    decodetree: Add --output-null for meson testing (2023-05-31 19:56:42 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git  tags/tracing-pull-request
> 
> for you to fetch changes up to 367189efae8b53ec2ade37a1c079fd8f69244b9e:
> 
>    accel/tcg: include cs_base in our hash calculations (2023-06-01 11:05:05 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> This pull request contains Alex Bennée's vcpu trace events removal patches.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


