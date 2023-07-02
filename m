Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1737744C4E
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 07:10:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFpLr-0003WN-M1; Sun, 02 Jul 2023 01:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFpLj-0003R0-EM
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFpLh-0001HE-4R
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688274612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYXEomIT88wKVu+yPUmwrshmpggd4TyAOLCQI9fe+6o=;
 b=ClpDSYAIagv/qbodJIPzrbJkRtDpcHlyriNSjiLsZK7empuCR98LwLmy7xaMOhAOgTPZxW
 otp2ra3hJnrg8uG3nmiFYQOo4a9bFSo+grlw5VbS3bWquKjxIMBCFOXXbiiyeCf3QyoPwd
 k9zxosNI0ZsqBLuTz3enq9F9MlEwJ0s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-y-NvfnMaN92Ucua3alswtQ-1; Sun, 02 Jul 2023 01:10:10 -0400
X-MC-Unique: y-NvfnMaN92Ucua3alswtQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so1743371f8f.1
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 22:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688274609; x=1690866609;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYXEomIT88wKVu+yPUmwrshmpggd4TyAOLCQI9fe+6o=;
 b=QhKyDCtCCA9nBG2gN7PHNHGuh4ajJM0Bwo1tJYOnY4J85p2MGt2xEAFJ6BQsH0qmKb
 qUX2ToXV+0T4sbCNoXx0Haz180lTZR5FixlzxJANIpxctyoEihqqUSYCifS3vXH5oIWy
 fPdIUYvBR72a9zSKwLA5BAwoh9b9uXmXZCocckADd3gK+SIFa4sph2DobWJaSDVs7zis
 CYGCs1rDAgmqx9QfBMEJIoQXIlMmPENY0Nm1EjfnJF5G/thfvrjDV6etd3rZDSxf9w1V
 qPuXTaRHx23653SpEM2yLkww35pUL/y/txhcXNTrOafnydF53jjfyOZca/0r+zR0yXEM
 DOLw==
X-Gm-Message-State: ABy/qLZ+8Zvr829DcQpZSm+5GeU2jgbdpzK6b0h7oda+pSnb5OOkL9JW
 t7RGR1BSzX867cSGmpVEGqlb3gIrWYZu2E4BYhReMqpEn0I8BhXG+W5id2OxDoPiY7mrRnSlwXS
 51dSJVt/Cyc9UtSE=
X-Received: by 2002:a05:6000:12c1:b0:314:1c96:7f3c with SMTP id
 l1-20020a05600012c100b003141c967f3cmr4438641wrx.7.1688274609576; 
 Sat, 01 Jul 2023 22:10:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE2400FljIo6WbI36LE1QjFw70pV5DN0NEiuHsPVOJR/QoyXdbStoEsU5kI2VBsrsdBW1zyaA==
X-Received: by 2002:a05:6000:12c1:b0:314:1c96:7f3c with SMTP id
 l1-20020a05600012c100b003141c967f3cmr4438631wrx.7.1688274609255; 
 Sat, 01 Jul 2023 22:10:09 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 x18-20020adff0d2000000b003141e86e751sm6416216wro.5.2023.07.01.22.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Jul 2023 22:10:08 -0700 (PDT)
Date: Sun, 2 Jul 2023 01:10:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 0/4] pci: Compare function number and ARI next function
 number
Message-ID: <20230702010655-mutt-send-email-mst@kernel.org>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230701070133.24877-1-akihiko.odaki@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jul 01, 2023 at 04:01:18PM +0900, Akihiko Odaki wrote:
> The function number must be lower than the next function number
> advertised with ARI. Add a check to enforce this.
> 
> I suggested this change at:
> https://lore.kernel.org/qemu-devel/bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com/
> 
> Implementing this change, I found the devices implementing ARI do not set the
> correct next function numbers, which is also fixed in this series.

This isn't going to be merged with more in the way of motivation.

Analysis of at least linux guest behavious, documentation about testing,
addressing migration concerns are all not there either.



> Akihiko Odaki (4):
>   docs: Fix next function numbers in SR/IOV documentation
>   hw/nvme: Fix ARI next function numbers
>   igb: Fix ARI next function numbers
>   pci: Compare function number and ARI next function number
> 
>  docs/pcie_sriov.txt |  5 +++--
>  hw/net/igb_core.h   |  3 +++
>  hw/net/igb.c        |  4 +---
>  hw/net/igbvf.c      |  5 ++++-
>  hw/nvme/ctrl.c      |  7 ++++++-
>  hw/pci/pci.c        | 15 +++++++++++++++
>  6 files changed, 32 insertions(+), 7 deletions(-)
> 
> -- 
> 2.41.0


