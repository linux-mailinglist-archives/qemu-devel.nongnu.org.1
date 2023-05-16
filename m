Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 748D270508D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 16:25:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyvcM-0003D1-07; Tue, 16 May 2023 10:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4936e02c6=anthony.perard@citrix.com>)
 id 1pyvcI-0002vi-1u; Tue, 16 May 2023 10:25:30 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4936e02c6=anthony.perard@citrix.com>)
 id 1pyvcA-0002Vh-3z; Tue, 16 May 2023 10:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1684247121;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aGmtyziSnn1Gib25HiVVWwKSGRKb01gX2nE2o8MoFMc=;
 b=UKbEmkEmnS4l2qBZznogsxK2xqqTkCaG93Q4nYnXdoQfo203jUs+1KPj
 nAnSBWoD5DWqB4AL075i0bmlLuT87vxCMinWWnyVT6ffYMDiAx5MD5gej
 SLlLU60QvyeHQ2k8NTGf8G8FTNwLjD02rE/U590kEQSVQ/NU66cPxpJNF w=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 107984133
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:WUeaxazOHDDjFqrAnGB6t+fkwCrEfRIJ4+MujC+fZmUNrF6WrkVSx
 mMbC2mAO/ePY2GmKtlzPt7i9x4D7JKAyodrSgptqSAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTrafYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw//F+UIHUMja4mtC5QRjPK4T5jcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KVtW8
 aQDJSJUV0C8he+U6umpTbVVnMt2eaEHPKtH0p1h5TTQDPJgSpHfWaTao9Rf2V/chOgXQ6yYP
 ZBAL2MyMlKZOUYn1lQ/UfrSmM+hgGX/dDtJ7kqYv6Mt70DYzRBr0airO93QEjCPbZwNwRfI+
 judpAwVBDkTL/CG8Xm70UijqeHuohjlYpMxFuGno6sCbFq7mTVIVUx+uUGAieKlh0C3XdJWA
 1YZ9ionse4580nDZtf0WjW1vWaEuRhaXddMe8Ug6gaLx7H8+QuVBmEYCDVGbbQOrdI3QyAn0
 lahhd7lBTVz9raSTBq1+7qPtTSpODQ9N2IOZSYYCwAC5rHLsIw1yx7CUNtnOKq0lcHuXyH9x
 SiQqyozjKlVitQEv4254EvaijaEvJXFTgcpoA7QWwqN5A5jfoejaIGA81XX7f9cao2eSzGpp
 HgFn82SxOQPC5iXk2qKWuplNKqm7uyXOSfRqURiE5ko63Km/HvLVY1c/ThkKEBBMs8Oejjyf
 AnVtB85zLRUPXG7K59qS420AsUui6PnELzNWu/RcYBmY55/bgaL8ShiI0mK0AjFikknkaglN
 dGbfMCgAGwBDqJPyDuwTv0al7gxyUgWwGrJTp3/iR2/37eabneITJ8KNVKPaqYy66bsiB7O7
 99VOs+OyhNeeO7zeC/a9cgUN19iBWA2GZ3su+RNe+KDKxYgE2YkY9fVzLQrYYV+t75YmufB4
 je2XUow4F/kmVXdJAmKY2wlY7TqNb5np3U9Ly0qPH6y1nQjaJrp56AaH7M0Yr4j+sR5wPJ0R
 uVDcMKFatxfSznW/DISb5jVpp1+eRiigwmDeSGiZVAXZIFIWAHI/tnpYhmp+CRmJjKzncg3p
 qXm2g6zaYIKWgBKHMvQLvW1wDuZpHUYhad4W0zDIfFVf0Pj9pUsLDb+5tcyLsEQIFPKzyGHj
 V6+DhIRpO2LqIgwmPHTgqaCroqyGut6FEdAEEHU6L+3MW/R+W/L6ZZNVfvNcT3DWWfc/qKka
 uNIifbmP5UvnExHspZuO6xmwaI3+53koLoy5g18EW/CdViDFrJqKX7A1s5K3pCh3ZcA51HwA
 BjWvIAHZ/PQYpiN/EMtyBQNVPyHjeoZiGDrvcs3LWfQvz1woIOdXhAHV/WTsxB1ILxwOYIj5
 O4uvs8K9gCy4iYX3sa6YjN8rDrVcCFZO0kzntRDWdKw1FJ3or1XScaEYhIa9q1jfDml3qMCB
 jaPzJTPiL1HrqYpWypiTCOdtQaxaHlnhfyr8LPgDw7R8jYmrqVttPG0zdjQZlo98/m/+7gvU
 lWHzmUsTUl0wx9mhdJYQ0enEBxbCRuS9yTZkgVZyDSGEhf5DzCSdgXR3NphG2hIm1+wgxABp
 O3IoIobeWyCkD7NMtsaBhc+9q2LoS1Z/QzegsG3d/m4820BSWO92MeGPDNYwyYL9Ott3CUrU
 8E2prcvAUA6XAZMy5AG536yi+RPFUDYezUZKRyjlYtQdVzhlPiJ8WDmAyiMlgllfpQmLWfQ5
 xRSG/9y
