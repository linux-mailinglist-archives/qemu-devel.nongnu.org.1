Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 620DB70F2A5
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:24:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kiq-0002pj-HL; Wed, 24 May 2023 05:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kio-0002pH-IF
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:23:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kim-00043b-V2
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:23:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-306dbad5182so369036f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684920231; x=1687512231;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zUuevSaUgd4wLJgCuealWaLOltRNi5FBp5bmVhtagEM=;
 b=F5GhfGOcoxeRqoqd7SGF0kA+s9R2WFXy5r7Xkxrg1w6Qqe1NZ4kjjWZ/egBo4g7xlp
 0jLcuvsJ+J+DV+LNQNGrR/sgU3V50PDFzKGGlvQcAkZo//GBw8M4k8mAwYeM+Hw+WXyS
 Yx9fNyN7P0p/1qhulPcsUOVbBe+eYnrAX3neiW7oO5Nq2uTrHdXPyKUD376jvM+IcT6d
 nLdXmJLv8E4U16gPn20ti7UyGQwO/gPeocL0VmoSJg55C8U320tFeCautEil320y0nC0
 dKJq5CWtJGqT4ouKFbDkTxR5tTq6dgVoLHr0kYqF9XZAsWWS5vgAS48mdxb/J1gPOsDr
 N68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684920231; x=1687512231;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zUuevSaUgd4wLJgCuealWaLOltRNi5FBp5bmVhtagEM=;
 b=UVJACi3YXK0Ujh4DdlD7+uhPr22Zv//czLp2ovJUSOuhg55uJTtHFINXJ55GXaV+7U
 ZYdIHJy9xQG2RcQohSfgrPxZcDfYnLuzdyCWRwzOlq4PPbce2ZwDjDF9Up6fw20LzLzK
 c8HrbH0ery6pLWZwDsY15iv6FumM8PH52hW1TTmwroCoNKJNXwBJYCghMhqzxYt/IVpA
 G6EbMR8gWGiD4KRGaJIb9yl8GDt/UoyJgVrrnFHRzyHb0Ovy6unVNYQFAm+b1Y+uhVoZ
 vRAc3PuVZc9N0AUFO9MM/GXNhSp+nMbHHWhRF8hfqqZl1I4QsL4Ya7DGXJV/6I+sTfMy
 2V3Q==
X-Gm-Message-State: AC+VfDwA1GqJedcr+kBmbkS4dz5PqA1PCKkcWz19hBqzdTwDpSyVMiP1
 kN50IJg7Sf/vbeUnZzqD87sgrw==
X-Google-Smtp-Source: ACHHUZ6Do1mQcoMHKwfyQYXtMTCSMox15pXWyuyGTO5qghblgcKLGO8VP8uCTzdFIMwNvq2iAoRP1Q==
X-Received: by 2002:a5d:43cb:0:b0:306:2c39:5d52 with SMTP id
 v11-20020a5d43cb000000b003062c395d52mr12053504wrr.57.1684920231314; 
 Wed, 24 May 2023 02:23:51 -0700 (PDT)
Received: from [192.168.69.115] (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr.
 [176.184.31.246]) by smtp.gmail.com with ESMTPSA id
 n10-20020a5d660a000000b003063a92bbf5sm13774091wru.70.2023.05.24.02.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 02:23:50 -0700 (PDT)
Message-ID: <52c2f4c6-bb87-b2ff-0450-5acc22a7d57c@linaro.org>
Date: Wed, 24 May 2023 11:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 01/10] *-user: remove the guest_user_syscall tracepoints
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Riku Voipio <riku.voipio@iki.fi>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Yanan Wang <wangyanan55@huawei.com>
References: <20230523125000.3674739-1-alex.bennee@linaro.org>
 <20230523125000.3674739-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523125000.3674739-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 23/5/23 14:49, Alex Bennée wrote:
> This is pure duplication now. Both bsd-user and linux-user have
> builtin strace support and we can also track syscalls via the plugins
> system.
> 
> Message-Id: <20230420150009.1675181-2-alex.bennee@linaro.org>
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20230503091756.1453057-2-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20230505155336.137393-2-alex.bennee@linaro.org>
> ---
>   include/user/syscall-trace.h  |  4 ----
>   bsd-user/freebsd/os-syscall.c |  2 --
>   trace-events                  | 19 -------------------
>   3 files changed, 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


