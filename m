Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 807BC706D9D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:05:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJe7-0006sM-KY; Wed, 17 May 2023 12:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzJe4-0006qQ-Vr
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:04:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzJe3-0000LK-8f
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:04:56 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64390dc0a7fso133086b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684339491; x=1686931491;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CHwAN4ESZ3VxZO0fmXmqay6HYmHu4L/knpMqtQTMyE4=;
 b=MybG2I43L2eSr36UH2z+Wn8oJObv1IVjWyoQHDpeodrxs/yYRwq2/mfuJUrS86bqXI
 cJaECfxudbym76XXwBYz134thwa4cYBEiMAsMdK6cqnwfTlYDRdbcK2rw7zXWP6K7Uc6
 d2J8rMesCr3LmLfLd4W3oUc5ffG6UmR1ZvJ1WFGHGLcgs7KkneE67yYv8E8D4BufOEfj
 ufYID7J1JRQ/C8rS/J2lrv99vi1xgpU98kBc53xgfFg1ZcWbgkpQRTHI0zNf3NHUOJHx
 Z7OOawF0MNSWwhFionF+Vun2rHqCSgNi9jCIsnc3cTvJGKRnpQk8ocPxPqnKcvw+H/9M
 VlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684339491; x=1686931491;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CHwAN4ESZ3VxZO0fmXmqay6HYmHu4L/knpMqtQTMyE4=;
 b=a+4RR3E3VG9kUb7OIV6oaIH2pwmliguNSdmDSONaNHhI9OgNGvcAzX4QSyqXP+zhlp
 muHzp5Y/yh+bvRO4DY3pbGizkvI1Vn/bclfGLudzqD2x3PAlMRb7PFjN5TK7aXKWNi0h
 VQ9ATS/1KrCcAARJnrYsDX2uYiBX9QPIbfgsSSh01oLu51aeQgfn2qvDI8aXzcovWckY
 H4kfjD9lMP//bh+jQJeRiGsk9Guza9NSONm5UFcjESTbQz1fptDvVvUqF/zOCcXxXvF4
 dj5jvCdhvBLtpAYqcaAYxC0E0y33fHgOPoJNCnmFMBIe4ICxNyPPLr7Mk8eZuHEp445u
 dTdw==
X-Gm-Message-State: AC+VfDyF+n4RKvsLYk+2BNsVEXZzsbp3C9NwzPdHHLdZDgT792r70JOE
 KDeywOKlPDgXdIhuToj09WmjFh0CbWT4XdhWTzw=
X-Google-Smtp-Source: ACHHUZ4XN8wy8NGywwktxqftXZxUzf+nr3QZ3VK+yslFsKe0+kGKus5++vrDZXc5FmU5cb5G/P+WvA==
X-Received: by 2002:aa7:88ce:0:b0:635:7fb2:2ab4 with SMTP id
 k14-20020aa788ce000000b006357fb22ab4mr37237pff.6.1684339490892; 
 Wed, 17 May 2023 09:04:50 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7?
 ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 u12-20020aa7848c000000b0063f00898245sm15947506pfn.146.2023.05.17.09.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 09:04:50 -0700 (PDT)
Message-ID: <6b54c5dd-bdae-ac9c-c1bf-fa1ef8676b7d@linaro.org>
Date: Wed, 17 May 2023 09:04:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 0/9] Linux user for 8.1 patches
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20230517080152.108660-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230517080152.108660-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.412,
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

On 5/17/23 01:01, Laurent Vivier wrote:
> The following changes since commit 7c18f2d663521f1b31b821a13358ce38075eaf7d:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2023-04-29 23:07:17 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/vivier/qemu.git  tags/linux-user-for-8.1-pull-request
> 
> for you to fetch changes up to 1e35d327890bdd117a67f79c52e637fb12bb1bf4:
> 
>    linux-user: fix getgroups/setgroups allocations (2023-05-17 07:20:29 +0200)
> 
> ----------------------------------------------------------------
> linux-user pull request 20230512-v4
> 
> add open_tree(), move_mount()
> add /proc/cpuinfo for riscv
> fixes and cleanup

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


