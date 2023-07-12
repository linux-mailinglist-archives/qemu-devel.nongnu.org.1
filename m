Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3DB7509C9
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 15:41:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJa5a-0008M1-Aq; Wed, 12 Jul 2023 09:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8b06b5fac5f44d4f4265+7262+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1qJa5V-0008Hh-Js; Wed, 12 Jul 2023 09:41:01 -0400
Received: from bombadil.infradead.org ([2607:7c80:54:3::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8b06b5fac5f44d4f4265+7262+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1qJa5S-0000me-Uf; Wed, 12 Jul 2023 09:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=jBtAqtTkPe7xSA8gIcOGPofAG5Ec6Godi3McG+Bj7TI=; b=ne4U33O6PpFN0GLvSBzWvdpMwS
 fqEB0JUvUajrnCGj0wimrRumDWvNjBni3q3H/klPnnmG4JXWtZNh2Y/Kr8ARlu6T6RA0Yo9YtWZmW
 VN5KR+qLiAlYcoVi3lgrmu+MPFVYCx1sUWGRxy9IytLpG/Q9I0LQkmPi6tAvlA5H9U2CkWaHcwM8f
 9xwHpByfBwJrELoXbx8GycAAGgOUrENgCNm4c5QZcx25O/liCF+a+4efNKt/9ndN5qMe8sUd9Pzr8
 9wCz4R6K1OrD+MGsu5s+hBG08OoMrhLMZrhPUZ2QGHJiE6d75hsds9crd8et3iAvcoi5+iwwNPmoT
 fWOo5qDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qJa4q-0005Yd-38; Wed, 12 Jul 2023 13:40:20 +0000
Date: Wed, 12 Jul 2023 06:40:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <ZK6tRDwxgbyYfv2v@infradead.org>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <CAJSP0QX5bf1Gp6mnQ0620FS61n=cY6n_ca7O-cAcH7pYCV2frw@mail.gmail.com>
 <v6xzholcgdem3c2jkkuhqtmhzo4wflvkh53nohcgtjpgkh5y2e@bb7vliper2f3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v6xzholcgdem3c2jkkuhqtmhzo4wflvkh53nohcgtjpgkh5y2e@bb7vliper2f3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2607:7c80:54:3::133;
 envelope-from=BATV+8b06b5fac5f44d4f4265+7262+infradead.org+hch@bombadil.srs.infradead.org;
 helo=bombadil.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Wed, Jul 12, 2023 at 10:28:00AM +0200, Stefano Garzarella wrote:
> The problem is that the SCSI stack does not send this command, so we
> should do it in the driver. In fact we do it for
> VIRTIO_SCSI_EVT_RESET_RESCAN (hotplug), but not for
> VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug).

No, you should absolutely no do it in the driver.  The fact that
virtio-scsi even tries to do some of its own LUN scanning is
problematic and should have never happened.

