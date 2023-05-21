Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F95470AD20
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 11:06:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0f0T-0002mC-0a; Sun, 21 May 2023 05:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q0f0Q-0002lp-GQ
 for qemu-devel@nongnu.org; Sun, 21 May 2023 05:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q0f0O-0006Bb-Qb
 for qemu-devel@nongnu.org; Sun, 21 May 2023 05:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684659931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VSx/Avfb33Ldgih9JSGuUPfbI4fITybLTK9e69Y1TY=;
 b=H3PvPJGEirhAGh1/ETZBHyG6SRErpnSnuu348f0B/YbIW/b4oQ2OPFpSxpxPnN2KcoV+DD
 4MaU0EG1tLStVvIwGWwLWNJOF7FSQd6z+MgqOoXPxNj5NItGDZv9CDllwvAvQpriVb5nxC
 wTJviQX0ol4N9056Kc1OctNjEot920Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-di6i7gboNtGYnoiAlrNQqw-1; Sun, 21 May 2023 05:05:30 -0400
X-MC-Unique: di6i7gboNtGYnoiAlrNQqw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30793c16c78so3174323f8f.3
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 02:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684659929; x=1687251929;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3VSx/Avfb33Ldgih9JSGuUPfbI4fITybLTK9e69Y1TY=;
 b=FDM2V6lGD6TiieCP9foplQ22+BFstON76sstIKmFQSW6jtf4prblkHhj5RZnU//YoS
 FsQZo9Lqz+yStLrlX2H7j9DSLcWBDwZqp7P9VsjEBZfSKvRerzOXdNdnmg9QfkpUs77l
 t1YycxW/uc2mn/Jl+fw0v2Y1sokOByRzHJuVdfL2XqUsehGvgJpkbQbO63Vd6poVUf93
 n26LpGFi58ZqEPvR7aCyPoxcijY6/dlv363CJ4/4sulOuQB+sQn5rnSJF7EHaH+snEIl
 MMIsp/9oPSmn2IlVN7q/j0b8n1eiGuopW6PF8CX51wabYIGxuMUBFyNeuHkiUHR0hqqr
 GiYw==
X-Gm-Message-State: AC+VfDx1wo8VHd9BDy2DOR/A7IKBB+LmG7jd4XMoLt2hh0mogDr3l2Mr
 x4HvuRyXkZ7Mp2q6kJ0brsXNS7smUm3Dk8+hRSXMU0QO8pso9XXpZtA06KZGAhq48pAiyWa1WAZ
 1zxZ/DjZIAtl8NNQ=
X-Received: by 2002:a5d:4b4e:0:b0:2fb:600e:55bd with SMTP id
 w14-20020a5d4b4e000000b002fb600e55bdmr4945540wrs.39.1684659928896; 
 Sun, 21 May 2023 02:05:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XOP64xDKuhvScJEE4WNn6L+GxaVOCiNZ2RGkPbPgb+PtDQCMNsQ+Es239o+pZAxvM+7IIWA==
X-Received: by 2002:a5d:4b4e:0:b0:2fb:600e:55bd with SMTP id
 w14-20020a5d4b4e000000b002fb600e55bdmr4945531wrs.39.1684659928608; 
 Sun, 21 May 2023 02:05:28 -0700 (PDT)
Received: from redhat.com ([2.52.11.67]) by smtp.gmail.com with ESMTPSA id
 l4-20020a5d5604000000b00300aee6c9cesm4112693wrv.20.2023.05.21.02.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 May 2023 02:05:27 -0700 (PDT)
Date: Sun, 21 May 2023 05:05:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned
 24 bit field
Message-ID: <20230521050417-mutt-send-email-mst@kernel.org>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
 <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
 <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
 <04b53845-b54f-458f-bc6f-f5aed86cdd06@eik.bme.hu>
 <4dd8a802-9a8c-77ab-6355-38910eefe19e@linaro.org>
 <06481704-adc6-bc63-e79d-34ac87484810@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06481704-adc6-bc63-e79d-34ac87484810@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, May 20, 2023 at 07:08:22PM +0200, Philippe Mathieu-Daudé wrote:
> On 20/5/23 17:15, Richard Henderson wrote:
> > On 5/20/23 06:15, BALATON Zoltan wrote:
> > > On Sat, 20 May 2023, Peter Maydell wrote:
> > > > On Fri, 19 May 2023 at 15:19, Jonathan Cameron via
> > > > <qemu-devel@nongnu.org> wrote:
> > > > > 
> > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > 
> > > > > CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> > > > > specified as little endian.
> > > > > 
> > > > > Define st24_le_p() and the supporting functions to store such a field
> > > > > from a 32 bit host native value.
> > > > > 
> > > > > The use of b, w, l, q as the size specifier is limiting.  So "24" was
> > > > > used for the size part of the function name.
> > > 
> > > Maybe it's clearer to use 24 but if we want to keep these somewhat
> > > consistent how about using t for Triplet, Three-bytes or
> > > Twenty-four?
> > 
> > I think it's clearer to use '3'.
> > When I added 128-bit support I used cpu_ld16_mmu.
> 
> There is also ld8u / ld8s / st8.
> 
> > I think it would be clearer to not use letters anywhere, and to use
> > units of bytes instead of units of bits (no one can store just a bit),
> > but changing everything is a big job.
> 
> So:
> 
> ldub ->  ld1u,
> 
> lduw_le -> ld2u_le,
> 
> virtio_stl -> virtio_st4,
> 
> stq_be -> st8_be.
> 
> Right?


No, using bits is so ingrained by now, that people will think
st8 is a single byte.

And yes, you can store a bit - you have to read modify write but
hey.

> Also we have:
> 
> cpu_ld/st_*
> virtio_ld/st_*
> ld/st_*_phys
> ld/st_*_pci_dma
> address_space_ld/st
> 
> While mass-changing, we could use FOO_ld/st_BAR with FOO
> for API and BAR for API variant (endian, mmuidx, ra, ...):
> 
> So:
> 
> ld/st_*_pci_dma -> pci_dma_ld/st_*
> 
> for ld/st_*_phys I'm not sure.


