Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BF8774D14
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:31:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTUHq-0001j0-9h; Tue, 08 Aug 2023 17:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUHo-0001cd-7J
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:30:40 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUHm-0001fH-Lw
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:30:39 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bc8b15c3c3so7262085ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691530237; x=1692135037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NYUlEzmMtdYdFD2PYJ/AEEGs4blk+bXeQtOLn1OYMbM=;
 b=z7t7OTAbmtB8r2Bh9py3Q6I1aoFW/ZPcpledgQv0LSoAyVwupKBQ4nFMIwpWZC56kG
 q3J/hcqOeIVcje6j+jovd/oEuP/jLdaxdACpCVe6Qc3cTXqAl88DA+eTaLHEwf76sfQd
 dG88Fntsg3jwqI0Y+BEwPKR0Ur/u0B0pLPxQ6SrHn3jj0iJ0rKW6utx0HScG+dScP/U1
 MGFC+q1tt8nCyJC8Q8esbAyLx5CDhgapANQXRDQBfPO9HpaiWeqeuQyDhfpnmqoRXJU2
 f4q0rCCATGX7kGe8eMDHrxYEcTrdVKVSAHIP7lBRK3Cjqrt5r6VragrbAAkO0aTfSs+B
 a5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691530237; x=1692135037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NYUlEzmMtdYdFD2PYJ/AEEGs4blk+bXeQtOLn1OYMbM=;
 b=QxY1at9RszklUnh6IEdP6dTunikbRsW3yU7wb5TKo1xXYsm0Z/D94qhU0cuJDpn1g9
 35HJ2OoxgjtaGUkSxAzu6s0I3voXfIUGrN8DH4Z0YrHXGudV5UaQJ8y7IIcO3NWc7eXr
 S0CnuwWGZLwyJkdy4KCOiFT809JVUi4FTw64cMM87kfn/JOKiIFPU7xJq019oaUtemHD
 5r6dn4NWE6OZsuIe5s2Eqax7oAnOL8kzG6IjZxrcNMTAupWQ75U7fr0U92VoUXB54OBS
 otroDjvRx6+g5LCgAwMfxVhLKNnfzGUpAPXtHSKAx64Bs5d+bttCOdQ+3VXtzFn38r/Z
 6GWQ==
X-Gm-Message-State: AOJu0YwEGmfK1zj1OC2i9KeMjVedJTBX27P3ZpMoYmQQtm8ArgR3W3Mx
 GrQWPVP+R3WqKBTmRcfNHuOg403K/rPs1tsiMR0=
X-Google-Smtp-Source: AGHT+IGSkT8uJotVJbheeT5nNSm9D9wBpaxHs/uxMf4dw+MP2jKQcQ4LCfungCdvwrbAIBAsZ4dOBQ==
X-Received: by 2002:a17:90b:3e8d:b0:268:df3d:bfa1 with SMTP id
 rj13-20020a17090b3e8d00b00268df3dbfa1mr717868pjb.20.1691530237299; 
 Tue, 08 Aug 2023 14:30:37 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a17090ad38f00b00268188ea4b9sm2791pju.19.2023.08.08.14.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:30:36 -0700 (PDT)
Message-ID: <c17fc2da-e134-1e71-0e6f-657898c10282@linaro.org>
Date: Tue, 8 Aug 2023 14:30:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/33] Implement host-target convertion functions
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-14-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-14-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 23:07, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Implement the stat converstion functions:
> h2t_freebsd11_stat
> h2t_freebsd_nstat
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-stat.c | 94 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 94 insertions(+)
>   create mode 100644 bsd-user/freebsd/os-stat.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

