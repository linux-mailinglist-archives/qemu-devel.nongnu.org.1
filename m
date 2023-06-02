Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A837204D8
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:49:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q565B-0001tw-El; Fri, 02 Jun 2023 10:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q5653-0001b8-FX
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:48:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q5652-0007K1-05
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685717319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSXIPk4zvdFvGQz3mC+FxUjGVWna4Gv8Jb3AtN6FTxc=;
 b=P91jcebZ/WwBF8M+APSPvs3hCNZ9Cp9a/3po/9wb7sj13aX708+vxoPzJu3gUsMR7M9LAF
 mYHlvCWP6fs2lTFdEJNsStviGqPZIcm2KRp6p87pXwOnlRs25DdpS+/tNLak6YMzUbQdIs
 R7J2fl0u9mw0PcInAs+tOyru6/G90Bc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-HeoiBX7_M72XqVcVEu0KZQ-1; Fri, 02 Jun 2023 10:48:37 -0400
X-MC-Unique: HeoiBX7_M72XqVcVEu0KZQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a356c74e0so153553766b.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 07:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685717316; x=1688309316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VSXIPk4zvdFvGQz3mC+FxUjGVWna4Gv8Jb3AtN6FTxc=;
 b=Az7zuBLpZNJ172DyiqEkScqg90O3hPtEXjzoFwj44m5tmUsUzE1AM8T4uhz3pIJNfx
 iA9aRRvwj5KO4aU23FGbhwpJgx7A8YhNCXQ6kMw/qqF02jg+2Ce2BLGTjKzoIC6Jh8DS
 8uhRAqew2sfuYEy6xRcs82LqLU9GPSaqdkpuJ0EnKT0erGF31qAP5q79IwK1knUf/Gro
 4f752/PXAaHYk8E9rESGTjl5tNtZ88eam1BWd/ewBwSDui3K5El+rJFHUTu28E+8Aw41
 nhtjet+Kvtl6H1Ckq8RhKDozBEa0cFONQR26EDbLBh1xUdMDaQYWusSYCZoAqjTsbzTg
 kVOg==
X-Gm-Message-State: AC+VfDzFg7QuQcb3V+r7rC9xSqFFZSVh99G2Naqpy8/FoapJ/js24LHy
 1uNNXQCGUBNFChBXSNdLZOhmU0B2nKlMqrQ8yQb5amgM/ytio0vKtSycRBvIzQrG8FEs1hzh0kN
 iosxJA2SI6I0HCic=
X-Received: by 2002:a17:906:da8e:b0:96a:3119:ac0 with SMTP id
 xh14-20020a170906da8e00b0096a31190ac0mr9949677ejb.69.1685717316408; 
 Fri, 02 Jun 2023 07:48:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5aAPNhddlDRW8S63R5C7ln+dYFmhcITpuDMTw2fAbdo8xA84MB6Jgt8UyUsbnYKD4t00tZQg==
X-Received: by 2002:a17:906:da8e:b0:96a:3119:ac0 with SMTP id
 xh14-20020a170906da8e00b0096a31190ac0mr9949665ejb.69.1685717316156; 
 Fri, 02 Jun 2023 07:48:36 -0700 (PDT)
Received: from ?IPV6:2003:cf:d72e:f7e0:e1ec:6307:c799:c188?
 (p200300cfd72ef7e0e1ec6307c799c188.dip0.t-ipconnect.de.
 [2003:cf:d72e:f7e0:e1ec:6307:c799:c188])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a170906a00500b0096f641c6167sm829308ejy.181.2023.06.02.07.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 07:48:35 -0700 (PDT)
Message-ID: <9c89f136-4ab9-d6bc-e4c4-2dda3505cdff@redhat.com>
Date: Fri, 2 Jun 2023 16:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 4/5] parallels: Replace fprintf by qemu_log in check
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
 <20230529151503.34006-5-alexander.ivanov@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230529151503.34006-5-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 29.05.23 17:15, Alexander Ivanov wrote:
> If the check is called during normal work, tracking of the check must be
> present in VM logs to have some clues if something going wrong with user's
> data.

I understand stderr counts as part of the VM log, doesn’t it?  I thought 
stderr is generally logged, and naïvely, it seems like the better fit to 
me, because it conveys more urgency than the standard log (which, 
judging from its callers, looks mostly like a debug log).

Hanna

> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> Reviewed-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)