IronPort-HdrOrdr: A9a23:oCFmuKHvnrN7vG7mpLqELMeALOsnbusQ8zAXPiBKJCC9E/bo8v
 xG+c5w6faaslkssR0b9+xoW5PwI080l6QU3WB5B97LMDUO0FHCEGgI1/qA/9SPIUzDHu4279
 YbT0B9YueAcGSTW6zBkXWF+9VL+qj5zEix792uq0uE1WtRGtldBwESMHf9LmRGADNoKLAeD5
 Sm6s9Ot1ObCA8qhpTSPAhiYwDbzee77a7bXQ==
X-Talos-CUID: 9a23:eNez+mDXUuJzIJD6ExN/8BYPF9J8Sy3iznryCRSqDjpQUrLAHA==
X-Talos-MUID: 9a23:4bn87gqMVqthFqrvv+Yezzh5GN5QoJqNMk8in7Q5gNe+JA9yZyjI2Q==
X-IronPort-AV: E=Sophos;i="5.99,278,1677560400"; d="scan'208";a="107984133"
Date: Tue, 16 May 2023 15:25:09 +0100
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: <qemu-devel@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, <qemu-block@nongnu.org>, Paul Durrant
 <paul@xen.org>, Peter Lieven <pl@kamp.de>, Stefan Weil <sw@weilnetz.de>, Xie
 Yongji <xieyongji@bytedance.com>, Kevin Wolf <kwolf@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Richard
 Henderson <richard.henderson@linaro.org>, David Woodhouse
 <dwmw2@infradead.org>, Coiby Xu <Coiby.Xu@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Stefano Garzarella <sgarzare@redhat.com>, Philippe
 =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Daniel
 =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Julia Suvorova
 <jusual@redhat.com>, <xen-devel@lists.xenproject.org>, <eesposit@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, "Richard W.M. Jones"
 <rjones@redhat.com>, Fam Zheng <fam@euphon.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v5 13/21] hw/xen: do not set is_external=true on evtchn fds
Message-ID: <dec567c6-5850-48b5-89f9-676c0160389b@perard>
References: <20230504195327.695107-1-stefanha@redhat.com>
 <20230504195327.695107-14-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230504195327.695107-14-stefanha@redhat.com>
Received-SPF: pass client-ip=216.71.155.168;
 envelope-from=prvs=4936e02c6=anthony.perard@citrix.com;
 helo=esa5.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, May 04, 2023 at 03:53:19PM -0400, Stefan Hajnoczi wrote:
> is_external=true suspends fd handlers between aio_disable_external() and
> aio_enable_external(). The block layer's drain operation uses this
> mechanism to prevent new I/O from sneaking in between
> bdrv_drained_begin() and bdrv_drained_end().
> 
> The previous commit converted the xen-block device to use BlockDevOps
> .drained_begin/end() callbacks. It no longer relies on is_external=true
> so it is safe to pass is_external=false.
> 
> This is part of ongoing work to remove the aio_disable_external() API.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

