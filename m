Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DB2768F3F
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:55:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNje-0004fF-Ki; Mon, 31 Jul 2023 03:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQNjc-0004e5-Ei
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQNja-0004Ki-4x
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690790069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ZO8/+xFrYFUUplmprpXkdk9gdtVNU+g6sTlEM4wmig=;
 b=bSF5Hn1KJU95KOoN3xBYymqnfKeHmmWCBvHiMNyi2bQI55Ey2BFcFcLBgF0kA+nmd4C8ad
 1uNaWYumze9n8mIoocEAiYYeuwB5TGvKo3OMlr/81iSc77DZ/8B6ltfkJ6BweMHssLr6Nk
 z6K1IkkKfUxwOeI+RpLkiFEUihDxeKo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-7OLDSE_HMyarX-Fu6psOIQ-1; Mon, 31 Jul 2023 03:54:27 -0400
X-MC-Unique: 7OLDSE_HMyarX-Fu6psOIQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-767b778582eso431234185a.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 00:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690790067; x=1691394867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ZO8/+xFrYFUUplmprpXkdk9gdtVNU+g6sTlEM4wmig=;
 b=J9zJK7URKpd9PisrD1fFs8u1L5bC0UIWRKoO0OLty1lTCBLvRXC3OuNE+2+W4qI8VZ
 kvJnrTF4aYoyTFHU7m5ZGyYrjAYTMYEL70MDsZzD35/BPZz34xP+Xq7AegPexn7mwki+
 t2MwHTQPvJCW44SyjfqbMKTh04UOKxGRKEicXpNcj8r0L/tkEKTtXH5q0IvRGNR5DDry
 V2MstpaieC8D3mbLUCHKQRbYjkvTfQETzo8qZRPpkaM2M7KLFl+HzJdbr1hlfGaWlMgz
 okIIlOSdIZFit2m3Dq8HazOpE3RTd7bmM1DUDY8Nf3TovG2UWLFBuzsNRvsiCmp+nHja
 ysqg==
X-Gm-Message-State: ABy/qLa0KGsso1Y3nOgnDMsSoupc94gq5FtOjIpgYGKkvfoXtn0GK6mH
 MWxd/Do2xUAOuQlDupETT2Jzo21OeA0QwDa/yN6okVFvOuNJe07k7aQ3vQ5x1ZsdOBb9s0QF1Dy
 verUap4V42mHlBsw=
X-Received: by 2002:a05:620a:3189:b0:76c:54bc:ad1c with SMTP id
 bi9-20020a05620a318900b0076c54bcad1cmr10030231qkb.18.1690790067239; 
 Mon, 31 Jul 2023 00:54:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFk2oCdEiTcWc41B1ZfXLl7ZOXw1FZ0RVxTs0qs0NU99w0okiTz5eTSFBTq6+qKWYeVsO5Hjw==
X-Received: by 2002:a05:620a:3189:b0:76c:54bc:ad1c with SMTP id
 bi9-20020a05620a318900b0076c54bcad1cmr10030213qkb.18.1690790067011; 
 Mon, 31 Jul 2023 00:54:27 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 b26-20020a05620a119a00b0076c701c3e71sm3036372qkk.121.2023.07.31.00.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 00:54:26 -0700 (PDT)
Message-ID: <51ef9524-5550-1331-41e1-a349a6260ab4@redhat.com>
Date: Mon, 31 Jul 2023 09:54:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] tests/tcg: Add -fno-stack-protector
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20230731065904.5869-1-akihiko.odaki@daynix.com>
 <20230731065904.5869-4-akihiko.odaki@daynix.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230731065904.5869-4-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31/07/2023 08.58, Akihiko Odaki wrote:
> A build of GCC 13.2 will have stack protector enabled by default if it
> was configured with --enable-default-ssp option. For such a compiler,
> it is necessary to explicitly disable stack protector when linking
> without standard libraries.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   tests/tcg/mips/hello-mips.c                   | 4 ++--
>   tests/tcg/aarch64/Makefile.softmmu-target     | 2 +-
>   tests/tcg/aarch64/Makefile.target             | 2 +-
>   tests/tcg/alpha/Makefile.softmmu-target       | 2 +-
>   tests/tcg/arm/Makefile.target                 | 2 +-
>   tests/tcg/cris/Makefile.target                | 2 +-
>   tests/tcg/hexagon/Makefile.target             | 2 +-
>   tests/tcg/i386/Makefile.softmmu-target        | 2 +-
>   tests/tcg/i386/Makefile.target                | 2 +-
>   tests/tcg/loongarch64/Makefile.softmmu-target | 2 +-
>   tests/tcg/minilib/Makefile.target             | 2 +-
>   tests/tcg/mips/Makefile.target                | 2 +-
>   tests/tcg/nios2/Makefile.softmmu-target       | 2 +-
>   tests/tcg/s390x/Makefile.softmmu-target       | 2 +-
>   tests/tcg/x86_64/Makefile.softmmu-target      | 2 +-
>   15 files changed, 16 insertions(+), 16 deletions(-)

I think the changes to the Makefile.softmmu-target files should rather be 
done in a central place, in tests/tcg/Makefile.target, right after the 
"EXTRA_CFLAGS += -ffreestanding" there.

  Thomas


