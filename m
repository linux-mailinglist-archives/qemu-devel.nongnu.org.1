Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E2734C1E
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:09:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB90W-0005qu-UW; Mon, 19 Jun 2023 03:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB90U-0005qe-Rg
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:08:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB90S-0005gR-A0
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:08:58 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f9b258f3a2so3884695e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687158534; x=1689750534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ttSWFnSjua/q/ayNYO2TQcjJdlDXxpArt2a4I5UjLQ=;
 b=vhIRN9h7ddkr44bGLi5LoPUAFgZbvoPbGliv7gs+MWpUlLqrUfiCGHlh9OLTZT+92M
 p4azFwNBbUDCEt/fm4KNf/YNuo8McHqg8f00vwUYBo5IQGMhUuX4YiUU9muH6frV01WJ
 7hg2qJemQP0/RdSrEWHkaJzsDA4QF+BhaQKHrqnBjex3m4p0ZHIlUXPRuc3I+BulOzyf
 mIZJy/WZ+rTVTrj08LM/ce/K8LgX7zz8dNbgXhTB/MwCi+Md2ucJLajXcqE2zqfYvSVb
 jpGfanvOh9oXjKAXb2DDftRYaTAmOfZ2NUBX1hiw8jZ6Xz0n3KySmYnMfL3GbkzSyR7R
 xP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687158534; x=1689750534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ttSWFnSjua/q/ayNYO2TQcjJdlDXxpArt2a4I5UjLQ=;
 b=DGbb951xcCfG7vPIjg4QyJR3ZGSktpju6sCj0lZ2nYdOhD0bkn8qpoGTCKZw9JlAz6
 am+OkM1onYLUsP6jA7bC7Jo3+eWyIHv2HpXr++7WOJK+0VJL18gSqKUlDZlMOWxJK876
 04Sqtv70jsPxCVOt1Lcwp1dJfwWrfJxqfrzYquXlyON9yMU+d/hy2/5tWCtvc151JUSI
 2ab0xnVx7s3ul9wiIBy5PnOjUqQQ1mXecI9yedNr6zCUbi5Km6SfYd75aQCwIsNEM+6n
 dXdgnhDk4xmZnEjXktaGA44/1+EG3cYAf0llfod+onTWy2IbdfWksnh/bts96EWd4rj7
 1nJg==
X-Gm-Message-State: AC+VfDziU/tO9vVMZXN7cwuhE4XhqIvyOR9h9uPa7FIb0Eg2wShf12D6
 QNw/qNwut6DxiexvHBxbRnWpmg==
X-Google-Smtp-Source: ACHHUZ6muwDExxanKU3ute8PV529GOZi5I2MeEoXYRw+kD+sx4fIOM2/0kMvWKPyiVqZLX/8A0VdPw==
X-Received: by 2002:a7b:cb56:0:b0:3f7:e48b:974d with SMTP id
 v22-20020a7bcb56000000b003f7e48b974dmr10143286wmj.27.1687158534054; 
 Mon, 19 Jun 2023 00:08:54 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 s3-20020a7bc383000000b003f6132f95e6sm9755587wmj.35.2023.06.19.00.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 00:08:53 -0700 (PDT)
Message-ID: <aec066a2-5588-c6c1-1da0-b7ade155735e@linaro.org>
Date: Mon, 19 Jun 2023 09:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 6/6] net: tap: Use qemu_close_range() to close fds
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>, Jason Wang <jasowang@redhat.com>
References: <20230616152737.23545-1-bmeng@tinylab.org>
 <20230616152737.23545-7-bmeng@tinylab.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230616152737.23545-7-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

On 6/16/23 17:27, Bin Meng wrote:
> From: Zhangjin Wu<falcon@tinylab.org>
> 
> Current codes using a brute-force traversal of all file descriptors
> do not scale on a system where the maximum number of file descriptors
> is set to a very large value (e.g.: in a Docker container of Manjaro
> distribution it is set to 1073741816). QEMU just looks frozen during
> start-up.
> 
> The close-on-exec flag (O_CLOEXEC) was introduced since Linux kernel
> 2.6.23, FreeBSD 8.3, OpenBSD 5.0, Solaris 11. While it's true QEMU
> doesn't need to manually close the fds for child process as the proper
> O_CLOEXEC flag should have been set properly on files with its own
> codes, QEMU uses a huge number of 3rd party libraries and we don't
> trust them to reliably be using O_CLOEXEC on everything they open.
> 
> Modern Linux and BSDs have the close_range() call we can use to do the
> job, and on Linux we have one more way to walk through /proc/self/fd
> to complete the task efficiently, which is what qemu_close_range() does.
> 
> Reported-by: Zhangjin Wu<falcon@tinylab.org>
> Signed-off-by: Zhangjin Wu<falcon@tinylab.org>
> Signed-off-by: Bin Meng<bmeng@tinylab.org>
> 
> ---
> 
> Changes in v2:
> - Change to use qemu_close_range() to close fds for child process efficiently
> - v1 link:https://lore.kernel.org/qemu-devel/20230406112041.798585-1-bmeng@tinylab.org/
> 
>   net/tap.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

