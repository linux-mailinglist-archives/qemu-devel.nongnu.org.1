Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4717F70416E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 01:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyhkc-0002Dt-BD; Mon, 15 May 2023 19:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyhka-0002Dj-U6
 for qemu-devel@nongnu.org; Mon, 15 May 2023 19:37:08 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyhkZ-0003nt-5W
 for qemu-devel@nongnu.org; Mon, 15 May 2023 19:37:08 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6439bbc93b6so9476917b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 16:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684193825; x=1686785825;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Aurf2e1xga4E1VZRAAjM7qHxekmbNCzjHV7M/l0zJs=;
 b=kJlbrT9sHPqZiy8sBy5yjrnnr95vWb+Y76dx38wwa/koRXHdxlott2XRlThTgSSIL9
 mDF6S6HLUECwvEjol+rIcSAB5/33Dc7r3bDmclZ4vFpDbHBREP1pYutAB3fITZEme5bF
 iIttQj6Ra8+fn1gCEAoLcm58k+8OrhVOThfrVohBBPnYnORUJ1xToAEhSNWdMUWLS5ea
 Mex70lzgsagN5TXxaI6QGHTwR5l7FPacGoGhNh9+i18ha6l/J6Rj8nETcRu3CyaDFNqu
 liR52nAaI2W9eJYCFcf0EgLWKn/4S9aCJfvcMfQqk3PUaXCLBPTvRjUmjcW33VPlRFRc
 3Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684193825; x=1686785825;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Aurf2e1xga4E1VZRAAjM7qHxekmbNCzjHV7M/l0zJs=;
 b=HRusleqhzhkwt8bJ9JeVUEYeM90Cjd+PvEvoZ9k+BlTAbApLDaJA6JomgW44AE8CX3
 9F152p+p743teRX6qw8EiCTGb4Xx6HfG6a24/LYZDgBLdSu01hnVoGHZl/9a0Df1e+Ph
 k9hSSvm9uFsbnbKHmUT0ct6leQorjTEzbNuTZIWeGDguNBgR5Tj3bEhpRdnRmPp0NtcP
 iybwX2iuBx9POl6V7wdd639w/uY7gPfRD3b1fDyBOWONWkP7xyWNdQTPEf0QO4pHa2M3
 fxdsA0moBQUnriUHwYXMzN/l0D/UN0TWI5Ch4u4AdV/xLEBdOlnGYYiY7GfSE+Zs18r6
 SkBg==
X-Gm-Message-State: AC+VfDzbF8f1fpiqzUAQcrDWr9ZKBmPk2WmC/0ZtbhPlj/DZG2wz0+jD
 Bb6ZAnyBIckL3SLtziDaHaYX4ubYnHQpsuDCqRY=
X-Google-Smtp-Source: ACHHUZ6y7JbU2oqv2WBkKDZfDfWIxaDuzV8iVU2zUO4rKM3lEahN7rdtcHFNoexVrAFrgz/A2rkotQ==
X-Received: by 2002:a05:6a20:12cf:b0:104:1016:dd4d with SMTP id
 v15-20020a056a2012cf00b001041016dd4dmr20493931pzg.57.1684193825150; 
 Mon, 15 May 2023 16:37:05 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9902:96ac:8d8c:4366?
 ([2602:ae:1598:4c01:9902:96ac:8d8c:4366])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a17090b019300b002448f08b177sm163702pjs.22.2023.05.15.16.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 16:37:04 -0700 (PDT)
Message-ID: <356b996c-310a-858f-5987-a698654fec8b@linaro.org>
Date: Mon, 15 May 2023 16:37:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL v2 00/16] Block patches
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 kvm@vger.kernel.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20230515160506.1776883-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230515160506.1776883-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
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

On 5/15/23 09:04, Stefan Hajnoczi wrote:
> The following changes since commit 8844bb8d896595ee1d25d21c770e6e6f29803097:
> 
>    Merge tag 'or1k-pull-request-20230513' ofhttps://github.com/stffrdhrn/qemu  into staging (2023-05-13 11:23:14 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git  tags/block-pull-request
> 
> for you to fetch changes up to 01562fee5f3ad4506d57dbcf4b1903b565eceec7:
> 
>    docs/zoned-storage:add zoned emulation use case (2023-05-15 08:19:04 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> This pull request contain's Sam Li's zoned storage support in the QEMU block
> layer and virtio-blk emulation.
> 
> v2:
> - Sam fixed the CI failures. CI passes for me now. [Richard]

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


