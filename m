Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C209B759877
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:36:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM8G8-0001sr-72; Wed, 19 Jul 2023 10:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM8G5-0001sj-Gz
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM8G4-0007fc-A8
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689777267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUdDmld4ha756xVMo8Lci7vWsAh5dhqCSMnmzGGao7k=;
 b=X0jRI51XUlpX/STQJ795iwcoIZWaDR0Uc9H+JJg83LFHL/c/CvyqtVgoiPJgu+jgyDwADq
 D0IoU5SsBrtWNtgzTWX9MYm7ehlLjKoQ38jyEodUtSVav7s25wN7Tn7SWjw+vlIJEUQXLQ
 0i1l74aMWkhdajBRh7bzN9mzDrg/hVE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-UDLUJa_YO0aB3c328otPyw-1; Wed, 19 Jul 2023 10:34:24 -0400
X-MC-Unique: UDLUJa_YO0aB3c328otPyw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31437f02985so4338401f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 07:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689777263; x=1692369263;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uUdDmld4ha756xVMo8Lci7vWsAh5dhqCSMnmzGGao7k=;
 b=J1THt1oyXrFa3eZswVjA9bDEFptsERLTJRBf96gyzA15YLjernBHwMH98q3PTLEF90
 Uw6f8DgkKl5mYUJ9WaGy35W98KuxC3WrInxSqhlDW6exzlxHzyJB3YK/bdjM9H/64EUO
 ku1vp9Er3ZVD4gk5fyOyp+4fhkNIIjZ0UeKscDiICkfrz6ApXpvgjYOaq9RaHojmr1zw
 ax3EUztL+EHjdg8Qw1HKwDi99lvlwvCs389cD+Y2SDFLPHXQ0XpGHfOZmpbgceWj+dog
 0LoosRLM0jY9LoCYsldUVqKPtc9cO0MBwtHDrv7/AjzS/vPtnX+MExmCBQP0CH2pllF/
 3fdw==
X-Gm-Message-State: ABy/qLbU7Z5AiSpimHIWBsCHTKs7NT9RllFRFtX0LqTiHVKaDceP4N7+
 74lxs2TimGTrGvLwSvSWUdslYsNAvLFKzfORNurklMaKoQC5nvL6jF6g50uOQHUBmst7uz4F+Z0
 wWsvqZ4swLWj7wVA=
X-Received: by 2002:a5d:43ca:0:b0:314:3983:1465 with SMTP id
 v10-20020a5d43ca000000b0031439831465mr51131wrr.31.1689777263373; 
 Wed, 19 Jul 2023 07:34:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcxlScztqR+UKZyIvSGa4IY/OK3/kTatVe6eX46xf5zp7n0b/g7jWfWY3vdqH8umtUBwbu3w==
X-Received: by 2002:a5d:43ca:0:b0:314:3983:1465 with SMTP id
 v10-20020a5d43ca000000b0031439831465mr51123wrr.31.1689777263111; 
 Wed, 19 Jul 2023 07:34:23 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 k25-20020a7bc319000000b003fbb25da65bsm1836245wmj.30.2023.07.19.07.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 07:34:22 -0700 (PDT)
Message-ID: <96cdf3b3-bb5e-32fd-4f12-455e27be1897@redhat.com>
Date: Wed, 19 Jul 2023 16:34:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 09/14] tests/tcg/s390x: Test CLGEBR and CGEBRA
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20230719094620.363206-1-iii@linux.ibm.com>
 <20230719094620.363206-10-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230719094620.363206-10-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 19/07/2023 11.44, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  5 +++++
>   tests/tcg/s390x/cgebra.c        | 32 ++++++++++++++++++++++++++++++++
>   tests/tcg/s390x/clgebr.c        | 32 ++++++++++++++++++++++++++++++++
>   3 files changed, 69 insertions(+)
>   create mode 100644 tests/tcg/s390x/cgebra.c
>   create mode 100644 tests/tcg/s390x/clgebr.c

Tested-by: Thomas Huth <thuth@redhat.com>



