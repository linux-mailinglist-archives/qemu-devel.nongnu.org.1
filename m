Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82988776BB0
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 00:05:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTrID-0007V3-MU; Wed, 09 Aug 2023 18:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTrI8-0007Ul-EH
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 18:04:32 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTrI5-0008Rz-LG
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 18:04:31 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68783b2e40bso200643b3a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 15:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691618668; x=1692223468;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FJDberCdVl5PjRa/JnExc4W9YFuE33Zx/fA0UykSCN8=;
 b=vH4zChKNtQrlAs0BX60NAww1emnXV1xmhzgUUAFw1+bwwPBdnBrf7EyoCiP5aVSSTL
 j2OmP0lfylVOZFsFps0OeVtFWn81E2D1xF58dd309aLRtHLf94LfCzxZ6OJuLJdj+S0k
 4h8pioBuNcaaXmdynpONKQtkh1nT4VcpIlekLjR6ISL6kzYuphs82esc30QNixtDOaDa
 HLNMrGIsx1joso3jfabthwn1m/adqtAe7Uxwp9lrkmKN4rEaXiqjvaq03t0AZzcXsfkT
 iQqIac4vCWBGPTfekMp29pybl8B74jt9XobvcoIdlrSC4eq8vDtkp1+iCjy8yx+KlAEV
 vTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691618668; x=1692223468;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FJDberCdVl5PjRa/JnExc4W9YFuE33Zx/fA0UykSCN8=;
 b=STrdA1QmiL4IvTnYD35firLOirU3muKqs3FjBMgFu/xcQJts18Mys+1mm1cWpB6FcX
 T1GqStWXfr5W6lV2UyHCb2TtO2xl0lCWpAC0Xmi7mkVpqicpj5czv2DuSdY4JCDJGFlY
 p3REG+HCnigMrHY9EzVycXwMt/XZc1IW2d2d9UQTDUaWv7kVrKWH+188hK07M0sOkvG2
 u9gBcpgo1xb3wLZxnwtJ4gQm+2u+6AtBnBRw77qZ3RUzfWYeHKedVDwWCttNWuES8/V8
 urtFOwgWBx+H3LSuWtG2KhNGOyA55bDU7+GGIGd3fMEWEVmOoFA+XLzm5RTnfyqmrtQM
 2RXw==
X-Gm-Message-State: AOJu0YyT6DnMLj5HMSGJ/gQn8r/VMlnzuJU/vL53woUTGdncsZh2bfL4
 G8rDZbSA1lUsnUipZ/pXBTR2leOf8pXoVBYCzKY=
X-Google-Smtp-Source: AGHT+IHWlmJos5cMJb9GV3RK72IDpQMsJnxPYXFXYhn7Vc/X1WgvLQGaZmoVaqc3zrtzV6Vm0GtVxQ==
X-Received: by 2002:a17:903:1206:b0:1b3:cf98:a20b with SMTP id
 l6-20020a170903120600b001b3cf98a20bmr476688plh.54.1691618668243; 
 Wed, 09 Aug 2023 15:04:28 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a17090311ce00b001b51b3e84cesm19835plh.166.2023.08.09.15.04.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 15:04:27 -0700 (PDT)
Message-ID: <7e43dc9a-f57f-fdfd-fb0e-8941908a46c5@linaro.org>
Date: Wed, 9 Aug 2023 15:04:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/6] linux-user late fixes
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230809175006.242479-1-richard.henderson@linaro.org>
In-Reply-To: <20230809175006.242479-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 8/9/23 10:50, Richard Henderson wrote:
> The following changes since commit 32e07fddc6d989dc5fdff4f9c9e47cb1f3911904:
> 
>    Merge tag 'pull-lu-20230808' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-08-08 14:10:07 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-lu-20230809
> 
> for you to fetch changes up to b8002058c45a50d893c51cf62ec96c70128fc1eb:
> 
>    linux-user: Fix openat() emulation to correctly detect accesses to /proc (2023-08-09 09:31:30 -0700)
> 
> ----------------------------------------------------------------
> linux-user: Fixes for mmap syscall emulation
> linux-user: Correctly detect access to /proc in openat
> util/interval-tree: Check root for null in interval_tree_iter_first
> tests/tcg: Disable filename test for info proc mappings

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


