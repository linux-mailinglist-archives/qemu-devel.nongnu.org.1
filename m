Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B78A766E13
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:24:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPN0s-0007aY-QR; Fri, 28 Jul 2023 08:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPN0q-0007aA-UT
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:56:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPN0o-0000RL-II
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:56:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686b91c2744so1604912b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 05:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690548965; x=1691153765;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yaDvuOzjT/cE8KTBWyp8O1ZzjSSrXtCAPkVOGLmfrMk=;
 b=kARtKhtf+WmpbkswSmmjhHybmpm6xDoyE/r/tDv17xYkbWUbUq5iAZjTV/GN4bkeuq
 SCBOxlShfucwSpT8JoQ0ho9IJ6nUdo9qFQBplD84P6/LYsbh02C8p1RJKrOXt4yXAeDY
 lWvpBcZexijH5+BpMVB4zIqiAk6Kwq4ViacY3fD7PKcRPYdG8OmxaDS7skB2M47SbOH+
 zEsytdREHP0GBq4zktXSs9/3uVGRBrjP+hOFTilI5iimuMCIBBLXdAw0IdahUvg0POS2
 e0F43+PDE5GHfCFVlBg9Q1Ur4ZHY7RXWS/d0/EEoMu8utYXGCgPM7DiOW//OKEEwvS5N
 ylDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690548965; x=1691153765;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yaDvuOzjT/cE8KTBWyp8O1ZzjSSrXtCAPkVOGLmfrMk=;
 b=KZPT8h2FA0FwNbSyOatI2T7mvoQhreitBwafeVgxtQuKUUzvccJbpoSrrBdSI53jgd
 pto60+AqXl/ScTjcOpD6YoW5RIDmcP0xbJnVhxz2gzOIMNwvv/jIwaQOUvyw1xzdbDNu
 YYZcoJkq0nmMbd4W9T9u847LJP7RPBZTDPLRbZDNpxG2nzJ7CWRYrzXtaIMK6vTtdPbA
 nMeoqKvqyyvrngJPTHIL+32e654QPob/pBPgM7RWL/xHjfFacrxGIdbYbnhzsCA1+5ID
 4kLzce6TweDfVl044dKG7j+dml/7YPnZ4uLuq8llyw5glBHrgDeFhu6V9kRicahfP5yb
 YqaQ==
X-Gm-Message-State: ABy/qLaz6bUmT589BDDsyLG0CvAPiaJiP8aSVpi2xnOYzLHUIOgGLKJD
 Ud6WeyWmacpZQpapUxKTeoJCRA==
X-Google-Smtp-Source: APBJJlHe0Rbpq3oeewPMnTPb7wfwpRACmC0C2BklswS8r2M9z8Smry5Aoc29SAU+f3KuGZ7fqJYHZQ==
X-Received: by 2002:a05:6a21:a109:b0:133:cf5c:4d2e with SMTP id
 aq9-20020a056a21a10900b00133cf5c4d2emr1476406pzc.20.1690548964581; 
 Fri, 28 Jul 2023 05:56:04 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a170902cf4600b001b8b2b95068sm3502071plg.204.2023.07.28.05.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 05:56:03 -0700 (PDT)
Message-ID: <7d4fa349-25c4-dbc4-a3da-bf9bd05c22a0@linaro.org>
Date: Fri, 28 Jul 2023 05:56:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL for-8.1 0/8] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>,
 Hanna Reitz <hreitz@redhat.com>
References: <20230727200058.1071776-1-stefanha@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230727200058.1071776-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/27/23 13:00, Stefan Hajnoczi wrote:
> The following changes since commit 66547f416a61e0cb711dc76821890242432ba193:
> 
>    block/nvme: invoke blk_io_plug_call() outside q->lock (2023-07-17 09:17:41 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> 
> for you to fetch changes up to 1c38fe69e2b8a05c1762b122292fa7e3662f06fd:
> 
>    block/blkio: use blkio_set_int("fd") to check fd support (2023-07-27 15:51:46 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Please include these bug fixes in QEMU 8.1. Thanks!

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


> 
> ----------------------------------------------------------------
> 
> Hanna Czenczek (1):
>    block: Fix pad_request's request restriction
> 
> Sam Li (1):
>    block/file-posix: fix g_file_get_contents return path
> 
> Stefano Garzarella (6):
>    block/blkio: enable the completion eventfd
>    block/blkio: do not use open flags in qemu_open()
>    block/blkio: move blkio_connect() in the drivers functions
>    block/blkio: retry blkio_connect() if it fails using `fd`
>    block/blkio: fall back on using `path` when `fd` setting fails
>    block/blkio: use blkio_set_int("fd") to check fd support
> 
>   block/blkio.c      | 132 ++++++++++++++++++++++++++++++---------------
>   block/file-posix.c |   6 +--
>   block/io.c         |   8 ++-
>   3 files changed, 97 insertions(+), 49 deletions(-)
> 


