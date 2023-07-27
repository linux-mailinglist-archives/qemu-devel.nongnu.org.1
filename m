Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B257657FA
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:45:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP37d-0000yk-Ku; Thu, 27 Jul 2023 11:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qP37b-0000yW-VZ
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:41:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qP37Y-0003R8-VV
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690472503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3twflg7qq146CAW1UkGRcyOhrEf6j72/eSiga4zvOL8=;
 b=dCAcldn+LNr5oEcOPAY+foJyLM5ei506iczNWHvwtKCRzLRs3VwcB1IcFpc1n0EsMhnMaM
 nDcgwWqXBsybqIp4QaV3xsFLlyUZpvW6Td8pB4HS0dWfUlncui8FcpiK2+cW/HEu5wbDpg
 DQitnLHIQna2WLWUSUhncQ54N495SUM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-TE_ilbIzM2yuJfz9eKR_mw-1; Thu, 27 Jul 2023 11:41:42 -0400
X-MC-Unique: TE_ilbIzM2yuJfz9eKR_mw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-993c24f3246so140418266b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 08:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690472501; x=1691077301;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3twflg7qq146CAW1UkGRcyOhrEf6j72/eSiga4zvOL8=;
 b=YmmpsIHTpzlYG2cutgWmv1pUpapEbXp4I25qxgrlpiakuiCiMCeXOof4VifGNRO4Xc
 Q1wUQWbY9MLtQ+gyrbWiXFR++rKhfbI1c0RE88OCVLEWV+j1VgOaxaGrupKN9H+xTe8x
 bPqvl5ZSyzimtb1RM+4D1KhCvDwQW/5slnbQX3ashePZ4YO6ddA6y7hF3Ji1YD0W6oYo
 CXSjtJd/vDws2VopVNk+6CC8D2MtYobmNqnvJhYPi3Jr8noSCkFO0Di3zdx2R24KwzYB
 nhdL5R/L4MD71t3ibUyeILulZU/cRnGadOnvWrkxE0CwWAMT65T3XE3zxulvavOgFcYm
 IoXA==
X-Gm-Message-State: ABy/qLallCVFCDtHQMhBb3vHkj/0bnefTAl3Lz3TOdFDQo77bz1WuFhj
 skU69j/SQKAXYyuUK8N3G9vfvZf1XYu2R/rb8fp62JfYgoQWqPZHV6btDG5WHaaZLn9Mgfzqx4u
 i/mA56FaR18NUpqg=
X-Received: by 2002:a17:907:a075:b0:99b:4bab:2841 with SMTP id
 ia21-20020a170907a07500b0099b4bab2841mr2843918ejc.26.1690472501204; 
 Thu, 27 Jul 2023 08:41:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHNOiomoD6HV4cDzzOx9/XdpV3Nx4TtXTla4iyATNjL9Fzavj9tNyT0264iy9CjstbtvMFKgA==
X-Received: by 2002:a17:907:a075:b0:99b:4bab:2841 with SMTP id
 ia21-20020a170907a07500b0099b4bab2841mr2843897ejc.26.1690472500867; 
 Thu, 27 Jul 2023 08:41:40 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a1709066d1500b009920a690cd9sm909897ejr.59.2023.07.27.08.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 08:41:40 -0700 (PDT)
Message-ID: <1c703fbb-41a9-a702-e051-ccb950cb70f6@redhat.com>
Date: Thu, 27 Jul 2023 17:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 6/9] throttle: use enum ThrottleDirection instead of
 bool is_write
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, berto@igalia.com, kwolf@redhat.com, 
 groug@kaod.org, qemu_oss@crudebyte.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com
References: <20230724100939.1022984-1-pizhenwei@bytedance.com>
 <20230724100939.1022984-7-pizhenwei@bytedance.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230724100939.1022984-7-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24.07.23 12:09, zhenwei pi wrote:
> enum ThrottleDirection is already there, use ThrottleDirection instead
> of 'bool is_write' for throttle API, also modify related codes from
> block, fsdev, cryptodev and tests.
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   backends/cryptodev.c        |  9 +++++----
>   block/throttle-groups.c     |  6 ++++--
>   fsdev/qemu-fsdev-throttle.c |  8 +++++---
>   include/qemu/throttle.h     |  5 +++--
>   tests/unit/test-throttle.c  |  4 ++--
>   util/throttle.c             | 31 +++++++++++++++++--------------
>   6 files changed, 36 insertions(+), 27 deletions(-)

[...]

> diff --git a/util/throttle.c b/util/throttle.c
> index 0439028d21..9a37209bb8 100644
> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -136,11 +136,11 @@ int64_t throttle_compute_wait(LeakyBucket *bkt)
>   
>   /* This function compute the time that must be waited while this IO
>    *
> - * @is_write:   true if the current IO is a write, false if it's a read
> + * @throttle:   throttle direction

The parameter is now named @direction, so this should be changed. (Same 
in all other comments describing functions in this patch.)

With that done (in all 4 places):

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

>    * @ret:        time to wait
>    */
>   static int64_t throttle_compute_wait_for(ThrottleState *ts,
> -                                         bool is_write)
> +                                         ThrottleDirection direction)
>   {
>       BucketType to_check[2][4] = { {THROTTLE_BPS_TOTAL,
>                                      THROTTLE_OPS_TOTAL,


