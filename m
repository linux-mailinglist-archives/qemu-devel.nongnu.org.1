Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B221792324
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 15:47:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdWNY-00067V-P5; Tue, 05 Sep 2023 09:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdWNW-000676-9y
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdWNT-0000Lb-G8
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693921555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hqUqtyM/QnaMtD2Nhw47SNzbEkCcUbacw0gkTBYP7/c=;
 b=FoK7STvAJJptfohHLXZmFmMQxET93xyMZ64fmStqKOxElRgLfgBULFN0IzeER8/uA8oMqO
 iYj1jFMZiCRCps048nl71WAucG60tk0HxoQvOSDrd+FXEFiH1UfEob0ZcKbmi2yiuB0yn8
 E0guBusXj4yW2BCK7Te3WXVvalT2GzA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Szysnxw3MgmdQr731xAJZw-1; Tue, 05 Sep 2023 09:45:53 -0400
X-MC-Unique: Szysnxw3MgmdQr731xAJZw-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3a9b9649cd1so519572b6e.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 06:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693921553; x=1694526353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqUqtyM/QnaMtD2Nhw47SNzbEkCcUbacw0gkTBYP7/c=;
 b=BY6hlIVmwz5h+66ckdPl/eaptC/x9VwZTIMaIZ+qzIBOQ9D2OaeG5ro3YdlB0brQl3
 NhWmK+p9JzH7E7myQiE6u31vri4UESyBTMhiDtbTquTDNQXynD1Gl3sqKk1OjQnwIQQV
 L0kSfwLFlEaHJ/U8ow8MmzI8jpW3bwAtPf7SU1cnRlvcwXv4zYJeCYKdi88OcB07mi/X
 zncffVToBHe2QpZm8iE3A6dSyzOa+1K+GOnuA2LTb0TTOCzgX/A4XjwyNeBw3sgBXyFy
 KkJJZq2+IQDtwN/foEiF+H1x671ersdC48g9c6pKto/iBQRUVc1xOGfNjAeADUgkwSKG
 KXLg==
X-Gm-Message-State: AOJu0Yw7wIhulUlTMo2G4cCQIVQbFbfcpY4oMp7r1eBXyMxGuAdkTJj6
 LFkAS6QZ6BbnGzgby3Kt3wbnhZYFKv8kuzJsbNYxY9HLg1ecbfzfwAVkaGJ10nxEbmsf0wXNSzz
 ACnH/W+mAOKlu57w=
X-Received: by 2002:a05:6808:30a2:b0:3a9:f25d:d917 with SMTP id
 bl34-20020a05680830a200b003a9f25dd917mr15300094oib.4.1693921552965; 
 Tue, 05 Sep 2023 06:45:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2IZ3pwQGCaOjcnbdNTY96pYM2HERHrIRkCTqm4r7QqMukD7lQy3VKcy9WqnssEGDqgUdYhQ==
X-Received: by 2002:a05:6808:30a2:b0:3a9:f25d:d917 with SMTP id
 bl34-20020a05680830a200b003a9f25dd917mr15300074oib.4.1693921552737; 
 Tue, 05 Sep 2023 06:45:52 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h16-20020ac85490000000b00401e04c66fesm4355082qtq.37.2023.09.05.06.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 06:45:52 -0700 (PDT)
Date: Tue, 5 Sep 2023 09:45:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 john.levon@nutanix.com, Jagannathan Raman <jag.raman@oracle.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v2 1/4] softmmu: Support concurrent bounce buffers
Message-ID: <ZPcxD+lqtt8PFwCl@x1n>
References: <20230823092905.2259418-1-mnissler@rivosinc.com>
 <20230823092905.2259418-2-mnissler@rivosinc.com>
 <ZOZDQVgboMaiZ4x6@x1n>
 <CAGNS4TY2-scz3pu16tUF1bA-FEk+pe86QsgjW8L=qjidw5TqOQ@mail.gmail.com>
 <ZOZx7vMqFRfaIwSp@x1n> <20230824133245.GA1412804@fedora>
 <87edjixb6n.fsf@pond.sub.org>
 <CAGNS4TaEL1CapL3NoM4XYVMLOH-heOs=2WHMLHNEz072fcxNfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGNS4TaEL1CapL3NoM4XYVMLOH-heOs=2WHMLHNEz072fcxNfw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 05, 2023 at 09:38:39AM +0200, Mattias Nissler wrote:
> It would be nice to use a property on the device that originates the
> DMA operation to configure this. However, I don't see how to do this
> in a reasonable way without bigger changes: A typical call path is
> pci_dma_map -> dma_memory_map -> address_space_map. While pci_dma_map
> has a PCIDevice*, address_space_map only receives the AddressSpace*.
> So, we'd probably have to pass through a new QObject parameter to
> address_space_map that indicates the originator and pass that through?
> Or is there a better alternative to supply context information to
> address_space map? Let me know if any of these approaches sound
> appropriate and I'll be happy to explore them further.

Should be possible to do. The pci address space is not shared but
per-device by default (even if there is no vIOMMU intervention).  See
do_pci_register_device():

    address_space_init(&pci_dev->bus_master_as,
                       &pci_dev->bus_master_container_region, pci_dev->name);

Thanks,

-- 
Peter Xu


