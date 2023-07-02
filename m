Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E67744DA2
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 14:44:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFwQS-0002RV-Du; Sun, 02 Jul 2023 08:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFwQO-0002QY-O6
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 08:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFwQN-000641-8t
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 08:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688301810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HTruH8z8mVnt+uJIEUxNX1yo4B7p96vvYy4M4kNWLqY=;
 b=G12Znu89dmBxliDE10uved3KnWv+W8Nx3MlG6fHa4ZNXmtQNeadZu8vdIijSwuXHGWDEAJ
 deTFzXW2UXxzPPV6roEuJKlzAA08//y2C8mVQa+fTgkO2MGRai30M85GrUiTK00LMWbr2+
 g6Jp6qcG4m4H/JaMlCdPxU5vFfVEaQ0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-cF5BlTmJNiSjk9d6k9xiew-1; Sun, 02 Jul 2023 08:43:28 -0400
X-MC-Unique: cF5BlTmJNiSjk9d6k9xiew-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9932bf9a1e8so67263666b.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 05:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688301807; x=1690893807;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTruH8z8mVnt+uJIEUxNX1yo4B7p96vvYy4M4kNWLqY=;
 b=HJeS5mh0zTOuwApTotwD7PftBpK6IreO4ANMuQRT2NwHJg192zX/LKwHC1kY9YEB56
 AjoNDnlit2HxUFCEhEzOSChRh6iMenQFYvaMGrsvO6p5kd+Mmuxj8CUp5dYmYFnRdpcT
 5xaH2HXaCwQuqnL6uSLqQrCtj3rVwpG3wsl9mW8CnqehpKhxQ+/+cwF0Srk02IH6rhsZ
 vdX5bROp9eL3SUKfGQfLUTk7yuAvoJKcpX2k8ugG2o8Hw7CU9+92ATXy3Jkw96X5zs5j
 vgSoaHoGZb/6wu2oC4Cl2SQTVTGGzczeH6t1onh/qwHnxeA+sti+9t2ZsMeRjn98GPsY
 NIxg==
X-Gm-Message-State: AC+VfDw9Lraka8+cwvOf296kgytjqwL8Va1xA28MZ+nKqp0i+qGtIYLL
 Kls0Hr+lFjFi9rD5DQVtVmQ4k4lEpYbyfC6Rr6xFYjHK+5tWGF8XsizNqO0OOapmO9k+I3inOua
 dL8RANp3v6whYCvk=
X-Received: by 2002:a17:906:7e0b:b0:992:c5ad:18bc with SMTP id
 e11-20020a1709067e0b00b00992c5ad18bcmr5145999ejr.70.1688301807655; 
 Sun, 02 Jul 2023 05:43:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEXXNCQLM+K6Yl8Buv3eb9GpsUy2a2ULde/IY17gmPzEw06TB5+xw+ZU0UeP1JXRh4yTUBlGw==
X-Received: by 2002:a17:906:7e0b:b0:992:c5ad:18bc with SMTP id
 e11-20020a1709067e0b00b00992c5ad18bcmr5145987ejr.70.1688301807398; 
 Sun, 02 Jul 2023 05:43:27 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 a10-20020a17090640ca00b0098e025cda3bsm10386293ejk.141.2023.07.02.05.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 05:43:26 -0700 (PDT)
Date: Sun, 2 Jul 2023 08:43:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v3 0/2] pcie: Fix ARI next function numbers
Message-ID: <20230702084251-mutt-send-email-mst@kernel.org>
References: <20230702120229.66978-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702120229.66978-1-akihiko.odaki@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Jul 02, 2023 at 09:02:25PM +0900, Akihiko Odaki wrote:
> The ARI next function number field is undefined for VF. The PF should
> end the linked list formed with the field by specifying 0.
> 
> Supersedes: <20230701070133.24877-1-akihiko.odaki@daynix.com>
> ("[PATCH 0/4] pci: Compare function number and ARI next function number")

Thanks! How was this patch tested?


> V2 -> V3:
>   Moved the logic to PCI common infrastucture (Michael S. Tsirkin)
> 
> V1 -> V2:
>   Fixed migration. (Michael S. Tsirkin)
>   Added a caveat comment. (Michael S. Tsirkin)
> 
> Akihiko Odaki (2):
>   pcie: Use common ARI next function number
>   pcie: Specify 0 for ARI next function numbers
> 
>  docs/pcie_sriov.txt   | 4 ++--
>  include/hw/pci/pci.h  | 2 ++
>  include/hw/pci/pcie.h | 2 +-
>  hw/core/machine.c     | 1 +
>  hw/net/igb.c          | 2 +-
>  hw/net/igbvf.c        | 2 +-
>  hw/nvme/ctrl.c        | 2 +-
>  hw/pci/pci.c          | 2 ++
>  hw/pci/pcie.c         | 4 +++-
>  9 files changed, 14 insertions(+), 7 deletions(-)
> 
> -- 
> 2.41.0


