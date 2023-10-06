Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1114B7BB5EC
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:06:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoieA-0008BV-TB; Fri, 06 Oct 2023 07:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoie6-0008BM-NG
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoie5-0006ON-6W
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcfTJPBkqRp4r/kflobRIgnFndbLwv/7bA1bcqLiqBs=;
 b=CPJtr4u/wctvDYHe6112QDhpqkQQYx5QJ7ksr2G6ca3DpyeWxBPmKXfKbEaLyZB9oZL6t+
 Dyxt6vGbm6hbT6UyWystkHz73qgTToMhb98yBMY1ZuFTcPlYn7QlR0WzpSshbWtnsAtJpU
 6aL16H57fE17x/etpPpBKeMbeUd5/qY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-bPO3ZuruN7Cqig5g260nBg-1; Fri, 06 Oct 2023 07:05:07 -0400
X-MC-Unique: bPO3ZuruN7Cqig5g260nBg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b98bbf130cso168644866b.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590306; x=1697195106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CcfTJPBkqRp4r/kflobRIgnFndbLwv/7bA1bcqLiqBs=;
 b=TBpa3CHBZOKD7D85ASR7Eq6ns/EPDwfa9fRWNgPn5uuAMnYh1+2OWi9x5pxTTgUDSg
 RA9MLIvVtPupIfALFLDqJcVSmOUdTvS3NMwy/H8ba7txcg+U+Ys7co3iP58apFDCSwOL
 iiVR8R9NlmzF3MhU9gPWLNtnq6z1t67vaOhJdv7+gi/t5LWYBgx4MF+VgfavvuUiRV/i
 4mjVka96pFhzfJpZ+mQMLUcp8v5gHwIlgO9BFaerzKztzh2GBGkT0SVf0GRgAEUQlI4q
 9IpyoakO/zdzcV4W/d2vFV0s3dzGjrz7Ts53wizwKC+dbLQ8CjzipJkgC/OeS+IGfY8L
 aADQ==
X-Gm-Message-State: AOJu0YzeCIrX37X9efLCUR1A8C+T8SZijmVPsvhaGJo9vhPslpkKcmn3
 DkIOLni4ejV8QajKCPMUmWIvAIQaQloPi+gRTNrdpk1hSHxmKgs0d5YY2QagIiuM1a9tTNgtzgk
 TRc+ke6NIZ4mX0f0=
X-Received: by 2002:a17:906:ce:b0:9a6:426f:7dfd with SMTP id
 14-20020a17090600ce00b009a6426f7dfdmr6413008eji.66.1696590306498; 
 Fri, 06 Oct 2023 04:05:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyE1DEgFLHT2a9WKstnZE0w4Z6vDCOITpEr/yqyOXrLbefJ/ANANFvBX6+WA7kZdynm5P3KA==
X-Received: by 2002:a17:906:ce:b0:9a6:426f:7dfd with SMTP id
 14-20020a17090600ce00b009a6426f7dfdmr6412987eji.66.1696590306167; 
 Fri, 06 Oct 2023 04:05:06 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 b13-20020a170906d10d00b009930c80b87csm2734298ejz.142.2023.10.06.04.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 04:05:05 -0700 (PDT)
Message-ID: <f99f21f2-d1b8-9471-39e0-0756c7f0457b@redhat.com>
Date: Fri, 6 Oct 2023 13:05:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/5] linux-user/syscall.c: clean up local variable
 shadowing in do_ioctl_dm()
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
References: <20230925151029.461358-1-laurent@vivier.eu>
 <20230925151029.461358-4-laurent@vivier.eu>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230925151029.461358-4-laurent@vivier.eu>
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
> Fix following warnings:
> 
> .../linux-user/syscall.c: In function 'do_ioctl_dm':
> .../linux-user/syscall.c:5053:23: warning: declaration of 'arg_type' shadows a previous local [-Wshadow=local]
>   5053 |         const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
>        |                       ^~~~~~~~
> .../linux-user/syscall.c:4991:20: note: shadowed declaration is here
>   4991 |     const argtype *arg_type = ie->arg_type;
>        |                    ^~~~~~~~
> ...//linux-user/syscall.c:5102:27: warning: declaration of 'arg_type' shadows a previous local [-Wshadow=local]
>   5102 |             const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_name_list) };
>        |                           ^~~~~~~~
> .../linux-user/syscall.c:4991:20: note: shadowed declaration is here
>   4991 |     const argtype *arg_type = ie->arg_type;
>        |                    ^~~~~~~~
> .../linux-user/syscall.c:5130:27: warning: declaration of 'arg_type' shadows a previous local [-Wshadow=local]
>   5130 |             const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
>        |                           ^~~~~~~~
> .../linux-user/syscall.c:4991:20: note: shadowed declaration is here
>   4991 |     const argtype *arg_type = ie->arg_type;
>        |                    ^~~~~~~~
> .../linux-user/syscall.c:5170:27: warning: declaration of 'arg_type' shadows a previous local [-Wshadow=local]
>   5170 |             const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_versions) };
>        |                           ^~~~~~~~
> .../linux-user/syscall.c:4991:20: note: shadowed declaration is here
>   4991 |     const argtype *arg_type = ie->arg_type;
>        |                    ^~~~~~~~
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/syscall.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


