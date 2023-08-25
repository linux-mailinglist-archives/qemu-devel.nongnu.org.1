Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DC9788C41
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 17:15:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZYVs-0000QM-Q2; Fri, 25 Aug 2023 11:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZYVp-0000QC-CI
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZYVl-00056C-Mo
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692976448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tunp69SOLVm0fOvag7etUUrPDVIyy7U6xEqw+3q+kGI=;
 b=dd00Uiwut5VGEcWKN7wnsXi5xmuVPmmtqtNTByBer2itPUi/i20ZlScu25su+aQ/qwxi2S
 hsM6VNqQawYavGgrjvAPzcx0wt9JtKurPaQYZY66xnu74N9qllpLuo2oGz7oGYaN2DuqaG
 yGOuoYFUQOe1KXxZdw/1Upvx7uYlxS0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-yQ__AgoWMgut92lbkmpMGg-1; Fri, 25 Aug 2023 11:14:06 -0400
X-MC-Unique: yQ__AgoWMgut92lbkmpMGg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-521da4c99d4so926971a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 08:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692976445; x=1693581245;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tunp69SOLVm0fOvag7etUUrPDVIyy7U6xEqw+3q+kGI=;
 b=FLfL1eovHXC4fVZaBifTqYthAyviAQeKIoKwpteZDJgktKvSe2xNKGlRFe63ugOzMe
 absKRS0/6recqNAVSV5qCsedu81NwifQsawriDUCifRBcVKeLNhpSt57IM8QWe9DgChq
 VHV6Kw2dNeJRxy39g+F/9knOicZf2lIX1YuQtjhZzVs8vp67U5SKJIN8Y1RBIPaSNbxC
 JgNAKDM6Ii2rffN3KhqqH71HEaGwPUrlLlb19ZzHLH2L7b0fPq3vfwksfwYjaOeWxI98
 06bzen45DzDA1zKDnB2vj/L7LffW/cs0ZvQi41yeex3Ttr3t21FKdDyqpLUI/dZVlU47
 N0IA==
X-Gm-Message-State: AOJu0YwoUS1xx8Vx5hJzr7cUWd3zdsnW6pKUNU3EPBzW+1H+YMdnqVAZ
 HRF6CkcGoUrbx1TQCM2Bb55DkCHTDgeagQ3UtxcRsz7xBlVDXoqIWqewwYP0BjbEY6R9aO6fmRi
 V9nI7kVrWe1Bu2J0=
X-Received: by 2002:a17:906:5a5d:b0:9a1:edfd:73b2 with SMTP id
 my29-20020a1709065a5d00b009a1edfd73b2mr6001877ejc.2.1692976445443; 
 Fri, 25 Aug 2023 08:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyX4oqoYjEdZfM5LG/3rUQTD0iWVipRiNFxSrP7/T4W2xJs2/Pn5eq6Q9r+eCoQRFHDYXGOw==
X-Received: by 2002:a17:906:5a5d:b0:9a1:edfd:73b2 with SMTP id
 my29-20020a1709065a5d00b009a1edfd73b2mr6001859ejc.2.1692976445128; 
 Fri, 25 Aug 2023 08:14:05 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37?
 (p200300cfd70f5ee06d7a84866b838d37.dip0.t-ipconnect.de.
 [2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a170906395800b00993b381f808sm1058910eje.38.2023.08.25.08.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 08:14:04 -0700 (PDT)
Message-ID: <d6d14b11-fcf3-7306-c421-3fe7328dc47a@redhat.com>
Date: Fri, 25 Aug 2023 17:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] qemu-img: add compression option to rebase subcommand
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-6-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230601192836.598602-6-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.57, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 01.06.23 21:28, Andrey Drobyshev via wrote:
> If we rebase an image whose backing file has compressed clusters, we
> might end up wasting disk space since the copied clusters are now
> uncompressed.  In order to have better control over this, let's add
> "--compress" option to the "qemu-img rebase" command.
>
> Note that this option affects only the clusters which are actually being
> copied from the original backing file.  The clusters which were
> uncompressed in the target image will remain so.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   docs/tools/qemu-img.rst |  6 ++++--
>   qemu-img-cmds.hx        |  4 ++--
>   qemu-img.c              | 19 +++++++++++++++++--
>   3 files changed, 23 insertions(+), 6 deletions(-)

Interesting.  I was about to protest because we only really support 
writing compressed clusters to new and empty images, so the qcow2 driver 
does not allow overwriting existing clusters with compressed data.  But 
by design we skip all clusters that are anything but unallocated in the 
top image (i.e. the one we are going to write to), so this should indeed 
work out well.

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 15aeddc6d8..973a912dec 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -663,7 +663,7 @@ Command description:
>   
>     List, apply, create or delete snapshots in image *FILENAME*.
>   
> -.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] -b BACKING_FILE [-F BACKING_FMT] FILENAME
> +.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] [-c] -b BACKING_FILE [-F BACKING_FMT] FILENAME
>   
>     Changes the backing file of an image. Only the formats ``qcow2`` and
>     ``qed`` support changing the backing file.
> @@ -690,7 +690,9 @@ Command description:
>   
>       In order to achieve this, any clusters that differ between
>       *BACKING_FILE* and the old backing file of *FILENAME* are merged
> -    into *FILENAME* before actually changing the backing file.
> +    into *FILENAME* before actually changing the backing file. With ``-c``

“With the ``-c`` option specified, [...]”

> +    option specified, the clusters which are being merged (but not the
> +    entire *FILENAME* image) are written in the compressed mode.

“[...] are compressed when written.”

>       Note that the safe mode is an expensive operation, comparable to
>       converting an image. It only works if the old backing file still


