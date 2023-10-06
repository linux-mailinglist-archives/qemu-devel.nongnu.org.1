Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6747BB5F9
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:10:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoiiN-00043c-GX; Fri, 06 Oct 2023 07:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoiiD-00043I-No
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoiiC-0007Xo-63
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTRgg4rZDQgjbQiv8atBP5UcvcxOADqTkggQrknsVVM=;
 b=AZrsTfPKZkR51dWkf3ofbxfkEfJIBZdUzFU5chqX1fGf7UCxrxKYkOlgQr3i/r7eDWl5hU
 9V21nC0JqWLtFF6q3qdX9YqLwkXBEIsMJIQFJOmb3y5vuKZikuUxzUh/+ngKIvVEcs3jrN
 hYUOCQn/AK2bOEsxOw+FJu7mEV7IG6o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-EoQhNrvtN36bQ27UFm8aaQ-1; Fri, 06 Oct 2023 07:09:27 -0400
X-MC-Unique: EoQhNrvtN36bQ27UFm8aaQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae686dafedso181276066b.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590567; x=1697195367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iTRgg4rZDQgjbQiv8atBP5UcvcxOADqTkggQrknsVVM=;
 b=gqB+G1NTPEYv2dr2wV1Kwg1o/10EAM+gKYqlCNUURJxh9PLMFSxHFX97618+rNfa3x
 SqmXBM0JikFn9VRGZ4vLZpwjOzH3r+vBfhR1mcuAT9eT79kyPC6DDJT4mxVSnuLxArrj
 dGP4pcHOGd9BmpfXrFQjnu3kdKPRkROa+lEEP1nqAFeKjZtitFRtdzKOabyrNsN0MFTk
 bme+EfK+0DyygKk7iuy5iDDJhYGXHBKTtWSDPHXHyFqt2baYOadXuFOJPyTsNuhzJHMq
 /74i//TzmPM8ub8iy206FAIiOIvbLjdomoYof1ByMCSBVUIWQsvnAWz3EqSNSSZIf3sY
 PLoQ==
X-Gm-Message-State: AOJu0Yw+eqp8EHUsUKod85STgTwjygutxJSCtk+PNcbw8L/w478O1xQ9
 3ya9FDD58gHExjqHBnje4QNBYWY0r4TqJToDFggnBEYi0poXX40Pwc0G39bxocXF8fNNCBMhtxX
 Wop7LzrQIMiORWS0=
X-Received: by 2002:aa7:c2cc:0:b0:534:697c:3e65 with SMTP id
 m12-20020aa7c2cc000000b00534697c3e65mr7135504edp.36.1696590566806; 
 Fri, 06 Oct 2023 04:09:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX1gFcMCWlRGkqJo2JDi9ulglSksvbJvmMkPG29nCSyRqYs5+OuXtqBcHmxQoj/iAPQBhjcw==
X-Received: by 2002:aa7:c2cc:0:b0:534:697c:3e65 with SMTP id
 m12-20020aa7c2cc000000b00534697c3e65mr7135474edp.36.1696590566420; 
 Fri, 06 Oct 2023 04:09:26 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 p14-20020aa7cc8e000000b005340d9d042bsm2367864edt.40.2023.10.06.04.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 04:09:26 -0700 (PDT)
Message-ID: <bb283e8c-b468-932b-fc58-614d264977f9@redhat.com>
Date: Fri, 6 Oct 2023 13:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/5] linux-user/syscall.c: clean up local variable
 shadowing in xattr syscalls
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
References: <20230925151029.461358-1-laurent@vivier.eu>
 <20230925151029.461358-6-laurent@vivier.eu>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230925151029.461358-6-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 25/09/2023 17.10, Laurent Vivier wrote:
> p is a generic variable in syscall() and can be used by any syscall
> case, so this patch removes the useless local variable declaration for
> the following syscalls: TARGET_NR_llistxattr, TARGET_NR_listxattr,
> TARGET_NR_setxattr, TARGET_NR_lsetxattr, TARGET_NR_getxattr,
> TARGET_NR_lgetxattr, TARGET_NR_removexattr, TARGET_NR_lremovexattr.
> 
> Fix following warnings:
> 
> .../linux-user/syscall.c:12342:15: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
> 12342 |         void *p, *b = 0;
>        |               ^
> .../linux-user/syscall.c:8975:11: note: shadowed declaration is here
>   8975 |     void *p;
>        |           ^
> .../linux-user/syscall.c:12379:19: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
> 12379 |             void *p, *n, *v = 0;
>        |                   ^
> .../linux-user/syscall.c:8975:11: note: shadowed declaration is here
>   8975 |     void *p;
>        |           ^
> .../linux-user/syscall.c:12424:19: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
> 12424 |             void *p, *n, *v = 0;
>        |                   ^
> .../linux-user/syscall.c:8975:11: note: shadowed declaration is here
>   8975 |     void *p;
>        |           ^
> .../linux-user/syscall.c:12469:19: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
> 12469 |             void *p, *n;
>        |                   ^
> .../linux-user/syscall.c:8975:11: note: shadowed declaration is here
>   8975 |     void *p;
>        |           ^
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/syscall.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


