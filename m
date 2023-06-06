Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9824724470
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 15:30:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Wl8-0005HA-7f; Tue, 06 Jun 2023 09:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6Wl5-0005Du-FE
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6Wl2-0004Fa-VX
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686058195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5TPZuNu5CrN3WtPbVpIabLG73lAPGlRGkFCLedHFMI=;
 b=gTlXnY+KzqZYd0IaWsREW2/fGLYDGa7RykbJx5JDSmkAXxMmhO52qFkkml7crv2YN6BVHY
 hOipFC16acXb2aDH9MKCikukUlb6CpULhUhflUIk2sAlTR0NIRi1nfP2zNM7sX+tTnoGcm
 Q6r3WoFLm+e2ktnoypVUBIMpcY/FlE8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-_dfwG7zxOtyUmx2fk1G26A-1; Tue, 06 Jun 2023 09:29:54 -0400
X-MC-Unique: _dfwG7zxOtyUmx2fk1G26A-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-75d461f9457so454071685a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 06:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686058194; x=1688650194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5TPZuNu5CrN3WtPbVpIabLG73lAPGlRGkFCLedHFMI=;
 b=gSEEM/ku7v1BcYCfV46RTJ5cPL9oRZeT/xBNOconF+MtJ4p7e3oEoeJGFDVSyXLYUP
 8KbInL7duyrNVFh++UtPUfOLHrlwnwDy0PusbpTRtRV+TrthelwnE8EO60WGw2CZZO0S
 aHlnjxv2xYhjY3P20Hn1h/35PPy/BppWtNdT5AnNvLR2Z4ZMKUuKMy2kH+oodw7ZIFu1
 g+vGEBkeUt/udfIvl0ooSLtAeU7T++K18OEmQpcxMku2UqnTFqHTMpR30CwekGMJQ3C/
 fAhCgjd0QdpkCsG+7DtfGH5PyI3FBIs9AMr0UB1s6UGVQ7NBjALjUPltOFkaEfh/hPKi
 1yBQ==
X-Gm-Message-State: AC+VfDyRuBTg7iH0FpFvasT65ClgDoi8v7RPaOYV9Z9XTNqN6oy+bZ2P
 ifNojz0YqQfGaCa3IxONSpmnpY1o6HyYg90MaAMeLfOKQ0ZRm2pEzd+Ix7Ea0TEGQgz48BTZBY0
 KiGFpYnrrNylDHoI=
X-Received: by 2002:a05:620a:6790:b0:75e:cc54:7d54 with SMTP id
 rr16-20020a05620a679000b0075ecc547d54mr1507454qkn.31.1686058194274; 
 Tue, 06 Jun 2023 06:29:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4O7mAg6me2K4Mk+VbnnmqyoAY03iQL/dMcYJndulq6b1h07H4+I+F0sgcGpo+X71gZbG3VRA==
X-Received: by 2002:a05:620a:6790:b0:75e:cc54:7d54 with SMTP id
 rr16-20020a05620a679000b0075ecc547d54mr1507394qkn.31.1686058193183; 
 Tue, 06 Jun 2023 06:29:53 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-u.redhat.com.
 [213.175.37.12]) by smtp.gmail.com with ESMTPSA id
 s17-20020ae9f711000000b007592f2016f4sm4889137qkg.110.2023.06.06.06.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 06:29:52 -0700 (PDT)
Date: Tue, 6 Jun 2023 15:29:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1E?=
 =?UTF-8?B?YXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>
Subject: Re: [PATCH] hw: Fix format for comments
Message-ID: <20230606152949.1aad469e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230515072525.886221-1-shahuang@redhat.com>
References: <20230515072525.886221-1-shahuang@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 15 May 2023 03:25:25 -0400
Shaoqin Huang <shahuang@redhat.com> wrote:

> Simply fix the #vcpus_count to @vcpus_count in CPUArchId comments.

> Since
> we are at here, resort the parameters in comments to match the sequence
While at it, reorder ...
                   
> of parameters which defined in the CPUArchId.
> 
> CC: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>

with commit message fixed up
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/boards.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index f4117fdb9a..cefa3d5897 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -101,10 +101,10 @@ MemoryRegion *machine_consume_memdev(MachineState *machine,
>  /**
>   * CPUArchId:
>   * @arch_id - architecture-dependent CPU ID of present or possible CPU
> + * @vcpus_count - number of threads provided by @cpu object
> + * @props - CPU object properties, initialized by board
>   * @cpu - pointer to corresponding CPU object if it's present on NULL otherwise
>   * @type - QOM class name of possible @cpu object
> - * @props - CPU object properties, initialized by board
> - * #vcpus_count - number of threads provided by @cpu object
>   */
>  typedef struct CPUArchId {
>      uint64_t arch_id;


