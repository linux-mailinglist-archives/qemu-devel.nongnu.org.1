Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EA3787883
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 21:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZG1L-0003DB-6H; Thu, 24 Aug 2023 15:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZG1J-0003Cz-J8
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 15:29:29 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZG1G-0000kM-7M
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 15:29:29 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-564cd28d48dso84542a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692905364; x=1693510164;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QSQNqkPQ0Ll/EORjCuc1EKc0DvG0hcHjUxIqxfYhhXc=;
 b=Su67MB1teXsFsLn+t/9+h6d34sxYvfWUNzNl/zHWlQVbJ1ZpLXXEXIKedIelPTW03+
 gqwjC/e8lOukTMB0/QKZTGD5l9JSddxH9xUxvzX4bNrTRhqJQWwv5cb6UsYgelYvIkaM
 tWFCLS5HEV/Br57/dsWIEhsFu35H6gWPfMxZpDzQRM9aVnt5a0XT1kzimdYrf1M56rkp
 Uvv2wol2PqXUlGlBJLsvljV6bJ7GcX7meCC//r8Do8pbPw7HFnQkYyJyM+nahnNyiMOV
 kwR54zpk49DRvK2miWbv1mtRL12nH6sRGarad0lQcpCvqMlD+seq2PJPP3M/HaYK0KcJ
 w2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905364; x=1693510164;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QSQNqkPQ0Ll/EORjCuc1EKc0DvG0hcHjUxIqxfYhhXc=;
 b=Zl9J/AzcI4SGxmUyzqB7aOifG0T8lpgcq2c6yT/GHdC5/wbow2hCu89B8vl7gserAi
 MS0+NPMFrBOAvo6NWb12rAU9VM8n4NVQ3Wmjn1ix4H/0YkChwrMtF2j7so5GlTG0TJoM
 UMZJjyelj2gOwQ6qLloJFdGiyLSaf+aawPZXibz8S0XnwA+NMNkbOzWoF6oW1OnaAzCV
 msGsxbki87l+mfWr1IgiH49xxPT80loxcLGbJfPeSdV++UofTecBflrlZrxeB/bHtDvw
 Bam5Dodal0jtvqaJi9OLl5lN7Dujth751LhwE6B2CWnW72b4Dicvs0el9UmjIt0A2JOh
 BwVQ==
X-Gm-Message-State: AOJu0YzCKijkRB0vPnvz6GM5qP/sxrYhJbW0qaOgI2n7GfyumwPY6s/g
 e2OwrcQgGGNy4yM4XXmmL3gj3A==
X-Google-Smtp-Source: AGHT+IGioe8FszwIe1lT8a4n2tYS/plAXDOZ3tWImZ7h6MjMcnX8WWpflpu4qCtAwQai+WIl3o3D+w==
X-Received: by 2002:a17:90a:43e2:b0:268:81c6:a01f with SMTP id
 r89-20020a17090a43e200b0026881c6a01fmr12958678pjg.26.1692905364608; 
 Thu, 24 Aug 2023 12:29:24 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:5418:3064:bd46:c048?
 ([2602:47:d483:7301:5418:3064:bd46:c048])
 by smtp.gmail.com with ESMTPSA id
 23-20020a17090a01d700b0026fb228fafasm2094660pjd.18.2023.08.24.12.29.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 12:29:24 -0700 (PDT)
Message-ID: <7768361e-cab8-9dde-8bf3-103687cc30bf@linaro.org>
Date: Thu, 24 Aug 2023 12:29:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 12/12] gdbstub: move comment for
 gdb_register_coprocessor
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
 <20230824163910.1737079-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230824163910.1737079-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 8/24/23 09:39, Alex Bennée wrote:
> Use proper kdoc style comments for this API function.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   include/exec/gdbstub.h | 10 ++++++++++
>   gdbstub/gdbstub.c      |  6 ------
>   2 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

