Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0173709A7F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:53:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Sq-0004ag-Gp; Fri, 19 May 2023 10:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01Si-0004B8-Aj
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01Sb-0003hs-So
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BhxSf9MG4sE+I3nZiAvxxBLABniX6x9Cgnmgp9/7iYc=;
 b=HKBYkr2MEgcZLAnaxZOX+BwhI2GC+pduxUpPPZb6VedFcNOtVQQYzb33omqbbVeDwlGGdp
 9lvyebgjOrHRN5CJH49oMZsFUDK0YzJRCJBoYwGH4qVWE+UHPMzVcd9t4olT+7LZOC22aZ
 ZPY5i6RK5LNecgvq9RBOdjUxv90H30I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-D6RHdErCOw6S6uVcFMnNAg-1; Fri, 19 May 2023 10:51:58 -0400
X-MC-Unique: D6RHdErCOw6S6uVcFMnNAg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-510d1c71b8fso3357041a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507917; x=1687099917;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BhxSf9MG4sE+I3nZiAvxxBLABniX6x9Cgnmgp9/7iYc=;
 b=T+vPArZJv74QlnC+gJyJSyDgZvY1yEcSBjEfMHf+Qj967HFBqLI2y+5D/XV6PxQagy
 ccXNX1wKbzA5iprB45YdfTfo2miyEndoSBmFf9qtKNSp0zHQU/Yp8Yfl+0UichKnXBag
 TPr6Y1AXu7Y0s/HCiRChfgckEXNk/7WeMhPFJsVQm92oXrYKj53FfSOa+IDLdSRqy6JZ
 yMtChfowDBQZzCDe36/vaZ8eZJrJZqoPNJYq3NESPCqla5SaFpip34HpU/adImUte4jI
 K9poG05/v/w1h7qc7s4Gfn5mmbAQd2LP/64GVlIMkOywfE6DAVw+1YqMBGaj/orUcnJ2
 wgSA==
X-Gm-Message-State: AC+VfDxQnFTA50gSH4PN137WxEq8bWMBi/Tn+o2VxsdXh666gkV3+fbh
 hSZymrjfhfQWkf3/p80Z8v+MCuB9hN+KdkfGyF6v53J782XtKduczH1T5F8xYmDFlTpaOUn4/It
 thmuJ3nddgMbknEo=
X-Received: by 2002:a17:907:3fa8:b0:96b:1608:3563 with SMTP id
 hr40-20020a1709073fa800b0096b16083563mr2264924ejc.58.1684507917474; 
 Fri, 19 May 2023 07:51:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xlgNRg3hkcmBF/kk1HyKNFheE87uxHPM5Qp85+OFt3V6ssCD0raP1eyMKmueqPsp3PCOQuA==
X-Received: by 2002:a17:907:3fa8:b0:96b:1608:3563 with SMTP id
 hr40-20020a1709073fa800b0096b16083563mr2264907ejc.58.1684507917161; 
 Fri, 19 May 2023 07:51:57 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:284b:5990:6336:f84f?
 (p200300cfd723b0c7284b59906336f84f.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:284b:5990:6336:f84f])
 by smtp.gmail.com with ESMTPSA id
 kl13-20020a170907994d00b00947740a4373sm2348324ejc.81.2023.05.19.07.51.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 07:51:56 -0700 (PDT)
Message-ID: <923d9425-e041-9647-9530-990f9994ad85@redhat.com>
Date: Fri, 19 May 2023 16:51:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 07/19] cutils: Adjust signature of parse_uint[_full]
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, "open list:GLUSTER" <qemu-block@nongnu.org>,
 "open list:GLUSTER" <integration@gluster.org>
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-8-eblake@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230512021033.1378730-8-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.527, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12.05.23 04:10, Eric Blake wrote:
> It's already confusing that we have two very similar functions for
> wrapping the parse of a 64-bit unsigned value, differing mainly on
> whether they permit leading '-'.  Adjust the signature of parse_uint()
> and parse_uint_full() to be like all of qemu_strto*(): put the result
> parameter last, use the same types (uint64_t is not always the same as
> unsigned long long, and mark endptr const (only latter affects the
> rare caller of parse_uint).  Adjust all callers in the tree.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   include/qemu/cutils.h         |   5 +-
>   audio/audio_legacy.c          |   4 +-
>   block/gluster.c               |   4 +-
>   block/nfs.c                   |   4 +-
>   blockdev.c                    |   4 +-
>   contrib/ivshmem-server/main.c |   4 +-
>   qapi/opts-visitor.c           |  10 +--
>   tests/unit/test-cutils.c      | 113 +++++++++++++++-------------------
>   ui/vnc.c                      |   4 +-
>   util/cutils.c                 |  13 ++--
>   util/guest-random.c           |   4 +-
>   util/qemu-sockets.c           |  10 +--
>   12 files changed, 82 insertions(+), 97 deletions(-)

[...]

> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
> index 08989d1d3ac..0c7d07b3297 100644
> --- a/tests/unit/test-cutils.c
> +++ b/tests/unit/test-cutils.c

[...]

> @@ -186,32 +176,31 @@ static void test_parse_uint_max(void)
>
>   static void test_parse_uint_overflow(void)
>   {
> -    unsigned long long i;
> -    char f = 'X';
> -    char *endptr;
> +    uint64_t i;
> +    const char *endptr = "somewhere";

The initialization here is technically not necessary because it’s reset 
above the parse_uint() call below.

Anyway:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

>       const char *str;
>       int r;
>
>       i = 999;
> -    endptr = &f;
> +    endptr = "somewhere";
>       str = "99999999999999999999999999999999999999";
> -    r = parse_uint(str, &i, &endptr, 0);
> +    r = parse_uint(str, &endptr, 0, &i);
>       g_assert_cmpint(r, ==, -ERANGE);
>       g_assert_cmpuint(i, ==, ULLONG_MAX);
>       g_assert_true(endptr == str + strlen(str));


