Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 172387EC92B
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:03:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3JI0-0000im-TN; Wed, 15 Nov 2023 12:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r3JHy-0000c9-DM
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:02:54 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r3JHh-0003qm-N4
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:02:54 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc7077d34aso54459845ad.2
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 09:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700067756; x=1700672556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1hH2+YKt9zYIhiiH3XyznCkvTgrqRLwn6i0BkrFs5hE=;
 b=fzUq5Iz3oZKQS/qhSmI5Fa77PYXRvkhDkN0VYIgpWeFG5/dPDKtdZhFI6A2nM/CfyQ
 AvuFwoNY2Zc04Rk2CA3FBiml5kiXzwqoXJ+Jp8yclDla0PagrGfYzdSnyWWnj0F1qxZF
 WSLQNW45DY3NwiffBueB798lADBdA7QD2JnE2AnWTDqrHZ4F3JFL3I4uPYVbA+3SgFOd
 UxzIQN92b70XM8YpKCS4Xx5NxMxXMeUXeKElmB0+L75tBZFtULP2V0oKqlFHnSFBD1E1
 EoAwPAecyBYY/VYrrG4HWpCHr2mWJgS4b/Du/yZvQlVfIePwekhIsO7Y/Wxd3ZPbAfWJ
 S6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700067756; x=1700672556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1hH2+YKt9zYIhiiH3XyznCkvTgrqRLwn6i0BkrFs5hE=;
 b=Go3ZAEBxEkQpgp4/SYI26/b1BAwWke7ozTtuC2sjYWqaZqOPZh6g3dTeJknZRtoWK5
 qF+Qo5VHx4panwODBR8Iy5TVec1qLjczs3Uht+lZQi+hN+ODcbymn6JTp0ZbKVM6sd8D
 e54CDGHSKjeBXUakQFzVQbwSI+zu+xo44eEQXi33wPVknX39Gi9w8fs8JYk1ebKxRIcR
 Vl4oTpWolGoeUYZwnX+ZGp2bahx8qmg0oaGgwwKqnp5YGBVJZbF/pGVCCPEzBpOiZUPq
 aqw7rGQrbUJYF/10CY16tMzqZPXAzw5G8BmM+GWYQ1QZI7l2sdAZQ1HHWp3OFCaqxYLa
 Wzww==
X-Gm-Message-State: AOJu0YzwbdDzvoXrkeidKLLgCEqf3XdYSw/h4HZRNXeKpXgbjOzotiyc
 RRoe3ZUZQvtPj7/Zb19X4TSzsw==
X-Google-Smtp-Source: AGHT+IFy2qe9Ulligr8zPb69b3JQ3WBzhltLc3QkCswtAMUg6BAeOdAECtzwQfdsQ0Xc1KsvW7mcmg==
X-Received: by 2002:a17:902:c40f:b0:1cc:436d:39dd with SMTP id
 k15-20020a170902c40f00b001cc436d39ddmr7857445plk.65.1700067755839; 
 Wed, 15 Nov 2023 09:02:35 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a170902eb0400b001c63429fa89sm7593074plb.247.2023.11.15.09.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 09:02:35 -0800 (PST)
Message-ID: <aa6bce64-430c-4876-9025-f29e06399d4d@linaro.org>
Date: Wed, 15 Nov 2023 09:02:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] softmmu/memory: use memcpy for multi-byte accesses
To: Patrick Venture <venture@google.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, qemu-devel@nongnu.org, Chris Rauer <crauer@google.com>,
 Peter Foley <pefoley@google.com>
References: <20231114205507.3792947-1-venture@google.com>
 <CAFEAcA_cKSM-N0nkjtg4UYKwQwBRxffifteU3P=BBxxhEyePsw@mail.gmail.com>
 <CAO=notzk2Dv3LOh+w1XZ1H6vTdq4sp_KvOat4Dj1vbDBhJKzvA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAO=notzk2Dv3LOh+w1XZ1H6vTdq4sp_KvOat4Dj1vbDBhJKzvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 11/15/23 08:58, Patrick Venture wrote:
> 
> 
> On Wed, Nov 15, 2023 at 2:35 AM Peter Maydell <peter.maydell@linaro.org 
> <mailto:peter.maydell@linaro.org>> wrote:
> 
>     On Tue, 14 Nov 2023 at 20:55, Patrick Venture <venture@google.com
>     <mailto:venture@google.com>> wrote:
>      > Avoids unaligned pointer issues.
>      >
> 
>     It would be nice to be more specific in the commit message here, by
>     describing what kind of guest behaviour or machine config runs into this
>     problem, and whether this happens in a situation users are likely to
>     run into. If the latter, we should consider tagging the commit
>     with "Cc: qemu-stable@nongnu.org <mailto:qemu-stable@nongnu.org>" to have it
>     backported to the
>     stable release branches.
> 
> 
> Thanks! I'll update the commit message with v2.  We were seeing this in our 
> infrastructure with unaligned accesses using the pointer dereference as there are no 
> guarantees on alignment of the incoming values.

Which host cpu, for reference?  There aren't many that generate unaligned traps these days...


r~


