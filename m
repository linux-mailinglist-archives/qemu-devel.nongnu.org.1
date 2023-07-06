Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B08AF74A232
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:29:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHRql-0007bt-7O; Thu, 06 Jul 2023 12:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qHRqj-0007bh-SW; Thu, 06 Jul 2023 12:28:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qHRqi-0005Wd-9D; Thu, 06 Jul 2023 12:28:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so10218695e9.1; 
 Thu, 06 Jul 2023 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688660933; x=1691252933;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Nrzaoz+rsxVgQTd6TxexIuCRlSLkofQwGuRUpX9fTY=;
 b=lRE5ncMMCLuhjZR7WCD9aIRabbtkx72rnve+GOLxtTjFVgCmhjIjI1BAyFoegY0t6+
 PRFrrxdVjaFL3OLdaNmXR16w786N8MHGmcm+MVOoZMMjs5GKyfOF7sP5DClmcmwAsSAK
 0wzjGoSKnIHCBGRAmu+3uOt8aK5g6xWX0lxQof+d4tKxb+P+1RFJE5DOp2fjpqZ7lucF
 fZf9ukLA0CS1JZaSzCMIoRL1X/6334t/BCvebW/LS0c+2fwJV4oVzQ7jRjickoReikRX
 z5CSX5skhwsPzo/LUkGGZ9Dnntgbp2CX2XjBLynF5Kon+6KTS1ecJO63B3Ap+TTfsMBZ
 SWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688660933; x=1691252933;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Nrzaoz+rsxVgQTd6TxexIuCRlSLkofQwGuRUpX9fTY=;
 b=hynUPMDFUwaWNoufqRzFLEHxsjGGfeW5ZmvWhyDnWekremnaJ4ywBnxDJmyVTfJ9Ja
 1GORkfPezPSSi+nUUndf+JSk40CJle8wVba0bAODTscxWzgwxl3A//YSKp+5NnWPafcB
 2Pb/0niQm+YjHBRml6lpxrTOogOpUsN7pMiMPofu1jnDa8rfojNlQbBfK1dj0xxn+X2N
 kas+KRSSJJqkIncTHlPv2tGEPUgHXr+w8xpqORhR1YPm3ijYpM9owYSXm/k4v17ie1Ja
 37PY9BL8ANZSkaWn64Bg5SQ1wjw8aDJdWbOmY6oNChK7OrDbN6p3P3VwnrzOGNtLTVVF
 h2CA==
X-Gm-Message-State: ABy/qLYo1vPQkilznovAfqCe4W1EZNU+WjqbkZXgI4UtLLoQsB4XHGCj
 fWS9Ta/HsvHixkI0vfQyhKs=
X-Google-Smtp-Source: APBJJlGWcxJJF03lZm81+ayN8BYKTAHsb1a6gRv3FRByPiONZ3DSvT07hsvUipV0f0QybLNHfc56Dg==
X-Received: by 2002:a05:600c:2055:b0:3f7:4961:52ad with SMTP id
 p21-20020a05600c205500b003f7496152admr1975126wmg.3.1688660932849; 
 Thu, 06 Jul 2023 09:28:52 -0700 (PDT)
Received: from [10.95.131.194] (54-240-197-233.amazon.com. [54.240.197.233])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a1c720a000000b003f733c1129fsm797wmc.33.2023.07.06.09.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 09:28:52 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <c1d5ff39-2e2a-d863-7de5-7092e559c344@xen.org>
Date: Thu, 6 Jul 2023 17:28:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] xen-block: Avoid leaks on new error path
Content-Language: en-US
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
References: <20230704171819.42564-1-anthony.perard@citrix.com>
Organization: Xen Project
In-Reply-To: <20230704171819.42564-1-anthony.perard@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 04/07/2023 18:18, Anthony PERARD wrote:
> From: Anthony PERARD <anthony.perard@citrix.com>
> 
> Commit 189829399070 ("xen-block: Use specific blockdev driver")
> introduced a new error path, without taking care of allocated
> resources.
> 
> So only allocate the qdicts after the error check, and free both
> `filename` and `driver` when we are about to return and thus taking
> care of both success and error path.
> 
> Coverity only spotted the leak of qdicts (*_layer variables).
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: Coverity CID 1508722, 1398649
> Fixes: 189829399070 ("xen-block: Use specific blockdev driver")
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>   hw/block/xen-block.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


