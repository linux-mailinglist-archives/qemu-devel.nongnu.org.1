Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE50D7390FB
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 22:45:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC4gU-0006bG-HE; Wed, 21 Jun 2023 16:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC4gP-0006aa-Rn
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 16:44:05 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC4gM-0005eh-Uz
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 16:44:05 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-986d8332f50so754171166b.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687380241; x=1689972241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bhsq46qNVwSvronmHaPOGiMcowP9uql3k80oUJ61bvI=;
 b=I+q7Er35q/7Nk2O/YkjZ7jqySUpzkwOy5T1VQsHI6v8ZJtA1Hf/rJvJleh+uaJt31Z
 uSAbCQ3+MCWETWhiL6VUZshJ4q8eVkho55lDK40v3uSnc/eyGitbfrWIihuoXbHRKYQQ
 owC788o7B/SbTFzNr6VdlO1QDVlpEfX8ykhhrv+KwrY8kuiVfqCICVwdvKpTnf/fsqta
 cSgQB/dQJ2Fqgq7h6viumGRh//aVdibMDqStlOblzo3Ej3uwNDIRKX4F/lTzYd4uEWYT
 66igJgf37hPrVGuKo0Aq9QCkhH9WJ6WYRtTo8DrGHdxJCFQGRsfvG4+4u4eCOkjjmMru
 hPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687380241; x=1689972241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bhsq46qNVwSvronmHaPOGiMcowP9uql3k80oUJ61bvI=;
 b=JUC9zmvtI+msqWj22KMXwb7u/D4jDyTFwsG5lXvGimXPj1SNPZsSFRzcCHFKbVsqFf
 U/1Tibc7Ggrb1PsRTqCZfNODnsZt+xU0qSnF/UPlNARIM+DFfg4QkxakeDHAFu/4OhwN
 XTs13cm+encAfIlZQThHcpe9d5gq++baOwfH85fVAXw1iQpNPJNrMmY/S7ygGjINzAnr
 2BNUFDyu8JMqZ53cEO78j0aOUT0tt6PPp+0GoA/Tqzd84gz6SeoHTtG2aHz47dFh6olR
 x/3m+vkFrAB32XlXK+n1PPZGNZNpMZudjPE56KzWTT4zf3JdYjW2BnKYB6vxyzFdGM+Y
 wQ7Q==
X-Gm-Message-State: AC+VfDw1Xed9QJThpgT80g2S9thpEQrZOILrYET28fJgVw8RMDdmMixs
 KbEZm5FqI1f06Uq02mrc0EubEz/bIUpJQjb8b0sNdCCP
X-Google-Smtp-Source: ACHHUZ6AGKyL1xwT9Uj2gGrP0v8VI//neI8SBXZXID106dBcNN4fvqOCQPLkCzUBq0gFsaJIP0+LAw==
X-Received: by 2002:a17:907:6d9c:b0:988:9763:9517 with SMTP id
 sb28-20020a1709076d9c00b0098897639517mr8529197ejc.43.1687380241154; 
 Wed, 21 Jun 2023 13:44:01 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a17090640c400b009788dfde0b2sm3713415ejk.12.2023.06.21.13.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 13:44:00 -0700 (PDT)
Message-ID: <03ad8580-f698-af6b-ab42-b51b408ec3c4@linaro.org>
Date: Wed, 21 Jun 2023 22:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/20] tricore queue
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/21/23 18:14, Bastian Koppelmann wrote:
> The following changes since commit c5ffd16ba4c8fd3601742cc9d2b3cff03995dd5d:
> 
>    Revert "cputlb: Restrict SavedIOTLB to system emulation" (2023-06-21 07:19:46 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/bkoppelmann/qemu.git  tags/pull-tricore-20230621-1
> 
> for you to fetch changes up to a9c37abdff65a07d0191123a21d318c4d8cc7f33:
> 
>    target/tricore: Fix ICR.IE offset in RESTORE insn (2023-06-21 18:09:54 +0200)
> 
> ----------------------------------------------------------------
> - Implement privilege levels for TriCore
> - Fix missing REG_PAIR() for insns using two 32 regs
> - Fix erroneously saving PSW.CDC on CALL insns
> - Added some missing v1.6.2 insns

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


