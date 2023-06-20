Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D09737113
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:59:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdke-0004sB-Ig; Tue, 20 Jun 2023 11:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBdkH-0004cf-O4
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:58:17 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBdkG-00060y-AW
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:58:17 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5187aa18410so5212035a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687276695; x=1689868695;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5KQoYQEfwJu/376+DWnLIGfWGq9QwHg19XSNj0syNIs=;
 b=BNrMJwjQylaZRkhSXPReYCeIhqrV0OTDI6S7qDiyIho5aee9HVFK1JvkIdXhVXTkSH
 ne1G2LXE9zVEb5L25kUFU+Juh8MbzpnfcU0rD0JUZU0Vsu5F4N/TU8dZ3BkUHTJzCD6P
 YZ0JO8R23Qc2xpKSf0uMY/SDLP0MdrvzPKI04iKm6hW0UY8JUYNIOSrAAGNcoLml/omP
 gn5nT54VsHF7fZ4dRhdecVZSlRQ0PIVwv/rrpw0D/GXgqcwm2xoT4Zop09OOdRT8bk5r
 BP2tfqTEKDJ2sgkn1NGftfHdWCYGfM7/U0IDRHjTQmc7OD+a3PTZ07MmCuMEcqxYSwQ7
 no5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687276695; x=1689868695;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5KQoYQEfwJu/376+DWnLIGfWGq9QwHg19XSNj0syNIs=;
 b=FZY36Fi5+eXakDwqnrxqfooOTgaDuGiPMEW1Z5Dua15BRiDDelf4q8T0Z7TZ8Qb/Q3
 oUqOvUDLsvZS5rk3GJYi4ww95d1lL/T2o4xC9QAFAVewCVMY3wrZRv8UH3YdKzGOVT42
 BhxMFa99DuVgyZrwB+1Vb/prGaoOBnNZCKO+z+Ecmv/ELqFYLAJei1luZPTFSNuwSwMX
 Ab31FNH0y22uYtTBbWoCV9Wi/Uv7jt2rS4xFrbE4h4BOo95ysDPX+Zhnb+3SXZNDbV4G
 gfn/1Y8yqtaPJLsSYyER1m8EdBxYb6GnkN6nkPc7B7AFsBBt8y+FGV6ylRnY4Hd/YP+8
 aN5Q==
X-Gm-Message-State: AC+VfDyDEQAgSweQN4do+cqEKkM77QxrrSTbJcVkMrKCiBz+zemx/wVX
 m+Br0CZz/44ALFPDg0r+Jh5oxw==
X-Google-Smtp-Source: ACHHUZ5dVm/w5/rB31qtAtTa3yN6aw+8LIsa+SDIOPvE9P4Bt8eJXcp0ZqM4xUOrC/QoCkOkQxi3HA==
X-Received: by 2002:aa7:cf19:0:b0:514:9e3c:d82e with SMTP id
 a25-20020aa7cf19000000b005149e3cd82emr9587450edy.14.1687276694645; 
 Tue, 20 Jun 2023 08:58:14 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 o4-20020aa7d3c4000000b0051632dc69absm1375087edr.86.2023.06.20.08.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 08:58:14 -0700 (PDT)
Message-ID: <1916d7b6-f1f7-5fd3-e3d5-fa7894118280@linaro.org>
Date: Tue, 20 Jun 2023 17:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 07/10] target/i386: sysret and sysexit are privileged
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230620151634.21053-1-pbonzini@redhat.com>
 <20230620151634.21053-8-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620151634.21053-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/20/23 17:16, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

