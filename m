Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AF379A8E8
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 16:47:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfiBV-0008Ri-Lt; Mon, 11 Sep 2023 10:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qfiBU-0008Q3-Hy
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qfiBS-0007DU-F6
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694443596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HD4Fdvg7rfOlXWL1oGmxg5INWEg59tdPrEszeSd4pUU=;
 b=XcaHCYr3KNuhSWJK/4s7UnHW4PHTdjb3B5+Tr13YktlkBnfC0yc3fD/eeTNqUzFkuz3hJ3
 Kqrl9ehP4Cwi3gd+vS35kdrhkdECJTfyUSQHHZ9G/jqRAZu2duUfZ1BS+cI/bDVQ6tcgFl
 I4PkWvS7mgPdhdUxmR+fTbsP9eQCcxU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-0soXbQtLM3-U9yIk-jegPQ-1; Mon, 11 Sep 2023 10:46:32 -0400
X-MC-Unique: 0soXbQtLM3-U9yIk-jegPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97957101A529;
 Mon, 11 Sep 2023 14:46:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63F702156701;
 Mon, 11 Sep 2023 14:46:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 261AA1800850; Mon, 11 Sep 2023 16:46:31 +0200 (CEST)
Date: Mon, 11 Sep 2023 16:46:31 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/6] misc tweaks for kvm and the 64bit pci window
Message-ID: <o75td5j4ajuejtgahkoqmdylqi7xcfywmv5cbsiikfiskhi2uy@3lv5idp2n7ee>
References: <20230824085756.66732-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824085756.66732-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 24, 2023 at 10:57:50AM +0200, Gerd Hoffmann wrote:
> v4 changes:
>  - fix handling of 32bit memory bars.
> v3 changes:
>  - rename variables, use u8 for CPULongMode.
> v2 changes:
>  - e820 conflict fix
> 
> Gerd Hoffmann (6):
>   better kvm detection
>   detect physical address space size
>   move 64bit pci window to end of address space
>   be less conservative with the 64bit pci io window
>   qemu: log reservations in fw_cfg e820 table
>   check for e820 conflict

Patch series committed now.

take care,
  Gerd


