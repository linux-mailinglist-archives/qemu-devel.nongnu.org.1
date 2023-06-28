Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B48F741080
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:55:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETkz-0002yZ-2d; Wed, 28 Jun 2023 07:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qETkw-0002yC-5c
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qETku-0003aY-F3
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687953279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n6Yd39jQiIfXzajqxx7OTS1pjn86kSe493yHFqEn7Gg=;
 b=RR/lkwxeegr2LYBMHMTQ/R1TAfRid3MZhaSXnno7n/WZPGBn8Aj8EAGNGPFlfSO6ylgbNL
 gtLZp1A1MmVHk9ZojMQ+9aUjHE75iUqkIJhLQiV7Zg3+psGzpKNdHyfHWYCa1nt8BOhd9M
 01xdOOhyHOGqT5qea1DBfv/OgmOqt0I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-NUI7ULGePoeXtj_dJQUQ-A-1; Wed, 28 Jun 2023 07:54:37 -0400
X-MC-Unique: NUI7ULGePoeXtj_dJQUQ-A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-313f59eba37so1367698f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 04:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687953276; x=1690545276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6Yd39jQiIfXzajqxx7OTS1pjn86kSe493yHFqEn7Gg=;
 b=M0lSzdUxKnNdjmwJZ55NDaFj7LvwzQVK3qlEUedp5EeTGzjr9gQKLGdRL3tPnSNTKl
 1J9RL6ubRWI36qnYBTmj8AY1H5ssOAG/en7yx8zzD5hNgP+w/YHR5HCpFFyMCFNaPlZR
 5FquZcWTAlbaLUEmZjihXz6BKhDQMywtmrrFTOjqwHTZnxvB99Z2m3MJnxeFdgsz/kHT
 0D1crrZ+w2p+lzclTzfmZqIpnLpgs7zM5pio7osYj0uZ4sk/34owKGiRVeFD0O/6P6lt
 FUiRDdUwADUJKfwhrXJmvPJmqYxqzXe/ydGpYqR3PUHq+Mqf13pU+fGgRppzw8AdTEpO
 VcCA==
X-Gm-Message-State: AC+VfDzP+rR4xX4TxPsdYKpKXW7Eh9MS8ZVS/cgSDcVNL71c5BrTZh5F
 g4oCAN7BXSVzwYLT+EaERzE+8hChBq0xLWIvxjHCdvzu8XKkLnnkx+QR4TaM3n7cNRfnV3uIi5t
 V1Cv712KMcIyOiCL1caza0XC6xyzsqb6DruuBrI8A1QlhgB0Q40dbvPq2DpF52ID/g7KN9dE=
X-Received: by 2002:adf:d84f:0:b0:313:ea8f:30a5 with SMTP id
 k15-20020adfd84f000000b00313ea8f30a5mr7984074wrl.23.1687953276039; 
 Wed, 28 Jun 2023 04:54:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ77SAU/Z1m/QUQnb2u2EeXr5n4C9sZsK2waNPg+nV+MrhSma3XZCpW7bdzEgrZL8TrvrvyUIQ==
X-Received: by 2002:adf:d84f:0:b0:313:ea8f:30a5 with SMTP id
 k15-20020adfd84f000000b00313ea8f30a5mr7984063wrl.23.1687953275750; 
 Wed, 28 Jun 2023 04:54:35 -0700 (PDT)
Received: from redhat.com ([176.12.183.225]) by smtp.gmail.com with ESMTPSA id
 w7-20020a5d4047000000b003063772a55bsm13126238wrp.61.2023.06.28.04.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 04:54:35 -0700 (PDT)
Date: Wed, 28 Jun 2023 07:54:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/1] virtio: regression fix
Message-ID: <20230628075419-mutt-send-email-mst@kernel.org>
References: <cover.1687952477.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687952477.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 28, 2023 at 07:41:34AM -0400, Michael S. Tsirkin wrote:
> The following changes since commit a0d7215e339b61c7d7a7b3fcf754954d80d93eb8:
> 
>   vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is present (2023-06-26 09:50:00 -0400)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 0585e97f070014265e5ec3b28d27dcb963cde25b:

ca3fcdeeeef56f46a7ac7b2408eda608d59be6f1 now - added reviewed by tags.

>   net/vhost-net: do not assert on null pointer return from tap_get_vhost_net() (2023-06-28 07:38:59 -0400)
> 
> ----------------------------------------------------------------
> virtio: regression fix
> 
> A regression was introduced in the last pull request. Fix it up.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Ani Sinha (1):
>       net/vhost-net: do not assert on null pointer return from tap_get_vhost_net()
> 
>  hw/net/vhost_net.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 


