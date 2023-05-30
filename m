Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B777159FB
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:24:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vZk-0000Y7-0q; Tue, 30 May 2023 05:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3vZi-0000Xi-Bc
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3vZg-0003hN-2K
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685438606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+AOwHvEIiVH41W5U7PoxNynkLdExqYPosiFFFpkYp0=;
 b=I/PhulSOU4spj15iqhvGtv2NsdW6Ci7ZwjiBRFBP6wh/q+z/mGjfRyLwwi6fACIx+mT+Gk
 fEcCWoiZdIQdcbTExiRU8L7FZradiTWeS12n4dcdFNct4ZYlGc3TDGawMb6dY88Ab1/bI1
 S3hPs3gLrTf58EF85C/7Jc3EEHaqox0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-1NfSTo3gO7acfs8JTIx2dA-1; Tue, 30 May 2023 05:23:25 -0400
X-MC-Unique: 1NfSTo3gO7acfs8JTIx2dA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f60536450eso24912215e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 02:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685438604; x=1688030604;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5+AOwHvEIiVH41W5U7PoxNynkLdExqYPosiFFFpkYp0=;
 b=IRLzYCGuNvBpC/NetthpmGG0O1Zv5Qhwg+CpFnPFkUP7G661wBt4dIknDrEAzH3JFA
 bHIM8PCs6vIYM8Gr+VRoQChkwGvq8UJtVhzbFGOEyXf7oj6yxSzw55tjNa8hWUAYuare
 bB+fNNJyxGa32BXXvn1MWKpbM49Sj8eI2+1hVV3OZboyHSwIb0AA77aqn8yR3cKERieh
 k2isIy0FKFy0eHAen6kfVAuC4NUuzxTttKYQY643yMtmY/X4YLw9c+TggM3Hu+fHC4sQ
 G0gyl/JjJzdsTaQ6MGjQRX7BWy8lNcmmX0OiZInQ7Wg9MQXFudXQjIHNAtVtuOhXjHzo
 v+7w==
X-Gm-Message-State: AC+VfDw5QEutfMErKfLLP5nwlUhNUeNx60uGadeWzQMbRoQrGzqq9DEb
 KPkOk5BCa3xG0I87R9268iaFFDuHhYDzfB7ZHoWcZjN2a6Y8UsU99aFn6Dt/aGfZbp9rfkXgv01
 UvWu4F4ciSPQ/i7I=
X-Received: by 2002:a5d:58f3:0:b0:30a:e9bd:b4cf with SMTP id
 f19-20020a5d58f3000000b0030ae9bdb4cfmr1638350wrd.52.1685438604241; 
 Tue, 30 May 2023 02:23:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4z6MB6rLzWFoTtJIxU18yuV+s8Ua/u0wgY900AhLtArPaURnoU/QhV4FBjheBJAJdvadby7g==
X-Received: by 2002:a5d:58f3:0:b0:30a:e9bd:b4cf with SMTP id
 f19-20020a5d58f3000000b0030ae9bdb4cfmr1638336wrd.52.1685438603984; 
 Tue, 30 May 2023 02:23:23 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-11.web.vodafone.de.
 [109.43.176.11]) by smtp.gmail.com with ESMTPSA id
 l13-20020adff48d000000b003064088a94fsm2640474wro.16.2023.05.30.02.23.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 02:23:23 -0700 (PDT)
Message-ID: <0ba18db1-9dc9-6eb2-a626-3c73fe33dfaa@redhat.com>
Date: Tue, 30 May 2023 11:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: stable-8.0.1 re-tagging?
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers
 <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <4aa77e25-c224-c2aa-d17d-54d3d04f763e@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <4aa77e25-c224-c2aa-d17d-54d3d04f763e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 30/05/2023 10.15, Michael Tokarev wrote:
> Hi!
> 
> Yesterday I pushed v8.0.1 tag for 8.0.1 stable qemu release, but in the
> process of publishing it, Michael Roth discovered a regression in iotest
> which we all overlooked when initial patch has been applied to master.
> 
> The commit in question is this one:
> 
> commit de79b52604e43fdeba6cee4f5af600b62169f2d2
> Author: Stefan Hajnoczi <stefanha@redhat.com>
> Date:   Tue May 2 17:11:19 2023 -0400
> 
>      block/export: call blk_set_dev_ops(blk, NULL, NULL)
> 
> It caused iotest 307 to fail, - qemu failed with Sig11. 
...
> And another lesson for me to learn, - actually 2 - first is to listen
> to myself, since my inner self did think about running more complete
> checks after a bunch of block-io changes which I picked up, but I didn't
> think about that with enough attention. And second is to verify whatever
> I "think" is true, instead of relying on own assumptions, - here, I was
> sure iotests are run within CI infrastructure, but nothing really indicates
> this is the case.

FYI, only a subset of the iotests are run during "make check" since some of 
them do not work reliable in all environments (e.g. non-Linux systems). To 
be more precise, only the ones marked with the "auto" group are run during 
"make check", and test 307 does not have the "auto" label, thus it is not 
run in the CI.

  HTH,
   Thomas


