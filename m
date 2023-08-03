Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8C376DF77
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 06:44:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRQAt-0002h9-Sf; Thu, 03 Aug 2023 00:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRQAr-0002gv-MK
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 00:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRQAp-0006pT-RQ
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 00:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691037775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQXKDg18JCYlxjQ1cLjbp+15UYaGbdekzXID4P+dfF8=;
 b=I5RDPJf60pm84eJgVGWQOinnG4S3krp4q9o/KLPQKqgGO1Pya2KHsamSXzXnhR2RJHtSoW
 kpzZHfXlVXM43prrUM1+56QYtQDvvTHt/VvGlGxj4hvrPA8tdFdbNwVnAadKGCoxO8BXjW
 Lh97tdyw5/eGdItR5geBtI2UeS1WPOs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-ll7PztUiOYygo2gZVnKT8w-1; Thu, 03 Aug 2023 00:42:53 -0400
X-MC-Unique: ll7PztUiOYygo2gZVnKT8w-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63cd05c0415so6038406d6.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 21:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691037758; x=1691642558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FQXKDg18JCYlxjQ1cLjbp+15UYaGbdekzXID4P+dfF8=;
 b=AAeBMtdIuDoo0069v4qSxSgYTHZWhJR6iNrgAnlReeNYrwSdXJEh0gGXu9t89VxjI1
 ZE6iL42vaTobZmC7v1Hs8AMcJzF8aal/dRAm3Z757WQvr5Ybrrd6X3nCdnA3PJnR3kVY
 WcLmh4L2w9S6bbspF23El41x9+z7i8vtLS8Dv2v78BOZoYjl5aUHmyk9u84qqm8XScoU
 XU2X/R38J2tnmRDjKrsPm+2z4QHMaRvhlOJxvA89BpvLaSeadeWYaSpVEqV0+kbMnXv0
 IwgGoX4DBpaStRez9krrRUSl/He7OK1ENRlh9fSpDJeQHYV/z191hEuFwugU4bI7ouem
 Yx3A==
X-Gm-Message-State: ABy/qLZoyfEPh2mljXv9L6qzI4qcRUl+kEH9BaXZwrCUG5NNQyn9LerL
 boVg8kOtd0vgq7v9Qjr7KmEyUunnJ0UJnXWJbgveeiUyIbVM2wipzcqInz55l5HCNdCY7GlU6Ls
 INZXAJPca2PsUcEk=
X-Received: by 2002:a05:6214:16d0:b0:63d:eef:c3f6 with SMTP id
 d16-20020a05621416d000b0063d0eefc3f6mr18456133qvz.38.1691037757959; 
 Wed, 02 Aug 2023 21:42:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEl3xmCAtbjixcvr70IqM53Eqmlxv1ooZ/H/jdj3dhvWhcJ1aVz7JHQQuNPSoxPlPU/uxHIuQ==
X-Received: by 2002:a05:6214:16d0:b0:63d:eef:c3f6 with SMTP id
 d16-20020a05621416d000b0063d0eefc3f6mr18456126qvz.38.1691037757695; 
 Wed, 02 Aug 2023 21:42:37 -0700 (PDT)
Received: from [192.168.8.105] (tmo-081-137.customers.d1-online.com.
 [80.187.81.137]) by smtp.gmail.com with ESMTPSA id
 x12-20020a0ce0cc000000b006263c531f61sm5999521qvk.24.2023.08.02.21.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 21:42:37 -0700 (PDT)
Message-ID: <044ceb14-e5cc-6d78-deaf-254dc3d1e170@redhat.com>
Date: Thu, 3 Aug 2023 06:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Fixed incorrect LLONG alignment for openrisc and cris
To: Luca Bonissi <qemu@bonslack.org>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Stafford Horne <shorne@gmail.com>,
 Jia Liu <proljc@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <8cca5c06-4df8-b7d4-4aee-f52f956437f8@bonslack.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <8cca5c06-4df8-b7d4-4aee-f52f956437f8@bonslack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 03/08/2023 02.29, Luca Bonissi wrote:
> From: Luca Bonissi <qemu@bonslack.org>
> Date: Thu, 3 Aug 2023 02:15:57 +0200
> Subject: [PATCH] Fixed incorrect LLONG alignment for openrisc and cris
> 
> OpenRISC (or1k) has long long alignment to 4 bytes, but currently not
> defined in abitypes.h. This lead to incorrect packing of /epoll_event/
> structure and eventually infinite loop while waiting for file
> descriptor[s] event[s].
> 
> Fixed also CRIS alignments (1 byte for all types).
> 
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>
> ---
>   include/exec/user/abitypes.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
> index 6191ce9f74..6178453d94 100644
> --- a/include/exec/user/abitypes.h
> +++ b/include/exec/user/abitypes.h
> @@ -15,8 +15,16 @@
>   #define ABI_LLONG_ALIGNMENT 2
>   #endif
> 
> +#ifdef TARGET_CRIS
> +#define ABI_SHORT_ALIGNMENT 1
> +#define ABI_INT_ALIGNMENT 1
> +#define ABI_LONG_ALIGNMENT 1
> +#define ABI_LLONG_ALIGNMENT 1
> +#endif
> +
>   #if (defined(TARGET_I386) && !defined(TARGET_X86_64)) \
>       || defined(TARGET_SH4) \
> +    || defined(TARGET_OPENRISC) \
>       || defined(TARGET_MICROBLAZE) \
>       || defined(TARGET_NIOS2)
>   #define ABI_LLONG_ALIGNMENT 4

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1770
Reviewed-by: Thomas Huth <thuth@redhat.com>


