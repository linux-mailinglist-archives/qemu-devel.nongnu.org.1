Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F08F7DCEA1
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:05:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpN8-0003tQ-4y; Tue, 31 Oct 2023 10:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxpMv-0003sK-Gb
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxpMt-0002kU-AH
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698761118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAcmM2uex8DOK3ABPpWS2N6eTCTzhqgp2427GSg1JH0=;
 b=hy237m888UBd4J0J+p/JsMAjLzjs6ZUckWnVhK1IrNj2xRZ/EmL9wvko3wHfObJBwEDKqY
 s/axyF1AoQ5U0aEsX9g/LNYobQZZuf1GI5AmmHO1Ye6EuPXeUP7BQszuX4lOM0cuEWaHWk
 MS3D9Fv2C4uhqpxYWq6KQgew7e0TUl0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-QWXQU010N6ir_aYO93gCDA-1; Tue, 31 Oct 2023 10:05:16 -0400
X-MC-Unique: QWXQU010N6ir_aYO93gCDA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32de9f93148so3110324f8f.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698761115; x=1699365915;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UAcmM2uex8DOK3ABPpWS2N6eTCTzhqgp2427GSg1JH0=;
 b=VoZWeK3ZRHZl/sAmiBJ5xtC4CZGMgTVmLFAB9dFuBAJ8OdTpK7D1kwD4A4qpAnhBxX
 7NkXKqkGY2o785xUwntVNSPGLrr/176zMgFXt4puBzJGdQXjYAQMZiZrnuZ/ifTNBov0
 fOgDqEMqWmEHkMDVkcIVRa3P/jW5U5EuuONlz8fzOzm0iStZuF6OoQEnxl4Y2/aZZi0g
 aJuZRm2X1vhbKbD/ZGp8yk8j52sgyHJkz9WTACqxYcsTY5oH3jBcR/BX+ydqRNsR5mQZ
 MVUMJ7Rbv67yzCywWqvRRSpNGFikghZtuW3Uf790VuO/CyUc1S1Wbis0vRRxz4auo2RN
 gCrQ==
X-Gm-Message-State: AOJu0YzQio96k95is6nzpR8Pb45AfO6KnCuCB8mjWJcv/mrA0bHrC7C6
 9YPtTilGBlkkZ2onOsHovWaaSpaN9EcS5QYNQ9BsuN+6Xmp+tBLg3tENyupRzJzkwnl8pZUerSu
 zc/640Ollb5SMjEc=
X-Received: by 2002:a05:600c:35cb:b0:406:44e6:c00d with SMTP id
 r11-20020a05600c35cb00b0040644e6c00dmr11053462wmq.2.1698761115708; 
 Tue, 31 Oct 2023 07:05:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1u8kXI+01CxfO+F9tV/BDdOwCMUaiBEiW7i9/Z/FFUH5Lzox0F/T2vqKtivwW12Qj+K9u4w==
X-Received: by 2002:a05:600c:35cb:b0:406:44e6:c00d with SMTP id
 r11-20020a05600c35cb00b0040644e6c00dmr11053433wmq.2.1698761115282; 
 Tue, 31 Oct 2023 07:05:15 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 k20-20020a05600c479400b004064288597bsm1798618wmo.30.2023.10.31.07.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 07:05:14 -0700 (PDT)
Message-ID: <fd7da9d6-be5a-40f7-9c59-593ac8de41d1@redhat.com>
Date: Tue, 31 Oct 2023 15:05:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block-jobs: add final flush
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 Evanzhang@archeros.com, den@openvz.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20231004135632.18196-1-vsementsov@yandex-team.ru>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231004135632.18196-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 04.10.23 15:56, Vladimir Sementsov-Ogievskiy wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Actually block job is not completed without the final flush. It's
> rather unexpected to have broken target when job was successfully
> completed long ago and now we fail to flush or process just
> crashed/killed.
>
> Mirror job already has mirror_flush() for this. So, it's OK.
>
> Add similar things for other jobs: backup, stream, commit.
>
> Note, that stream has (documented) different treatment of IGNORE
> action: it don't retry the operation, continue execution and report
> error at last. We keep it for final flush too.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>
> Was: [PATCH v4] block-jobs: flush target at the end of .run()
>    But now rewritten.
> Supersedes: <20230725174008.1147467-1-vsementsov@yandex-team.ru>
>
>   block/backup.c             |  2 +-
>   block/block-copy.c         |  7 +++++++
>   block/commit.c             | 16 ++++++++++++----
>   block/stream.c             | 21 +++++++++++++++++----
>   include/block/block-copy.h |  1 +
>   5 files changed, 38 insertions(+), 9 deletions(-)

[...]

> diff --git a/block/commit.c b/block/commit.c
> index aa45beb0f0..5205c77ec9 100644
> --- a/block/commit.c
> +++ b/block/commit.c

[...]

> @@ -187,7 +187,15 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>           }
>       }
>   
> -    return 0;
> +    do {
> +        ret = blk_co_flush(s->base);
> +        if (ret < 0) {
> +            action = block_job_error_action(&s->common, s->on_error,
> +                                            false, -ret);
> +        }
> +    } while (ret < 0 && action != BLOCK_ERROR_ACTION_REPORT);

Do we need to yield in this loop somewhere so that 
BLOCK_ERROR_ACTION_STOP can pause the job?

Hanna


