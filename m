Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D4578D621
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:27:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLDf-0006I2-Nx; Wed, 30 Aug 2023 09:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbLDO-00067Y-HT
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbLDL-00044c-DF
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693401990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t6jW74vuKBIpKI42oFy9w7JaXJavjZCR3RPUOqxzxOU=;
 b=BN2PCuhukF9/lXe3aVihh4L1U/fLbOWsr5wsuLE3jS/zw6RQoShimChE4+kh/Msa0CGJf1
 Fk1540KVARN2q5AQ+UDm9Fq1a8PM/fyDEr3N0o2lOf1oQhmdjkTQ/ZJ5HGFE/U2ivZDGXj
 2wbxVF6OkO5P7etxTiuMRlsaUoisv1A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-sbfensL6NrG8Kpa1KWD6Gg-1; Wed, 30 Aug 2023 09:26:28 -0400
X-MC-Unique: sbfensL6NrG8Kpa1KWD6Gg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31c5c55fd70so383079f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 06:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693401987; x=1694006787;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t6jW74vuKBIpKI42oFy9w7JaXJavjZCR3RPUOqxzxOU=;
 b=V2BQHawO0d3J6yXKP7EDuGkiFvEV7v82Bbs5qWs2tw1Wu6r+ufLN/aqXTyafmZCBTW
 70PKdO5LLqtKsFBU2h/3SmabLyYse1atWLQAX0rse2wovJNYKltljMgehqDZOQvJAaJu
 /u/w5ygj0Yxh5PqQIAy5l/Rq9erPW7mDCxKTUbPb+s1MtE5XbyBe2mtLPlXy4TDZ4/a1
 m9aWuA1jtHHXBos7Ec0yPgG3g1IMYebbRkBGe4ay4P7fms7TCghtGNqWtBALzRj6UG4+
 1XMCZen7iNquL5ZBqMnSJk8pXZuP6m9ENqE79qSQDlvRQJKlqze9ALPYOG0KQFfm2HOO
 nmLg==
X-Gm-Message-State: AOJu0Yxoe2AIW4JKxSjZgRRaX/snxOfVPbcidQyIhauN/Uos/VkMhKSd
 HY7CJTwN+6YyMIj4rkVZnwf8yaNLgwK8mkWxVTtQwJMlDctWGc1LZQ6hmn2AxRzeSVpyL/BRD6V
 eipB1BkTK5O7wWcg=
X-Received: by 2002:a5d:4592:0:b0:31a:dbd8:95dd with SMTP id
 p18-20020a5d4592000000b0031adbd895ddmr1762190wrq.29.1693401987807; 
 Wed, 30 Aug 2023 06:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp1eH+79o+9bZ0aEy7BVlAqopWJ5AOSKqtoNh/xSt8lwv7PYZZSlmYl5F/W61dFnL85HL36g==
X-Received: by 2002:a5d:4592:0:b0:31a:dbd8:95dd with SMTP id
 p18-20020a5d4592000000b0031adbd895ddmr1762176wrq.29.1693401987500; 
 Wed, 30 Aug 2023 06:26:27 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-145.web.vodafone.de.
 [109.43.179.145]) by smtp.gmail.com with ESMTPSA id
 q7-20020adff787000000b003188358e08esm16513304wrp.42.2023.08.30.06.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 06:26:26 -0700 (PDT)
Message-ID: <bcc8770e-95e6-e259-3c0b-e18a2c41474b@redhat.com>
Date: Wed, 30 Aug 2023 15:26:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PULL 0/1] Quick fix patches
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>, Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230830022205.57878-1-imp@bsdimp.com>
 <CAJSP0QVnEswDVbvWU3Zv74L+19De+nTVmzueAP-Lg_zw4E1mtg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CAJSP0QVnEswDVbvWU3Zv74L+19De+nTVmzueAP-Lg_zw4E1mtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 30/08/2023 15.16, Stefan Hajnoczi wrote:
> Hi,
> The patch introduces the following build failure:
> 
> cc -m64 -mcx16 -Isubprojects/libvhost-user/libvhost-user.a.p
> -Isubprojects/libvhost-user -I../subprojects/libvhost-user
> -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu99 -O2 -g
> -Wsign-compare -Wdeclaration-after-statement -Wstrict-aliasing
> -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
> -fno-common -fwrapv -fPIE -pthread -D_GNU_SOURCE -MD -MQ
> subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -MF
> subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o.d -o
> subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -c
> ../subprojects/libvhost-user/libvhost-user.c
> In file included from ../subprojects/libvhost-user/include/atomic.h:18,
> from ../subprojects/libvhost-user/libvhost-user.c:53:
> ../subprojects/libvhost-user/include/compiler.h:38:40: error: missing
> binary operator before token "("
> 38 | #if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
> | ^
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4981576093

IIRC older versions of GCC do not have __has_warning() yet, so if you want 
to use this in compiler.h, you have to do it below the line in compiler.h 
that adds this:

#ifndef __has_warning
#define __has_warning(x) 0 /* compatibility with non-clang compilers */
#endif

  HTH,
   Thomas


