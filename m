Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E6E7631C3
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 11:23:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOajm-0002zv-5N; Wed, 26 Jul 2023 05:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qOajk-0002zh-KS
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 05:23:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qOajj-000109-2Q
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 05:23:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso5319525e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690363393; x=1690968193;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fFQvuvTA0rApmyYbTz3tv5ZD3yKdHhVxq/4ZpYUd/aI=;
 b=AtnzzCtWg9h1M4tC8McICoStSn5jsjyoy+ew/xxN9mQBvEjNEHl4ER4tog0WNTSZzo
 lnglCuW3q0LPjKsD218sZEoandOW/q3lMtLwl+AsxR77MD1dRSn6X4XsvmWtrVsRzKqx
 HbfPYIBT6TxK3K/jd6jQgve3nBOLC+EBwnaFgWkBW/bEPc9WdxNixXHxIENuQ9+Y0kRV
 tkmfEhQsP1If3YM9jxQa5m8PT5p0Ub6KPO7nxZUQjDOXEjdxwxm8WTXDkSM5RaDye+/0
 2MZnNxRwkbUTt4TxF81R5wSwn6CjJ+KCgdvb+SNVvfYFZPMzLAg7XwyhXJ8AVnP28zIp
 IjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690363393; x=1690968193;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFQvuvTA0rApmyYbTz3tv5ZD3yKdHhVxq/4ZpYUd/aI=;
 b=E1JQGEBWcqr39V8xgZHunDwO61BWunXH9v/2ttfsp8E63ZMZxCW9RMhva76WMEVt1f
 9ePZyV7LPfsM5Iq6tgtkz4wvEfRlhIK3HrbqZGAaQaHPeZnGg9VG3RFk0Z1IstFe+I90
 QYQ/Ery0R8np5oVxCWtzAFB4l3Oy1uSV7wlvoCR2dBGAZ18SWXpCrsw5DgkgD1iUTWE3
 ws7dzj40mevvhZgfUo1MCeD81FeYNCS720VWrZ97gOBh890DqRmwY1tIOKHKbgW/N5Up
 MxaKh4kI4IG0ztzRu3pcctN1K16eQWIq74/K8hhxwLuCIj/H+8GTJMX47QmnGYLss6js
 1lKA==
X-Gm-Message-State: ABy/qLZoY+Udsk8mII0VbXLeHc/9oZERhMtf06WBWV3yCQiaHrOI5iis
 p0FRe5y8Lib04XreTUpP4XU=
X-Google-Smtp-Source: APBJJlEokAR5XBWIWrvKx0TqxfcWcSIIEbmM36Ox1s94Psz19r/IEQDX+DN0c5KH+aLxaizghWa1VQ==
X-Received: by 2002:a05:600c:3b88:b0:3fa:91d0:8ddb with SMTP id
 n8-20020a05600c3b8800b003fa91d08ddbmr4148536wms.14.1690363392741; 
 Wed, 26 Jul 2023 02:23:12 -0700 (PDT)
Received: from [192.168.24.200] (54-240-197-226.amazon.com. [54.240.197.226])
 by smtp.gmail.com with ESMTPSA id
 f12-20020adfe90c000000b0031758e7ba6dsm11331347wrm.40.2023.07.26.02.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 02:23:12 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <2ce9338f-30a3-e240-6cf6-a0280294c14f@xen.org>
Date: Wed, 26 Jul 2023 10:23:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/xen: Clarify (lack of) error handling in
 transaction_commit()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Ankur Arora <ankur.a.arora@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, vikram.garhwal@amd.com,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
References: <20230307182707.2298618-1-dwmw2@infradead.org>
 <20230307182707.2298618-6-dwmw2@infradead.org>
 <CAFEAcA9gzJGMqsEY5TuNmb74RskgUTMW+XcqGV53n3SsKyVVXg@mail.gmail.com>
 <CAFEAcA9aFv5c4S=Pyf3dMU-v9FnNJqWTQ7ZbiDQLTjh8Qou71g@mail.gmail.com>
 <CAFEAcA--FqeioUdPb9sr5fEy3q0H0swcp+rbGxoNbhgMkYdC+A@mail.gmail.com>
 <20076888f6bdf06a65aafc5cf954260965d45b97.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <20076888f6bdf06a65aafc5cf954260965d45b97.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x336.google.com
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

On 20/06/2023 18:58, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Coverity was unhappy (CID 1508359) because we didn't check the return of
> init_walk_op() in transaction_commit(), despite doing so at every other
> call site.
> 
> Strictly speaking, this is a false positive since it can never fail. It
> only fails for invalid user input (transaction ID or path), and both of
> those are hard-coded to known sane values in this invocation.
> 
> But Coverity doesn't know that, and neither does the casual reader of the
> code.
> 
> Returning an error here would be weird, since the transaction *is*
> committed by this point; all the walk_op is doing is firing watches on
> the newly-committed changed nodes. So make it a g_assert(!ret), since
> it really should never happen.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xenstore_impl.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


