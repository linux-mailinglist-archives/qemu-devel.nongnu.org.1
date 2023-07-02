Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AA5744CC9
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 10:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFsgv-0004Ur-Jj; Sun, 02 Jul 2023 04:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFsgu-0004UW-06
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFsgs-0004pt-IO
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688287457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Er0m2fO6uHut4kkk/p6m2/etLa27zlPnCtqaRVHgCk8=;
 b=gYLcl/rgCHa+XE2G5uZI0fiGYS1euBwgyOGfoiilyPpVRcSWB/OiOLbNeK1y5hyiI/bYf2
 yj9jJjOmz3n/ERdi6egaW06/hLz/nqmqc82aqA/EfvATJdvS6Va/KNjlXMMyqmLqs/H8Ew
 m5iCONuTlrtGmHN/KN/S1OzTXyMbF40=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-LJBTNh7yM1KWSFLRLqU62g-1; Sun, 02 Jul 2023 04:44:16 -0400
X-MC-Unique: LJBTNh7yM1KWSFLRLqU62g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-314326f6e23so173011f8f.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 01:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688287455; x=1690879455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Er0m2fO6uHut4kkk/p6m2/etLa27zlPnCtqaRVHgCk8=;
 b=gHz3kbOj/njpoqW5lpKXS0gKv6YXvs1RHhUbrQoQqK94MKve/5fu0jb4CbLZFxnedN
 cv2Wwf2tJqIK957ch0RXKsd10GLvT3xgBVR1G9s3u+xlNZNKHRIvh1iv9wVQBQqR/5uX
 soCeYflvFPWnR9SVLBS+l/W2VPJAQ+5Pot69PZRaRCXyPYIcfyqk0lDZx3LkyAn2KzSg
 qUY/1LZ1xjoXMnJ2RTrHvCfrn5XZzAab/SIXY2mw1mHpg5am4n18PHVzOPziuMt6qSMa
 GEhUkyQRoQPmrr3nIDLI7uhYNkXoA4IE3IXiafva6S3pClbN08O1Kq5lOiMB6lz/JI0o
 onoQ==
X-Gm-Message-State: ABy/qLa4lKXcNS6dS0C6huMOegxkSSzYknkLPdhniH4MK6mPMEEeLAjG
 vhAAfoqzETav4R+3toO8sxTJZW5omqMHe5YkFppy2T4hzFDpDWRkSNdXOWVZ3jXYxe0PbpHSwzZ
 VMyj4WmrVTdyW7CY=
X-Received: by 2002:adf:e44d:0:b0:313:f97c:d87f with SMTP id
 t13-20020adfe44d000000b00313f97cd87fmr5473988wrm.67.1688287455246; 
 Sun, 02 Jul 2023 01:44:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHCWbOQ7jYZOSvXJdbgtQcjYqPsQhTTF0glSP1DgK5scdXVTy3ej2Jo2lNnKily5zJLp7hcjw==
X-Received: by 2002:adf:e44d:0:b0:313:f97c:d87f with SMTP id
 t13-20020adfe44d000000b00313f97cd87fmr5473973wrm.67.1688287454932; 
 Sun, 02 Jul 2023 01:44:14 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 a20-20020a05600c225400b003fbb06af219sm11963187wmm.32.2023.07.02.01.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 01:44:14 -0700 (PDT)
Date: Sun, 2 Jul 2023 04:44:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 0/3] pci: Fix ARI next function numbers
Message-ID: <20230702044103-mutt-send-email-mst@kernel.org>
References: <20230702083357.13517-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702083357.13517-1-akihiko.odaki@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Sun, Jul 02, 2023 at 05:33:53PM +0900, Akihiko Odaki wrote:
> The ARI next function number field is undefined for VF. The PF should
> end the linked list formed with the field by specifying 0.
> 
> Supersedes: <20230701070133.24877-1-akihiko.odaki@daynix.com>
> ("[PATCH 0/4] pci: Compare function number and ARI next function number")

changelog?

motivation?

effect on migration?

testing?


> Akihiko Odaki (3):
>   docs: Fix next function numbers in SR/IOV documentation
>   hw/nvme: Fix ARI next function numbers
>   igb: Fix ARI next function numbers
> 
>  docs/pcie_sriov.txt | 4 ++--
>  hw/net/igb.c        | 2 +-
>  hw/nvme/ctrl.c      | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> -- 
> 2.41.0


