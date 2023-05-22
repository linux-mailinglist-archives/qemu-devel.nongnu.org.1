Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF1F70C25C
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:28:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17RT-0005a5-S5; Mon, 22 May 2023 11:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1q17RB-0005Zj-Dm
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1q17R9-00008u-4s
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684769221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dXvBsRw4fRV3sd9BFWe+bAbBt2tYjvVuo4LWj8SXyNw=;
 b=LxdGSgz6KHrOvF8YBOC39WLNw4avcDDa+ZBBay06nGzdGVkfmghDoh8wXYY9mfzUZVqWL4
 mjX1s4pPbRuy7g/u+NcbtzqWaYx03wxqPMrMHqk17BoKFIANMPGCVuMb9LiiRjvH3KvoNa
 wW5vf1D0TkskonlexGwvj/RWpd1F7S8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-QBwt7_QTOfmbm-FQw6PXyg-1; Mon, 22 May 2023 11:25:26 -0400
X-MC-Unique: QBwt7_QTOfmbm-FQw6PXyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27CBD832D19;
 Mon, 22 May 2023 15:25:19 +0000 (UTC)
Received: from rein.int.mamuti.net (unknown [10.45.226.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 063A440D1B60;
 Mon, 22 May 2023 15:25:17 +0000 (UTC)
Date: Mon, 22 May 2023 17:25:17 +0200
From: Jiri Denemark <jdenemar@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Leonardo Bras <leobras@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Daniel Berrange <berrange@redhat.com>
Subject: Re: [PATCH v1 1/1] hw/pci: Disable PCI_ERR_UNCOR_MASK register for
 machine type < 8.0
Message-ID: <ZGuJXf9B0xEeDGe6@orkuz.int.mamuti.net>
References: <20230503002701.854329-1-leobras@redhat.com>
 <7f308149-5495-d415-5e51-1fa15fc20f84@proxmox.com>
 <20230511064306-mutt-send-email-mst@kernel.org>
 <8735435c0c.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735435c0c.fsf@secure.mitica>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jdenemar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 11, 2023 at 13:43:47 +0200, Juan Quintela wrote:
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> [Added libvirt people to the party, see the end of the message ]

Sorry, I'm not that much into parties :-)

> That would fix the:
> 
> qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2
> 
> It is worth it?  Dunno.  That is my question.
> 
> And knowing from what qemu it has migrated from would not help.  We
> would need to add a new tweak and means:
> 
> This is a pc-7.2 machine that has been isntantiated in a qemu-8.0 and
> has the pciaerr bug.  But wait, we have _that_.
> 
> And it is called
> 
> +    { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
> 
> from the patch.
> 
> We can teach libvirt about this glitch, and if he is migrating a pc-7.2
> machine in qemu-8.0 machine, And they want to migrate to a new qemu
> (call it qemu-8.1), it needs to be started:
> 
> qemu-8.1 -M pc-7.2 <whatever pci devices need to do>,x-pci-err-unc-mask="true"
> 
> Until the user reboots it and then that property can be reset to default
> value.

Hmm and what would happen if eventually this machine gets migrated back
to qemu-8.0? Or even when the machine is stopped, started again, and
then migrated to qemu-8.0?

Jirka


