Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3431C77A1A1
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 20:07:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUt0i-0001B1-Ve; Sat, 12 Aug 2023 14:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qUt0g-0001AY-JN
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 14:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qUt0e-0006JA-3a
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 14:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691863602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+XclhbQLYfDVhd4kNBe0JGX7zf7FYOs8+Zi+O3JfqPw=;
 b=QR3OnGxWuJlru52CjPfLZvkNMUpsDUoMPHVLmHAoO/6m2R4N/KsdrmD7PEcfeRiMUlv/UO
 xKIYoJc3VKc6khpU5NZLbm7ZVFIDKcj827Fl3cUG6MKk5mA1UC0Jr6xfDA1Ulwr3C1c8GR
 qFXQIkAgywdmW3iHIAIt7aKKqurcc4E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-S3cJzoYCNHeKWVN2TZDDng-1; Sat, 12 Aug 2023 14:06:40 -0400
X-MC-Unique: S3cJzoYCNHeKWVN2TZDDng-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-317a3951296so1852752f8f.2
 for <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 11:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691863599; x=1692468399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XclhbQLYfDVhd4kNBe0JGX7zf7FYOs8+Zi+O3JfqPw=;
 b=ErPqisuQKIyC4O4mKF8a9ROoMulOy5YjF7Otqr5aUeAMMwO0DuJoBhMOUk6k+ez+R+
 hnJjMHdfF9rJ1LXHtHDr8AddBuee53PVnn1OdC/0SorxLGze45HhoX0T7AXJvlt1y5x2
 HSiX87eggHZFwBw4o0jwgHeRALAVr+k0DD0/XzL3Ek/epxlPoKNkpZxSuHYXTEGboMgw
 bbx7A5/VGp99mkVrOJs6lu9o4GttPJtiDLe3GcVpHnDDztXV32vjkpI5Pywa/FUKWq58
 rydiHN1b97CQ3TLjGlaBKJbvnec+h5HlgWRt2TAr9yGdaw8dRgtLiqYRFznwZF3lT+rN
 q1qQ==
X-Gm-Message-State: AOJu0YwPPEpyU2yxVgMeXHuNi/m7lJq9tqb5wJUdu2jHdZKxiFVoYuWI
 njA73wJVV6Pm+x/bFWLNWb+YpsF1usaSaBw3Qil/QETBPSzLFIKmU1WwjdKMf22aqZv2Mz8AiKr
 KpZHuYJzFklFW5JE=
X-Received: by 2002:a5d:544e:0:b0:317:3b13:94c3 with SMTP id
 w14-20020a5d544e000000b003173b1394c3mr4161499wrv.41.1691863599502; 
 Sat, 12 Aug 2023 11:06:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ2mFaWZ0MedHJDT6HcmhiPV09S0yRn/66T57BCwqtFNy31kTF9jPGBF93BP891B57qKx5EQ==
X-Received: by 2002:a5d:544e:0:b0:317:3b13:94c3 with SMTP id
 w14-20020a5d544e000000b003173b1394c3mr4161491wrv.41.1691863599191; 
 Sat, 12 Aug 2023 11:06:39 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f2:b100:fba1:19ce:4f7b:4008])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a5d5941000000b003141f96ed36sm9217086wri.0.2023.08.12.11.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Aug 2023 11:06:37 -0700 (PDT)
Date: Sat, 12 Aug 2023 14:06:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/2] pci: last minute bugfixes
Message-ID: <20230812140616-mutt-send-email-mst@kernel.org>
References: <cover.1691770630.git.mst@redhat.com>
 <CAFEAcA8sKYYfo_OazF_fftUwnU0viaTxk9tyn=TUrChMxaLgGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8sKYYfo_OazF_fftUwnU0viaTxk9tyn=TUrChMxaLgGg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Fri, Aug 11, 2023 at 06:41:53PM +0100, Peter Maydell wrote:
> On Fri, 11 Aug 2023 at 17:18, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit 15b11a1da6a4b7c6b8bb37883f52b544dee2b8fd:
> >
> >   cryptodev: Handle unexpected request to avoid crash (2023-08-03 16:16:17 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 0f936247e8ed0ab5fb7e75827dd8c8f73d5ef4b5:
> >
> >   pci: Fix the update of interrupt disable bit in PCI_COMMAND register (2023-08-11 12:15:24 -0400)
> >
> > ----------------------------------------------------------------
> > pci: last minute bugfixes
> >
> > two fixes that seem very safe and important enough to sneak
> > in before the release.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > Guoyi Tu (1):
> >       pci: Fix the update of interrupt disable bit in PCI_COMMAND register
> >
> > Jason Chien (1):
> >       hw/pci-host: Allow extended config space access for Designware PCIe host
> 
> Could you respin to get rid of the malformed Signed-off-by
> line in patch 1 which has an HTML mailto link in it, please?
> 
> thanks
> -- PMM

Pushed as c4e775652a1043b21e6228e8a4d73abe943637b0, sorry I didn't
notice.

-- 
MST


