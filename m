Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E287E0573
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 16:21:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyvym-0004Xp-Mv; Fri, 03 Nov 2023 11:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qyvyk-0004XS-WE
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qyvyj-0002jz-Hh
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699024856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uY3JrLqTqkR8utRxdyW6ukuQBPjbsg8JAOYxdKSyCn8=;
 b=BlxdbZmdL0qGU4a+qoCm6wVKo4c8AaHx0M1Z2KZzD7vKtLsavboIHPfTbiTv9Mba1rdnen
 J27J4OiP/ejPs5fMXU02OgeSYfJRo+H68j2XpPwEnMBJLFiMPHR8XDk/gPnebATdQ2fYOU
 y+rRrYzBLk4fPhDqC2DBBKpnPY3p5LY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-zVx5GKutN6uK8IX-mdRwsA-1; Fri, 03 Nov 2023 11:20:55 -0400
X-MC-Unique: zVx5GKutN6uK8IX-mdRwsA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-407d3e55927so13460275e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 08:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699024854; x=1699629654;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uY3JrLqTqkR8utRxdyW6ukuQBPjbsg8JAOYxdKSyCn8=;
 b=EXZRJWuUKDI6IbGxBY1dF8MqrzO/A2NH3RlCKGbVLb5tgjSF8s3U0Glm5iDR5XnA3t
 hWx19O2rWT8xBZcPBN4L4dumAIXMb9hVRCQ2S63Q70dVYmGj/2l0SK1MTtZtqFkCssnh
 2/k3yg9PGW0BgXNQPtLSlM15tRsEq/JtryRqddXxEZtZcxZPNhD+9WmdHEcx/kdeFF14
 8S067/8N5F4cU62Ikfy0xk47xqcYYIahtyn09reb/ud2CNJH5l8UnarIR6dKMAo+rKPg
 Xb2mueYxCaj+tAkJwS6eM0bUSon3/Uj64vnGU+Y7zeQdNMvNEiMGWr+NWUfzccjRXIF5
 TCnw==
X-Gm-Message-State: AOJu0YxH6NbCmv21UsZHfWQ7TnGru8+B0ws/ozMZAJevoh6mvgWxHnC3
 IN16jQ5UiuYAAnvTBuRZ1nGzdZxsu4eGivtjkJWFMcChOcRFVW5nijmV2UOF1aMHSirjS6D5Ab8
 b0osNZbBYBRrV1EM=
X-Received: by 2002:a05:600c:a45:b0:409:67b8:1980 with SMTP id
 c5-20020a05600c0a4500b0040967b81980mr4158347wmq.21.1699024854307; 
 Fri, 03 Nov 2023 08:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsZQd8FSRmjWWSQs3W43U80GRLGVa5eOutsCIRshRte4/a6lxbod7wAoX3JfjeHMePM5iGlg==
X-Received: by 2002:a05:600c:a45:b0:409:67b8:1980 with SMTP id
 c5-20020a05600c0a4500b0040967b81980mr4158334wmq.21.1699024853929; 
 Fri, 03 Nov 2023 08:20:53 -0700 (PDT)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 n37-20020a05600c3ba500b003fee6e170f9sm2847310wms.45.2023.11.03.08.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 08:20:53 -0700 (PDT)
Message-ID: <0b4f4294-8b01-4d6e-84a1-462d8b802062@redhat.com>
Date: Fri, 3 Nov 2023 16:20:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] iotests/common.rc: add disk_usage function
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-7-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231020215622.789260-7-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
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

On 20.10.23 23:56, Andrey Drobyshev wrote:
> Move the definition from iotests/250 to common.rc.  This is used to
> detect real disk usage of sparse files.  In particular, we want to use
> it for checking subclusters-based discards.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/250       | 5 -----
>   tests/qemu-iotests/common.rc | 6 ++++++
>   2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
> index af48f83aba..c0a0dbc0ff 100755
> --- a/tests/qemu-iotests/250
> +++ b/tests/qemu-iotests/250
> @@ -52,11 +52,6 @@ _unsupported_imgopts data_file
>   # bdrv_co_truncate(bs->file) call in qcow2_co_truncate(), which might succeed
>   # anyway.
>   
> -disk_usage()
> -{
> -    du --block-size=1 $1 | awk '{print $1}'
> -}
> -
>   size=2100M
>   
>   _make_test_img -o "cluster_size=1M,preallocation=metadata" $size
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 95c12577dd..5d2ea26c7f 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -140,6 +140,12 @@ _optstr_add()
>       fi
>   }
>   
> +# report real disk usage for sparse files
> +disk_usage()
> +{
> +    du --block-size=1 $1 | awk '{print $1}'

Pre-existing, but since you’re touching this now: Can you please change 
the $1 to "$1"?

Hanna

> +}
> +
>   # Set the variables to the empty string to turn Valgrind off
>   # for specific processes, e.g.
>   # $ VALGRIND_QEMU_IO= ./check -qcow2 -valgrind 015


