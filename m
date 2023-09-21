Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B88ED7A9584
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 17:27:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjLZH-0008Fo-Bf; Thu, 21 Sep 2023 11:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qjLZD-0008Fb-18
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qjLZ8-00084l-M3
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695309964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lEVCAjk9PCZb4ufnP17EEPGzqHexmR/+y4/bxTQbhHI=;
 b=dQsZKiXsJAjg49crAvQZvXy47yx5a+lyUSaJoycAUAmGzEsbXYDjBpJU7JCnZ1gDZ/9PuC
 0tKzuNg8H/ejzSbqnY2VdCcgPI2+bqsr68d5OklKpmL+xL+N+Aq9Z9Lqbr7KyRGb8QW6GX
 TedvyFn6yfwlIuHaz4NwYtpamNrnFBk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-5HN0fiLiN2uesp1yL5iARw-1; Thu, 21 Sep 2023 11:26:01 -0400
X-MC-Unique: 5HN0fiLiN2uesp1yL5iARw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 465FE3C0DF90;
 Thu, 21 Sep 2023 15:26:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 014A010F1BE7;
 Thu, 21 Sep 2023 15:25:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6952818007AA; Thu, 21 Sep 2023 17:25:58 +0200 (CEST)
Date: Thu, 21 Sep 2023 17:25:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, devel@edk2.groups.io, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Ard Biesheuvel <ardb+tianocore@kernel.org>, 
 Sami Mujawar <sami.mujawar@arm.com>
Subject: Re: EDK2 ArmVirtQemu behaviour with multiple UARTs
Message-ID: <b7wuvs5qtdvjzb5getkggsi772gqvmb4xnuhq4ssxdu5lgiyi7@nprpol5z2t5u>
References: <CAFEAcA_P5aOTQnM2ARYgR5WvKouvndMbX95XNmDsS0KTxMkMMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_P5aOTQnM2ARYgR5WvKouvndMbX95XNmDsS0KTxMkMMw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Sep 21, 2023 at 11:50:20AM +0100, Peter Maydell wrote:
> Hi; I've been looking again at a very long standing missing feature in
> the QEMU virt board, which is that we only have one UART. One of the
> things that has stalled this in the past has been the odd behaviour of
> EDK2 if the DTB that QEMU passes it describes two UARTs.

Note that edk2 recently got support for virtio-serial, so you can use
that for the console and leave the uart for debug logging.  The prebuild
edk2 binaries in qemu have been updated days ago and these already
support for virtio-serial..

take care,
  Gerd


