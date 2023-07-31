Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06922769FEE
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 20:02:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQXC6-0007px-9k; Mon, 31 Jul 2023 14:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQXBh-0007fs-N5
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 14:00:09 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQXBf-0001to-Cl
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 14:00:09 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bbc64f9a91so40562655ad.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 11:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690826405; x=1691431205;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z9S2VUWykVDvSTXh1yH09zpefDu27r+l0OD3wgxCE8s=;
 b=UWe1OpXynMnQbniMhkQXHhu1W9j12t29H/jX0w1VvFFfGSLYuor9zET56Q7ra05JVD
 XDFmiVOi8vx3DUGKnT3l/Rp/eIj9fEdzrhVtiJKJ3Acllpb7+s9ug7kWIUxW4Z8/dcIx
 U8o3Wa333zXZQODyAjQ9a9EHRykHSixjcPxQjpAStvy1WW1M9MFV8ZMzRHsJIV/ND5t4
 nbZS0UaYzbXAbn56EloqZPIDSiIdY140zao8Upy4LqgPNGjSljd7Q/fiIlHgBXgG0KOw
 WgYNBxH5fvLGqF74CYdlADozzTwD1X0810BJ0YPRY9i1tEYnQPvoZoUl/3hfXw8HtUJc
 d4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690826405; x=1691431205;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z9S2VUWykVDvSTXh1yH09zpefDu27r+l0OD3wgxCE8s=;
 b=JZexGYux5cGxSIqCXkEitERq0MxRkixyOlTi7zcsFrI6c6W09FP4/KNmP2fxKPy71v
 DlvE4I4ppSC0gDV9aD4YKmZe2A9s6lyxarWXLOLbxHGW0BsK8rSN73SO1f/Uo/aRMnuS
 kFilQCKUESXg3mIXjbNcTZF9C6WJ0ArwboOAva30fwB4m+6DJQZCrNrvuQKWme5kwacu
 kETA7GBG1F2RJNBGQt84y1TegK9qTyRPuVE1cGeGr8KCYRaSJ04y9qabx+f/r33eFbLK
 k6sENDa0cmP77J+6gcYGULVFJTd7p5KwA06MVJVyWm02FWhX9aftelL2PQSiSv56jg7p
 PDgg==
X-Gm-Message-State: ABy/qLa8F5IiSM+6LLNT/1uhaeBCiolhsYNX/yrQ5sKpko8MJ3m1cAr1
 VoGizfKKRg2nY9H8Uksz1nyr8g==
X-Google-Smtp-Source: APBJJlG54HCF9DlpYqDdW36DMkhd/tiUwHtrxWs2gUExut/isng8HLNEIdITiphUeFfmQkzj4An84w==
X-Received: by 2002:a17:902:e807:b0:1b9:e091:8037 with SMTP id
 u7-20020a170902e80700b001b9e0918037mr13061367plg.30.1690826405585; 
 Mon, 31 Jul 2023 11:00:05 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:4f6f:6b:2de4:e0cb?
 ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a170902ceca00b001b89045ff03sm8852471plg.233.2023.07.31.11.00.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 11:00:05 -0700 (PDT)
Message-ID: <1a59ed94-b942-cf51-6f0e-e0b9d4bb9bcf@linaro.org>
Date: Mon, 31 Jul 2023 11:00:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/6] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230731141533.3303894-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230731141533.3303894-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/31/23 07:15, Peter Maydell wrote:
> Hi; here's a target-arm pull for rc2. Four arm-related fixes,
> and a couple of bug fixes for other areas of the codebase
> that seemed like they'd fallen through the cracks.
> 
> thanks
> -- PMM
> 
> The following changes since commit ccb86f079a9e4d94918086a9df18c1844347aff8:
> 
>    Merge tag 'pull-nbd-2023-07-28' ofhttps://repo.or.cz/qemu/ericb  into staging (2023-07-28 09:56:57 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git  tags/pull-target-arm-20230731
> 
> for you to fetch changes up to 108e8180c6b0c315711aa54e914030a313505c17:
> 
>    gdbstub: Fix client Ctrl-C handling (2023-07-31 14:57:32 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Don't build AArch64 decodetree files for qemu-system-arm
>   * Fix TCG assert in v8.1M CSEL etc
>   * Fix MemOp for STGP
>   * gdbstub: Fix client Ctrl-C handling
>   * kvm: Fix crash due to access uninitialized kvm_state
>   * elf2dmp: Don't abandon when Prcb is set to 0

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


